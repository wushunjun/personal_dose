<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">修改号牌</h4>
</div>
<div class="modal-body">
    <div class="panel-body panel-form">
        <input type="hidden" name="id" value="{{ $number->id }}"/>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="name"><span class="form-required">*</span>编号</label>

            <div class="col-md-7 col-sm-7">
                <input class="form-control" type="text" id="number" name="number" placeholder="请填写编号"
                       data-parsley-required="true" data-parsley-required-message="请填写编号"
                       data-parsley-maxlength="20"
                       data-parsley-maxlength-message="编号最多20个字符" value="{{ $number->number }}"/>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-md-3 col-sm-3" for="region_id"><span class="form-required">*</span>单位</label>

            <div class="col-md-7 col-sm-7">
                <select name="region_id" class="form-control" id="edit_region_id" style="width: 150px;float: left;">
                    <option value="">--选择区域--</option>
                    @if (count($region))
                        @foreach($region as $item)
                            <option @if ($item->pid == 0) disabled @endif @if ($item->id == $number->region_id) selected @endif value="{{ $item->id }}">{{ $item->html }}{{ $item->name }}</option>
                        @endforeach
                    @endif
                </select>
                <select name="company_id" id="edit_company_id" class="form-control" style="margin-left:20px;width: 150px;float: left">
                    <option value="">--选择单位--</option>
                    @if (count($company))
                        @foreach($company as $item)
                            <option @if ($item->id == $number->company_id) selected @endif value="{{ $item->id }}">{{ $item->name }}</option>
                        @endforeach
                    @endif
                </select>
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

    })
</script>