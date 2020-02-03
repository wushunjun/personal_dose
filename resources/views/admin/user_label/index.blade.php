@extends('admin.layouts.base')
@section('title', '个人标签列表')
@section('breadcrumb')
    {!! Breadcrumbs::render('user_label'); !!}
@endsection
@section('style')
    <link rel="stylesheet" href="{{ asset('admin/assets/plugins/iCheck/all.css') }}">
    <link rel="stylesheet" href="{{ asset('admin/assets/plugins/bootstrap-select/bootstrap-select.min.css') }}">
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
                        <button href="#create-label-modal" class="btn btn-primary btn-sm" data-toggle="modal"><i
                                    class="fa fa-plus"></i> 绑定标签
                        </button>
                    </h4>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-6 col-sm-12">
                            <h4 class="panel-title">
                                当前人员：{{  $user->name }}
                            </h4>
                        </div>
                        <div class="col-md-6 col-sm-12">
                            <form action="{{ route('user_label.index', $user->id) }}" class="form-inline pull-right">
                                <input type="hidden" name="page_size" value="{{ $params['page_size'] }}">
                                <div class="input-group input-group-sm" style="width: 250px;">
                                    <input type="text" name="_kw" class="form-control pull-right"
                                           placeholder="请填写标签" value="{{ $params['_kw'] ?? '' }}">

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
                            <th>编号</th>
                            <th>状态</th>
                            <th>绑定时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        @if(count($lists))
                            @foreach($lists as $item)
                                <tr>
                                    <td>{{ $item->id }}</td>
                                    <td>{{ $item->number }}</td>
                                    <td>{!! $item::$statusText[$item->status] !!}</td>
                                    <td>{{ date('Y-m-d H:i:s', $item->bind_at) }}</td>
                                    <td>
                                        @if($item->status == 0)
                                            <a href="javascript:void(0);"
                                               data-href="{{ route('user_label.destroy', ['id'=>$item->id]) }}"
                                               class="btn btn-danger btn-xs cancel"><i class="fa fa-trash-o"></i> 解绑</a>
                                        @endif
                                        @if(in_array($item->status, [1,2]))
                                            <a href="javascript:void(0);"
                                               data-href="{{ route('user_label.scrap', ['id'=>$item->id]) }}"
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
                            {{ $lists->render() }}
                        </div>
                    </div>
                @endif
            </div>
            <!-- end panel -->
        </div>
    </div>
    <!-- end row -->

    <!-- 新增人员科目 -->
    <div class="modal fade" id="create-label-modal">
        <div class="modal-dialog">
            <form class="form-horizontal" data-parsley-validate="true" name="demo-form"
                  action="{{ route('user_label.store') }}"
                  method="post" id="create-label">
                {{ csrf_field() }}
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">绑定标签</h4>
                    </div>
                    <div class="modal-body">
                        <div class="panel-body panel-form">
                            <input type="hidden" name="user_id" value="{{ $user->id }}"/>

                            <div class="form-group">
                                <label class="control-label col-md-3 col-sm-3" for="label_id">标签</label>

                                <div class="col-md-7 col-sm-7">
                                    <select name="label_id" id="label_id" class="form-control selectpicker"
                                            data-live-search="true" data-style="btn-white"
                                            data-parsley-required="true" data-parsley-required-message="请选择标签">
                                        <option value="" selected>--选择标签--</option>
                                        @if (count($labels))
                                            @foreach($labels as $label)
                                                <option value="{{ $label->id }}">{{ $label->number }}</option>
                                            @endforeach
                                        @endif
                                    </select>
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


@endsection
@section('script')
    <script src="{{ asset('admin/assets/plugins/iCheck/icheck.min.js') }}"></script>
    <script src="{{ asset('admin/assets/plugins/bootstrap-select/bootstrap-select.min.js') }}"></script>
    <script>
        $(function () {
            $(".selectpicker").selectpicker("render");
            //提交数据
            ajaxSubmitData('create-label');

            //切换搜索类型
            $('body').on('click', '.search-select li>a', function () {
                $('input[name="_t"]').val($(this).attr('data-value'));
                $(this).parent('li').parent('ul').prev('button.dropdown-toggle').html($(this).html() + '&nbsp;<span class="caret"></span>')
            });
            $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass: 'iradio_minimal-blue'
            });
            $('body').on('click', '.cancel', function () {
                var target = $(this);
                layer.confirm('确定解绑吗？', {
                    btn: ['确定', '取消'],
                    icon: 3,
                    title: '操作提示',
                    skin: 'my-layer-skin-class'
                }, function () {
                    $.get(target.attr('data-href'), {}, function (res) {
                        layer.msg(res.msg);
                        if (res.status) {
                            setTimeout(function () {
                                window.location.reload();
                            }, 1000);
                        }
                    })
                }, function () {

                })
            });
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
        })
    </script>
@endsection