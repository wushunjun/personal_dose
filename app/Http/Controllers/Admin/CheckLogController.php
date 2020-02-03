<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\CheckLogRequest;
use App\Models\CheckLog;
use App\Models\Company;
use App\Models\Plan;
use App\Models\Remark;
use App\Models\User;
use App\Models\Vocation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CheckLogController extends Controller
{
    /**
     * 审核记录列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            'plan_id' => $request->input('plan_id', '0'),
            'company_id' => $request->input('company_id', '0'),
            'vocation_id' => $request->input('vocation_id', '0'),
            'status' => $request->input('status', '0'),
            '_kw' => $request->input('_kw', ''),
            'page_size' => $request->input('page_size', '10'),
        ];
        $where = [];
        if($params['plan_id']){
            $where['c.plan_id'] = $params['plan_id'];
        }
        if($params['company_id']){
            $where['users.company_id'] = $params['company_id'];
        }
        if($params['vocation_id']){
            $where['users.vocation_id'] = $params['vocation_id'];
        }
        $lists = User::select('users.*', 'c.admin_name', 'l.number', 'c.created_at as check_time', 'c.status as check_status', 'c.label_id', 'c.id as cl_id', 'p.name as plan_name')
            ->join('check_logs as c', function($join){
                $join->on('c.user_id', '=', 'users.id');
            })
            ->join('labels as l', function($join){
                $join->on('c.label_id', '=', 'l.id');
            })
            ->join('plans as p', function($join){
                $join->on('c.plan_id', '=', 'p.id');
            })
            ->join('company as co', function($join){
                $join->on('users.company_id', '=', 'co.id');
            })
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where('users.name', 'like', "%$params[_kw]%")->orWhere("co.name", 'like', "%$params[_kw]%");
            })
            ->when($params['status'], function ($query) use ($params) {
                if($params['status'] == 1){
                    return $query->where('c.status', '=', 1);
                }else{
                    return $query->where('c.status', '=', 0);
                }
            })
            ->where($where)
            ->orderBy('c.created_at', 'desc')
            ->orderBy('c.id', 'desc')
            ->paginate($params['page_size']);

        $plans = Plan::get();
        $companys = Company::get();
        $vocations = Vocation::get();
        return view('admin.check_log.index', compact('lists', 'plans', 'companys', 'vocations', 'params'));
    }

    /**
     * 审核备注
     * @param $cl_id
     * @return string
     * @throws \Throwable
     */
    public function show($cl_id)
    {
        $check_log = CheckLog::findOrFail($cl_id);
        $lists = Remark::where(['label_id' => $check_log['label_id'], 'plan_id' => $check_log['plan_id']])->get();
        return view('admin.check_log.show', compact('lists'))->render();
    }

}
