<?php

namespace App\Http\Controllers\Admin;

use App\Models\Company;
use App\Models\Label;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class LabelController extends Controller
{
    /**
     * 标签列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_t' => $request->input('_t', 'number'),
            '_kw' => $request->input('_kw', ''),
            'status' => $request->input('status', '0'),
            'company_id' => $request->input('company_id', '0'),
            'page_size' => $request->input('page_size', '10'),
        ];
        $lists = Label::select('labels.*')
            ->leftJoin('users as u', 'labels.user_id', '=', 'u.id')
            ->leftJoin('company as c', 'u.company_id', '=', 'c.id')
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where('c.name', 'like', '%' . $params['_kw'] . '%')->orWhere('u.name', 'like', '%' . $params['_kw'] . '%');
            })
            ->when($params['status'], function ($query) use ($params) {
                if($params['status'] == 1){
                    return $query->where('labels.user_id', '>', 0);
                }else{
                    return $query->where('labels.user_id', '=', 0);
                }
            })
            ->when($params['company_id'], function ($query) use ($params) {
                return $query->where('u.company_id', '=', $params['company_id']);
            })
            ->orderBy('labels.created_at', 'desc')
            ->orderBy('labels.id', 'desc')
            ->paginate($params['page_size']);
        $companys = Company::get();
        return view('admin.label.index', compact('lists', 'params', 'companys'));
    }

    /**
     * 删除标签
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $label = Label::findOrFail($id);
        if ($label->delete()) {
            return self::success('删除标签成功');
        }
        return self::error('删除标签失败');
    }
}
