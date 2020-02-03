<?php

namespace App\Http\Controllers\Api;

use App\Models\Label;
use App\Models\Plan;
use App\Models\Recovery;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class IndexController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->all();
        $validator = Validator::make($data, [
            'type' => 'required|in:1,2',
            'label' => 'required',
        ], [
            'type.required' => '缺少类型参数',
            'label.required' => '缺少标签参数',
            'type.in' => '类型参数有误',
        ]);
        if (!$validator->passes()) {
            return response()->json([
                'message' => $validator->errors()->first()
            ], 400);
        }

        $labels = json_decode($data['label']);
        if (!is_array($labels))
            return response()->json([
                'message' => '标签参数格式有误'
            ], 400);
        $count = 0;
        if ($data['type'] == 1) {//标签入库
            $old_labels = Label::pluck('number')->toArray();
            foreach ($labels as $k => $v) {
                if (!in_array($v, $old_labels)) {
                    $Label = new Label();
                    $Label->fill(['number' => $v]);
                    $Label->save();
                    $count++;
                }
            }
            $msg = '入库' . $count . '个剂量牌标签';
        } else {//样品回收
            $plan = (new Plan())->get_recovery_plan();
            if (!$plan) {
                return response()->json([
                    'message' => '暂无回收中的计划'
                ], 400);
            }
            $old_recovery = Recovery::whereBetween('created_at', [strtotime($plan['created_at']), time()])->pluck('number')->toArray();
            foreach ($labels as $k => $v) {
                if (!in_array($v, $old_recovery)) {
                    $label = Label::where(['number' => $v, 'status' => 1, 'plan_id' => $plan['id']])->first();
                    if ($label) {
                        $Recovery = new Recovery();
                        $Recovery->fill(['number' => $v, 'plan_id' => $plan['id']]);
                        $Recovery->save();
                        $count++;
                    }
                }
            }
            $msg = '回收' . $count . '个剂量牌';
        }
        return response()->json([
            'message' => '成功' . $msg,
        ]);
    }

    public function get_user(Request $request)
    {
        $data = $request->all();
        $validator = Validator::make($data, [
            'label' => 'required',
        ], [
            'label.required' => '缺少标签参数',
        ]);
        if (!$validator->passes()) {
            return response()->json([
                'message' => $validator->errors()->first()
            ], 400);
        }

        $labels = json_decode($data['label']);
        if (!is_array($labels))
            return response()->json([
                'message' => '标签参数格式有误'
            ], 400);
        $lists = User::select('users.*', 'l.number as label_number', 'l.status as label_status', 'p.status as plan_status')
            ->join('labels as l', 'users.id', '=', 'l.user_id')
            ->leftJoin('plans as p', 'p.id', '=', 'l.plan_id')
            ->with('company', 'card_number')
            ->whereIn('l.number', $labels)
            ->get();
        $plan = (new Plan())->get_grant_plan();
        $data = [];
        foreach($lists as $k => $v){
            //没有计划不能选择
            if(!$plan){
                continue;
            }elseif($v['label_status'] == 2 && $v['plan_status'] != 3){//当标签状态为已回收，但是对应的计划还没结束时
                continue;
            }
            //已报废或已发放的不能选择
            if(in_array($v['label_status'], [1,3])){
                continue;
            }
            $data[] = $v;
        }
        return response()->json([
            'message' => '成功',
            'data' => $data,
        ]);
    }
    public function grant(Request $request)
    {
        $data = $request->all();
        $validator = Validator::make($data, [
            'label' => 'required',
        ], [
            'label.required' => '缺少标签参数',
        ]);
        if (!$validator->passes()) {
            return response()->json([
                'message' => $validator->errors()->first()
            ], 400);
        }

        $labels = json_decode($data['label']);
        if (!is_array($labels))
            return response()->json([
                'message' => '标签参数格式有误'
            ], 400);
        $lists = User::select('users.*', 'l.number as label_number', 'l.status as label_status', 'l.id as label_id', 'p.status as plan_status')
            ->join('labels as l', 'users.id', '=', 'l.user_id')
            ->leftJoin('plans as p', 'p.id', '=', 'l.plan_id')
            ->with('company', 'card_number')
            ->whereIn('l.number', $labels)
            ->get();
        $plan = (new Plan())->get_grant_plan();
        foreach($lists as $k => $v){
            //没有计划不能选择
            if(!$plan){
                continue;
            }elseif($v['label_status'] == 2 && $v['plan_status'] != 3){//当标签状态为已回收，但是对应的计划还没结束时
                continue;
            }
            //已报废或已发放的不能选择
            if(in_array($v['label_status'], [1,3])){
                continue;
            }
            $Label = new Label();
            $Label->grant($v['label_id'], $plan);
        }
        return response()->json([
            'message' => '成功',
        ]);
    }

    public function test(){//echo 1;die;
        $labels = ['ABCD19100178', 'ABCD19100189', 'ABCD19100181', 'ABCD19100186'];
        if (!is_array($labels))
            return response()->json([
                'message' => '标签参数格式有误'
            ], 400);
        $lists = User::select('users.*', 'l.number as label_number', 'l.status as label_status', 'p.status as plan_status')
            ->join('labels as l', 'users.id', '=', 'l.user_id')
            ->leftJoin('plans as p', 'p.id', '=', 'l.plan_id')
            ->with('company', 'card_number')
            ->whereIn('l.number', $labels)
            ->get();
        $plan = (new Plan())->get_grant_plan();
        $data = [];
        foreach($lists as $k => $v){
            //已报废或已发放的不能选择
            if(in_array($v['label_status'], [1,3])){
                continue;
            }
            $data[] = $v;
        }
        return response()->json([
            'message' => '成功',
            'data' => $data,
        ]);
    }
}
