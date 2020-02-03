<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\VocationRequest;
use App\Models\Vocation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class VocationController extends Controller
{
    /**
     * 职业列表
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
        $lists = Vocation::select()
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where($params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->orderBy('created_at', 'desc')
            ->orderBy('id', 'desc')
            ->paginate($params['page_size']);
        return view('admin.vocation.index', compact('lists', 'params'));
    }

    /**
     * 添加职业
     * @param VocationRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(VocationRequest $request)
    {
        $data = $request->all();
        $vocation = new Vocation();
        $vocation->fill($data);
        if ($vocation->save()) {
            return self::success('新增职业成功');
        }
        return self::error('新增职业失败');
    }

    /**
     * 编辑职业
     * @param $id
     * @return string
     * @throws \Throwable
     */
    public function edit($id)
    {
        $vocation = Vocation::find($id);
        return view('admin.vocation.edit', compact('vocation'))->render();
    }

    /**
     * 更新职业
     * @param VocationRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(VocationRequest $request)
    {
        $vocation = Vocation::find($request->input('id'));
        $vocation->fill($request->all());
        if ($vocation->where([
            ['name', $request->input('name')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该名称已存在');
        }
        if ($vocation->save()) {
            return self::success('修改职业成功');
        }
        return self::error('修改职业失败');
    }

    /**
     * 删除职业
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $vocation = Vocation::findOrFail($id);
        if ($vocation->delete()) {
            return self::success('删除职业成功');
        }
        return self::error('删除职业失败');
    }
}
