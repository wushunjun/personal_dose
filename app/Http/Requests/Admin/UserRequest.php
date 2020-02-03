<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UserRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        if ($this->input('id')) {
            $rules['name'] = 'required';
        }else{
            //$rules['name'] = 'required|unique:users,name';
            $rules['name'] = 'required';
            $rules['number_id'] = 'required';
            $rules['region_id'] = 'required';
            $rules['number'] = 'numeric';
            $rules['company_id'] = 'required';
        }
        $rules['vocation_id'] = 'required';
        return $rules;
    }

    public function messages()
    {
        return [
            'name.required' => '请填写用户名',
            //'name.unique' => '该用户名已存在',
            'region_id.required' => '请选择区域',
            'company_id.required' => '请选择单位',
            'number_id.required' => '请选择号牌',
            'vocation_id.required' => '请选择职业',
            'number.numeric' => '证件编号只能是数字',
        ];
    }
}
