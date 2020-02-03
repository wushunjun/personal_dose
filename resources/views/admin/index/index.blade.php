@extends('admin.layouts.base')
@section('content')
        <!-- begin row -->
<style>
    .col-md-3.col-sm-6 a {
        text-decoration: none;
        color: #fff;
    }

    .stats-link {
        height: 20px;
    }

    .searchable-select {
        z-index: 999;
    }
    .innerbox{
        overflow: scroll;
        overflow-x: hidden;
    }
    /*滚动条样式*/
    .innerbox::-webkit-scrollbar {/*滚动条整体样式*/
        width: 4px;     /*高宽分别对应横竖滚动条的尺寸*/
        height: 4px;
    }
    .innerbox::-webkit-scrollbar-thumb {/*滚动条里面小方块*/
        border-radius: 5px;
        -webkit-box-shadow: inset 0 0 5px rgba(0,0,0,0.2);
        background: rgba(0,0,0,0.2);
    }
    .innerbox::-webkit-scrollbar-track {/*滚动条里面轨道*/
        -webkit-box-shadow: none;
        border-radius: 0;
        background: none;
    }
    .widget-stats .stats-icon{
        left: 15px;
        top: 25px;
        opacity: 1;
    }
    .widget{
        color: #242a30;
        padding-left: 110px;
        padding-top: 25px;
        padding-bottom: 25px;
    }
    .widget-stats .stats-info h4{
        color: #242a30;
    }
    .nav-pills>li>a{
        border: 1px solid #eee;
    }
    .nav-pills>li.active>a, .nav-pills>li.active>a:hover, .nav-pills>li.active>a:focus{
        background: #348fe2;
    }
</style>
<div class="row">
    <!-- begin col-3 -->
    <div class="col-md-3 col-sm-6">
        <a href="{{ route('user.index') }}">
            <div class="widget widget-stats bg-white">
                <div class="stats-icon"><i class="fa fa-users" style="color: #348fe2;"></i></div>
                <div class="stats-info">
                    <h4>人员总数量</h4>

                    <p>{{ $user_count }}</p>
                </div>
            </div>
        </a>
    </div>
    <!-- end col-3 -->
    <!-- begin col-3 -->
    <div class="col-md-3 col-sm-6">
        <a href="{{ route('label.index') }}">
            <div class="widget widget-stats bg-white">
                <div class="stats-icon"><i class="fa fa-cubes" style="color: #49b6d6;"></i></div>
                <div class="stats-info">
                    <h4>剂量牌标签总数量</h4>

                    <p>{{ $rfid_count }}</p>
                </div>
            </div>
        </a>
    </div>
    <!-- end col-3 -->
    <!-- begin col-3 -->
    <div class="col-md-3 col-sm-6">
        <a href="{{ route('label.index') }}">
            <div class="widget widget-stats bg-white">
                <div class="stats-icon"><i class="fa fa-bullseye" style="color: #f59c1a;"></i></div>
                <div class="stats-info">
                    <h4>剩余剂量牌标签数量</h4>

                    <p>{{ $nu_use_rfid_count }}</p>
                </div>
            </div>
        </a>
    </div>
    <!-- end col-3 -->
    <!-- begin col-3 -->
    <div class="col-md-3 col-sm-6">
        <a href="{{ route('label.index') }}">
            <div class="widget widget-stats bg-white">
                <div class="stats-icon"><i class="fa fa-bullseye" style="color: #7cdda7;"></i></div>
                <div class="stats-info">
                    <h4>报废剂量牌标签数量</h4>

                    <p>{{ $scrap_count }}</p>
                </div>
            </div>
        </a>
    </div>
    <!-- end col-3 -->
