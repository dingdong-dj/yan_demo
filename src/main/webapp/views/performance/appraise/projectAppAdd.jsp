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
                    <div class="form-group">
                        <input type="text" id="fillDt" name="fillDt" class="form-control"
                               value="${projectAppraise.fillDt}"  placeholder="考核时间" readonly/>
                    </div>
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
                        <select class="selectpicker" name="customId" id="customId" >
                        </select>
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
                        <option value="上半年">上半年</option>
                        <option value="下半年">下半年</option>
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
                        <input type="text" id="ratio2" name="ratio2"
                               value="${projectAppraise.validFee}" class="form-control" placeholder="有效考核基准金额" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">绩效系数：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="ratio3" name="ratio3"
                               value="${projectAppraise.kSumn}" class="form-control" placeholder="绩效系数" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">最终金额：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="ratio4" name="ratio4"
                               value="${projectAppraise.lastFee}" class="form-control" placeholder="最终金额" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                    </div>
                </div>
            </div>
            <c:choose>
                <c:when test="${projDic.projNo == null || projDic.projNo == ''}">
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

        <c:if test ="${projDic.projNo != null && projDic.projNo != ''}">
        $("#projNo").attr("readOnly","true");
        </c:if>
        //项目状态赋值
        $("#statusFlag").selectpicker('val','${projDic.statusFlag}');

        //查询员工信息做成选项
        $.ajax({
            url: "${pageContext.request.contextPath}/dic/emp/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#empNo").find("option").remove();
                    var list = data.empList;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var optionString = "";
                            optionString = "<option value='"+ list[i].empNo + "'>" + list[i].empName + "</option>";
                            $("#empNo").append(optionString);
                        }
                        $("#empNo").selectpicker('refresh');
                        //项目经理下拉框赋值
                        $("#empNo").selectpicker('val', '${projDic.empNo}');
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });


        //查询所有客户信息做成选项
        $.ajax({
            url: "${pageContext.request.contextPath}/dic/custom/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#customId").find("option").remove();
                    var list = data.customList;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var optionString = "";
                            optionString = "<option value='"+ list[i].customId + "'>" + list[i].customName + "</option>";
                            $("#customId").append(optionString);
                        }
                        $("#customId").selectpicker('refresh');
                        //伤人动物下拉框赋值
                        $("#customId").selectpicker('val', '${projDic.customId}');
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });


        //必填项检查
        function formCheck() {
            if ($("#projNo").val() == null || $("#projNo").val() == ''||$("#projNo").val() == 'undefined') {
                $.alert("项目编号不能为空");
                return false;
            }

            if ($("#projName").val() == "" || $("#projName").val() == null || $("#projName").val() == "undefined") {
                $.alert("项目名称不能为空");
                return false;
            }

            if ($("#totalFee").val() == "" || $("#totalFee").val() == null || $("#totalFee").val() == "undefined") {
                $.alert("项目金额不能为空");
                return false;
            }

            if ($("#leftFee").val() == null || $("#leftFee").val() == "" || $("#leftFee").val() == "undefined") {
                $.alert("应收尾款不能为空");
                return false;
            }

            if ($("#statusFlag").val() == null || $("#statusFlag").val() == "" || $("#statusFlag").val() == "undefined") {
                $.alert("请选择项目状态");
                return false;
            }

            //时间
            if ($("#contractDt").val() == null || $("#contractDt").val() == "" || $("#contractDt").val() == "undefined") {
                $.alert("合同签订日期不能为空");
                return false;
            }
            if ($("#projStart").val() == null || $("#projStart").val() == "" || $("#projStart").val() == "undefined") {
                $.alert("项目开始时间不能为空");
                return false;
            }

            if ($("#empNo").val() == null || $("#empNo").val() == "" || $("#empNo").val() == "undefined") {
                $.alert("请选择项目经理");
                return false;
            }

            if ($("#customId").val() == null || $("#customId").val() == "" || $("#customId").val() == "undefined") {
                $.alert("请选择客户");
                return false;
            }
            if ($("#ratio1").val() == null || $("#ratio1").val() == "" || $("#ratio1").val() == "undefined") {
                $.alert("战略意义系数不能为空");
                return false;
            }else if(parseFloat($("#ratio1").val())<15 || parseFloat($("#ratio1").val())>30){
                $.alert("战略意义系数范围为15~30");
                return false;
            }

            if ($("#ratio2").val() == null || $("#ratio2").val() == "" || $("#ratio2").val() == "undefined") {
                $.alert("实施难度系数不能为空");
                return false;
            }else if(parseFloat($("#ratio2").val())<30 || parseFloat($("#ratio2").val())>50){
                $.alert("实施难度系数范围为30~50");
                return false;
            }

            if ($("#ratio3").val() == null || $("#ratio3").val() == "" || $("#ratio3").val() == "undefined") {
                $.alert("实施周期系数不能为空");
                return false;
            }else if(parseFloat($("#ratio3").val())<5 || parseFloat($("#ratio3").val())>15){
                $.alert("实施周期系数范围为5~15");
                return false;
            }

            if ($("#ratio4").val() == null || $("#ratio4").val() == "" || $("#ratio4").val() == "undefined") {
                $.alert("收益程度系数不能为空");
                return false;
            }else if(parseFloat($("#ratio4").val())<5 || parseFloat($("#ratio4").val())>15){
                $.alert("收益程度系数范围为5~15");
                return false;
            }
            if ($("#ratio5").val() == null || $("#ratio5").val() == "" || $("#ratio5").val() == "undefined") {
                $.alert("维护成本系数不能为空");
                return false;
            }else if(parseFloat($("#ratio5").val())<15 || parseFloat($("#ratio5").val())>25){
                $.alert("维护成本系数范围为15~25");
                return false;
            }
            return true;
        }


        function createOrUpdate() {
            if (!formCheck()) {
                return;
            }

            var formData = $("#dataForm").serialize();
            var empName = $("#empNo option:selected").text();
            var customName = $("#customId option:selected").text();
            $.post('${pageContext.request.contextPath}/dic/proj/save',$.param({'empName':empName,'customName':customName})+'&'+formData,function (data) {
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

</script>
</html>