<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">剂量牌记录</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>详情</th>
                <th>操作员</th>
                <th>状态</th>
                <th>操作时间</th>
            </tr>
            </thead>
            <tbody>
            @if(count($lists))
                @foreach($lists as $item)
                    <tr>
                        <td>{{ $item->remark }}</td>
                        <td>{{ $item->admin_name }}</td>
                        <td>{!! \App\Models\LabelLog::$statusText[$item->status] !!}</td>
                        <td>{{ $item->created_at }}</td>
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
</div>