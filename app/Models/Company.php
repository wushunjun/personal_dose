<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Company extends Model
{

    const FORBIDDEN = 0;//禁用
    const NORMAL = 1;//正常


    protected $guarded = ['_token'];

    protected $table = 'company';

    //public $timestamps = false;//关闭自动维护

    public function region(){
        return $this->belongsTo(Region::class);
    }
    public  function  setCreatedAtAttribute($value)
    {
        $this->attributes['created_at'] = strtotime($value);
    }

    public  function  setUpdatedAtAttribute($value)
    {
        $this->attributes['updated_at'] = strtotime($value);
    }

    public function user(){
        return $this->hasMany(User::class);
    }
    public static $statusText = [
        self::FORBIDDEN => '<label class="label label-default">已禁用</label>',
        self::NORMAL => '<label class="label label-success">已启用</label>',
    ];
}
