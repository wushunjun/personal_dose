@extends('admin.layouts.base')
@section('title', '人员列表')
@section('breadcrumb')
    {!! Breadcrumbs::render('user'); !!}
@endsection
@section('style')
    <link rel="stylesheet" href="{{ asset('admin/assets/plugins/iCheck/all.css') }}">
    <link href="{{ asset('admin/assets/plugins/fancybox/source/jquery.fancybox.css') }}" rel="stylesheet"/>
    <link rel="stylesheet" href="{{ asset('admin/assets/plugins/bootstrap-select/bootstrap-select.min.css') }}">
    <style>
        #parsley-id-multiple-type {
            display: none;
        }

        .area_select {
            display: inline-block !important;
            width: auto;
            float: left;
            margin-right: 5px;
        }
    </style>
    @endsection
    @section('content')
            <!-- begin row -->
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <!-- begin panel -->
            <div class="panel panel-default" data-sortable-id="table-basic-2">
                <div class="panel-heading">
                    <div class="panel-heading-btn">
                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default"
                           data-click="panel-expand"><i class="fa fa-expand"></i></a>
                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success"
                           data-click="panel-reload"><i class="fa fa-repeat"></i></a>
                        <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning"
                           data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                    </div>
                    <h4 class="panel-title">
                        <div class="btn-group">
                            <a href="#modal-dialog" class="btn btn-success btn-sm" data-toggle="modal"><i
                                        class="fa fa-plus"></i> 新增
                            </a>
                        </div>
                        &nbsp;&nbsp;
                        <div class="btn-group">
                            <a href="#modal-import" class="btn btn-success btn-sm" data-toggle="modal"><i
                                        class="fa fa-plus"></i> Excel导入
                            </a>
                        </div>
                        &nbsp;&nbsp;
                    </h4>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <h4 class="panel-title">
                            </h4>
                        </div>
                        <div class="col-md-12 col-sm-12">
                            <div class="btn-group">
                                <a href="javascript:;" class="btn btn-info btn-sm" id="print" data-toggle="modal"><i
                                            class="fa fa-print"></i> 打印号牌
                                </a>
                            </div>
                            <form action="{{ route('user.index') }}" class="form-inline pull-right">
                                <input type="hidden" name="page_size" value="{{ $params['page_size'] }}">
                                <div class="input-group input-group-sm m-r-10">
                                    <div class="input-group-btn">
                                        <select name="company_id" class="form-control jquery-select">
                                            <option @if ($params['company_id'] == 0) selected @endif value="0">全部单位</option>
                                            @foreach($companys as $item)
                                                <option @if ($item['id'] == $params['company_id']) selected @endif value="{{ $item->id }}">{{ $item->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="input-group input-group-sm m-r-10">
                                    <div class="input-group-btn">
                                        <select name="vocation_id" class="form-control jquery-select">
                                            <option @if ($params['vocation_id'] == 0) selected @endif value="0">全部职业</option>
                                            @foreach($vocation as $item)
                                                <option @if ($item['id'] == $params['vocation_id']) selected @endif value="{{ $item->id }}">{{ $item->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>
                                <div class="input-group input-group-sm m-r-10">
                                    <div class="input-group-btn">
                                        <select name="status" class="form-control">
                                            <option @if ($params['status'] == -1) selected @endif value="-1">全部人员状态</option>
                                            <option @if ($params['status'] == \App\Models\User::NORMAL) selected @endif value="{{ \App\Models\User::NORMAL }}">在职</option>
                                            <option @if ($params['status'] == \App\Models\User::FORBIDDEN) selected @endif value="{{ \App\Models\User::FORBIDDEN }}">离职</option>
                                            <option @if ($params['status'] == \App\Models\User::RETIRE) selected @endif value="{{ \App\Models\User::RETIRE }}">退休</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="input-group input-group-sm" style="width: 250px;">
                                    {{--<div class="input-group-btn">
                                        <button type="button" class="btn btn-default dropdown-toggle"
                                                data-toggle="dropdown">
                                            @if('id' == $params['_t']) 人员ID @elseif('number' == $params['_t'])
                                                证件编号 @elseif('card_number' == $params['_t'])
                                                号牌编号 @else 姓名 @endif<span
                                                    class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a href="javascript:void(0);" data-value="name">姓名</a></li>
                                            <li><a href="javascript:void(0);" data-value="id">人员ID</a></li>
                                            <li><a href="javascript:void(0);" data-value="number">证件编号</a></li>
                                            <li><a href="javascript:void(0);" data-value="card_number">号牌编号</a></li>
                                        </ul>
                                    </div>--}}
                                    <input type="hidden" name="_t"
                                           value="{{ $params['_t'] ?? 'name' }}"/>
                                    <input type="text" name="_kw" class="form-control pull-right"
                                           placeholder="请填写姓名" value="{{ $params['_kw'] ?? '' }}">

                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-default"><i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <form action="{{ route('user.print_number') }}" id="print-form" class="form-horizontal"
                          method="post">
                        {{ csrf_field() }}
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th><input type="checkbox" class="minimal all"></th>
                                {{--<th>ID</th>--}}
                                <th>姓名</th>
                                <th>单位</th>
                                <th>职业</th>
                                <th>号牌编号</th>
                                <th>证件编号</th>
                                <th>工龄</th>
                                <th>性别</th>
                                <th>剂量牌数</th>
                                <th>状态</th>
                                <th>注册时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            @if(count($lists))
                                @foreach($lists as $item)
                                    <tr>
                                        <td><input type="checkbox" name="id[]" value="{{ $item->id }}" class="minimal check"></td>
                                        {{--<td>{{ $item->id }}</td>--}}
                                        <td>{{ $item->name }}</td>
                                        <td>{{ $item->company->name }}</td>
                                        <td>{{ $item->vocation->name }}</td>
                                        <td>{{ $item->company->number ?? '' }}{{ $item->card_number->number ?? '' }}</td>
                                        <td>{{ $item->number }}</td>
                                        <td>{{ $item->work_years }}</td>
                                        <td>{!! $item::$sexText[$item->sex] !!}</td>
                                        <td>{{ $item->label_count }}</td>
                                        <td>{!! $item::$statusText[$item->status] !!}</td>
                                        <td>{{ $item->created_at }}</td>
                                        <td>
                                            <a href="{{ route('user_label.index', $item->id) }}"
                                               class="btn btn-primary btn-xs"><i
                                                        class="fa fa-eye"></i> 剂量牌</a>
                                            <a href="{{ route('user.edit', ['id'=>$item->id]) }}" data-toggle="modal"
                                               data-target="#modal-default-edit"
                                               class="btn btn-success btn-xs"><i class="fa fa-edit"></i> 编辑</a>
                                            <a href="javascript:void(0);"
                                               data-href="{{ route('user.destroy', ['id'=>$item->id]) }}"
                                               class="btn btn-danger btn-xs delete"><i class="fa fa-trash-o"></i> 删除</a>
                                        </td>
                                    </tr>
                                @endforeach
                            @else
                                <tr>
                                    <td colspan="9" align="center"><i class="fa fa-info-circle"></i>&nbsp;暂无符合条件的记录</td>
                                </tr>
                            @endif

                            </tbody>
                        </table>
                    </form>
                </div>
                @if(count($lists))
                    <div class="panel-footer clearfix">
                        <div class="pull-left text-muted">共 {{ $lists->total() }} 条记录
                            每页显示
                            <form id="select_page_size" style="display: inline-block">
                                <select name="page_size">
                                    @foreach(page_size_list() as $item)
                                        <option @if ($item == $params['page_size']) selected @endif value="{{ $item }}">{{ $item }}</option>
                                    @endforeach
                                </select>
                            </form>
                            条
                        </div>
                        <div class="pull-right">
                            {{ $lists->appends($params)->render() }}
                        </div>
                        <div style="float: right;margin-right: 50px;"><a target="_blank" href="/storage/admin/user-template.xlsx">数据模板下载</a></div>
                    </div>
                @endif
            </div>
            <!-- end panel -->
        </div>
    </div>
    <!-- end row -->

    <!-- 新增会员 -->
    <div class="modal fade" id="modal-dialog">
        <div class="modal-dialog">
            <form class="form-horizontal" data-parsley-validate="true" name="demo-form"
                  action="{{ route('user.store') }}" method="post" id="create">
                {{ csrf_field() }}
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">新增人员</h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body panel-form">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="name"><span class="form-required">*</span>姓名</label>

                                <div class="col-md-7 col-sm-7">
                                    <input class="form-control" type="text" id="name" name="name" placeholder="请填写姓名"
                                           data-parsley-required="true" data-parsley-required-message="请填写姓名"
                                           data-parsley-maxlength="20"
                                           data-parsley-maxlength-message="姓名最多20个字符"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="region_id"><span class="form-required">*</span>单位</label>

                                <div class="col-md-7 col-sm-7">
                                    <select name="region_id" id="region_id" class="form-control"
                                            style="width: 150px;float: left;">
                                        <option value="">--选择区域--</option>
                                        @if (count($region))
                                            @foreach($region as $item)
                                                <option @if ($item->pid == 0) disabled
                                                        @endif value="{{ $item->id }}">{{ $item->html }}{{ $item->name }}</option>
                                            @endforeach
                                        @endif
                                    </select>
                                    <select name="company_id" id="company_id" class="form-control"
                                            style="margin-left:20px;width: 150px;float: left">
                                        <option value="">--选择单位--</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3">单位编号</label>

                                <div class="col-md-7 col-sm-7">
                                    <input class="form-control" id="company_number" type="text" readonly/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="number_id"><span class="form-required">*</span>号牌</label>

                                <div class="col-md-7 col-sm-7">
                                    <select name="number_id" id="number_id" class="form-control">
                                        <option value="">--选择号牌--</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="vocation_id"><span class="form-required">*</span>职业</label>

                                <div class="col-md-7 col-sm-7">
                                    <select name="vocation_id" id="vocation_id" class="form-control">
                                        @if (count($vocation))
                                            @foreach($vocation as $item)
                                                <option value="{{ $item->id }}">{{ $item->name }}</option>
                                            @endforeach
                                        @endif
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="number">证件编号</label>

                                <div class="col-md-7 col-sm-7">
                                    <input class="form-control" type="text" id="number" name="number"
                                           placeholder="请填写证件编号"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="entry_at">入职时间</label>

                                <div class="col-md-7 col-sm-7">
                                    <input class="form-control time" type="text" id="entry_at" name="entry_at"
                                           placeholder="请填写入职时间"/>
                                </div>
                            </div>
                            <div class="form-group no-parsley">
                                <label class="control-label col-md-3 col-sm-3" for="sex"><span class="form-required">*</span>性别</label>

                                <div class="col-md-7 col-sm-7 my_select">
                                    <label class="control-label">
                                        <input type="radio" name="sex" value="{{ \App\Models\User::MAN }}"
                                               class="minimal" checked>&nbsp;男
                                    </label>
                                    <label class="control-label">
                                        <input type="radio" name="sex" value="{{ \App\Models\User::WOMAN }}"
                                               class="minimal">&nbsp;女
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-white" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-sm btn-success">确定</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="modal fade" id="modal-import">
        <div class="modal-dialog">
            <form class="form-horizontal" data-parsley-validate="true" name="demo-form"
                  action="{{ route('user.import') }}" method="post" id="import">
                {{ csrf_field() }}
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">Excel导入</h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body panel-form">
                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="name">Excel文件</label>

                                <div class="col-md-7 col-sm-7">
                                    <div>
                                        <div class="input-append input-group"
                                             onClick="GetUploadify(1,'file','excel','file_call_back','file')">
                                            <span class="input-group-btn">
                                                <button class="btn btn-default" type="button">选择文件</button>
                                            </span>
                                            <input style="cursor: pointer;" name="file" id="file" readonly
                                                   class="input-large form-control"/>
                                        </div>
                                    </div>
                                    <div><a target="_blank" href="/storage/admin/user-template.xlsx">数据模板下载</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-white" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-sm btn-success">确定</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- 修改会员 -->
    <div class="modal fade" id="modal-default-edit">
        <div class="modal-dialog">
            <form class="form-horizontal" action="{{ route('user.update') }}" id="edit" method="post"
                  data-parsley-validate="true">
                {{ csrf_field() }}
                <div class="modal-content">

                </div>
            </form>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

@endsection
@section('script')
    <script src="{{ asset('admin/assets/plugins/iCheck/icheck.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/moment/min/moment.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/distpicker/distpicker.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/webuploader/function.js') }}"></script>
    <script>
        //文件上传回调
        function file_call_back(fileurl_tmp, elementid) {
            $("#" + elementid).val(fileurl_tmp);
        }
        $(function () {
            $('.time').datepicker({
                format: 'yyyy-mm-dd',
                todayHighlight: true,
                autoclose: true
            });
            // console.log(JSON.stringify(ChineseDistricts));

            //iCheck for checkbox and radio inputs
            $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass: 'iradio_minimal-blue'
            });
            //全选开始
            var checkAll = $('input.all');
            var checkboxes = $('input.check');
            checkAll.on('ifChecked ifUnchecked', function (event) {
                if (event.type == 'ifChecked') {
                    checkboxes.iCheck('check');
                } else {
                    checkboxes.iCheck('uncheck');
                }
            });
            checkboxes.on('ifChanged', function (event) {
                if (checkboxes.filter(':checked').length == checkboxes.length) {
                    checkAll.prop('checked', 'checked');
                } else {
                    checkAll.removeProp('checked');
                }
                checkAll.iCheck('update');
            });
            //全选结束
            $('#distpicker').distpicker({valueType: 'code'});

            //提交数据
            ajaxSubmitData('create');
            ajaxSubmitData('edit');
            ajaxSubmitData('import');

            //解决模态框只显示一次的问题
            $("#modal-default-addCoin").on("hidden.bs.modal", function () {
                $(this).removeData("bs.modal");
            });

            //切换搜索类型
            $('body').on('click', '.dropdown-menu li>a', function () {
                $('input[name="_t"]').val($(this).attr('data-value'));
                $('button.dropdown-toggle').html($(this).html() + '&nbsp;<span class="caret"></span>')
            });
            //打印
            $('body').on('click', '#print', function () {
                var select_count = $("input[name='id[]']:checked").length;
                if(select_count > 0){
                    $('#print-form').submit();
                }else{}
            });
            //选择区域
            $('body').on('change', '#region_id', function () {
                var region_id = $(this).val();
                var obj = $('#company_id');
                $.ajax({
                    url: "{{ route('company.get_company') }}",
                    data: {region_id: region_id},
                    dataType: 'json',
                    success: function (res) {
                        var html_str = '<option value="">--选择单位--</option>';
                        $.each(res.data, function (idx, item) {
                            html_str += '<option data-number="' + item.number + '" value="' + item.id + '">' + item.name + '</option>';
                        })
                        $(obj).html(html_str);
                    },
                    error: function () {
                        alert('网络连接错误，请联系管理员');
                    }
                })
            });
            //选择单位
            $('body').on('change', '#company_id', function () {
                var company_id = $(this).val();
                var company_number = $(this).find("option:selected").attr('data-number');
                var obj = $('#number_id');
                $('#company_number').val(company_number);
                $.ajax({
                    url: "{{ route('number.get_numbers') }}",
                    data: {company_id: company_id},
                    dataType: 'json',
                    success: function (res) {
                        var html_str = '<option value="">--选择号牌--</option>';
                        $.each(res.data, function (idx, item) {
                            html_str += '<option value="' + item.id + '">' + item.number + '</option>';
                        })
                        $(obj).html(html_str);
                    },
                    error: function () {
                        alert('网络连接错误，请联系管理员');
                    }
                })
            });
        })
    </script>
@endsection