<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Recovery extends Model
{
    protected $guarded = ['_token'];

    protected $table = 'recovery';

    //public $timestamps = false;//关闭自动维护

    public  function  setCreatedAtAttribute($value)
    {
        $this->attributes['created_at'] = strtotime($value);
    }

    public  function  setUpdatedAtAttribute($value)
    {
        $this->attributes['updated_at'] = strtotime($value);
    }
}
