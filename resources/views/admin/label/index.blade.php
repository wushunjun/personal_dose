@extends('admin.layouts.base')
@section('title', '剂量牌标签列表')
@section('breadcrumb')
    {!! Breadcrumbs::render('label'); !!}
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
                            {{--<a href="#modal-dialog" class="btn btn-success btn-sm" data-toggle="modal"><i
                                        class="fa fa-plus"></i> 新增
                            </a>--}}
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
                            <form action="{{ route('label.index') }}" class="form-inline pull-right">
                                <input type="hidden" name="page_size" value="{{ $params['page_size'] }}">
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
                                        <select name="status" class="form-control">
                                            <option @if ($params['status'] == 0) selected @endif value="0">全部状态</option>
                                            <option @if (1 == $params['status']) selected @endif value="1">使用中</option>
                                            <option @if (2 == $params['status']) selected @endif value="2">未使用</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="input-group input-group-sm" style="width: 250px;">
                                    {{--<div class="input-group-btn">
                                        <button type="button" class="btn btn-default dropdown-toggle"
                                                data-toggle="dropdown">
                                            @if('id' == $params['_t']) ID @else 编号 @endif<span
                                                    class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a href="javascript:void(0);" data-value="number">编号</a></li>
                                            <li><a href="javascript:void(0);" data-value="id">ID</a></li>
                                        </ul>
                                    </div>
                                    <input type="hidden" name="_t"
                                           value="{{ $params['_t'] ?? 'number' }}"/>--}}
                                    <input type="text" name="_kw" class="form-control pull-right"
                                           placeholder="请填写单位名称或姓名" value="{{ $params['_kw'] ?? '' }}">

                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-default"><i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>单位</th>
                            <th>使用者</th>
                            <th>编号</th>
                            <th>状态</th>
                            <th>添加时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        @if(count($lists))
                            @foreach($lists as $item)
                                <tr>
                                    <td>{{ $item->id }}</td>
                                    <td>@if($item->user) {{ $item->user->company->name ?? '' }} @else 无 @endif</td>
                                    <td>@if($item->user) {{ $item->user->name }} @else 无 @endif</td>
                                    <td>{{ $item->number }}</td>
                                    <td>{!! $item::$UseStatusText[$item->use_status] !!}</td>
                                    <td>{{ $item->created_at }}</td>
                                    <td>
                                        @if(!$item->user)
                                            <a href="javascript:void(0);"
                                               data-href="{{ route('label.destroy', ['id'=>$item->id]) }}"
                                               class="btn btn-danger btn-xs delete"><i class="fa fa-trash-o"></i> 删除</a>
                                        @endif
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
                    </div>
                @endif
            </div>
            <!-- end panel -->
        </div>
    </div>
    <!-- end row -->

@endsection
@section('script')
    <script src="{{ asset('admin/assets/plugins/iCheck/icheck.min.js') }}"></script>
    <script>

        $(function () {

            //iCheck for checkbox and radio inputs
            $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass: 'iradio_minimal-blue'
            });

            //提交数据
            ajaxSubmitData('create');
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
        })
    </script>
@endsection