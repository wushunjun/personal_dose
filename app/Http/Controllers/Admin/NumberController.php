<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\NumberRequest;
use App\Models\Number;
use App\Models\Region;
use App\Models\Company;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Rap2hpoutre\FastExcel\FastExcel;

class NumberController extends Controller
{
    /**
     * 号牌列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_t' => $request->input('_t', 'number'),
            '_kw' => $request->input('_kw', ''),
            'region_id' => $request->input('region_id', ''),
            'status' => $request->input('status', '0'),
            'page_size' => $request->input('page_size', '10'),
        ];
        $where = [];
        if($params['region_id']){
            $where['numbers.region_id'] = $params['region_id'];
        }
        $number_ids = User::pluck('number_id');
        $lists = Number::select('numbers.*')->with('company','region','user')
            ->join('company as c', 'numbers.company_id', '=', 'c.id')
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where('c.name', 'like', '%' . $params['_kw'] . '%');
            })
            ->when($params['status'], function ($query) use ($params, $number_ids) {
                if($params['status'] == 1){
                    return $query->whereIn('numbers.id', $number_ids);
                }else{
                    return $query->whereNotIn('numbers.id', $number_ids);
                }
            })
            ->where($where)
            ->orderBy('numbers.created_at', 'desc')
            ->orderBy('numbers.id', 'desc')
            ->paginate($params['page_size']);
        $Region = new Region();
        $region = $Region->getTree();
        $companys = Company::where('status',1)->get();
        return view('admin.number.index', compact('lists', 'params', 'region', 'companys'));
    }

    /**
     * 添加号牌
     * @param NumberRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(NumberRequest $request)
    {
        $data = [
            'region_id' => $request->region_id,
            'company_id' => $request->company_id,
            'created_at' => time(),
        ];
        if($request->number){
            $all = [];
            foreach($request->number as $k => $v){
                if(!is_numeric($v)){
                    return self::error('编号必须是数字');
                }
                $res = Number::where(['number' => $v, 'company_id' => $data['company_id']])->first();
                if($res){
                    return self::error('编号' . $v . '已存在');
                }
                $number_data = $data;
                $number_data['number'] = $v;
                $all[] = $number_data;
            }
            $res = DB::table('numbers')->insert($all);
            if ($res) {
                return self::success('新增号牌成功');
            }
            return self::error('新增号牌失败');
        }else{
            return self::error('至少添加一个编号');
        }

    }

    /**
     * 编辑号牌
     * @param $id
     * @return string
     * @throws \Throwable
     */
    public function edit($id)
    {
        $number = Number::find($id);
        $Region = new Region();
        $region = $Region->getTree();
        $company = Company::where('status',1)->where('region_id',$number['region_id'])->get();
        return view('admin.number.edit', compact('number', 'region', 'company'))->render();
    }

    /**
     * 更新号牌
     * @param NumberRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(NumberRequest $request)
    {
        $number = Number::find($request->input('id'));
        $number->fill($request->all());
        if ($number->where([
            ['number', $request->input('number')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该编号已存在');
        }
        if ($number->save()) {
            return self::success('修改号牌成功');
        }
        return self::error('修改号牌失败');
    }

    /**
     * 删除号牌
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $user_count = User::where('number_id', $id)->count();
        if($user_count > 0){
            return self::error('该号牌在使用中，不能删除');
        }
        $number = Number::findOrFail($id);
        if ($number->delete()) {
            return self::success('删除号牌成功');
        }
        return self::error('删除号牌失败');
    }
    /**
     * 获取单位列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function get_numbers(Request $request)
    {
        $company_id = $request->company_id;
        $Number = new Number();
        $numbers = $Number->get_not_use($company_id);
        return response()->json([
            'message' => 'success',
            'data' => $numbers
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
            $company = Company::where('name', $v[1])->first();
            if(!$company){
                continue;
            }
            $data = [
                'number' => $v[0],
                'company_id' => $company['id'],
                'region_id' => $company['region_id'],
            ];
            $number = new Number();
            $number->fill($data);
            if (!$number->save()) {
                continue;
            }
        }
        return self::success('导入数据成功');
    }
}
