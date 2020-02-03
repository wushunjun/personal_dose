<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    protected $table = 'menus';
    protected $guarded = ['_token'];

    /**
     * 获取父级资源名称
     * @param $pid
     * @return mixed
     */
    public function getParentMenu($pid)
    {
        return $pid ? self::where('id', $pid)->value('name') : '顶级资源';
    }
}
