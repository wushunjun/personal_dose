<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\UserRequest;
use App\Models\Number;
use App\Models\Region;
use App\Models\Company;
use App\Models\User;
use App\Models\Vocation;
use App\Models\Label;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Rap2hpoutre\FastExcel\FastExcel;

class UserController extends Controller
{
    /**
     * 人员列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_t' => $request->input('_t', 'name'),
            '_kw' => $request->input('_kw', ''),
            'company_id' => $request->input('company_id', '0'),
            'vocation_id' => $request->input('vocation_id', '0'),
            'page_size' => $request->input('page_size', '10'),
            'status' => $request->input('status', '-1'),
        ];
        $where = [];
        if($params['company_id']){
            $where['users.company_id'] = $params['company_id'];
        }
        if($params['vocation_id']){
            $where['users.vocation_id'] = $params['vocation_id'];
        }
        if($params['status'] != -1){
            $where['users.status'] = $params['status'];
        }
        $lists = User::select('users.*')->with('company', 'card_number', 'vocation')
            ->withCount('label')
            ->join('company as c', 'users.company_id', '=', 'c.id')
            ->leftJoin('numbers as n', 'users.number_id', '=', 'n.id')
            ->when($params['_kw'], function ($query) use ($params) {
                if($params['_t'] != 'card_number'){
                    return $query->where('users.' . $params['_t'], 'like', '%' . $params['_kw'] . '%')->orWhere('c.name', 'like', '%' . $params['_kw'] . '%');
                }else{
                    return $query->where(\DB::raw('concat(c.number,n.number)'), 'like', '%' . $params['_kw'] . '%');
                }
            })
            ->where($where)
            ->orderBy('users.created_at', 'desc')
            ->orderBy('users.id', 'desc')
            ->paginate($params['page_size']);
        $Region = new Region();
        $region = $Region->getTree();
        $vocation = Vocation::where('status',1)->get();
        $companys = Company::where('status',1)->get();
        return view('admin.user.index', compact('lists', 'params', 'region', 'vocation', 'companys'));
    }

    /**
     * 添加人员
     * @param UserRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(UserRequest $request)
    {
        $data = $request->all();
        $user = new User();
        $user->fill($data);
        if ($user->save()) {
            return self::success('新增人员成功');
        }
        return self::error('新增人员失败');
    }

    /**
     * 编辑人员
     * @param $id
     * @return string
     * @throws \Throwable
     */
    public function edit($id)
    {
        $user = User::find($id);
        $Region = new Region();
        $region = $Region->getTree();
        $company = Company::where('status',1)->where('region_id',$user['region_id'])->get();
        $Number = new Number();
        $number = $Number->get_not_use($user['company_id'], $user['number_id']);
        $vocation = Vocation::where('status',1)->get();
        return view('admin.user.edit', compact('user', 'region', 'company', 'number', 'vocation'))->render();
    }

    /**
     * 更新人员
     * @param UserRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(UserRequest $request)
    {
        $user = User::find($request->input('id'));

        $user->fill($request->all());
        /*if ($user->where([
            ['name', $request->input('name')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该姓名已存在');
        }*/

        if ($user->save()) {
            return self::success('修改人员成功');
        }
        return self::error('修改人员失败');
    }

    /**
     * 删除人员
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $user = User::findOrFail($id);
        $label_count = Label::where('user_id', $id)->count();
        if($label_count){
            return self::error('请先解绑该人员的所有剂量牌标签');
        }
        if ($user->delete()) {
            return self::success('删除人员成功');
        }
        return self::error('删除人员失败');
    }

    public function print_number(Request $request){
        if($request->id){
            $lists = User::whereIn('id', $request->id)->get();
        }
        if($request->company_id){
            $lists = User::whereIn('company_id', $request->company_id)->get();
        }
        return view('admin.user.print_number', compact('lists'));
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
            $number = Number::where(['number' => $v[2], 'company_id' => $company['id']])->first();
            if(!$number){
                continue;
            }
            $vocation = Vocation::where('name', $v[3])->first();
            if(!$vocation){
                continue;
            }
            $data = [
                'name' => $v[0],
                'region_id' => $company['region_id'],
                'company_id' => $company['id'],
                'number_id' => $number['id'],
                'vocation_id' => $vocation['id'],
                'number' => $v[4],
                'entry_at' => $v[5],
                'sex' => $v[6] == '男' ? '0' : '1',
            ];
            $user = new User();
            $user->fill($data);
            if (!$user->save()) {
                continue;
            }
        }
        return self::success('导入数据成功');
    }
}
