<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">修改计划</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <input type="hidden" name="id" value="{{ $plan->id }}"/>

        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="name"><span class="form-required">*</span>名称</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="name" name="name" placeholder="请填写名称"
                       data-parsley-required="true" data-parsley-required-message="请填写名称"
                       data-parsley-maxlength="20"
                       data-parsley-maxlength-message="名称最多20个字符" value="{{ $plan->name }}"/>
            </div>
        </div>
        <div class="form-group no-parsley">
            <label class="control-label col-md-3 col-sm-3" for="status">状态</label>

            <div class="col-md-7 col-sm-7 my_select">
                @if ($plan->status == 1)
                    <label class="control-label">
                        <input type="radio" name="status" value="{{ \App\Models\Plan::GRANT }}" class="minimal"
                               @if ($plan::GRANT == $plan->status)checked @endif>&nbsp;发放中
                    </label>
                    <label class="control-label">
                        <input type="radio" name="status" value="{{ \App\Models\Plan::RECOVERY }}" class="minimal"
                               @if ($plan::RECOVERY == $plan->status)checked @endif>&nbsp;回收中
                    </label>
                    @elseif ($plan->status == 2)
                    <label class="control-label">
                        <input type="radio" name="status" value="{{ \App\Models\Plan::RECOVERY }}" class="minimal"
                               @if ($plan::RECOVERY == $plan->status)checked @endif>&nbsp;回收中
                    </label>
                    <label class="control-label">
                        <input type="radio" name="status" value="{{ \App\Models\Plan::END }}" class="minimal"
                               @if ($plan::END == $plan->status)checked @endif>&nbsp;已结束
                    </label>
                    @else
                    <label class="control-label">
                        已结束
                    </label>
                @endif
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-sm btn-white" data-dismiss="modal">取消</button>
    <button type="submit" class="btn btn-sm btn-success">确定</button>
</div>
<script>
    $(function () {
        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });

    })
</script>