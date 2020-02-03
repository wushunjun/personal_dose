<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class NumberRequest extends FormRequest
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
            $rules['number'] = 'required|numeric';
        }/*else{
            $rules['number'] = 'required|numeric|unique:numbers,number';
        }*/
        $rules['region_id'] = 'required';
        $rules['company_id'] = 'required';
        return $rules;
    }

    public function messages()
    {
        return [
            'number.required' => '请填写编号',
            'number.numeric' => '编号只能是数字',
            'region_id.required' => '请选择区域',
            'company_id.required' => '请选择单位',
        ];
    }
}
