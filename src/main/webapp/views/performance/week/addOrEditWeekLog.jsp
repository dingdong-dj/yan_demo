<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/19
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>周报添加</title>
</head>
<style>

    .fixed-table-toolbar {
        display: none;
    }

    .fixed-table-pagination {
        display: none;
    }

    .fixed-table-pagination {
        display: none;
    }

    .fixed-table-container {
        height: initial;
    }


    .colStyle {
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }

</style>
<body>
<div id="main" style=";background: #fff;left: 15%;">
    <div class="container col-md-12"
         style="margin-top: 30px; margin-left: 50px; display: table;">
        <form id="dataForm" method="post">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px; display: none">
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="text" id="sysno" name="sysno"
                               value="${wkLog.sysno}" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">周号：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="weekNo" name="weekNo"
                               value="${wkLog.weekNo}" class="form-control" readonly
                               placeholder="周号"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">周报主题：</label>
                </div>
                <div class="col-md-10">
                    <div class="form-group">
                        <textarea type="text" class="form-control" rows="1" id="titleName" name="titleName"
                                  placeholder="可以写医院名或研发中心">${wkLog.titleName}</textarea>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">本周总结：</label>
                </div>
                <div class="col-md-10">
                    <div class="form-group">
                        <textarea type="text" class="form-control" rows="3" id="sumText" name="sumText"
                                  placeholder="本周总结">${wkLog.sumText}</textarea>
                    </div>
                </div>
            </div>
            <input hidden id="fillEmp" name="fillEmp" value="${wkLog.fillEmp}">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="form-group  col-md-11" style="text-align: center">
                    <div style="margin:10px 0px 10px 5px">
                        <label style="margin-top: 5px; font-size: 1.5rem;">周报详情</label>
                        <button type="button" class="btn btn-default" style="float:right;margin:0 0 0 0"
                                id="tableRemoveData">
                            <span class="glyphicon glyphicon-remove"></span>
                        </button>
                        <button type="button" class="btn btn-default" style="float:right;margin:0 0 0 0"
                                id="tableAddData">
                            <span class="glyphicon glyphicon-plus"></span>
                        </button>
                    </div>
                    <table id="formTable" class="table"></table>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="form-group  col-md-11" style="text-align: center">
                    <div class="form-group" style="text-align: center">
                        <button class="btn btn-success btn-lg" type="button" id="registerFormSubmit">提交</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    var $registerTable = $('#formTable');
    $(function () {
        var data = new Date();
        var year = data.getFullYear();
        var week = getweek();
        $("#weekNo").val(year.toString()+week.toString());

        //绘制表格
        $registerTable.bsTable({
            toolbar: '#toolbar',
            singleSelect: true,
            search: true,
            height: 0,
            clickToSelect: true,
            detailView: false,
            pagination: false,
            //是否开启分页（*）
            pageNumber: 1,
            //初始化加载第一页，默认第一页
            pageSize: 8,
            //每页的记录行数（*）
            sidePagination: "client",
            //分页方式：client客户端分页，server服务端分页（*）
            columns: [
                {
                    field: 'state',
                    checkbox: true
                },
                {
                    field: 'sysno',
                    title: '系统编码',
                    align: 'center',
                    visible: false
                },
                {
                    field: 'lineId',
                    title: '行号',
                    align: 'center',
                    visible: false
                },
                {
                    field: 'logType',
                    title: '明细类别',
                    align: 'center',
                    editable: {
                        type: 'select',
                        showbuttons: false,
                        mode: 'popup',
                        source: [{value: "log", text: "本周工作"}, {value: "plan", text: "下周工作"}]
                    }
                },
                {
                    field: 'logDt',
                    title: '日志日期',
                    align: 'center',
                    editable: {
                        type: 'date',
                        showbuttons: false,
                    }
                },
                {
                    field: 'workType',
                    title: '工作内容类别',
                    align: 'center',
                    editable: {
                        type: 'select',
                        mode: 'popup',
                        showbuttons: false,
                        source: [{value: "requ", text: "需求"}, {value: "bug", text: "错误"},
                            {value: "stat", text: "统计"}, {value: "other", text: "其他"}]
                    }
                },
                {
                    field: 'logDesc',
                    title: '工作记录或内容',
                    align: 'center',
                    editable: {
                        type: 'textarea',
                        onblur: 'submit',
                        showbuttons: false
                    }
                },
                {
                    field: 'dealEmp',
                    title: '处理人',
                    align: 'center',
                    editable: {
                        type: 'text',
                        onblur: 'submit',
                        showbuttons: false
                    }
                },
                {
                    field: 'result',
                    title: '完成情况',
                    align: 'center',
                    editable: {
                        type: 'text',
                        onblur: 'submit',
                        showbuttons: false
                    }
                },
                {
                    field: 'remarks',
                    title: '备注',
                    align: 'center',
                    class:'colStyle',
                    editable: {
                        type: 'textarea',
                        onblur: 'submit',
                        showbuttons: false
                    },
                },
            ]
        });
        //表格添加数据
        $('#tableAddData').click(function () {
            if(!tableCheck()){
                return;
            }
            var nowData = $registerTable.bootstrapTable('getData');
            var addLineNo = 1;
            if (0 < nowData.length) {
                addLineNo = parseInt(nowData[nowData.length - 1].lineNo) + 1 || 1;
            }

            var data = {
                sysno: $("#sysno").val(),
                lineId: addLineNo,
                logType: '',
                logDt: '',
                workType: '',
                logDesc:'',
                dealEmp:'',
                result:'',
                remarks: '',
            };
            $registerTable.bootstrapTable('append', data);
        });

        $("#registerFormSubmit").click(function () {
            createOrUpdate();
        });



        function createOrUpdate() {
            if (!formCheck()) {
                return;
            }
            if(!tableCheck()){
                return;
            }
            console.log($registerTable.bootstrapTable('getData'));
            var jsonLogDet = JSON.stringify($registerTable.bootstrapTable('getData'));
            $.ajax({
                url: "${pageContext.request.contextPath}/week/log/create",
                type: "post",
                data: {
                    sysno:$("#sysno").val(),
                    weekNo:$("#weekNo").val(),
                    titleName:$("#titleName").val(),
                    sumText:$("#sumText").val(),
                    fillEmp:$("#fillEmp").val(),
                    wkLogDet:jsonLogDet
                },
                success: function (data) {
                    if (!data.success) {
                        $.alert(data.msg);
                    } else {
                        $.alert(data.msg);
                        $("#registerFormSubmit").hide()
                    }
                }
            });


        }


        //table项检查
        function tableCheck(){
            var nowData = $registerTable.bootstrapTable('getData');
            var length = nowData.length;
            if(length == 0){
                return true;
            }
            try{
                nowData.forEach(function (item,index,arr) {
                    var l = index+1;
                    if(item.logType == '' || item.logType == null){
                        $.alert("请选择第"+l +"行 明细类别!");
                        throw new Error('找到目标');
                    }
                    if(item.logDt == '' || item.logDt == null){
                        $.alert("请选择第"+length +"行 日志日期!");
                        throw new Error('找到目标');
                    }
                    if(item.workType == '' || item.workType == null){
                        $.alert("请选择第"+l +"行 工作内容类别!");
                        throw new Error('找到目标');
                    }

                    if(item.logDesc == '' || item.logDesc == null){
                        $.alert("请输入第"+ l+"行 工作记录或内容!");
                        throw new Error('找到目标');
                    }

                    if(item.dealEmp == '' || item.dealEmp == null){
                        $.alert("请输入第"+l +"行 处理人!");
                        throw new Error('找到目标');
                    }
                })
                return true;
            }catch(e){
                return false;
            }
        }
        //必填项检查
        function formCheck() {
            if ($("#weekNo").val() == "") {
                $.alert("周号不能为空");
                return false;
            }

            if ($("#titleName").val() == "") {
                $.alert("周报主题不能为空");
                return false;
            }
            return true;
        }

    });

    function getweek(dateString){
        var da='';
        if(dateString==undefined){
            var now=new Date();
            var now_m=now.getMonth()+1;
            now_m=(now_m<10)?'0'+now_m:now_m;
            var now_d=now.getDate();
            now_d=(now_d<10)?'0'+now_d:now_d;
            da=now.getFullYear()+'-'+now_m+'-'+now_d;
        }else{
            da=dateString;//日期格式2015-12-30
        }
        var date1 = new Date(da.substring(0,4), parseInt(da.substring(5,7)) - 1, da.substring(8,10));//当前日期
        var date2 = new Date(da.substring(0,4), 0, 1); //1月1号
        //获取1月1号星期（以周一为第一天，0周一~6周日）
        var dateWeekNum=date2.getDay()-1;
        if(dateWeekNum<0){dateWeekNum=6;}
        if(dateWeekNum<4){
            //前移日期
            date2.setDate(date2.getDate()-dateWeekNum);
        }else{
            //后移日期
            date2.setDate(date2.getDate()+7-dateWeekNum);
        }
        var d = Math.round((date1.valueOf() - date2.valueOf()) / 86400000);
        if(d<0){
            var date3 = (date1.getFullYear()-1)+"-12-31";
            return getYearWeek(date3);
        }else{
            //得到年数周数
            var year=date1.getFullYear();
            var week=Math.ceil((d+1 )/ 7);
            return  week;
        }
    };
    //表格移除数据
    $('#tableRemoveData').click(function () {
        var rows = $registerTable.bootstrapTable('getSelections');
        if (rows.length == 0) {
            $.confirm({
                title: false,
                content: '请选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除数据吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            for (var i = 0; i < rows.length; i++) {
                                $registerTable.bootstrapTable('remove', {
                                    field: 'lineNo',
                                    values: [rows[i].lineNo]
                                });
                            }
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        }
    });
    //选择器重绘
    $(".selectpicker").selectpicker({
        width: 'auto'
    });

    //选择器禁用
    $('.selectpicker').prop('disabled', true);

</script>
</html>