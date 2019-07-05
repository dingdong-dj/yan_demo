<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/5
  Time: 8:55
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
    <title>项目字典管理</title>
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
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">考核编号：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="sysNo" name="sysNo" class="form-control"
                               value="${projectAppraise.sysNo}"  placeholder="考核编号根据考核时间自动生成" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">考核时间：</label>
                </div>
                <div class="col-md-4">
                    <div class="input-group date form_date col-md-16">
                        <input id="fillDt" name="fillDt" class="form-control" size="16" type="text" value="${projectAppraise.fillDt}"
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
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="projNo" id="projNo" >
                        </select>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">客户:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="customName" name="customName" class="form-control"
                               value="${projectAppraise.customName}"  placeholder="客户" readonly/>
                        <input type="hidden" value="${projectAppraise.customId}" id = "customId" name = "customId">
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">考核年度:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="checkYear" id="checkYear" >
                        </select>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">考核周期：</label>
                </div>
                <div class="col-md-4">
                    <select id="checkDt" name="checkDt" class="selectpicker">
                        <option value="Q1">上半年</option>
                        <option value="Q2">下半年</option>
                    </select>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">本季回款：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="backFee" name="backFee"
                               value="${projectAppraise.backFee}" class="form-control" placeholder="本季回款金额" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">有效金额：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="validFee" name="validFee"
                               value="${projectAppraise.validFee}" class="form-control" placeholder="有效考核基准金额" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                    </div>
                </div>
            </div>
