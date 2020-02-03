<?php
/**
 * Created by PhpStorm.
 * User: pijh
 * Date: 2017/9/16
 * Time: 22:49
 */


Route::group(['namespace' => 'Auth'], function () {

    //登录、找回密码
    Route::get('login', 'LoginController@index')->name('login.index');
    Route::post('login', 'LoginController@login')->name('login.login');
    Route::get('logout', 'LoginController@logout')->name('login.logout');
    Route::get('auth/geetest', 'LoginController@getGeetest'); //生成极验验证码
    Route::get('auth/refresh_captcha', 'LoginController@refreshCaptcha')->name('auth.refresh_captcha'); //刷新验证码
});

Route::group(['namespace' => 'Admin', 'middleware' => ['check.login', 'check.permission', 'generate.menu']], function () {
    /*
    |--------------------------------------------------------------------------
    | 仪表盘
    |--------------------------------------------------------------------------
    */

    //系统首页
    Route::get('/', 'IndexController@index')->name('index.index');

    //个人设置
    Route::get('/profile', 'IndexController@profile')->name('index.profile');
    Route::get('/chang_status', 'IndexController@chang_status')->name('index.chang_status');
    Route::post('/profile', 'IndexController@updateProfile')->name('index.update_profile');


    //系统设置
    Route::group(['prefix' => 'system'], function () {
        Route::get('/', 'SystemController@index')->name('system.index');
        Route::get('/introduce', 'SystemController@introduce')->name('system.introduce');
        Route::get('/vote', 'SystemController@vote')->name('system.vote');
        Route::get('/modify_period', 'SystemController@modifyPeriod')->name('system.modify_period');
        Route::post('/update', 'SystemController@update')->name('system.update');
        Route::post('/upload', 'SystemController@upload')->name('system.upload');
    });


    /*
    |--------------------------------------------------------------------------
    | 权限管理
    |--------------------------------------------------------------------------
    */
    //管理员
    Route::group(['prefix' => 'admin'], function () {
        Route::get('/', 'AdminController@index')->name('admin.index');
        Route::post('/', 'AdminController@store')->name('admin.store');
        Route::get('/edit/{id}', 'AdminController@edit')->name('admin.edit');
        Route::post('/update', 'AdminController@update')->name('admin.update');
        Route::get('/destroy/{id}', 'AdminController@destroy')->name('admin.destroy');
    });

    //权限
    Route::group(['prefix' => 'permission'], function () {
        Route::get('/', 'PermissionController@index')->name('permission.index');
        Route::post('/', 'PermissionController@store')->name('permission.store');
        Route::get('/edit/{id}', 'PermissionController@edit')->name('permission.edit');
        Route::post('/update', 'PermissionController@update')->name('permission.update');
        Route::get('/destroy/{id}', 'PermissionController@destroy')->name('permission.destroy');
    });

    //角色
    Route::group(['prefix' => 'role'], function () {
        Route::get('/', 'RoleController@index')->name('role.index');
        Route::post('/', 'RoleController@store')->name('role.store');
        Route::get('/edit/{id}', 'RoleController@edit')->name('role.edit');
        Route::post('/update', 'RoleController@update')->name('role.update');
        Route::get('/destroy/{id}', 'RoleController@destroy')->name('role.destroy');
    });

    //资源
    Route::group(['prefix' => 'menu'], function () {
        Route::get('/', 'MenuController@index')->name('menu.index');
        Route::post('/', 'MenuController@store')->name('menu.store');
        Route::get('/edit/{id}', 'MenuController@edit')->name('menu.edit');
        Route::post('/update', 'MenuController@update')->name('menu.update');
        Route::get('/destroy/{id}', 'MenuController@destroy')->name('menu.destroy');
    });

    /*
    |--------------------------------------------------------------------------
    | 日志管理
    |--------------------------------------------------------------------------
    */
    //登录日志
    Route::group(['prefix' => 'log'], function () {
        Route::get('/', 'LogController@index')->name('log.index');
        Route::match(['get', 'post'], '/destroy/{id?}', 'LogController@destroy')->name('log.destroy');
    });
    /*
    |--------------------------------------------------------------------------
    | 其它
    |--------------------------------------------------------------------------
    */
    Route::get('/flush', 'IndexController@flush')->name('index.flush'); //清除所有缓存
    //文件上传插件
    Route::group(['prefix' => 'upload'], function () {
        Route::get('/index', 'UploadController@index')->name('upload.index');
        Route::post('/imageUp', 'UploadController@imageUp')->name('upload.imageUp');
        Route::get('/delupload', 'UploadController@delupload')->name('upload.delupload');
    });
    /*
    |--------------------------------------------------------------------------
    | 用户管理
    |--------------------------------------------------------------------------
    */
    //个人信息管理
    Route::group(['prefix' => 'user'], function () {
        Route::get('/', 'UserController@index')->name('user.index');
        Route::post('/', 'UserController@store')->name('user.store');
        Route::get('/edit/{id}', 'UserController@edit')->name('user.edit');
        Route::post('/update', 'UserController@update')->name('user.update');
        Route::get('/destroy/{id}', 'UserController@destroy')->name('user.destroy');
        Route::post('/import', 'UserController@import')->name('user.import');
        Route::post('/print_number', 'UserController@print_number')->name('user.print_number');
    });
    /*
    |--------------------------------------------------------------------------
    | 单位管理
    |--------------------------------------------------------------------------
    */
    //单位管理
    Route::group(['prefix' => 'company'], function () {
        Route::get('/', 'CompanyController@index')->name('company.index');
        Route::post('/', 'CompanyController@store')->name('company.store');
        Route::get('/edit/{id}', 'CompanyController@edit')->name('company.edit');
        Route::post('/update', 'CompanyController@update')->name('company.update');
        Route::get('/destroy/{id}', 'CompanyController@destroy')->name('company.destroy');
        Route::get('/get_company', 'CompanyController@get_company')->name('company.get_company');
        Route::post('/import', 'CompanyController@import')->name('company.import');
    });
    //职业管理
    Route::group(['prefix' => 'vocation'], function () {
        Route::get('/', 'VocationController@index')->name('vocation.index');
        Route::post('/', 'VocationController@store')->name('vocation.store');
        Route::get('/edit/{id}', 'VocationController@edit')->name('vocation.edit');
        Route::post('/update', 'VocationController@update')->name('vocation.update');
        Route::get('/destroy/{id}', 'VocationController@destroy')->name('vocation.destroy');
    });
    //区域管理
    Route::group(['prefix' => 'region'], function () {
        Route::get('/', 'RegionController@index')->name('region.index');
        Route::post('/', 'RegionController@store')->name('region.store');
        Route::get('/edit/{id}', 'RegionController@edit')->name('region.edit');
        Route::post('/update', 'RegionController@update')->name('region.update');
        Route::get('/destroy/{id}', 'RegionController@destroy')->name('region.destroy');
    });
    /*
    |--------------------------------------------------------------------------
    | 号牌管理
    |--------------------------------------------------------------------------
    */
    //号牌管理
    Route::group(['prefix' => 'number'], function () {
        Route::get('/', 'NumberController@index')->name('number.index');
        Route::post('/', 'NumberController@store')->name('number.store');
        Route::get('/edit/{id}', 'NumberController@edit')->name('number.edit');
        Route::post('/update', 'NumberController@update')->name('number.update');
        Route::get('/destroy/{id}', 'NumberController@destroy')->name('number.destroy');
        Route::get('/get_numbers', 'NumberController@get_numbers')->name('number.get_numbers');
        Route::post('/import', 'NumberController@import')->name('number.import');
    });
    /*
    |--------------------------------------------------------------------------
    | 标签管理
    |--------------------------------------------------------------------------
    */
    //标签管理
    Route::group(['prefix' => 'label'], function () {
        Route::get('/', 'LabelController@index')->name('label.index');
        Route::get('/destroy/{id}', 'LabelController@destroy')->name('label.destroy');
    });
    //个人标签管理
    Route::group(['prefix' => 'user_label'], function () {
        Route::get('/{user_id}', 'UserLabelController@index')->name('user_label.index');
        Route::post('/', 'UserLabelController@store')->name('user_label.store');
        Route::get('/destroy/{id}', 'UserLabelController@destroy')->name('user_label.destroy');
        Route::get('/scrap/{id}', 'UserLabelController@scrap')->name('user_label.scrap');
    });
    /*
    |--------------------------------------------------------------------------
    | 样品回收管理
    |--------------------------------------------------------------------------
    */
    //样品回收计划
    Route::group(['prefix' => 'plan'], function () {
        Route::get('/', 'PlanController@index')->name('plan.index');
        Route::post('/', 'PlanController@store')->name('plan.store');
        Route::get('/edit/{id}', 'PlanController@edit')->name('plan.edit');
        Route::post('/update', 'PlanController@update')->name('plan.update');
        Route::get('/destroy/{id}', 'PlanController@destroy')->name('plan.destroy');
    });
    //样品回收审核
    Route::group(['prefix' => 'recovery'], function () {
        Route::get('/', 'RecoveryController@index')->name('recovery.index');
        Route::get('/check/{label_id}', 'RecoveryController@check')->name('recovery.check');
        Route::post('/check_all', 'RecoveryController@check_all')->name('recovery.check_all');
        Route::get('/remark/{label_id}', 'RecoveryController@remark')->name('recovery.remark');
        Route::post('/store', 'RecoveryController@store')->name('recovery.store');
    });
    //样品审核记录
    Route::group(['prefix' => 'check_log'], function () {
        Route::get('/', 'CheckLogController@index')->name('check_log.index');
        Route::get('/show/{cl_id}', 'CheckLogController@show')->name('check_log.show');
    });
    //数据分析
    Route::group(['prefix' => 'data'], function () {
        Route::get('/', 'DataController@index')->name('data.index');
        Route::post('/import', 'DataController@import')->name('data.import');
        Route::get('/edit/{id}', 'DataController@edit')->name('data.edit');
        Route::get('/destroy/{id}', 'DataController@destroy')->name('data.destroy');
    });
    //剂量牌管理
    Route::group(['prefix' => 'grant'], function () {
        Route::get('/', 'GrantController@index')->name('grant.index');
        Route::get('/label_log/{label_id}', 'GrantController@label_log')->name('grant.label_log');
        Route::post('/grant_all', 'GrantController@grant_all')->name('grant.grant_all');
    });
    //样品审核记录统计
    Route::group(['prefix' => 'check_report'], function () {
        Route::get('/', 'CheckReportController@index')->name('check_report.index');
        Route::get('/company_list/{plan_id}', 'CheckReportController@company_list')->name('check_report.company_list');
        Route::get('/user_list/{company_id}/{plan_id}', 'CheckReportController@user_list')->name('check_report.user_list');
    });
});
