<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\VocationRequest;
use App\Models\Company;
use App\Models\Label;
use App\Models\LabelLog;
use App\Models\Plan;
use App\Models\User;
use App\Models\Vocation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class GrantController extends Controller
{
    /**
     * 发放列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_kw' => $request->input('_kw', ''),
            'company_id' => $request->input('company_id', '0'),
            'vocation_id' => $request->input('vocation_id', '0'),
            'status' => $request->input('status', '0'),
            'page_size' => $request->input('page_size', '10'),
        ];
        $where = [];
        if($params['company_id']){
            $where['users.company_id'] = $params['company_id'];
        }
        if($params['vocation_id']){
            $where['users.vocation_id'] = $params['vocation_id'];
        }
        $lists = User::select('users.*', 'l.number as label_number', 'l.id as label_id', 'l.status as label_status', 'l.send_at', 'p.status as plan_status')
            ->join('company as c', 'users.company_id', '=', 'c.id')
            ->join('labels as l', 'users.id', '=', 'l.user_id')
            ->leftJoin('plans as p', 'p.id', '=', 'l.plan_id')
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->whereRaw("users.name like '%" . $params['_kw'] . "%' or c.name like '%" . $params['_kw'] . "%'");
            })
            ->when($params['status'], function ($query) use ($params) {
                return $query->where('l.status', '=', $params['status'] - 1);
            })
            ->where($where)
            ->orderBy('created_at', 'desc')
            ->orderBy('id', 'desc')
            ->paginate($params['page_size']);
        $plan = (new Plan())->get_grant_plan();
        foreach($lists as &$v){
            $v['disabled'] = 0;
            //没有计划不能选择
            if(!$plan){
                $v['disabled'] = 1;
            }elseif($v['label_status'] == 2 && $v['plan_status'] != 3){//当标签状态为已回收，但是对应的计划还没结束时
                $v['disabled'] = 1;
            }
            //已报废或已发放的不能选择
            if(in_array($v['label_status'], [1,3])){
                $v['disabled'] = 1;
            }

        }
        $vocation = Vocation::where('status',1)->get();
        $companys = Company::get();
        return view('admin.grant.index', compact('lists', 'params', 'vocation', 'companys'));
    }


    /**
     * 批量发放
     * @param $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function grant_all(Request $request)
    {
        $plan = (new Plan())->get_grant_plan();
        if(!$plan){
            return self::error('当前暂无发放计划，请先添加计划');
        }
        $label_ids = $request->label_id;
        if(!is_array($label_ids) || !$label_ids){
            return self::error('请选择需要发放的剂量牌');
        }
        foreach($label_ids as $k=>$v){
            $Label = new Label();
            if (!$Label->grant($v, $plan)) {
                return self::error('发放失败');
            }
        }
        return self::success('发放成功');
    }

    public function label_log($label_id){
        $lists = LabelLog::where('label_id', $label_id)->get();
        return view('admin.grant.label_log', compact('lists'))->render();
    }
}
