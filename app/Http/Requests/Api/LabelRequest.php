<?php

namespace App\Http\Requests\Api;

use Illuminate\Foundation\Http\FormRequest;

class LabelRequest extends FormRequest
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
        $rules['type'] = 'required|in:1,2';
        $rules['label'] = 'required|array';
        return $rules;
    }

    public function messages()
    {
        return [
            'type.required' => '缺少类型参数',
            'label.required' => '缺少标签参数',
            'type.in' => '类型参数有误',
            'label.array' => '标签参数有误',
        ];
    }
}
