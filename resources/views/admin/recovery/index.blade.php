@extends('admin.layouts.base')
@section('title', '样品审核列表')
@section('breadcrumb')
    {!! Breadcrumbs::render('recovery'); !!}
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
                            <a href="javascript:;" id="confirm-check" class="btn btn-success btn-sm"><i
                                    class="fa fa-check"></i> 批量审核
                            </a>
                            <form action="{{ route('recovery.index') }}" class="form-inline pull-right">
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
                                            <option @if ($params['status'] == 0) selected @endif value="0">全部状态</option>
                                            <option @if ($params['status'] == 1) selected @endif value="1">已送样</option>
                                            <option @if ($params['status'] == 2) selected @endif value="2">未送样</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="input-group input-group-sm" style="width: 250px;">
                                    <input type="hidden" name="_t"
                                           value="{{ $params['_t'] ?? 'name' }}"/>
                                    <input type="text" name="_kw" class="form-control pull-right"
                                           placeholder="请填写姓名或单位名称" value="{{ $params['_kw'] ?? '' }}">

                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-default"><i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <form action="{{ route('recovery.check_all') }}" id="check-all" class="form-horizontal" method="post">
                        {{ csrf_field() }}
                        <table class="table table-hover">
                        <thead>
                        <tr>
                            <th><input type="checkbox" class="minimal all"></th>
                            <th>剂量牌编号</th>
                            <th>号牌编号</th>
                            <th>姓名</th>
                            <th>单位</th>
                            <th>职业</th>
                            <th>在职状态</th>
                            <th>发放时间</th>
                            <th>送样时间</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        @if(count($lists))
                            @foreach($lists as $item)
                                <tr>
                                    <td><input type="checkbox" name="label_id[]" value="{{ $item->label_id }}" class="minimal check"></td>
                                    <td>{{ $item->label_number }}</td>
                                    <td>{{ $item->company->number }}{{ $item->card_number->number }}</td>
                                    <td>{{ $item->name }}</td>
                                    <td>{{ $item->company->name }}</td>
                                    <td>{{ $item->vocation->name }}</td>
                                    <td>{!! $item::$statusText[$item->status] !!}</td>
                                    <td>{{ date('Y-m-d H:i:s',$item->send_at) }}({{ round((time() - $item->send_at)/3600/24, 1) }}天)</td>
                                    <td>@if ($item->is_back) {{ date('Y-m-d H:i:s',$item->created_time) }} @else <label class="label label-danger">未送样</label> @endif</td>
                                    <td>@if ($item->is_back)
                                            <label class="label label-success">已送样</label>
                                        @else
                                            <label class="label label-danger">未送样</label>
                                        @endif
                                    </td>
                                    <td>
                                        <a href="javascript:void(0);"
                                           data-href="{{ route('recovery.check', ['label_id'=>$item->label_id]) }}"
                                           class="btn btn-warning btn-xs check"><i class="fa fa-check"></i> 确定</a>
                                        <a href="{{ route('recovery.remark', ['label_id'=>$item->label_id]) }}" data-toggle="modal"
                                           data-target="#modal-default-edit"
                                           class="btn btn-success btn-xs"><i class="fa fa-edit"></i> 备注</a>
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
                    </div>
                @endif
            </div>
            <!-- end panel -->
        </div>
    </div>
    <!-- end row -->

    <!-- 修改会员 -->
    <div class="modal fade" id="modal-default-edit">
        <div class="modal-dialog">
            <form class="form-horizontal" action="{{ route('recovery.store') }}" id="edit" method="post"
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
    <script>

        $(function () {

            //iCheck for checkbox and radio inputs
            $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass: 'iradio_minimal-blue'
            });

            //全选开始
            var checkAll = $('input.all');
            var checkboxes = $('input.check');
            checkAll.on('ifChecked ifUnchecked', function(event) {
                if (event.type == 'ifChecked') {
                    checkboxes.iCheck('check');
                } else {
                    checkboxes.iCheck('uncheck');
                }
            });
            checkboxes.on('ifChanged', function(event){
                if(checkboxes.filter(':checked').length == checkboxes.length) {
                    checkAll.prop('checked', 'checked');
                } else {
                    checkAll.removeProp('checked');
                }
                checkAll.iCheck('update');
            });
            $('body').on('click', '#confirm-check', function () {
                layer.confirm('确定审核吗？', {
                    btn: ['确定', '取消'],
                    icon: 3,
                    title: '操作提示',
                    skin: 'my-layer-skin-class'
                }, function () {
                    $('#check-all').submit();
                }, function () {

                })
            });
            //全选结束
            //提交数据
            ajaxSubmitData('create');
            ajaxSubmitData('edit');
            ajaxSubmitData('check-all');

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