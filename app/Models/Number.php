<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Number extends Model
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
        self::FORBIDDEN => '<label class="label label-default">未使用</label>',
        self::NORMAL => '<label class="label label-success">使用中</label>',
    ];

    /**
     * 获取未使用的牌号
     */
    public function get_not_use($company_id, $number_id = 0){
        $ids = User::pluck('number_id')->toArray();
        if($number_id){
            foreach($ids as $k=>$v){
                if($number_id == $v){
                    unset($ids[$k]);
                }
            }
        }
        $list = self::whereNotIn('id', $ids)->where('company_id', $company_id)->get();
        return $list;
    }

    public function region(){
        return $this->hasOne(Region::class, 'id', 'region_id');
    }
    public function company(){
        return $this->hasOne(Company::class, 'id', 'company_id');
    }
    public function user(){
        return $this->hasOne(User::class, 'number_id', 'id');
    }
}
