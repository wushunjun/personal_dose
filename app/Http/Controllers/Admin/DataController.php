<?php

namespace App\Http\Controllers\Admin;

use App\Models\Company;
use App\Models\Data;
use App\Models\User;
use App\Models\Vocation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Rap2hpoutre\FastExcel\FastExcel;

class DataController extends Controller
{
    /**
     * 数据分析
     * @param Request $request
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(Request $request)
    {
        $params = [
            '_kw' => $request->input('_kw', ''),
            'excel' => $request->input('excel', '0'),
            'start_time' => $request->input('start_time', ''),
            'end_time' => $request->input('end_time', ''),
            'company_id' => $request->input('company_id', '0'),
            'vocation_id' => $request->input('vocation_id', '0'),
            'page_size' => $request->input('page_size', '10'),
        ];
        $user_lists = (new User())->get_user_number_list($params);
        $object = Data::select()
            ->when(($params['_kw'] || $params['vocation_id'] || $params['company_id']), function ($query) use ($params, $user_lists) {
                return $query->whereIn('number', array_keys($user_lists));
            })
            ->when($params['start_time'], function ($query) use ($params) {
                return $query->where('created_at', '>=', strtotime($params['start_time']));
            })
            ->when($params['end_time'], function ($query) use ($params) {
                return $query->where('created_at', '<=', strtotime($params['end_time']));
            })
            ->orderBy(\DB::raw('LEFT(number,7)'), 'asc')
            ->orderBy(\DB::raw('IF(data1,1,0)'), 'desc')
            ->orderBy('number', 'asc');
        if ($params['excel']) {
            $lists = $object->get();
            $data = [];
            if (count($lists)) {
                foreach ($lists as $k => $v) {
                    $data[] = [
                        '个人剂量计编号' => $v['number'],
                        '实验室检测日期' => $v['test_at'],
                        '样品受理编号' => $v['accept_number'],
                        '委托单位名称（选填）' => '',
                        '射线及防护类型' => $v['type'],
                        'Hp(10)(未穿铅衣)（mSv）' => $v['data1'] ? $this->NumToStr(round($v['data1'], 5)) : '',
                        'Hp(3)(未穿铅衣)（mSv）' => '',
                        'Hp(0.07)(未穿铅衣)（mSv）' => '',
                        '铅衣内Hp(10)（mSv）' => $v['data4'] ? $this->NumToStr(round($v['data4'], 5)) : '',
                        '铅衣外Hp(10)（mSv）' => $v['data5'] ? $this->NumToStr(round($v['data5'], 5)) : '',
                        '铅衣外Hp(3)（mSv）' => '',
                        '铅衣外Hp(0.07)（mSv）' => '',
                        '中子Hp(10)（mSv）' => '',
                    ];
                }
                $list = collect($data);
                (new FastExcel($list))->export('data-download.xlsx');
            }
            return response()->download('data-download.xlsx', date('Y-m-d') . '.xlsx');
        } else {
            $lists = $object->paginate($params['page_size']);
            $vocation = Vocation::where('status', 1)->get();
            $companys = Company::get();
            $company_lists = Company::pluck('name', 'number');
            return view('admin.data.index', compact('lists', 'params', 'user_lists', 'vocation', 'companys', 'company_lists'));
        }
    }

    function NumToStr($num)
    {
        if (stripos($num, 'e') === false) return $num;
        $parts = explode('E', $num);
        if(count($parts) != 2){
            return $num;
        }
        $exp = abs(end($parts)) +3;
        $decimal = number_format($num, $exp);
        $decimal = rtrim($decimal, '0');
        return rtrim($decimal, '.');
    }

    /**
     * 数据导入
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse|string
     */
    public function import(Request $request)
    {
        $filePath = $request->file;
        $data = (new FastExcel)->import('.' . $filePath)->toArray();
        $lists = [];
        foreach ($data as $k => $v) {
            /*$v = array_values($v);
            $data_lists[] = [
                'number' => $v[0],
                'test_at' => json_decode(json_encode($v[1]), true)['date'],
                'accept_number' => $v[2],
                'company_name' => $v[3],
                'type' => $v[4],
                'data1' => $v[5],
                'data2' => $v[6],
                'data3' => $v[7],
                'data4' => $v[8],
                'data5' => $v[9],
                'data6' => $v[10],
                'data7' => $v[11],
                'data8' => $v[12],
                'created_at' => time(),
            ];*/
            $v = array_values($v);
            $lists[$v[0]]['value'][] = $v[1];
            $lists[$v[0]]['date'] = $v[2];
            $lists[$v[0]]['number'] = $v[3];
        }
        foreach ($lists as $k => $v) {
            $data = [];
            $data['number'] = $k;
            $data['test_at'] = $v['date'];
            $data['accept_number'] = $v['number'];
            $value = $v['value'];
            if (count($value) == 1) {
                $data['type'] = '未穿铅衣';
                $data['data1'] = $value[0];
            } else {
                $data['type'] = '穿铅衣';
                $data['data4'] = $value[0] > $value[1] ? $value[1] : $value[0];
                $data['data5'] = $value[0] > $value[1] ? $value[0] : $value[1];
            }
            $data_model = new Data();
            $data_model->fill($data);
            $data_model->save();
        }
        return self::success('导入数据成功');
    }

    /**
     * 编辑数据
     * @param $id
     * @param $request
     * @return string
     * @throws \Throwable
     */
    public function edit($id, Request $request)
    {
        $user = User::findOrFail($request->user_id);
        $data = Data::find($id);
        return view('admin.data.edit', compact('data', 'user'))->render();
    }

    /**
     * 删除数据
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        $data = Data::findOrFail($id);
        if ($data->delete()) {
            return self::success('删除数据成功');
        }
        return self::error('删除数据失败');
    }
}
