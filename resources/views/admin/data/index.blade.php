@extends('admin.layouts.base')
@section('title', '数据分析')
@section('breadcrumb')
    {!! Breadcrumbs::render('data'); !!}
@endsection
@section('style')
    <link rel="stylesheet" href="{{ asset('admin/assets/plugins/iCheck/all.css') }}">
    <link href="{{ asset('admin/assets/plugins/fancybox/source/jquery.fancybox.css') }}" rel="stylesheet"/>
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
                            <a href="#modal-import" class="btn btn-success btn-sm" data-toggle="modal"><i
                                        class="fa fa-plus"></i> 数据上传
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
                            <form action="{{ route('data.index') }}" class="form-inline pull-right">
                                <input type="hidden" name="page_size" value="{{ $params['page_size'] }}">
                                <span style="position: relative;">
                                        <i class="fa fa-calendar" style="font-size: 18px;position: absolute;left: 4px;top: 2px;"></i>
                                     <input style="padding-left: 25px;" class="form-control time" type="text"
                                            value="{{ $params['start_time'] }}" name="start_time"
                                            placeholder="开始时间"/>
                                </span>
                                <span style="position: relative;">
                                        <i class="fa fa-calendar" style="font-size: 18px;position: absolute;left: 4px;top: 2px;"></i>
                                     <input style="padding-left: 25px;" class="form-control time" type="text"
                                            value="{{ $params['end_time'] }}" name="end_time"
                                            placeholder="结束时间"/>
                                </span>
                                {{--<div class="input-group input-group-sm m-r-10">
                                    <div class="input-group-btn">
                                        <select name="company_id" class="form-control jquery-select">
                                            <option @if ($params['company_id'] == 0) selected @endif value="0">全部单位</option>
                                            @foreach($companys as $item)
                                                <option @if ($item['id'] == $params['company_id']) selected @endif value="{{ $item->id }}">{{ $item->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>--}}
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
                                <div class="input-group input-group-sm" style="width: 320px;">
                                    <input type="text" name="_kw" class="form-control pull-right"
                                           placeholder="请填写单位名称、编号或姓名" value="{{ $params['_kw'] ?? '' }}">

                                    <div class="input-group-btn">
                                        <button type="submit" id="search" class="btn btn-default"><i class="fa fa-search"></i>
                                        </button>
                                    </div>&nbsp;
                                    <div class="input-group-btn">
                                        <input type="hidden" name="excel" value="0">
                                        <button type="submit" id="download" class="btn btn-success btn-sm"><i
                                                    class="fa fa-download"></i> 导出Excel
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>号牌编号</th>
                            <th>受理编号</th>
                            <th>单位</th>
                            <th>检测日期</th>
                            <th>姓名</th>
                            <th>职位</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        @if(count($lists))
                            @foreach($lists as $item)
                                <tr>
                                    <td>{{ $item->number }}</td>
                                    <td>{{ $item->accept_number }}</td>
                                    <td>@if(strlen($item->number) >= 7) {{ $company_lists[substr($item->number, 0, 7)] }} @endif</td>
                                    <td>{{ $item->test_at }}</td>
                                    <td>@if(isset($user_lists[$item->number])) {{ $user_lists[$item->number]->name }} @endif</td>
                                    <td>@if(isset($user_lists[$item->number])) {{ $user_lists[$item->number]->vocation->name }} @endif</td>
                                    <td>{{ $item->created_at }}</td>
                                    <td>
                                        @if(isset($user_lists[$item->number]))
                                            <a href="{{ route('data.edit', ['id'=>$item->id,'user_id'=>$user_lists[$item->number]->id]) }}" data-toggle="modal"
                                               data-target="#modal-default-edit"
                                               class="btn btn-success btn-xs"><i class="fa fa-eye"></i> 查看</a>
                                        @endif
                                        <a href="javascript:void(0);"
                                           data-href="{{ route('data.destroy', ['id'=>$item->id]) }}"
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
                        <div style="float: right;margin-right: 50px;"><a target="_blank" href="/storage/admin/template.xlsx">数据模板下载</a></div>
                    </div>
                @endif
            </div>
            <!-- end panel -->
        </div>
    </div>
    <!-- end row -->

    <div class="modal fade" id="modal-import">
        <div class="modal-dialog">
            <form class="form-horizontal" data-parsley-validate="true" name="demo-form"
                  action="{{ route('data.import') }}" method="post" id="import">
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
                                    <div><a target="_blank" href="/storage/admin/template.xlsx">数据模板下载</a></div>
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
    <div class="modal fade" id="modal-default-edit">
        <div class="modal-dialog" style="width:760px;">
            <form class="form-horizontal" action="" id="edit" method="post"
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

            //iCheck for checkbox and radio inputs
            $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass: 'iradio_minimal-blue'
            });

            //提交数据
            ajaxSubmitData('import');
            ajaxSubmitData('edit');

            //解决模态框只显示一次的问题
            $("#modal-default-addCoin").on("hidden.bs.modal", function () {
                $(this).removeData("bs.modal");
            });

            //切换搜索类型
            $('body').on('click', '.dropdown-menu li>a', function () {
                $('input[name="_t"]').val($(this).attr('data-value'));
                $('button.dropdown-toggle').html($(this).html() + '&nbsp;<span class="caret"></span>')
            });
            $('#search').click(function(){
                $("input[name='excel']").val(0);
            });
            $('#download').click(function(){
                $("input[name='excel']").val(1);
            })
        })
    </script>
@endsection