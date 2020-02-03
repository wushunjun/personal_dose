@extends('admin.layouts.base')
@section('title', '系统设置')
@section('breadcrumb')
    {!! Breadcrumbs::render('system'); !!}
@endsection
@section('style')
    <link rel="stylesheet" href="{{ asset('admin/assets/plugins/iCheck/all.css') }}">
    <style>
        #parsley-id-multiple-android_update_force,
        #parsley-id-multiple-ios_update_force {
            display: none;
        }
    </style>
@endsection
@section('content')
    <!-- begin row -->
    <div class="row">
        <div class="col-md-12 col-sm-12">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#default-tab-7" data-toggle="tab">网站设置</a></li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="default-tab-7">
                    {{--<form class="form-horizontal" method="post" id="platform_logo_form" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="platform_logo_handler">平台LOGO</label>
                            <div class="col-md-3">
                                <input type="file" id="platform_logo_handler" name="platform_logo_handler"
                                       class="form-control"/>
                            </div>
                            <a class="btn btn-success m-r-5 btn-sm" id="platform_logo_upload"><i
                                        class="fa fa-cloud-upload"> 上传</i></a>
                        </div>
                        @if(isset($config['platform_logo']))
                            <div class="form-group">
                                <label class="col-md-4 control-label"></label>
                                <div class="col-md-3">
                                    <p class="form-control-static"><img height="200" id="show_platform_logo"
                                                                        src="{{ asset('storage/'.$config['platform_logo']) }}"
                                                                        alt="平台LOGO"></p>
                                </div>
                            </div>
                        @endif
                    </form>--}}
                    <form class="form-horizontal" action="{{ route('system.update') }}" method="post" id="form-7"
                          data-parsley-validate="true">
                        {{ csrf_field() }}
                        <input type="hidden" name="platform_logo"/>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="site_name">网站名称</label>
                            <div class="col-md-3">
                                <input type="text" id="site_name" name="site_name" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写网站名称"
                                       @if(isset($config['site_name'])) value="{{ $config['site_name'] }}" @endif/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="site_title">网站title</label>
                            <div class="col-md-3">
                                <input type="text" id="site_name" name="site_title" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写网站title"
                                       @if(isset($config['site_title'])) value="{{ $config['site_title'] }}" @endif/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="company_name">公司名称</label>
                            <div class="col-md-3">
                                <input type="text" id="company_name" name="company_name" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写公司名称"
                                       @if(isset($config['company_name'])) value="{{ $config['company_name'] }}" @endif/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="address">公司地址</label>
                            <div class="col-md-3">
                                <input type="text" id="app_version" name="address" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填公司地址"
                                       @if(isset($config['address'])) value="{{ $config['address'] }}" @endif/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="tel">联系电话</label>
                            <div class="col-md-3">
                                <input type="text" id="tel" name="tel" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写联系电话"
                                       @if(isset($config['tel'])) value="{{ $config['tel'] }}" @endif/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="email">邮箱</label>
                            <div class="col-md-3">
                                <input type="text" id="tel" name="email" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-type="email"
                                       data-parsley-required-message="请填写联系电话"
                                       data-parsley-type-message="邮箱格式错误"
                                       @if(isset($config['email'])) value="{{ $config['email'] }}" @endif/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="copy_right">COPYRIGHT</label>
                            <div class="col-md-3">
                                <input type="text" id="tel" name="copy_right" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写COPYRIGHT"
                                       @if(isset($config['copy_right'])) value="{{ $config['copy_right'] }}" @endif/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="one_to_one">一对一课时兑换比例</label>
                            <div class="col-md-3">
                                <input type="text" id="tel" name="one_to_one" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写一对一课时兑换比例"
                                       @if(isset($config['one_to_one'])) value="{{ $config['one_to_one'] }}" @endif/>
                                <span>指多少小红花兑换1个一对一课时</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="one_to_more">一对多课时兑换比例</label>
                            <div class="col-md-3">
                                <input type="text" id="tel" name="one_to_more" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写一对多课时兑换比例"
                                       @if(isset($config['one_to_more'])) value="{{ $config['one_to_more'] }}" @endif/>
                                <span>指多少小红花兑换1个一对多课时</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="max_flow_number">单次送花数量上限</label>
                            <div class="col-md-3">
                                <input type="text" id="tel" name="max_flow_number" class="form-control"
                                       data-parsley-required="true"
                                       data-parsley-required-message="请填写单次送花上限"
                                       @if(isset($config['max_flow_number'])) value="{{ $config['max_flow_number'] }}" @endif/>
                                <span>老师一次最多能送学生多少小红花</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-4 col-md-offset-4">
                                <button type="submit" class="btn btn-sm btn-success">保存设置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- end row -->

@endsection

@section('script')
    <script src="{{ asset('admin/assets/plugins/iCheck/icheck.min.js') }}"></script>
    <script>
        $(function () {

            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': "{{ csrf_token() }}"
                }
            });

            //iCheck for checkbox and radio inputs
            $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                checkboxClass: 'icheckbox_minimal-blue',
                radioClass: 'iradio_minimal-blue'
            });

            //提交数据
            ajaxSubmitData('form-1');
            ajaxSubmitData('form-2');
            ajaxSubmitData('form-3');
            ajaxSubmitData('form-4');
            ajaxSubmitData('form-5');
            ajaxSubmitData('form-6');
            ajaxSubmitData('form-7');

            //上传APP背景图片
            var url = "{{ route('system.upload') }}?type=background_image";
            $('body').on('click', '#background_image_upload', function () {
                var formdata = new FormData();
                formdata.append('uploadImage', $('#background_image_handler').get(0).files[0]);
                $.ajax({
                    url: url,
                    type: 'post',
                    contentType: false,
                    data: formdata,
                    processData: false,
                    success: function (res) {
                        console.log(res);
                        layer.msg(res.msg);
                        if (res.status) {
                            $('#show_bg').attr('src', '/storage/' + res.data.path);
                            $('input[name="background_image"]').val(res.data.path);
                        }
                    },
                    error: function (err) {
                        console.log(err)
                    }
                });
            });

            //上传平台LOGO
            var url = "{{ route('system.upload') }}?type=platform_logo";
            $('body').on('click', '#platform_logo_upload', function () {
                var formdata = new FormData();
                formdata.append('uploadImage', $('#platform_logo_handler').get(0).files[0]);
                $.ajax({
                    url: url,
                    type: 'post',
                    contentType: false,
                    data: formdata,
                    processData: false,
                    success: function (res) {
                        console.log(res);
                        layer.msg(res.msg);
                        if (res.status) {
                            $('#show_platform_logo').attr('src', '/storage/' + res.data.path);
                            $('input[name="platform_logo"]').val(res.data.path);
                        }
                    },
                    error: function (err) {
                        console.log(err)
                    }
                });
            });

            //检查提醒时长是否小于每期时长
            $('#expired_remind').on('blur', function () {
                if ($(this).val() >= $('#auth_time_for_period').val()) {
                    layer.msg('到期提醒期限必须小于每期时长');
                }
            })

        })


    </script>
@endsection