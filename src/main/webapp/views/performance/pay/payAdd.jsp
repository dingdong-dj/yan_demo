<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/15
  Time: 15:49
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
    <title>发放登记</title>
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

</style>
<body>
<div id="main" style=";background: #fff;left: 15%;">
    <div class="container col-md-12"
         style="margin-top: 30px; margin-left: 50px; display: table;">
        <form id="dataForm" method="post">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">考核员工:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="empNo" id="empNo" >
                        </select>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">考核周期:</label>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <select class="selectpicker" name="checkDt" id="checkDt" >
                        </select>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">发放金额:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="payFee" name="payFee" class="form-control"
                               placeholder="发放金额" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">工资/报销：</label>
                </div>
                <div class="col-md-4">
                    <select id="payType" name="payType" class="selectpicker">
                        <option value="01">工资</option>
                        <option value="02">报销</option>
                    </select>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">发放时间：</label>
                </div>
                <div class="col-md-4">
                    <div class="input-group date form_date col-md-16">
                        <input id="payDt" name="payDt" class="form-control" size="16" type="text"
                               placeholder="请选择日期" readonly> <span
                            class="input-group-addon"><span
                            class="glyphicon glyphicon-remove"></span></span> <span
                            class="input-group-addon"><span
                            class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                    <script type="text/javascript">
                        //	日历组件选择
                        $(".form_date").datetimepicker({
                            language: 'zh-CN',
                            minView: "month",//设置只显示到月份
                            format: "yyyy-mm-dd",
                            autoclose: true,
                            todayBtn: true,
                            minuteStep: 5
                        });
                    </script>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="form-group  col-md-11" style="text-align: center">
                    <div class="form-group" style="text-align: center">
                        <button class="btn btn-success btn-lg" type="button" id="projFormSubmit">提交</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {

        //查询所有员工信息
        $.ajax({
            url: "${pageContext.request.contextPath}/dic/emp/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#empNo").find("option").remove();
                    var list = data.empList;
                    $("#empNo").append("<option value=''></option>");
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var projOption = "";
                            projOption = "<option value='"+ list[i].empNo + "'>" + list[i].empName + "</option>";
                            $("#empNo").append(projOption);
                        }
                        $("#empNo").selectpicker('refresh');
                        //下拉框赋值

                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });

        //查询所有考核编号并显示当前时间段或上一个考核时间的考核项目
        $.ajax({
            url: "${pageContext.request.contextPath}/appraise/project/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#checkDt").find("option").remove();
                    var list = data.list;
                    $("#checkDt").append("<option value=''></option>");
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var projOption = "";
                            projOption = "<option value='"+ list[i] + "'>" + list[i] + "</option>";
                            $("#checkDt").append(projOption);
                        }
                        $("#checkDt").selectpicker('refresh');
                        //下拉框赋值
                        // $("#checkDt").selectpicker('val',data.sysno);
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });
        //必填项检查
        function formCheck() {
            if ($("#empNo").val() == null || $("#empNo").val() == ''||$("#empNo").val() == 'undefined') {
                $.alert("请选择员工");
                return false;
            }

            if ($("#checkDt").val() == "" || $("#checkDt").val() == null || $("#checkDt").val() == "undefined") {
                $.alert("请选择考核周期");
                return false;
            }

            if ($("#payFee").val() == "" || $("#payFee").val() == null || $("#payFee").val() == "undefined") {
                $.alert("请输入发放金额");
                return false;
            }

            if ($("#payType").val() == null || $("#payType").val() == "" || $("#payType").val() == "undefined") {
                $.alert("请选择发放类型");
                return false;
            }

            if ($("#payDt").val() == null || $("#payDt").val() == "" || $("#payDt").val() == "undefined") {
                $.alert("请选择发放时间");
                return false;
            }
            return true;
        }

        //新增
        function createOrUpdate() {
            if (!formCheck()) {
                return;
            }
            var formData = $("#dataForm").serialize();
            var empName = $("#empNo option:selected").text();
            $.post('${pageContext.request.contextPath}/pay/roll/save',$.param({'empName':empName})+'&'+formData,function (data) {
                if("1" == data.status){
                    $.alert(data.msg);
                    return;
                }else{
                    $.alert(data.msg);
                    clearDate();
                }

            })
        }

        function clearDate(){
            $("#empNo").val("");
            $("#payFee").val("");
            $("#payDt").val("");
            $("#checkDt").val("");
        }
        //防止数据重复创建
        $("#projFormSubmit").click(function () {
            createOrUpdate();
        });


    });

    //选择器重绘
    $(".selectpicker").selectpicker({
        width: 'auto'
    });


</script>
</html>
