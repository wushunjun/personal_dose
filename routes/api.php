<?php

$api = app('Dingo\Api\Routing\Router');

$api->version('v1', [
    'namespace' => 'App\Http\Controllers\Api',
    'middleware' => ['serializer:array', 'cors']
], function ($api) {


    //数据接口
    $api->group([
        'middleware' => 'api.throttle',
        'limit' => config('api.rate_limits.access.limit'),
        'expires' => config('api.rate_limits.access.expires')
    ], function ($api) {
        //游客接口
        $api->group([
            'prefix' => 'index',
        ],function($api){
            $api->get('/test', 'IndexController@test')->name('index.test'); //测试
            $api->post('/store', 'IndexController@store')->name('index.store'); //标签数据上传
            $api->post('/get_user', 'IndexController@get_user')->name('index.get_user'); //扫描标签获取用户
            $api->post('/grant', 'IndexController@grant')->name('index.grant'); //扫描发放号牌
        });
    });

});