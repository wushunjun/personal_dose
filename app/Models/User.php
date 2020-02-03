<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    const FORBIDDEN = 0;//禁用
    const NORMAL = 1;//正常
    const RETIRE = 2;//退休
    const MAN = 0;//男
    const WOMAN = 1;//女


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
    public function  setEntryAtAttribute($value)
    {
        $this->attributes['entry_at'] = $value ? strtotime($value) : 0;
    }
    public function getWorkYearsAttribute(){
        return $this->entry_at ? round((time() - $this->entry_at)/3600/24/365,1) . '年' : '暂无';
    }
    public static $statusText = [
        self::FORBIDDEN => '<label class="label label-default">离职</label>',
        self::NORMAL => '<label class="label label-success">在职</label>',
        self::RETIRE => '<label class="label label-warning">退休</label>',
    ];

    public static $sexText = [
        self::MAN => '<label class="label label-info">男</label>',
        self::WOMAN => '<label class="label label-success">女</label>',
    ];

    public function card_number()
    {
        return $this->hasOne(Number::class, 'id', 'number_id');
    }

    public function company()
    {
        return $this->hasOne(Company::class, 'id', 'company_id');
    }

    public function vocation()
    {
        return $this->hasOne(Vocation::class, 'id', 'vocation_id');
    }

    public function label()
    {
        return $this->hasOne(Label::class, 'user_id', 'id');
    }

    public function get_user_number_list($params)
    {
        $all_user = User::select('users.*','c.name as company_name', 'c.number as company_number', 'n.number as card_number')
            ->with('vocation')
            ->join('company as c', 'users.company_id', '=', 'c.id')
            ->join('numbers as n', 'users.number_id', '=', 'n.id')
            ->when($params['_kw'], function ($query) use ($params) {
                return $query->where(\DB::raw('concat(users.name,c.name,c.number,n.number)'), 'like', '%' . $params['_kw'] . '%');
            })
            ->when($params['company_id'], function ($query) use ($params) {
                return $query->where('users.company_id', $params['company_id']);
            })
            ->when($params['vocation_id'], function ($query) use ($params) {
                return $query->where('users.vocation_id', $params['vocation_id']);
            })
            ->get();
        $user_lists = [];
        foreach ($all_user as $k => $v) {
            $user_lists[$v->company_number . $v->card_number] = $v;
        }
        return $user_lists;
    }
}
