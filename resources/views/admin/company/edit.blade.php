<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">修改单位</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <input type="hidden" name="id" value="{{ $company->id }}"/>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="name"><span class="form-required">*</span>名称</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="name" name="name" placeholder="请填写名称"
                       data-parsley-required="true" data-parsley-required-message="请填写名称" value="{{ $company->name }}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="region_id"><span class="form-required">*</span>区域</label>

            <div class="col-md-7 col-sm-7">
                <select name="region_id" class="form-control">
                    <option value="">--选择区域--</option>
                    @if (count($region))
                        @foreach($region as $item)
                            <option @if ($item->pid == 0) disabled @endif @if($company->region_id == $item->id) selected @endif value="{{ $item->id }}">{{ $item->html }}{{ $item->name }}</option>
                        @endforeach
                    @endif
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="number"><span class="form-required">*</span>编号</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="number" name="number"
                       placeholder="请填写编号"
                       data-parsley-required="true" data-parsley-required-message="请填写编号" value="{{ $company->number }}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="contact"><span class="form-required">*</span>联系人</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="contact" name="contact"
                       placeholder="请填写联系人"
                       data-parsley-required="true" data-parsley-required-message="请填写联系人" value="{{ $company->contact }}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="mobile"><span class="form-required">*</span>联系电话</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="mobile" name="mobile"
                       placeholder="请填写联系电话"
                       data-parsley-required="true" data-parsley-required-message="请填写联系电话" value="{{ $company->mobile }}"/>
            </div>
        </div>{{--
        <div class="form-group no-parsley">
            <label class="control-label col-md-3 col-sm-3" for="status">是否启用</label>
            <div class="col-md-7 col-sm-7 my_select">
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\Company::NORMAL }}" class="minimal"
                           @if ($company::NORMAL == $company->status)checked @endif>&nbsp;启用
                </label>
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\Company::FORBIDDEN }}" class="minimal"
                           @if ($company::FORBIDDEN == $company->status)checked @endif>&nbsp;禁用
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