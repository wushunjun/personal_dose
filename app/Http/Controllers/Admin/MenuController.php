<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\MenuRequest;
use App\Models\Menu;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class MenuController extends Controller
{
    /**
     * 资源列表
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $pid = Menu::where('pid', 0)->get();
        $params = [
            '_t' => $request->input('_t', 'name'),
            '_kw' => $request->input('_kw', ''),
        ];
        $lists = Menu::select()
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where($params['_t'], 'like', '%' . $params['_kw'] . '%');
            })
            ->orderBy('pid', 'asc')
            ->orderBy('sort', 'desc')
            ->orderBy('created_at', 'desc')
            ->orderBy('id', 'desc')
            ->paginate(10);
        return view('admin.menu.index', compact('lists', 'params', 'pid'));
    }

    /**
     * 添加资源
     * @param MenuRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function store(MenuRequest $request)
    {
        $menu = new Menu;
        $menu->name = $request->get('name');
        $menu->link = $request->get('link', '-');
        $menu->permission = $request->get('permission', '-');
        $menu->pid = $request->get('pid', 0);
        $menu->icon = $request->get('icon', '-');
        $menu->sort = $request->get('sort', 0);
        if ($menu->save()) {
            return self::success('添加资源成功');
        }
        return self::error('添加资源失败');
    }

    /**
     * 编辑资源
     * @param $id
     * @return string
     */
    public function edit($id)
    {
        $menu = Menu::findOrFail($id);
        $pid = Menu::where('pid', 0)->get();
        return view('admin.menu.edit', compact('menu', 'pid'))->render();
    }

    /**
     * 更新资源
     * @param MenuRequest $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function update(MenuRequest $request)
    {
        $menu = Menu::find($request->input('id'));
        if ($menu->where([
            ['name', $request->input('name')],
            ['id', '<>', $request->input('id')]
        ])->count()) {
            return self::error('该资源名称已存在');
        }
        $menu->fill($request->all());
        if ($menu->save()) {
            return self::success('修改资源成功');
        }
        return self::error('修改资源失败');
    }

    /**
     * 删除资源
     * @param $id
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function destroy($id)
    {
        $menu = Menu::findOrFail($id);
        $tips = '';
        if ($menu->delete()) {
            if (0 == $menu->pid) {
                $menu->where('pid', $menu->id)->update(['pid' => 0]);
                $tips = "<br/>该资源下所有子资源已转换为顶级资源";
            }
            return self::success('删除资源成功' . $tips);
        }
        return self::error('删除资源失败');
    }
}