</div>
<div class="row">
    <div class="col-md-8">
        <div class="widget-chart with-sidebar bg-white">
            <div class="widget-chart-content" style="margin-right: 0;position: relative">
                <h4 class="chart-title" style="color: #242a30;">
                    剂量牌发放回收统计
                    {{--<small>Statistics of dose card distribution and recovery</small>--}}
                </h4>
                <hr>
                <ul class="nav nav-pills">
                    <li class="active"><a href="#plan-chart-1" data-toggle="tab" aria-expanded="false">当前计划</a></li>
                    <li class=""><a href="#plan-chart-2" data-toggle="tab" aria-expanded="false">本年度</a></li>
                    <li class=""><a href="#plan-chart-3" data-toggle="tab" aria-expanded="false">单位</a></li>
                </ul>{{--
                <form action="{{ route('index.index') }}" id="year-form" class="form-inline pull-right">
                    <div class="input-group input-group-sm"
                         style="width: 250px;position: absolute;right: 60px;top: 15px;">
                        <select class="form-control pull-right select-year" name="year">
                            @if (count($years))
                                @foreach($years as $item)
                                    <option @if ($year == $item) selected @endif value="{{ $item }}">{{ $item }}年
                                    </option>
                                @endforeach
                            @endif
                        </select>

                    </div>
                </form>--}}
                <div class="tab-content">
                    <div id="plan-chart-1" class="morris-inverse active in" style="height: 300px;">
                    </div>
                    <div id="plan-chart-2" class="morris-inverse" style="height: 300px;">
                    </div>
                    <div id="plan-chart-3" class="morris-inverse" style="height: 300px;">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="widget-chart with-sidebar bg-white">
            <div class="widget-chart-content" style="margin-right: 0;position: relative;">
                <h4 class="chart-title" style="color: #242a30;">
                    职业占比
                    {{--<small style="color: #616D72;">Statistics of dose card distribution and recovery</small>--}}
                </h4>
                <hr>
                <div class="morris-inverse innerbox" style="height: 398px;">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>排名</th>
                            <th>职业</th>
                            <th width="150">占比</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($vocations as $k => $item)
                            <tr>
                                <td>{{ $k + 1 }}</td>
                                <td>{{ $item->name }}</td>
                                <td>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: {{ $item->scale }}%">{{ $item->scale }}%</div>
                                    </div>
                                </td>
                            </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="widget-chart with-sidebar bg-white">
            <div class="widget-chart-content" style="margin-right: 0;position: relative">
                <h4 class="chart-title" style="color: #242a30;">
                    洛阳市区域单位数量
                    {{--<small>Statistics of dose card distribution and recovery</small>--}}
                </h4>
                <hr>
                {{--<form action="{{ route('index.index') }}" class="form-inline pull-right">
                    <div class="input-group input-group-sm"
                         style="width: 400px;position: absolute;right: 60px;top: 15px;">

                        <div class="input-group-btn" style="margin-right: 10px;">
                            <select name="company_id" class="form-control jquery-select">
                                <option @if ($company_id == 0) selected @endif value="0">全部单位</option>
                                @foreach($company as $item)
                                    <option @if ($item['id'] == $company_id) selected
                                            @endif value="{{ $item->id }}">{{ $item->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <select class="form-control pull-right" name="year" style="width: 150px;height: 34.4px;">
                            @if (count($years))
                                @foreach($years as $item)
                                    <option @if ($year == $item) selected @endif value="{{ $item }}">{{ $item }}年
                                    </option>
                                @endforeach
                            @endif
                        </select>

                        <div class="input-group-btn">
                            <button type="submit" class="btn btn-default" style="height: 34.4px;"><i
                                        class="fa fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>--}}
                <div id="region-chart" class="morris-inverse" style="height: 300px;">
                </div>
            </div>
        </div>
    </div>
</div>

@endsection
@section('script')
    <script src="{{ asset('admin/assets/js/echarts/echarts.min.js') }}"></script>
    <script src="{{ asset('admin/assets/js/echarts/macarons.js') }}"></script>
    <script>
        $(function () {
            $('.select-year').change(function () {
                $('#year-form').submit();
            });
        });
        var myChart1 = echarts.init(document.getElementById('plan-chart-1'), 'macarons');
        var myChart2 = echarts.init(document.getElementById('plan-chart-2'), 'macarons');
        var myChart3 = echarts.init(document.getElementById('plan-chart-3'), 'macarons');
        var myChart4 = echarts.init(document.getElementById('region-chart'), 'macarons');
        var option1 = {
            title: {
                text: '当前计划发放回收情况',
            },
            tooltip: {
                trigger: 'item',
            },
            legend: {
                icon: 'pie',
                x: 'center',
                y: 'bottom',
                data: ['发放数', '已回收', '未回收']
            },
            series: [
                {
                    name: '当前计划发放回收情况',
                    center: ['50%', '50%'],
                    type: 'pie',
                    radius: ['50%', '65%'],
                    data: [
                        {value: '{{ $current['grant'] }}', name: '发放数'},
                        {value: '{{ $current['is_back'] }}', name: '已回收'},
                        {value: '{{ $current['no_back'] }}', name: '未回收'},
                    ]
                }
            ]
        };
        var option2 = {
            tooltip: {
                trigger: 'axis',
            },
            calculable: true,
            legend: {
                data: ['发放数', '已回收', '未回收']
            },
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: true,
                    data: @json($plan_x),
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            grid: {
                left: '3%',
                right: '4%',
                containLabel: true
            },
            dataZoom: [{
                type: 'inside',
                start: 0,
                end: 100,
            }, {
                start: 0,
                end: 100,
                handleSize: '80%',
                handleStyle: {
                    color: '#fff',
                    shadowBlur: 3,
                    shadowColor: 'rgba(0, 0, 0, 0.6)',
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            }],
            series: [
                {
                    name: '发放数',
                    type: 'bar',
                    barMaxWidth: 30,
                    data: @json($grant)


                },
                {
                    name: '已回收',
                    type: 'bar',
                    barMaxWidth: 30,
                    data: @json($is_back)


                },
                {
                    name: '未回收',
                    type: 'bar',
                    barMaxWidth: 30,
                    data: @json($no_back)


                },
            ]
        };
        var option3 = {
            tooltip: {
                trigger: 'axis',
            },
            calculable: true,
            legend: {
                data: ['发放数', '已回收', '未回收']
            },
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: true,
                    data: @json($company_x),
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            grid: {
                left: '3%',
                right: '4%',
                containLabel: true
            },
            dataZoom: [{
                type: 'inside',
                start: 0,
                end: 100,
            }, {
                start: 0,
                end: 100,
                handleSize: '80%',
                handleStyle: {
                    color: '#fff',
                    shadowBlur: 3,
                    shadowColor: 'rgba(0, 0, 0, 0.6)',
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            }],
            series: [
                {
                    name: '发放数',
                    type: 'bar',
                    barMaxWidth: 30,
                    data: @json($company_grant)


                },
                {
                    name: '已回收',
                    type: 'bar',
                    barMaxWidth: 30,
                    data: @json($company_is_back)


                },
                {
                    name: '未回收',
                    type: 'bar',
                    barMaxWidth: 30,
                    data: @json($company_no_back)


                },
            ]
        };
        var option4 = {
            title: {
                x: 'center',
                text: '洛阳市区域单位数量',
            },
            tooltip: {
                trigger: 'axis',
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: true,
                    data: @json($region_x),
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            grid: {
                left: '3%',
                right: '4%',
                containLabel: true
            },
            dataZoom: [{
                type: 'inside',
                start: 0,
                end: 100,
            }, {
                start: 0,
                end: 100,
                handleSize: '80%',
                handleStyle: {
                    color: '#fff',
                    shadowBlur: 3,
                    shadowColor: 'rgba(0, 0, 0, 0.6)',
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            }],
            series: [
                {
                    name: '单位数量',
                    type: 'bar',
                    barMaxWidth: 30,
                    data: @json($region_data)


                }
            ]
        };
        myChart1.setOption(option1);
        myChart2.setOption(option2);
        myChart3.setOption(option3);
        myChart4.setOption(option4);
        $('.tab-content .morris-inverse').addClass('tab-pane').addClass('fade');
    </script>
@endsection