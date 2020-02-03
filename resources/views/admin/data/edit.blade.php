<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">数据详情</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <div class="col-md-12">
            <h5>基础信息</h5>
            <table class="table">
                <tbody>
                <tr>
                    <td style="border: 0">
                        <b class="m-r-5">号牌编号:</b><span>{{ $data->number }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">受理编号:</b><span>{{ $data->accept_number }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">检测日期:</b><span>{{ $data->test_at }}</span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 0">
                        <b class="m-r-5">姓名:</b><span>{{ $user->name }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">职业:</b><span>{{ $user->vocation->name }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">性别:</b><span>{!! \App\Models\User::$sexText[$user->sex] !!}</span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 0">
                        <b class="m-r-5">状态:</b><span>{!! \App\Models\User::$statusText[$user->status] !!}</span>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
        <div class="col-md-12">
            <h5>检测结果</h5>
            <table class="table">
                <tbody>
                <tr>
                    <td style="border: 0">
                        <b class="m-r-5">(HP10)未穿铅衣:</b><span>{{ $data->data1 }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">(HP10)铅衣外:</b><span>{{ $data->data5 }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">(HP10)中子:</b><span>{{ $data->data8 }}</span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 0">
                        <b class="m-r-5">(HP3)未穿铅衣:</b><span>{{ $data->data2 }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">(HP3)铅衣外:</b><span>{{ $data->data6 }}</span>
                    </td>
                    <td style="border: 0">
                    </td>
                </tr>
                <tr>
                    <td style="border: 0">
                        <b class="m-r-5">(HP0.07)未穿铅衣:</b><span>{{ $data->data3 }}</span>
                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">(HP0.07)铅衣外:</b><span>{{ $data->data7 }}</span>
                    </td>
                    <td style="border: 0">
                    </td>
                </tr>
                <tr>
                    <td style="border: 0">

                    </td>
                    <td style="border: 0">
                        <b class="m-r-5">(HP10)铅衣内:</b><span>{{ $data->data4 }}</span>
                    </td>
                    <td style="border: 0">
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>
</div>{{--
<div class="modal-footer">
    <button type="button" class="btn btn-sm btn-white" data-dismiss="modal">取消</button>
    <button type="submit" class="btn btn-sm btn-success">更新</button>
</div>--}}
<script>
    $(function () {
        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });

    })
</script>