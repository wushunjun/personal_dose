<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">审核备注</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>备注时间</th>
                <th>备注人员</th>
                <th>备注</th>
            </tr>
            </thead>
            <tbody>
            @if(count($lists))
                @foreach($lists as $item)
                    <tr>
                        <td>{{ $item->created_at }}</td>
                        <td>{{ $item->admin_name }}</td>
                        <td>在职状态：{{ $item::$statusText[$item->status] }} 内容：{{ $item->remark }}</td>
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