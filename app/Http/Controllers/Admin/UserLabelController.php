<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\UserLabelRequest;
use App\Models\Label;
use App\Models\LabelLog;
use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserLabelController extends Controller
{
    /**
     * 标签列表
     * @param $user_id
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index($user_id, Request $request)
    {
        $params = [
            '_kw' => $request->input('_kw', ''),
            'page_size' => $request->input('page_size', '10'),
        ];
        $user = User::findOrFail($user_id);
        $lists = Label::select()
            ->when($params['_kw'], function($query) use ($params){
                return $query->where('number', 'like', "%$params[_kw]%");
            })
            ->where('user_id',$user_id)
            ->orderBy('id', 'desc')
            ->paginate($params['page_size']);
        $labels = Label::where('user_id',0)->orderBy('id','desc')->get();
        return view('admin.user_label.index', compact('lists', 'user', 'labels', 'params'));
    }

    /**
     * 添加标签
     * @param UserLabelRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(UserLabelRequest $request)
    {
        $data = $request->all();
        $label = Label::findOrFail($data['label_id']);
        $label->user_id = $data['user_id'];
        $label->bind_at = time();
        if ($label->save()) {
            return self::success('绑定标签成功');
        }
        return self::error('绑定标签失败');
    }

    /**
     * 解绑标签
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $label = Label::findOrFail($id);
        $label->user_id = 0;
        if ($label->save()) {
            return self::success('解绑标签成功');
        }
        return self::error('解绑标签失败');
    }
    /**
     * 标签报废
     * @param $id
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function scrap($id, Request $request)
    {
        $label = Label::findOrFail($id);
        $label->status = 3;
        if ($label->save()) {
            $label_log = new LabelLog();
            $remark = $request->type == 1 ? '剂量牌已报废' : '剂量牌未报废';
            $label_log->add_log($id, 2, '标签报废：' . $remark);
            return self::success('报废成功');
        }
        return self::error('报废失败');
    }
}
