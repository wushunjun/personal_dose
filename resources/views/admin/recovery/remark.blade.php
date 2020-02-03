<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">备注</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <input type="hidden" name="label_id" value="{{ $label->id }}"/>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="name">姓名</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" readonly  value="{{ $label->user->name }}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="name">号牌编号</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" readonly  value="{{ $label->user->company->number }}{{ $label->user->card_number->number }}"/>
            </div>
        </div>
        <div class="form-group no-parsley">
            <label class="control-label col-md-3 col-sm-3" for="status">在职状态</label>
            <div class="col-md-7 col-sm-7 my_select">
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\User::NORMAL }}" class="minimal"
                           @if (\App\Models\User::NORMAL == $label->user->status)checked @endif>&nbsp;在职
                </label>
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\User::FORBIDDEN }}" class="minimal"
                           @if (\App\Models\User::FORBIDDEN == $label->user->status)checked @endif>&nbsp;离职
                </label>
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\User::RETIRE }}" class="minimal"
                           @if (\App\Models\User::RETIRE == $label->status)checked @endif>&nbsp;退休
                </label>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="remark">备注</label>

            <div class="col-md-7 col-sm-7">
                <textarea class="form-control" name="remark" data-parsley-required="true" data-parsley-required-message="请填写备注内容" placeholder="备注内容"></textarea>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-sm btn-white" data-dismiss="modal">取消</button>
    <button type="submit" class="btn btn-sm btn-success">更新</button>
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