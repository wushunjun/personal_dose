<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\CompanyRequest;
use App\Models\Company;
use App\Models\Number;
use App\Models\Region;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Rap2hpoutre\FastExcel\FastExcel;

class CompanyController extends Controller
{
    /**
     * 单位列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_t' => $request->input('_t', 'name'),
            '_kw' => $request->input('_kw', ''),
            'region_id' => $request->input('region_id', '0'),
            'page_size' => $request->input('page_size', '10'),
        ];
        $lists = Company::select()
            ->with('region')
            ->withCount('user')
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where($params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->when($params['region_id'], function ($query) use ($params) {
                return $query->where('region_id', '=', $params['region_id']);
            })
            ->orderBy('created_at', 'desc')
            ->orderBy('id', 'desc')
            ->paginate($params['page_size']);
        $Region = new Region();
        $region = $Region->getTree();
        return view('admin.company.index', compact('lists', 'params', 'region'));
    }

    /**
     * 添加单位
     * @param CompanyRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(CompanyRequest $request)
    {
        $data = $request->all();
        $company = new Company();
        $company->fill($data);
        if ($company->save()) {
            return self::success('新增单位成功');
        }
        return self::error('新增单位失败');
    }

    /**
     * 编辑单位
     * @param $id
     * @return string
     * @throws \Throwable
     */
    public function edit($id)
    {
        $company = Company::find($id);
        $Region = new Region();
        $region = $Region->getTree();
        return view('admin.company.edit', compact('company', 'region'))->render();
    }

    /**
     * 更新单位
     * @param CompanyRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(CompanyRequest $request)
    {
        $company = Company::find($request->input('id'));
        $company->fill($request->all());
        if ($company->where([
            ['name', $request->input('name')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该名称已存在');
        }
        if ($company->save()) {
            return self::success('修改单位成功');
        }
        return self::error('修改单位失败');
    }

    /**
     * 删除单位
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $company = Company::findOrFail($id);
        $user_count = User::where('company_id', $id)->count();
        if($user_count > 0){
            return self::error('该单位下还有人员信息，不能删除');
        }
        $number_count = Number::where('company_id', $id)->count();
        if($number_count > 0){
            return self::error('该单位下还有号牌信息，不能删除');
        }
        if ($company->delete()) {
            return self::success('删除单位成功');
        }
        return self::error('删除单位失败');
    }
    /**
     * 获取单位列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function get_company(Request $request)
    {
        $region_id = $request->region_id;
        $company = Company::where('region_id', $region_id)->get();
        return response()->json([
            'message' => 'success',
            'data' => $company
        ]);
    }
    /**
     * 数据导入
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function import(Request $request)
    {
        $filePath = $request->file;
        $data = (new FastExcel())->import('.'.$filePath)->toArray();
        foreach($data as $k => $v){
            $v = array_values($v);
            $region = Region::where('name', $v[1])->first();
            if(!$region){
                continue;
            }
            $data = [
                'name' => $v[0],
                'region_id' => $region['id'],
                'number' => $v[2],
                'contact' => $v[3],
                'mobile' => $v[4],
            ];
            $company = new Company();
            $company->fill($data);
            if (!$company->save()) {
                continue;
            }
        }
        return self::success('导入数据成功');
    }
}
