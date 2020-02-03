<?php

namespace App\Http\Controllers\Admin;

use App\Models\Company;
use App\Models\Plan;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CheckReportController extends Controller
{
    /**
     * 审核记录统计
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_t' => $request->input('_t', 'name'),
            '_kw' => $request->input('_kw', ''),
        ];
        $lists = Plan::select([\DB::raw('count(*) as count'), 'l.status', 'l.plan_id', 'plans.name', 'l.remark'])
            ->join('label_logs as l', 'l.plan_id', '=', 'plans.id')
            ->whereIn('l.status', [0,1])
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where('plans.' . $params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->groupBy('l.plan_id', 'l.status', 'l.remark', 'plans.name')
            ->orderBy('plans.created_at', 'desc')
            ->orderBy('plans.id', 'desc')
            ->get();
        $count = [];
        foreach($lists as $k => $v){
            $count[$v['plan_id']]['name'] = $v['name'];
            $count[$v['plan_id']]['plan_id'] = $v['plan_id'];
            if($v['status'] == 0){
                isset($count[$v['plan_id']]['grant_count']) ? $count[$v['plan_id']]['grant_count'] += $v['count'] : $count[$v['plan_id']]['grant_count'] = $v['count'];
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：已送样'){
                isset($count[$v['plan_id']]['has_recovery_count']) ? $count[$v['plan_id']]['has_recovery_count'] += $v['count'] : $count[$v['plan_id']]['has_recovery_count'] = $v['count'];
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：未送样'){
                isset($count[$v['plan_id']]['no_recovery_count']) ? $count[$v['plan_id']]['no_recovery_count'] += $v['count'] : $count[$v['plan_id']]['no_recovery_count'] = $v['count'];
            }
        }
        return view('admin.check_report.index', compact('count', 'params'));
    }
    public function company_list($plan_id, Request $request){
        $params = [
            '_t' => $request->input('_t', 'name'),
            '_kw' => $request->input('_kw', ''),
        ];
        $lists = Company::select([\DB::raw('count(*) as count'), 'l.status', 'l.company_id', 'company.name', 'l.remark'])
            ->join('label_logs as l', 'l.company_id', '=', 'company.id')
            ->where('l.plan_id', $plan_id)
            ->whereIn('l.status', [0,1])
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where('company.' . $params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->groupBy('l.company_id', 'l.status', 'l.remark', 'company.name')
            ->orderBy('company.created_at', 'desc')
            ->orderBy('company.id', 'desc')
            ->get();
        $count = [];
        foreach($lists as $k => $v){
            $count[$v['company_id']]['name'] = $v['name'];
            $count[$v['company_id']]['company_id'] = $v['company_id'];
            if($v['status'] == 0){
                isset($count[$v['company_id']]['grant_count']) ? $count[$v['company_id']]['grant_count'] += $v['count'] : $count[$v['company_id']]['grant_count'] = $v['count'];
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：已送样'){
                isset($count[$v['company_id']]['has_recovery_count']) ? $count[$v['company_id']]['has_recovery_count'] += $v['count'] : $count[$v['company_id']]['has_recovery_count'] = $v['count'];
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：未送样'){
                isset($count[$v['company_id']]['no_recovery_count']) ? $count[$v['company_id']]['no_recovery_count'] += $v['count'] : $count[$v['company_id']]['no_recovery_count'] = $v['count'];
            }
        }
        return view('admin.check_report.company_list', compact('count', 'params', 'plan_id'));

    }
}
