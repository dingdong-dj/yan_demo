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
    <title>员工绩效管理</title>
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
                        <select class="selectpicker" name="sysNo" id="sysNo" >
                        </select>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">考核项目:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="projNo" id="projNo" >
                        </select>
                    </div>
                </div>
            </div>
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
                        <input type="text" id="checkDt" name="checkDt" class="form-control"
                               value="${pAward.checkDt}"  placeholder="考核周期" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">分配时间：</label>
                </div>
                <div class="col-md-4">
                    <div class="input-group date form_date col-md-16">
                        <input id="distDt" name="distDt" class="form-control" size="16" type="text" value="${pAward.distDt}"
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
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">分配人：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="distEmp" id="distEmp" >
                        </select>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">绩效奖金:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="award" name="award" class="form-control"
                               value="${pAward.award}"  placeholder="绩效奖金" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">审核状态：</label>
                </div>
                <div class="col-md-4">
                    <select id="checkFlag" name="checkFlag" class="selectpicker">
                        <option value="INIT">初始状态</option>
                        <option value="OK">已审核</option>
                        <option value="PUB">可公布</option>
                    </select>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">备注：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <textarea type="text" class="form-control" rows="2" id="remarks" name="remarks"
                                  placeholder="请输入描述">${pAward.remarks}</textarea>
                    </div>
                </div>
            </div>
            <c:choose>
                <c:when test="${pAward.sysNo == null || pAward.sysNo == ''}">
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

        //查询所有考核周期并生成select
        $.ajax({
            url: "${pageContext.request.contextPath}/appraise/project/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#sysNo").find("option").remove();
                    var list = data.list;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var projOption = "";
                            projOption = "<option value='"+ list[i] + "'>" + list[i] + "</option>";
                            $("#sysNo").append(projOption);
                        }
                        $("#sysNo").selectpicker('refresh');
                        //下拉框赋值
                        $("#sysNo").selectpicker('val',data.sysno);
                        $("#sysNo").change();
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/dic/emp/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#empNo").find("option").remove();
                    $("#distEmp").find("option").remove();
                    var list = data.empList;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            // var projOption = "";
                            var projOption = "<option value=''></option>";
                            projOption = "<option value='"+ list[i].empNo + "'>" + list[i].empName + "</option>";
                            $("#empNo").append(projOption);
                            $("#distEmp").append(projOption);
                        }
                        $("#empNo").selectpicker('refresh');
                        $("#distEmp").selectpicker('refresh');
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });


        <c:if test ="${pAward.sysNo != null && pAward.sysNo != ''}">
            $("#sysNo").attr("disabled",true);
            $("#projNo").attr("disabled",true);
            $("#empNo").attr("disabled",true);
        </c:if>
        //必填项检查
        function formCheck() {
            if ($("#sysNo").val() == null || $("#sysNo").val() == ''||$("#sysNo").val() == 'undefined') {
                $.alert("请选择考核编号");
                return false;
            }

            if ($("#projNo").val() == "" || $("#projNo").val() == null || $("#projNo").val() == "undefined") {
                $.alert("请选择考核项目");
                return false;
            }

            if ($("#empNo").val() == null || $("#empNo").val() == "" || $("#empNo").val() == "undefined") {
                $.alert("请选择考核员工");
                return false;
            }

            if ($("#checkDt").val() == null || $("#checkDt").val() == "" || $("#checkDt").val() == "undefined") {
                $.alert("考核周期不能为空");
                return false;
            }
            if ($("#award").val() == null || $("#award").val() == "" || $("#award").val() == "undefined") {
                $.alert("绩效奖金不能为空");
                return false;
            }

            if ($("#distDt").val() == null || $("#distDt").val() == "" || $("#distDt").val() == "undefined") {
                $.alert("请选择分配时间");
                return false;
            }

            if ($("#distEmp").val() == null || $("#distEmp").val() == "" || $("#distEmp").val() == "undefined") {
                $.alert("请选择分配人");
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
            var projName = $("#projNo option:selected").text();
            var empName =  $("#empNo option:selected").text();
            $.post('${pageContext.request.contextPath}/appraise/people/save',$.param({'projName':projName,'empName':empName})+'&'+formData,function (data) {
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
            $("#sysNo").attr("disabled",false);
            $("#projNo").attr("disabled",false);
            $("#empNo").attr("disabled",false);
            projUpdate();
        });

        //更新
        function projUpdate() {
            if (!formCheck()) {
                return;
            }
            var formData = $("#dataForm").serialize();
            var projName = $("#projNo option:selected").text();
            var empName =  $("#empNo option:selected").text();
            $.post('${pageContext.request.contextPath}/appraise/people/update',$.param({'projName':projName,'empName':empName})+'&'+formData,function (data) {
                if("1" == data.status){
                    $.alert(data.msg);
                    return;
                }
                $("#projUpdate").hide();
                $.alert(data.msg);
            })
        }
    });

    //选择器重绘
    $(".selectpicker").selectpicker({
        width: 'auto'
    });


    $("#checkDt").change(function () {
        if($("#checkYear").val() != null && $("#checkYear").val() != ""){
            var sysNo = $("#checkYear").val()+$("#checkDt").val();
            $("#sysNo").val(sysNo);
        }
    })
    //当考核编号变化项目也相应变化
    $("#sysNo").change(function () {
        var sysno = $("#sysNo").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/appraise/project/find/projects",
            async: true,
            data: {sysno:sysno},
            success: function (data) {
                if (data.success) {
                    $("#projNo").find("option").remove();
                    var list = data.list;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var projOption = "";
                            projOption = "<option value='"+ list[i].projNo + "'>" + list[i].projName + "</option>";
                            $("#projNo").append(projOption);
                        }
                        $("#projNo").selectpicker('refresh');
                        $("#checkDt").val(sysno);
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });
    })
</script>
</html>