<!DOCTYPE html>
<html>

<head>
    <title></title>
</head>
<script src="{{ asset('admin/assets/print/js/jquery-1.4.4.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('admin/assets/print/js/JsBarcode.all.min.js') }}"></script>
<style>
    .title {
        font-size: 4px;
        text-align: center;
        font-weight: bold;
    }

    p {
        margin: 0;
    }

    .header {
        margin: 0 auto;
        width: 200px;
        margin-top: 20px;
    }

    .page {
     margin-top: 8px;
    }

    .page {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }

    .print {
        margin-left: 40px;
        padding: 7px 12px;
        color: #fff;
        background: #348fe2;
        border-color: #348fe2;
        text-decoration: none;
        border-radius: 5px;
    }

    .back {
        padding: 7px 12px;
        color: #fff;
        background: #00acac;
        border-color: #00acac;
        text-decoration: none;
        border-radius: 5px;
    }

    @media print {
        body {
            background-color: #FFFFFF;
            margin: 0mm;
            /* this affects the margin on the content before sending to printer */
        }

        .page {
            break-after: page;
            page-break-after: always;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .bcode {
            width: 85%;
            height: 32px;

        }

        .title {
            font-size: 4px;
            text-align: center;
            font-weight: bold;
        }

        p {
            margin: 0;
        }

    }
</style>

<script type="text/javascript">
    function myprint() {
        //直接调用浏览器打印功能
        bdhtml = window.document.body.innerHTML;
        //定义打印区域起始字符，根据这个截取网页局部内容
        sprnstr = "<!--startprint-->"; //打印区域开始的标记
        eprnstr = "<!--endprint-->"; //打印区域结束的标记
        prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        //开始打印
        window.print();
        // $("#bcode").jqprint();
        // 还原网页内容
        window.document.body.innerHTML = bdhtml;
    }

    function barcodeGen() {
        var barvalue = $("#barcodeValue").val();
        if (barvalue == "") {
            alert("请输入条形码字符串！！")
        } else {
            $("#bcode").JsBarcode(barvalue,{displayValue: false});
            $("#bcode1").JsBarcode(barvalue,{displayValue: false});
        }
    }
    $(function () {
        $('.page .number').each(function (idx, item) {
            $(item).parent('.page').find('.bcode').JsBarcode($(item).text(),{displayValue: false});
        })
    })
</script>

<body>
<!--startprint-->
@if(count($lists))
    @foreach($lists as $item)
        <div class="page">
            <p class="title">{{ $item->name }}</p>
            <img class="bcode"/>

            <p class="title number">{{ $item->company->number }}{{ $item->card_number->number }}</p>

        </div>
        @endforeach
        @endif
                <!--endprint-->
        <hr>
        <div class="header">
            <a href="{{ route('user.index') }}" class="back"><span> 返回列表</span></a>
            <a href="#" class="print" onClick="myprint();"><span> 打 印</span></a>
        </div>


</body>

</html>