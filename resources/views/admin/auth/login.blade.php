<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>洛阳市外照射个人剂量信息管理系统</title>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    html,
    body {
        width: 100%;
        height: 100vh;
    }

    .background {
        width: 100%;
        z-index: 99;
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
    }

    .container {
        position: relative;
        margin: 0 auto;
        width: 1220px;
        z-index: 999;
        font-size: 30px;
        padding-top: 5%;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        font-family: SourceHanSansCN-Bold;
    }

    h1 {
        color: #0c749e;
    }

    h6 {
        color: #ffb21e;
    }

    .one-box {
        box-sizing: border-box;
        width: 600px;
        height: 400px;
        margin-top: 5%;
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(256, 256, 256, 0.5);
    }

    .two-box {
        width: 94%;
        height: 92%;
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        background: rgb(256, 256, 256);
    }

    .row {
        width: 50%;
        display: flex;
        align-items: center;
        height: 40px;
        border: 1px solid #2e719c;
    }

    .row1 {
        width: 50%;
        display: flex;
        align-items: center;
    }

    .code {
        width: 50%;
        display: flex;
        align-items: center;
        height: 40px;
        border: 1px solid #2e719c;
    }

    .code1 {
        width: 40%;
        height: 40px;
        color: #a6b4bd;
        font-size: 14px;
        margin-left: 10%;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #2e719c;
    }

    .icon {
        margin: 0 20px;

    }

    .input {
        border: none;
        color: #a6b4bd;
    }

    .mt20 {
        margin-top: 20px;
    }

    input {
        outline: none;
    }

    input:focus {
        outline: none;
    }

    .login {
        color: #994908;
        font-size: 16px;
        width: 50%;
        height: 40px;
        text-align: center;
        line-height: 40px;
        background: #ffb21e;
        border: 1px solid #ffb21e;
    }

    .footer {
        margin-top: 10px;
        color: #0c749e;
        font-size: 19px;
    }
    .notice{
        float: left;
        width: 230px;
        overflow: hidden;
        background: #f8b2b2;
        padding: 10px;
        font-size: 14px;
        color: #a94442;
    }
    .notice ul{
        list-style-type: disc;
    }
    /* body {

        background: url("./img/background.jpg") no-repeat;
        background-size: 100%;
    } */
</style>

<body>
<img class="background" src="{{ asset('admin/assets/img/new_login/background.jpg') }}" alt="">

<form action="{{ route('login.login') }}" method="POST">
    <div class="container">
        <h1>洛阳市外照射个人剂量信息管理系统</h1>

        <div class="one-box">
            <div class="two-box">
                <img src="{{ asset('admin/assets/img/new_login/title.png') }}" alt="">
                <h6>欢迎登录！</h6>
                @if (count($errors) > 0)
                    <div class="alert alert-danger" style="display: none">
                        <ul class="notice">
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif
                {{ csrf_field() }}
                <div class="row mt20">
                    <img src="{{ asset('admin/assets/img/new_login/user.png') }}" class="icon" alt="" width="20">
                    <input class="input" type="text" value="{{ old('name') }}" name="name" placeholder="请输入用户名">
                </div>
                <div class="row mt20">
                    <img src="{{ asset('admin/assets/img/new_login/pwd.png') }}" class="icon" alt="" width="20">
                    <input class="input" type="password" name="password" placeholder="请输入密码">
                </div>
                <div class="row1">
                    <div class="code mt20">
                        <img src="{{ asset('admin/assets/img/new_login/code.png') }}" class="icon" alt="" width="20">
                        <input class="input" style="width: 50px;" type="text" name="verification_code" placeholder="验证码">
                    </div>
                    <div class="code1 mt20">
                        <img src="{{ $captchaData['captcha'] }}" style="width: 100%;height: 100%;" alt="验证码，点击更换" title="点击更换" id="refresh_captcha">
                        <input type="hidden" name="captcha_key" value="{{ $captchaData['captcha_key'] }}" id="captcha_key">
                    </div>
                </div>

                <button class="login mt20">立即登录</button>
            </div>
        </div>
        <div class="footer">康卫创新（北京）信息技术有限公司</div>
    </div>
</form>
</body>
<script src="{{ asset('admin/assets/plugins/jquery/jquery-1.9.1.min.js') }}"></script>
<script src="{{ asset('admin/assets/plugins/layer/layer.js') }}"></script>
<script>
    @if (count($errors) > 0)
        layer.open({
            type: 1,
            shade: false,
            title: false, //不显示标题
            content: $('.alert-danger'),
            time:3000,
        });
    @endif

    //刷新验证码
    $('body').on('click', '#refresh_captcha', function () {
        var captcha_key = $('#captcha_key').val();
        $.get("{{ route('auth.refresh_captcha') }}", {captcha_key: captcha_key}, function (res) {
            if (res.captcha && res.captcha_key) {
                $('#refresh_captcha').attr('src', res.captcha);
                $('#captcha_key').val(res.captcha_key);
            } else {
                layer.msg('操作失败，请稍后重试');
            }
        })
    });
</script>
</html>