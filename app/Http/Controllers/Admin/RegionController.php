<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\RegionRequest;
use App\Models\Company;
use App\Models\Region;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class RegionController extends Controller
{
    /**
     * 区域列表
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
        $lists = Region::select()
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where($params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->orderBy('pid', 'asc')
            ->orderBy('created_at', 'desc')
            ->orderBy('id', 'desc')
            ->paginate($params['page_size']);
        $pid = Region::where('pid', 0)->get();
        return view('admin.region.index', compact('lists', 'params', 'pid'));
    }

    /**
     * 添加区域
     * @param RegionRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(RegionRequest $request)
    {
        $data = $request->all();
        $region = new Region();
        $region->fill($data);
        if ($region->save()) {
            return self::success('新增区域成功');
        }
        return self::error('新增区域失败');
    }

    /**
     * 编辑区域
     * @param $id
     * @return string
     * @throws \Throwable
     */
    public function edit($id)
    {
        $region = Region::find($id);
        $pid = Region::where('pid', 0)->get();
        return view('admin.region.edit', compact('region', 'pid'))->render();
    }

    /**
     * 更新区域
     * @param RegionRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(RegionRequest $request)
    {
        $region = Region::find($request->input('id'));
        $region->fill($request->all());
        if ($region->where([
            ['name', $request->input('name')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该名称已存在');
        }
        if ($region->save()) {
            return self::success('修改区域成功');
        }
        return self::error('修改区域失败');
    }

    /**
     * 删除区域
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $region_count = Region::where('pid', $id)->count();
        if($region_count > 0){
            return self::error('该区域下还有子区域，不能删除');
        }
        $company_count = Company::where('region_id', $id)->count();
        if($company_count > 0){
            return self::error('该区域下还有单位，不能删除');
        }
        $user_count = User::where('region_id', $id)->count();
        if($user_count > 0){
            return self::error('该区域下还有人员，不能删除');
        }
        $region = Region::findOrFail($id);
        if ($region->delete()) {
            return self::success('删除区域成功');
        }
        return self::error('删除区域失败');
    }
}
