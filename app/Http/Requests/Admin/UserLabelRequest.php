<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UserLabelRequest extends FormRequest
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
        $rules['user_id'] = 'required|integer';
        $rules['label_id'] = 'required|integer';
        return $rules;
    }

    public function messages()
    {
        return [
            'user_id.required' => '非法操作',
            'user_id.integer' => '非法操作',
            'label_id.integer' => '非法操作',
            'label_id.required' => '请选择标签',
        ];
    }
}
