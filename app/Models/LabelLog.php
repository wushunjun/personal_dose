<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LabelLog extends Model
{

    const SEND = 0;//发放
    const RECOVERY = 1;//回收
    const SCRAP = 2;//报废


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
        self::SEND => '<label class="label label-primary">发放</label>',
        self::RECOVERY => '<label class="label label-success">回收</label>',
        self::SCRAP => '<label class="label label-danger">报废</label>',
    ];

    public function user(){
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function label(){
        return $this->hasOne(Label::class, 'id', 'label_id');
    }

    public function add_log($label_id, $status, $remark, $plan_id = 0){
        $label = Label::findOrFail($label_id);
        $user = User::findOrFail($label['user_id']);
        $data = [
            'label_id' => $label_id,
            'user_id' => $label['user_id'],
            'plan_id' => $plan_id,
            'company_id' => $user['company_id'],
            'status' => $status,
            'remark' => $remark,
            'admin_name' => auth()->guard('admin')->user()->name ?? '扫码发放',
        ];
        $this->fill($data);
        if ($this->save()) {
            return true;
        }
        return false;
    }
}
