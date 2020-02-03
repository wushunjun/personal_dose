<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Region extends Model
{

    const FORBIDDEN = 0;//禁用
    const NORMAL = 1;//正常


    protected $guarded = ['_token'];

    protected $table = 'region';

    //public $timestamps = false;//关闭自动维护

    public  function  setCreatedAtAttribute($value)
    {
        $this->attributes['created_at'] = strtotime($value);
    }

    public  function  setUpdatedAtAttribute($value)
    {
        $this->attributes['updated_at'] = strtotime($value);
    }

    public function company(){
        return $this->hasMany(Company::class, 'region_id', 'id');
    }
    public static $statusText = [
        self::FORBIDDEN => '<label class="label label-default">已禁用</label>',
        self::NORMAL => '<label class="label label-success">已启用</label>',
    ];

    /**
     * 获取父级名称
     * @param $pid
     * @return mixed
     */
    public function getParentRegion($pid)
    {
        return $pid ? self::where('id', $pid)->value('name') : '顶级';
    }
    /**
     * 获取树形结构
     * @return mixed
     */
    public function getTree()
    {
        return cateTree(self::where('status',1)->get(), 'id', 'pid');
    }
}
