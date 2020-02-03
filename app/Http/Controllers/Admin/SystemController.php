<?php

namespace App\Http\Controllers\Admin;

use App\Models\AuditionsArea;
use App\Models\System;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;

class SystemController extends Controller
{
    /**
     * 系统设置
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index()
    {
        $config = System::pluck('value', 'code');
        return view('admin.system.index', compact('config'));
    }

    /**
     * 更新系统设置
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(Request $request)
    {
        $requestDate = $request->except('_token');

        //到期提醒期限必须小于每期时长
        if (isset($requestDate['expired_remind'])
            && isset($requestDate['auth_time_for_period'])
            && ($requestDate['expired_remind'] >= $requestDate['auth_time_for_period'])) {
            return self::error('到期提醒期限必须小于每期时长');
        }

        foreach ($requestDate as $k => &$item) {
            if ('platform_logo' == $k && empty($item)) continue;
            $system = System::where('code', $k)->first() ?? new System();
            $system->code = $k;
            $system->value = $item;
            if ($system->save()) {
                continue;
            } else {
                return self::error('更新失败');
            }
        }
        unset($item);
        return self::success('更新成功', null, false);

    }

    /**
     * 上传图片
     * @param Request $request
     * @return string
     */
    public function upload(Request $request)
    {
        if ($request->hasFile('uploadImage') && $request->file('uploadImage')->isValid()) {
            switch ($request->type) {
                case 'background_image':
                    $storePath = 'app_background';
                    break;
                case 'platform_logo':
                    $storePath = 'platform_logo';
                    break;
                default:
                    $storePath = 'app_images';
                    break;
            }

            $filename = $request->file('uploadImage')->store($storePath);
            return self::success('上传成功', ['path' => $filename]);
        }
        return self::error('上传失败');
    }

}
