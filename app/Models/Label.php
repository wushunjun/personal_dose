<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Label extends Model
{

    const FORBIDDEN = 0;//禁用
    const NORMAL = 1;//正常

    const NO_GRANT = 0;//未发放
    const HAS_GRANT = 1;//已发放
    const RECOVERY = 2;//已回收
    const SCRAP = 3;//已报废


    protected $guarded = ['_token'];

    //public $timestamps = false;//关闭自动维护

    public function  setCreatedAtAttribute($value)
    {
        $this->attributes['created_at'] = strtotime($value);
    }

    public function  setUpdatedAtAttribute($value)
    {
        $this->attributes['updated_at'] = strtotime($value);
    }

    public static $UseStatusText = [
        self::FORBIDDEN => '<label class="label label-default">未使用</label>',
        self::NORMAL => '<label class="label label-success">使用中</label>',
    ];

    public static $statusText = [
        self::NO_GRANT => '<label class="label label-default">未发放</label>',
        self::HAS_GRANT => '<label class="label label-success">已发放</label>',
        self::RECOVERY => '<label class="label label-primary">已回收</label>',
        self::SCRAP => '<label class="label label-danger">已报废</label>',
    ];

    public function user()
    {
        return $this->hasOne(User::class, 'id', 'user_id');
    }

    public function getUseStatusAttribute()
    {
        return $this->attributes['user_id'] ? 1 : 0;
    }

    public function grant($label_id, $plan){
        $label = $this::select('labels.*', 'p.status as plan_status')->leftJoin('plans as p', 'p.id', '=', 'labels.plan_id')->where('labels.id', $label_id)->first();
        if(!in_array($label->status, [0,2])){//只有未发放和已回收才能发放
            return true;
        }
        if($label->status == 2 && $label->plan_status != 3){//当标签状态为已回收，但是对应的计划还没结束时
            return true;
        }
        $label->status = 1;
        $label->plan_id = $plan['id'];
        $label->send_at = time();
        if ($label->save()) {
            $label_log = new LabelLog();
            $label_log->add_log($label_id, 0, '剂量牌发放', $plan['id']);
            return true;
        }
        return false;
    }
}
