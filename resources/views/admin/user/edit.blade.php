<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">修改人员</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <input type="hidden" name="id" value="{{ $user->id }}"/>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="name_edit"><span class="form-required">*</span>姓名</label>
            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="name_edit" name="name" placeholder="请填写姓名"
                       data-parsley-required="true" data-parsley-required-message="请填写姓名"
                       data-parsley-maxlength="20"
                       data-parsley-maxlength-message="姓名最多20个字符" value="{{ $user->name }}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="region_id"><span class="form-required">*</span>单位</label>

            <div class="col-md-7 col-sm-7">
                <select name="region_id" class="form-control" disabled id="edit_region_id" style="width: 150px;float: left;">
                    <option value="">--选择区域--</option>
                    @if (count($region))
                        @foreach($region as $item)
                            <option @if ($item->pid == 0) disabled @endif @if ($item->id == $user->region_id) selected @endif value="{{ $item->id }}">{{ $item->html }}{{ $item->name }}</option>
                        @endforeach
                    @endif
                </select>
                <select name="company_id" id="edit_company_id" disabled class="form-control" style="margin-left:20px;width: 150px;float: left">
                    <option value="">--选择单位--</option>
                    @if (count($company))
                        @foreach($company as $item)
                            <option @if ($item->id == $user->company_id) selected @endif value="{{ $item->id }}">{{ $item->name }}</option>
                        @endforeach
                    @endif
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3"><span class="form-required">*</span>单位编号</label>
            <div class="col-md-7 col-sm-7">
                <input class="form-control" id="edit_company_number" type="text" value="{{ $user->company->number }}" readonly/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="edit_number_id"><span class="form-required">*</span>号牌</label>
            <div class="col-md-7 col-sm-7">
                <select name="number_id" disabled id="edit_number_id" class="form-control">
                    <option value="">--选择号牌--</option>
                    @if (count($number))
                        @foreach($number as $item)
                            <option @if ($item->id == $user->number_id) selected @endif value="{{ $item->id }}">{{ $item->number }}</option>
                        @endforeach
                    @endif
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="vocation_id"><span class="form-required">*</span>职业</label>
            <div class="col-md-7 col-sm-7">
                <select name="vocation_id" id="vocation_id" class="form-control">
                    @if (count($vocation))
                        @foreach($vocation as $item)
                            <option @if ($item->id == $user->vocation_id) selected @endif value="{{ $item->id }}">{{ $item->name }}</option>
                        @endforeach
                    @endif
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="number">证件编号</label>
            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="number" name="number"
                       placeholder="请填写证件编号"
                       value="{{ $user->number }}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="entry_at">入职时间</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control time" type="text" id="entry_at" name="entry_at"
                       placeholder="请填写入职时间" value="{{ date('Y-m-d', $user->entry_at) }}"/>
            </div>
        </div>
        <div class="form-group no-parsley">
            <label class="control-label col-md-3 col-sm-3" for="sex"><span class="form-required">*</span>性别</label>
            <div class="col-md-7 col-sm-7 my_select">
                <label class="control-label">
                    <input type="radio" name="sex" value="{{ \App\Models\User::MAN }}" class="minimal"
                           @if ($user::MAN == $user->sex)checked @endif>&nbsp;男
                </label>
                <label class="control-label">
                    <input type="radio" name="sex" value="{{ \App\Models\User::WOMAN }}" class="minimal"
                           @if ($user::WOMAN == $user->sex)checked @endif>&nbsp;女
                </label>
            </div>
        </div>
        <div class="form-group no-parsley">
            <label class="control-label col-md-3 col-sm-3" for="status"><span class="form-required">*</span>是否在职</label>
            <div class="col-md-7 col-sm-7 my_select">
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\User::NORMAL }}" class="minimal"
                           @if ($user::NORMAL == $user->status)checked @endif>&nbsp;在职
                </label>
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\User::FORBIDDEN }}" class="minimal"
                           @if ($user::FORBIDDEN == $user->status)checked @endif>&nbsp;离职
                </label>
                <label class="control-label">
                    <input type="radio" name="status" value="{{ \App\Models\User::RETIRE }}" class="minimal"
                           @if ($user::RETIRE == $user->status)checked @endif>&nbsp;退休
                </label>
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
        $('.time').datepicker({
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            autoclose: true
        });
        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });
        //选择区域
        $('body').on('change', '#edit_region_id', function () {
            var region_id = $(this).val();
            var obj = $('#edit_company_id');
            $.ajax({
                url: "{{ route('company.get_company') }}",
                data: {region_id:region_id},
                dataType: 'json',
                success: function(res){
                    var html_str = '<option value="">--选择单位--</option>';
                    $.each(res.data,function(idx,item){
                        html_str += '<option data-number="' + item.number + '" value="' + item.id + '">' + item.name + '</option>';
                    })
                    $(obj).html(html_str);
                },
                error: function(){
                    alert('网络连接错误，请联系管理员');
                }
            })
        });
        //选择单位
        $('body').on('change', '#edit_company_id', function () {
            var company_id = $(this).val();
            var company_number = $(this).find("option:selected").attr('data-number');
            var obj = $('#edit_number_id');
            $('#edit_company_number').val(company_number);
            $.ajax({
                url: "{{ route('number.get_numbers') }}",
                data: {company_id:company_id},
                dataType: 'json',
                success: function(res){
                    var html_str = '<option value="">--选择号牌--</option>';
                    $.each(res.data,function(idx,item){
                        html_str += '<option value="' + item.id + '">' + item.number + '</option>';
                    })
                    $(obj).html(html_str);
                },
                error: function(){
                    alert('网络连接错误，请联系管理员');
                }
            })
        });
    })
</script>