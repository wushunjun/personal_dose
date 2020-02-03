<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class PlanRequest extends FormRequest
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
            $rules['name'] = 'required|unique:plans,name';
        }
        return $rules;
    }

    public function messages()
    {
        return [
            'name.required' => '请填写名称',
            'name.unique' => '该名称已存在',
        ];
    }
}