<%--            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">--%>
<%--                <div class="col-md-2 text-left"--%>
<%--                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">--%>
<%--                    <label style="margin-top: 5px; font-size: 14px; color: grey;">绩效系数：</label>--%>
<%--                </div>--%>
<%--                <div class="col-md-4">--%>
<%--                    <div class="form-group">--%>
<%--                        <input type="text" id="kSumn" name="kSumn"--%>
<%--                               value="${projectAppraise.kSumn}" class="form-control" placeholder="绩效系数" readonly/>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-md-2 text-left"--%>
<%--                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">--%>
<%--                    <label style="margin-top: 5px; font-size: 14px; color: grey;">最终金额：</label>--%>
<%--                </div>--%>
<%--                <div class="col-md-4">--%>
<%--                    <div class="form-group">--%>
<%--                        <input type="text" id="lastFee" name="lastFee"--%>
<%--                               value="${projectAppraise.lastFee}" class="form-control" placeholder="最终金额" onchange=" calculateKsum()" onkeyup="value=value.replace(/[^\d.]/g,'')"/>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
            <c:choose>
                <c:when test="${projectAppraise.sysNo == null || projectAppraise.sysNo == ''}">
                    <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                        <div class="form-group  col-md-11" style="text-align: center">
                            <div class="form-group" style="text-align: center">
                                <button class="btn btn-success btn-lg" type="button" id="projFormSubmit">提交</button>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                        <div class="form-group  col-md-11" style="text-align: center">
                            <div class="form-group" style="text-align: center">
                                <button class="btn btn-success btn-lg" type="button" id="projUpdate">修改</button>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        var year = getYear();
        for (var i = 0; i < year.length; i++) {
            var yearOption = "";
            yearOption = "<option value='"+ year[i] + "'>" + year[i] + "</option>";
            $("#checkYear").append(yearOption);
        }
        $("#checkYear").selectpicker('refresh');
        var data = getNowFormatDate();
        $("#checkYear").selectpicker('val',data.substr(0, 4));

        //项目状态赋值
        $("#checkDt").selectpicker('val','${projectAppraise.checkDt}');


        //查询所有项目信息做成选项
        //注意：后期看看需要添加条件码
        $.ajax({
            url: "${pageContext.request.contextPath}/dic/proj/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#projNo").find("option").remove();
                    var list = data.projList;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var projOption = "";
                            projOption = "<option value='"+ list[i].projNo + "'>" + list[i].projName + "</option>";
                            $("#projNo").append(projOption);
                        }
                        $("#projNo").selectpicker('refresh');
                        //下拉框赋值
                        $("#projNo").selectpicker('val','${projectAppraise.projNo}');
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });


        //必填项检查
        function formCheck() {
            if ($("#sysNo").val() == null || $("#sysNo").val() == ''||$("#sysNo").val() == 'undefined') {
                $.alert("考核编号不能为空,选择考核周期生成");
                return false;
            }

            if ($("#fillDt").val() == "" || $("#fillDt").val() == null || $("#fillDt").val() == "undefined") {
                $.alert("考核时间不能为空");
                return false;
            }

            if ($("#projNo").val() == "" || $("#projNo").val() == null || $("#projNo").val() == "undefined") {
                $.alert("请选择项目");
                return false;
            }

            if ($("#checkYear").val() == null || $("#checkYear").val() == "" || $("#checkYear").val() == "undefined") {
                $.alert("请选择考核年度");
                return false;
            }

            if ($("#checkDt").val() == null || $("#checkDt").val() == "" || $("#checkDt").val() == "undefined") {
                $.alert("请选择考核周期");
                return false;
            }
            if ($("#backFee").val() == null || $("#backFee").val() == "" || $("#backFee").val() == "undefined") {
                $.alert("本季回款不能为空");
                return false;
            }

            if ($("#validFee").val() == null || $("#validFee").val() == "" || $("#validFee").val() == "undefined") {
                $.alert("有效金额不能为空");
                return false;
            }
            return true;
        }


        function createOrUpdate() {
            if (!formCheck()) {
                return;
            }
            var formData = $("#dataForm").serialize();
            var projName = $("#projNo option:selected").text();
            $.post('${pageContext.request.contextPath}/appraise/project/save',$.param({'projName':projName})+'&'+formData,function (data) {
                if("1" == data.status){
                    $.alert(data.msg);
                    return;
                }
                $("#projFormSubmit").hide();
                $.alert(data.msg);
            })
        }

        //防止数据重复创建
        $("#projFormSubmit").click(function () {
            createOrUpdate();
        });

        //防止数据重复创建
        $("#projUpdate").click(function () {
            projUpdate();
        });

        function projUpdate() {
            if (!formCheck()) {
                return;
            }
            var formData = $("#dataForm").serialize();
            var empName = $("#empNo option:selected").text();
            var customName = $("#customId option:selected").text();
            $.post('${pageContext.request.contextPath}/dic/proj/update',$.param({'empName':empName,'customName':customName})+'&'+formData,function (data) {
                if("1" == data.status){
                    $.alert(data.msg);
                    return;
                }
                $("#projFormSubmit").hide();
                $.alert(data.msg);
            })
        }

    });

    //选择器重绘
    $(".selectpicker").selectpicker({
        width: 'auto'
    });

    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = year + seperator1 + month + seperator1 + strDate;
        return currentdate;
    }



    $("#projNo").change(function () {
        var projNo =  $("#projNo").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/dic/proj/find/custom",
            async: true,
            type: "POST",
            dataType: "json",
            data: {"projNo":projNo},
            success: function (data) {
                // var projDic = data.projDic;
                console.log(data);
                if(data.success){
                    var custom = data.custom
                    $("#customName").val(custom.customName);
                    $("#customId").val(custom.customId);
                }
            }
        })
    })

    function getYear(){
        var myDate = new Date();
        var startYear = myDate.getFullYear()-10;
        var endYear = myDate.getFullYear();
        var year = []
        for(var i = startYear;i<=endYear;i++){
            year.push(i);
        }
        return year;
    }

    $("#checkYear").change(function () {
        if($("#checkDt").val() != null && $("#checkDt").val() != ""){
            var sysNo = $("#checkYear").val()+$("#checkDt").val();
            $("#sysNo").val(sysNo);
        }
    })

    $("#checkDt").change(function () {
        if($("#checkYear").val() != null && $("#checkYear").val() != ""){
            var sysNo = $("#checkYear").val()+$("#checkDt").val();
            $("#sysNo").val(sysNo);
        }
    })
</script>
</html>