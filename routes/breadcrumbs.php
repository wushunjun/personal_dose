<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 2017/10/30
 * Time: 16:04
 */

//Home
Breadcrumbs::register('home', function ($breadcrumbs) {
    $breadcrumbs->push('首页', route('index.index'));
});

//Home > 系统首页
Breadcrumbs::register('index', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('系统首页', route('index.index'));
});

//Home > 系统设置
Breadcrumbs::register('system', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('系统设置', route('system.index'));
});

//Home > 管理员列表
Breadcrumbs::register('admin', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('管理员列表', route('admin.index'));
});

//Home > 角色列表
Breadcrumbs::register('role', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('角色列表', route('role.index'));
});

//Home > 权限管理 > 权限列表
Breadcrumbs::register('permission', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('权限列表', route('permission.index'));
});


//Home > 资源列表
Breadcrumbs::register('menu', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('资源列表', route('menu.index'));
});

//Home > 登录日志
Breadcrumbs::register('log', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('登录日志', route('log.index'));
});

//Home > 单位列表
Breadcrumbs::register('company', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('单位列表', route('company.index'));
});

//Home > 职业列表
Breadcrumbs::register('vocation', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('职业列表', route('vocation.index'));
});

//Home > 区域列表
Breadcrumbs::register('region', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('区域列表', route('region.index'));
});

//Home > 个人信息列表
Breadcrumbs::register('user', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('个人信息列表', route('user.index'));
});
//Home > 号牌列表
Breadcrumbs::register('number', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('号牌列表', route('number.index'));
});
//Home > 剂量牌标签列表
Breadcrumbs::register('label', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('剂量牌标签列表', route('label.index'));
});
//Home > 个人RFID标签列表
Breadcrumbs::register('user_label', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('个人标签列表', route('user_label.index',0));
});
//Home > 样品回收计划列表
Breadcrumbs::register('plan', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('样品回收计划列表', route('plan.index'));
});
//Home > 样品审核列表
Breadcrumbs::register('recovery', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('样品审核', route('recovery.index'));
});
//Home > 样品审核记录列表
Breadcrumbs::register('check_log', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('样品审核记录', route('check_log.index'));
});
//Home > 数据分析
Breadcrumbs::register('data', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('数据分析', route('data.index'));
});
//Home > 剂量牌列表
Breadcrumbs::register('grant', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('剂量牌列表', route('grant.index'));
});
//Home > 样品审核记录统计
Breadcrumbs::register('check_report', function ($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('样品审核记录统计', route('check_report.index'));
});