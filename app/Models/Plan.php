<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Plan extends Model
{

    const GRANT = 1;//发放中
    const RECOVERY = 2;//回收中
    const END = 3;//已结束


    protected $guarded = ['_token'];

    //public $timestamps = false;//关闭自动维护

    public  function  setCreatedAtAttribute($value)
    {
        $this->attributes['created_at'] = strtotime($value);
    }

    public  function  setUpdatedAtAttribute($value)
    {
        $this->attributes['updated_at'] = strtotime($value);
    }

    public static $statusText = [
        self::GRANT => '<label class="label label-success">发放中</label>',
        self::RECOVERY => '<label class="label label-warning">回收中</label>',
        self::END => '<label class="label label-danger">已结束</label>',
    ];

    public function recovery(){
        return $this->hasMany(Recovery::class, 'plan_id', 'id');
    }

    public function label(){
        return $this->hasMany(Label::class, 'plan_id', 'id');
    }

    public function get_grant_plan(){
        return $this->where('status', 1)->orderBy('id', 'desc')->first();
    }

    public function get_recovery_plan(){
        return $this->where('status', 2)->orderBy('id', 'desc')->first();
    }
}
