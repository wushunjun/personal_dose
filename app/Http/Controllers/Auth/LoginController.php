<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\AdminLoginRequest;
use App\Models\LoginLog;
use App\Models\System;
use Gregwar\Captcha\CaptchaBuilder;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Foundation\Auth\ThrottlesLogins;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Redirect;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    public $maxAttempts; //最大尝试登录次数
    public $decayMinutes; //锁定时长

    public function username()
    {
        return 'name';
    }

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     * @var string
     */
    protected $redirectTo = '/manage';

    /**
     * LoginController constructor.
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
        $this->maxAttempts = System::getConf('max_try_login_times', '5');
        $this->decayMinutes = System::getConf('lock_time', '1');
    }

    /**
     * 登录界面
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index()
    {
//        dd(Auth::guard('admin')->viaRemember());
        if (Auth::guard('admin')->check()) {
            return Redirect::route('index.index');
        }
        $captchaData = $this->createCaptcha();

        return view('admin.auth.login', compact('captchaData'));
    }

    /**
     * 刷新验证码
     * @param Request $request
     * @return array
     */
    public function refreshCaptcha(Request $request)
    {
        //清除验证缓存
        $request->captcha_key && Cache::forget($request->captcha_key);

        return $this->createCaptcha();
    }

    /**
     * 生成验证码
     * @return array
     */
    protected function createCaptcha()
    {
        $captchaKey = 'captcha-' . str_random(15);
        $captcha = (new CaptchaBuilder())->build($width = 165, $height = 45);
        $expiredAt = now()->addMinute(2);
        Cache::put($captchaKey, ['code' => $captcha->getPhrase()], $expiredAt);

        return [
            'captcha' => $captcha->inline(),
            'captcha_key' => $captchaKey
        ];
    }

    /**
     * 登录
     * @param AdminLoginRequest $request
     * @return $this|\Illuminate\Http\RedirectResponse|void
     * @throws \Illuminate\Validation\ValidationException
     */
    public function login(AdminLoginRequest $request)
    {
        $verifyData = Cache::get($request->captcha_key);

        if (!$verifyData) {
            return redirect()->back()->withInput()->withErrors('验证码已失效');
        }
        if (!hash_equals($verifyData['code'], $request->verification_code)) {
            return redirect()->back()->withInput()->withErrors('验证码错误');
        }

        $credentials = $request->only('name', 'password');
        $ip = $request->ip();
        $location = get_ip_address($request->ip());

        if (Auth::guard('admin')->attempt($credentials, $request->has('remember'))) {
            //记住登录日志，自动关闭临时验证码
            LoginLog::log(['ip' => $ip, 'location' => $location]);
            System::getConf('captcha_once_time') && System::set('captcha', 0);

            $admin = Auth::guard('admin')->user();
            $admin->ip = $ip;
            $admin->location = $location;
            $admin->save();
            $request->session()->regenerate();
            $this->clearLoginAttempts($request);

            return Redirect::intended('/manage');
        } else {
            $this->incrementLoginAttempts($request);

            //如果达到最大登录次数，自动启用临时验证码功能并锁定登录
            if ($this->hasTooManyLoginAttempts($request)) {
                System::getConf('captcha_once_time') && System::set('captcha', 1);
                $this->fireLockoutEvent($request);
                return $this->sendLockoutResponse($request);
            }
            return redirect()->back()->withInput()->withErrors('密码错误');
        }
    }

    /**
     * 退出
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function logout(Request $request)
    {
        Auth::guard('admin')->logout();
        $request->session()->regenerate();
        return Redirect::route('login.index');
    }
}
