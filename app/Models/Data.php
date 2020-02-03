<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Data extends Model
{



    protected $guarded = ['_token'];


    public function  setCreatedAtAttribute($value)
    {
        $this->attributes['created_at'] = strtotime($value);
    }

    public function  setUpdatedAtAttribute($value)
    {
        $this->attributes['updated_at'] = strtotime($value);
    }
}
