<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/22
  Time: 9:13
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
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目编号：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="projNo" name="projNo" class="form-control"
                               value="${projDic.projNo}" readonly/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目名称：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="projName" name="projName"
                               value="${projDic.projName}" class="form-control" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目金额：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="totalFee" name="totalFee"
                               value="${projDic.totalFee}" class="form-control" readonly/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">应收尾款：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="leftFee" name="leftFee"
                               value="${projDic.leftFee}" class="form-control" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目状态：</label>
                </div>
                <div class="col-md-4">
                    <select id="statusFlag" name="statusFlag" class="selectpicker">
                        <option value="立项">立项</option>
                        <option value="招标">招标</option>
                        <option value="已签合同">已签合同</option>
                        <option value="实施中">实施中</option>
                        <option value="已完成">已完成</option>
                    </select>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">合同签订时间：</label>
                </div>
                <div class="col-md-4">
                    <div class="input-group date form_date col-md-16">
                        <input id="contractDt" name="contractDt" class="form-control" size="16" type="text" value="${projDic.contractDt}"
                               placeholder="请选择日期" > <span
                            class="input-group-addon"><span
                            class="glyphicon glyphicon-remove"></span></span> <span
                            class="input-group-addon"><span
                            class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目开始时间：</label>
                </div>
                <div class="col-md-4">
                    <div class="input-group date form_date col-md-16">
                        <input id="projStart" name="projStart" class="form-control" size="16" type="text" value="${projDic.projStart}"
                               placeholder="请选择日期" > <span
                            class="input-group-addon"><span
                            class="glyphicon glyphicon-remove"></span></span> <span
                            class="input-group-addon"><span
                            class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目结束时间：</label>
                </div>
                <div class="col-md-4">
                    <div class="input-group date form_date col-md-16">
                        <input id="projEnd" name="projEnd" class="form-control" size="16" type="text" value="${projDic.projEnd}"
                               placeholder="请选择日期"> <span
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
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">客户:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="customId" id="customId" >
                            <option value="${projDic.customId}">${projDic.customName}</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">项目经理:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="empNo" id="empNo" >
                            <option value="${projDic.empNo}">${projDic.empName}</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">战略意义：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="ratio1" name="ratio1"
                               value="${projDic.ratio1}" class="form-control" readonly/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">实施难度：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="ratio2" name="ratio2"
                               value="${projDic.ratio2}" class="form-control" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">实施周期：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="ratio3" name="ratio3"
                               value="${projDic.ratio3}" class="form-control" readonly/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">收益程度：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="ratio4" name="ratio4"
                               value="${projDic.ratio4}" class="form-control" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">维护成本：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="ratio5" name="ratio5"
                               value="${projDic.ratio5}" class="form-control" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">备注：</label>
                </div>
                <div class="col-md-9">
                    <div class="form-group">
                        <textarea type="text" class="form-control" rows="4" id="remarks" name="remarks">${proDic.remarks}</textarea>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="form-group  col-md-11" style="text-align: center">
                    <div class="form-group" style="text-align: center">
                        <button class="btn btn-success btn-lg" type="button" id="projUpdate">修改</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {

        layer.msg("SORRY!该项目已存在绩效考核，只可部分修改")
        //项目状态赋值
        $("#statusFlag").selectpicker('val','${projDic.statusFlag}');

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
