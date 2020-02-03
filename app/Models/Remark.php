<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Remark extends Model
{

    const FORBIDDEN = 0;//禁用
    const NORMAL = 1;//正常


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
        self::FORBIDDEN => '离职',
        self::NORMAL => '在职',
    ];
}
