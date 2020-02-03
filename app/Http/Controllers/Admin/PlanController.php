<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\PlanRequest;
use App\Models\Plan;
use App\Models\Recovery;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class PlanController extends Controller
{
    /**
     * 计划列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_t' => $request->input('_t', 'name'),
            '_kw' => $request->input('_kw', ''),
            'page_size' => $request->input('page_size', '10'),
        ];
        $lists = Plan::select()
            ->withCount('recovery')
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where($params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->orderBy('created_at', 'desc')
            ->orderBy('id', 'desc')
            ->paginate($params['page_size']);
        return view('admin.plan.index', compact('lists', 'params'));
    }

    /**
     * 添加计划
     * @param PlanRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(PlanRequest $request)
    {
        $res = Plan::where('status',1)->count();
        if($res){
            return self::error('目前尚有发放中的计划，不能添加');
        }
        $data = $request->all();
        $plan = new Plan();
        $plan->fill($data);
        if ($plan->save()) {
            return self::success('新增计划成功');
        }
        return self::error('新增计划失败');
    }

    /**
     * 编辑计划
     * @param $id
     * @return string
     * @throws \Throwable
     */
    public function edit($id)
    {
        $plan = Plan::find($id);
        return view('admin.plan.edit', compact('plan'))->render();
    }

    /**
     * 更新计划
     * @param PlanRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(PlanRequest $request)
    {
        $plan = Plan::find($request->input('id'));
        $plan->fill($request->all());
        if($request->status == 2){
            $plan->end_at = time();
        }
        if ($plan->where([
            ['name', $request->input('name')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该名称已存在');
        }
        if ($plan->save()) {
            return self::success('修改计划成功');
        }
        return self::error('修改计划失败');
    }

    /**
     * 删除计划
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $plan = Plan::withCount('recovery', 'label')->findOrFail($id);
        if($plan->recovery_count || $plan->label_count){
            return self::error('该计划不能删除');
        }
        if ($plan->delete()) {
            return self::success('删除计划成功');
        }
        return self::error('删除计划失败');
    }
}
