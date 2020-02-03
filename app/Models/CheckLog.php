<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CheckLog extends Model
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
        self::FORBIDDEN => '<label class="label label-danger">未送样</label>',
        self::NORMAL => '<label class="label label-success">已送样</label>',
    ];

    public function user(){
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function label(){
        return $this->hasOne(Label::class, 'id', 'label_id');
    }

    public function check($label_id, $plan_id){
        $label = Label::findOrFail($label_id);
        $recovery = Recovery::where('plan_id', $plan_id)->where('number', $label['number'])->first();
        $data = [
            'label_id' => $label_id,
            'plan_id' => $plan_id,
            'user_id' => $label['user_id'],
            'company_id' => User::where('id', $label['user_id'])->value('company_id'),
            'status' => $recovery ? 1 : 0,
            'admin_name' => auth()->guard('admin')->user()->name,
        ];
        $this->fill($data);
        if ($this->save()) {
            if($recovery){
                $recovery->status = 1;
                $recovery->save();
            }
            $label->status = 2;
            $label->save();
            $label_log = new LabelLog();
            $remark = $recovery ? '已送样' : '未送样';
            $label_log->add_log($label_id, 1, '样品回收：' . $remark, $plan_id);
            return true;
        }
        return false;
    }
}
