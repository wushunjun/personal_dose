@extends('admin.layouts.base')
@section('title', '单位样品审核统计')
@section('breadcrumb')
    <ol class="breadcrumb pull-right">
        <ol class="breadcrumb">

            <li class="breadcrumb-item"><a href="/manage">首页</a></li>


            <li class="breadcrumb-item active">单位样品审核统计</li>

        </ol>


    </ol>
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
                            <form action="{{ route('check_report.company_list',['plan_id'=>$plan_id]) }}" class="form-inline pull-right">

                                <div class="input-group input-group-sm" style="width: 250px;">
                                    {{--<div class="input-group-btn">
                                        <button type="button" class="btn btn-default dropdown-toggle"
                                                data-toggle="dropdown">
                                            @if('id' == $params['_t']) ID @else 名称 @endif<span
                                                    class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a href="javascript:void(0);" data-value="name">名称</a></li>
                                            <li><a href="javascript:void(0);" data-value="id">ID</a></li>
                                        </ul>
                                    </div>--}}
                                    <input type="hidden" name="_t"
                                           value="{{ $params['_t'] ?? 'name' }}"/>
                                    <input type="text" name="_kw" class="form-control pull-right"
                                           placeholder="请填写单位名称" value="{{ $params['_kw'] ?? '' }}">

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
                            <th>单位名称</th>
                            <th>发放数量</th>
                            <th>回收数量</th>
                            <th>未回收数量</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        @if(count($count))
                            @foreach($count as $item)
                                <tr>
                                    <td>{{ $item['company_id'] }}</td>
                                    <td>{{ $item['name'] }}</td>
                                    <td>{{ $item['grant_count'] ?? 0 }}</td>
                                    <td>{{ $item['has_recovery_count'] ?? 0 }}</td>
                                    <td>{{ $item['no_recovery_count'] ?? 0 }}</td>
                                    <td>
                                        <a href="{{ route('check_log.index', ['company_id'=>$item['company_id'], 'plan_id'=>$plan_id]) }}"
                                           class="btn btn-success btn-xs"><i class="fa fa-search"></i> 查看</a>
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