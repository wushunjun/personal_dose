<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Company;
use App\Models\Label;
use App\Models\LabelLog;
use App\Models\Plan;
use App\Models\Region;
use App\Models\User;
use App\Models\Vocation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class IndexController extends Controller
{
    /**
     * 首页看板
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $year = $request->input('year', date('Y'));
        $company_id = $request->input('company_id', '');
        $first = LabelLog::orderBy('created_at', 'asc')->value('created_at');
        $first_year = date('Y',strtotime($first));
        $last = LabelLog::orderBy('created_at', 'desc')->value('created_at');
        $last_year = date('Y',strtotime($last));
        $years = [];
        while($first_year <= $last_year){
            $years[] = $first_year;
            $first_year ++;
        }
        $start_time = strtotime($year . '-1-1');
        $end_time = strtotime($year . '-12-31');

        /*按计划统计回收数据结束*/
        $lists = LabelLog::select([\DB::raw('count(*) as count'), 'label_logs.status', 'label_logs.remark', 'label_logs.plan_id', 'p.name'])
            ->join('plans as p', 'label_logs.plan_id', '=', 'p.id')
            ->whereBetween('label_logs.created_at', [$start_time, $end_time])
            ->groupBy('label_logs.plan_id', 'label_logs.status', 'label_logs.remark', 'p.name')
            ->get();
        $plan_x = $is_back = $no_back = $grant = [];
        foreach($lists as $k => $v){
            if(!in_array($v['name'], $plan_x))
                $plan_x[$v['plan_id']] = $v['name'];
            if($v['status'] == 0){
                isset($grant[$v['plan_id']]) ? $grant[$v['plan_id']] += $v['count'] : $grant[$v['plan_id']] = $v['count'];
                $no_back[$v['plan_id']] ?? 0;
                $is_back[$v['plan_id']] ?? 0;
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：已送样'){
                isset($is_back[$v['plan_id']]) ? $is_back[$v['plan_id']] += $v['count'] : $is_back[$v['plan_id']] = $v['count'];
                $no_back[$v['plan_id']] ?? 0;
                $grant[$v['plan_id']] ?? 0;
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：未送样'){
                isset($no_back[$v['plan_id']]) ? $no_back[$v['plan_id']] += $v['count'] : $no_back[$v['plan_id']] = $v['count'];
                $is_back[$v['plan_id']] ?? 0;
                $grant[$v['plan_id']] ?? 0;
            }
        }
        $plan_x = array_values($plan_x);
        $is_back = array_values($is_back);
        $no_back = array_values($no_back);
        $grant = array_values($grant);
        /*按计划统计回收数据结束*/

        /*单位回收数据统计开始*/
        $lists = LabelLog::select([\DB::raw('count(*) as count'), 'label_logs.status', 'label_logs.remark', 'label_logs.company_id', 'c.name'])
            ->join('company as c', 'label_logs.company_id', '=', 'c.id')
            ->whereBetween('label_logs.created_at', [$start_time, $end_time])
            ->when($company_id, function($query) use ($company_id){
                $query->where('c.id', $company_id);
            })
            ->groupBy('label_logs.company_id', 'label_logs.status', 'label_logs.remark', 'c.name')
            ->get();
        $company_x = $company_is_back = $company_no_back = $company_grant = [];
        foreach($lists as $k => $v){
            if(!in_array($v['name'], $plan_x))
                $company_x[$v['company_id']] = $v['name'];
            if($v['status'] == 0){
                isset($company_grant[$v['company_id']]) ? $company_grant[$v['company_id']] += $v['count'] : $company_grant[$v['company_id']] = $v['count'];
                $company_no_back[$v['company_id']] ?? 0;
                $company_is_back[$v['company_id']] ?? 0;
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：已送样'){
                isset($company_is_back[$v['company_id']]) ? $company_is_back[$v['company_id']] += $v['count'] : $company_is_back[$v['company_id']] = $v['count'];
                $company_no_back[$v['company_id']] ?? 0;
                $company_grant[$v['company_id']] ?? 0;
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：未送样'){
                isset($company_no_back[$v['company_id']]) ? $company_no_back[$v['company_id']] += $v['count'] : $company_no_back[$v['company_id']] = $v['count'];
                $company_is_back[$v['company_id']] ?? 0;
                $company_grant[$v['company_id']] ?? 0;
            }
        }
        $company_x = array_values($company_x);
        $company_is_back = array_values($company_is_back);
        $company_no_back = array_values($company_no_back);
        $company_grant = array_values($company_grant);
        /*单位回收数据统计结束*/

        /*当前计划统计开始*/
        $plan = (new Plan())->get_recovery_plan();
        $lists = LabelLog::select()
            ->where('plan_id', $plan->id)
            ->get();
        $current =  [
            'grant' => 0,
            'is_back' => 0,
            'no_back' => 0,
        ];
        foreach($lists as $k => $v){
            if($v['status'] == 0){
                $current['grant']++;
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：已送样'){
                $current['is_back']++;
            }
            if($v['status'] == 1 && $v['remark'] == '样品回收：未送样'){
                $current['no_back']++;
            }
        }
        /*当前计划统计结束*/

        /*顶部标签统计开始*/
        $user_count = User::count();
        $rfid_count = Label::count();
        $nu_use_rfid_count = Label::where('user_id', 0)->count();
        $scrap_count = Label::where('status', 3)->count();
        $company = Company::get();
        /*顶部标签统计结束*/

        /*职位占比开始*/
        $vocations = Vocation::select()
            ->withCount('user')
            ->orderBy('user_count', 'desc')
            ->get();
        foreach($vocations as $k => $v){
            $vocations[$k]['scale'] = round($v['user_count'] / $user_count  * 100, 2);
        }
        /*职位占比结束*/

        /*各区单位数统计开始*/
        $regions = Region::select()
            ->where('pid', '>', 0)
            ->withCount('company')
            ->get();
        $region_x = $region_data = [];
        foreach($regions as $k => $v){
            $region_x[] = $v->name;
            $region_data[] = $v->company_count ?? 0;
        }
        /*各区单位数统计结束*/

        return view('admin.index.index', compact('years', 'year', 'company_id', 'nu_use_rfid_count', 'scrap_count',
            'no_back', 'is_back', 'grant', 'plan_x', 'company_x', 'user_count', 'rfid_count',
            'company_is_back', 'company_no_back', 'company_grant', 'company', 'current', 'vocations', 'region_x', 'region_data'));
    }

    /**
     * 清除所有缓存
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function flush()
    {
        if (Cache::flush()) {
            return self::success('清除缓存成功');
        }
        return self::error('清除缓存失败');
    }

    /**
     * 修改配置文件
     * @return string
     * @throws \Throwable
     */
    public function profile()
    {
        $profile = Auth::guard('admin')->user();
        return view('admin.index.profile', compact('profile'))->render();
    }

    /**
     * 更新配置文件
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function updateProfile(Request $request)
    {
        $profile = Auth::guard('admin')->user();
        if ($profile->where([
            ['email', $request->input('email')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该邮箱已存在');
        }
        $profile->fill($request->except('headimgurl', 'password'));

        //如果存在图片上传
        if ($request->hasFile('headimgurl') && $request->file('headimgurl')->isValid()) {
            $profile->old_headimgurl = $profile->headimgurl;
            $filename = $request->file('headimgurl')->store('admin');
            if ($filename) {
                $profile->headimgurl = $filename;
                Storage::exists($profile->old_headimgurl) && Storage::delete($profile->old_headimgurl);
                unset($profile->old_headimgurl);
            }
        }

        if (!is_null($request->input('password'))) {
            $profile->password = bcrypt($request->input('password'));
        }

        if ($profile->save()) {
            return self::success('更新个人配置成功');
        }
        return self::error('更新个人配置失败');

    }

    public function chang_status(Request $request){
        $res = DB::table($request->table)->where($request->id_name, $request->id_value)->update([$request->field => $request->value]);
        echo $res;
    }

}
