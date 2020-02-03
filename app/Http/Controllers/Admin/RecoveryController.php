<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\RemarkRequest;
use App\Models\CheckLog;
use App\Models\Company;
use App\Models\Label;
use App\Models\Plan;
use App\Models\Recovery;
use App\Models\Remark;
use App\Models\User;
use App\Models\Vocation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class RecoveryController extends Controller
{
    /**
     * 样品回收列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_kw' => $request->input('_kw', ''),
            'status' => $request->input('status', '0'),
            'company_id' => $request->input('company_id', '0'),
            'vocation_id' => $request->input('vocation_id', '0'),
            'page_size' => $request->input('page_size', '10'),
        ];
        $where = [];
        if($params['company_id']){
            $where['users.company_id'] = $params['company_id'];
        }
        if($params['vocation_id']){
            $where['users.vocation_id'] = $params['vocation_id'];
        }
        $plan = (new Plan())->get_recovery_plan();
        $lists = [];
        if ($plan) {
            $lists = User::select('users.*', 'l.number as label_number', 'l.id as label_id', 'l.send_at', 'r.id as is_back', 'r.created_at as created_time')
                ->join('company as c', 'users.company_id', '=', 'c.id')
                ->join('labels as l', 'users.id', '=', 'l.user_id')
                ->leftJoin('recovery as r', function ($join) use ($plan) {
                    $join->on('l.number', '=', 'r.number')
                        ->where('r.plan_id', '=', $plan['id'])
                        ->where('r.status', '=', 0);
                })
                ->when($params['_kw'], function ($query) use ($params) {
                    return $query->whereRaw("users.name like '%" . $params['_kw'] . "%' or c.name like '%" . $params['_kw'] . "%'");
                })
                ->when($params['status'], function ($query) use ($params) {
                    if($params['status'] == 1){
                        return $query->where('r.id', '>', 0);
                    }else{
                        return $query->where('r.id', '=', null);
                    }
                })
                ->where(['l.status' => 1, 'l.plan_id' => $plan['id']])
                ->where($where)
                //->whereNotIn('l.id', $check_label_ids)
                ->orderBy('users.created_at', 'desc')
                ->orderBy('users.id', 'desc')
                ->orderBy('l.id', 'desc')
                //->toSql();
                ->paginate($params['page_size']);
        }
        $vocation = Vocation::where('status',1)->get();
        $companys = Company::get();
        return view('admin.recovery.index', compact('lists', 'params', 'vocation', 'companys'));
    }

    /**
     * 样品审核
     * @param $label_id
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function check($label_id)
    {
        $plan = (new Plan())->get_recovery_plan();
        if(!$plan){
            return self::error('数据错误，请联系网络管理员');
        }
        $CheckLog = new CheckLog();
        if ($CheckLog->check($label_id, $plan['id'])) {
            return self::success('审核成功');
        }
        return self::error('审核失败');
    }
    /**
     * 批量审核
     * @param Request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function check_all(Request $request)
    {
        $label_ids = $request->label_id;
        if(!is_array($label_ids) || !$label_ids){
            return self::error('请选择需要审核的数据');
        }
        $plan = (new Plan())->get_recovery_plan();
        if(!$plan){
            return self::error('数据错误，请联系网络管理员');
        }
        foreach($label_ids as $k=>$v){
            $CheckLog = new CheckLog();
            if (!$CheckLog->check($v, $plan['id'])) {
                return self::error('审核失败');
            }
        }
        return self::success('审核成功');
    }

    /**
     * 备注
     * @param $label_id
     * @return string
     * @throws \Throwable
     */
    public function remark($label_id)
    {
        $label = Label::findOrFail($label_id);
        return view('admin.recovery.remark', compact('label'))->render();
    }

    /**
     * 提交备注
     * @param RemarkRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(RemarkRequest $request)
    {
        $plan = (new Plan())->get_recovery_plan();
        $label = Label::findOrFail($request->input('label_id'));
        $data = [
            'label_id' => $request->label_id,
            'remark' => $request->remark,
            'user_id' => $label->user_id,
            'plan_id' => $plan->id,
            'status' => $request->status,
            'admin_name' => auth()->guard('admin')->user()->name,
        ];
        $Remark =  new Remark();
        $Remark->fill($data);
        if ($Remark->save()) {
            $user = User::findOrFail($label->user_id);
            $user->status = $request->status;
            $user->save();
            return self::success('备注成功');
        }
        return self::error('备注失败');
    }
}
