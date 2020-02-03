<?php

namespace App\Http\Controllers\Admin;

use App\Models\LoginLog;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class LogController extends Controller
{
    /**
     * 登录日志列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_t' => $request->input('_t', 'name'),
            '_kw' => $request->input('_kw', ''),
            'start_time' => $request->input('start_time', ''),
            'end_time' => $request->input('end_time', ''),
            'name' => $request->input('name', ''),
        ];

        $lists = LoginLog::select('login_logs.*')
            ->join('admins as a', 'login_logs.user_id', '=', 'a.id')
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where($params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->when($params['name'], function ($query) use ($params) {
                return $query->where('a.name', 'like', '%' . $params['name'] . '%');
            })
            ->when($params['start_time'], function ($query) use ($params) {
                return $query->where('login_logs.time', '>=', $params['start_time']);
            })
            ->when($params['end_time'], function ($query) use ($params) {
                return $query->where('login_logs.time', '<=', $params['end_time']);
            })
            ->when(!Auth::guard('admin')->user()->hasRole('SuperAdmin'), function ($query) {
                return $query->where('user_id', Auth::guard('admin')->id());
            })
            ->orderBy('time', 'desc')
            ->orderBy('login_logs.id', 'desc')
            ->paginate(10);
        return view('admin.login_log.index', compact('lists', 'params'));
    }

    /**
     * 删除登录日志
     * @param Request $request
     * @param null $id
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function destroy(Request $request, $id = null)
    {
        if (LoginLog::whereIn('id', explode(',', $id ?? $request->input('id')))->delete()) {
            return self::success('登录日志删除成功');
        }
        return self::error('登录日志删除失败');
    }
}
