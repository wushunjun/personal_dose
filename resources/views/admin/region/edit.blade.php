<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">修改区域</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <input type="hidden" name="id" value="{{ $region->id }}"/>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="pid"><span class="form-required">*</span>上级</label>
            <div class="col-md-7 col-sm-7">
                <select name="pid" class="form-control">
                    <option value="0" @if (0 == $region->pid) selected @endif>顶级</option>
                    @if (count($pid))
                        @foreach($pid as $item)
                            <option value="{{ $item->id }}" @if($region->pid == $item->id) selected @endif>{{ $item->name }}</option>
                        @endforeach
                    @endif
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="name"><span class="form-required">*</span>名称</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="name" name="name" placeholder="请填写名称"
                       data-parsley-required="true" data-parsley-required-message="请填写名称"
                       data-parsley-maxlength="20"
                       data-parsley-maxlength-message="名称最多20个字符" value="{{ $region->name }}"/>
            </div>
        </div>{{--
        <div class="form-group no-parsley">
            <label class="control-label col-md-3 col-sm-3" for="status">是否启用</label>
            <div class="col-md-7 col-sm-7 my_select">
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\Company::NORMAL }}" class="minimal"
                           @if ($region::NORMAL == $region->status)checked @endif>&nbsp;启用
                </label>
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\Company::FORBIDDEN }}" class="minimal"
                           @if ($region::FORBIDDEN == $region->status)checked @endif>&nbsp;禁用
                </label>
            </div>
        </div>--}}
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