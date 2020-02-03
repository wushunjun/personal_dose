@extends('admin.layouts.base')
@section('title', '剂量牌列表')
@section('breadcrumb')
    {!! Breadcrumbs::render('grant'); !!}
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
                            <a href="javascript:;" id="confirm-grant" class="btn btn-success btn-sm"><i
                                        class="fa fa-check"></i> 批量发放
                            </a>
                            <form action="{{ route('grant.index') }}" class="form-inline pull-right">
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
                                            <option @if (1 == $params['status']) selected @endif value="1">未发放</option>
                                            <option @if (2 == $params['status']) selected @endif value="2">已发放</option>
                                            <option @if (3 == $params['status']) selected @endif value="3">已回收</option>
                                            <option @if (4 == $params['status']) selected @endif value="4">已报废</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="input-group input-group-sm" style="width: 250px;">
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
                    <form action="{{ route('grant.grant_all') }}" id="grant-all" class="form-horizontal"
                          method="post">
                        {{ csrf_field() }}
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th><input type="checkbox" class="minimal all"></th>
                                <th>号牌编号</th>
                                <th>剂量牌编号</th>
                                <th>姓名</th>
                                <th>单位</th>
                                <th>职业</th>
                                <th>发放时间</th>
                                <th>发放状态</th>
                                <th>是否在职</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            @if(count($lists))
                                @foreach($lists as $item)
                                    <tr>
                                        <td><input type="checkbox" @if($item->disabled) disabled @endif name="label_id[]" value="{{ $item->label_id }}" class="minimal grant"></td>
                                        <td>{{ $item->company->number ?? '' }}{{ $item->card_number->number ?? '' }}</td>
                                        <td>{{ $item->label_number }}</td>
                                        <td>{{ $item->name }}</td>
                                        <td>{{ $item->company->name }}</td>
                                        <td>{{ $item->vocation->name }}</td>
                                        <td>{{ $item->send_at ? date('Y-m-d H:i:s',$item->send_at) : '未发放' }}</td>
                                        <td>{!! \App\Models\Label::$statusText[$item->label_status] !!}</td>
                                        <td>{!! \App\Models\User::$statusText[$item->status] !!}</td>
                                        <td>
                                            <a href="{{ route('grant.label_log', ['label_id'=>$item->label_id]) }}" data-toggle="modal"
                                               data-target="#modal-default-edit"
                                               class="btn btn-success btn-xs"><i class="fa fa-eye"></i> 查看记录</a>
                                            @if(in_array($item->label_status, [1,2]))
                                                <a href="javascript:void(0);"
                                                   data-href="{{ route('user_label.scrap', ['id'=>$item->label_id]) }}"
                                                   class="btn btn-warning btn-xs scrap"><i class="fa fa-trash-o"></i> 报废</a>
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
    <div class="modal fade" id="modal-default-edit">
        <div class="modal-dialog">
            <form class="form-horizontal" action="" id="edit" method="post"
                  data-parsley-validate="true">
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
            var checkboxes = $('input.grant');
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
            $('body').on('click', '#confirm-grant', function () {
                layer.confirm('确定发放吗？', {
                    btn: ['确定', '取消'],
                    icon: 3,
                    title: '操作提示',
                    skin: 'my-layer-skin-class'
                }, function () {
                    $('#grant-all').submit();
                }, function () {

                })
            });
            //全选结束
            //提交数据
            ajaxSubmitData('create');
            ajaxSubmitData('edit');
            ajaxSubmitData('grant-all');
            $('body').on('click', '.scrap', function () {
                var target = $(this);
                layer.confirm('剂量牌是否报废？', {
                    btn: ['是', '否'],
                    icon: 3,
                    title: '操作提示',
                    skin: 'my-layer-skin-class'
                }, function () {
                    $.get(target.attr('data-href'), {type:1}, function (res) {
                        layer.msg(res.msg);
                        if (res.status) {
                            setTimeout(function () {
                                window.location.reload();
                            }, 1000);
                        }
                    })
                }, function () {
                    $.get(target.attr('data-href'), {type:2}, function (res) {
                        layer.msg(res.msg);
                        if (res.status) {
                            setTimeout(function () {
                                window.location.reload();
                            }, 1000);
                        }
                    })
                })
            });
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