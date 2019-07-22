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
                               placeholder="请选择日期" readonly> <span
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
                               placeholder="请选择日期" readonly> <span
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
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">客户:</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <select class="selectpicker" name="customId" id="customId" >
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
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">备注：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <textarea type="text" class="form-control" rows="2" id="remarks" name="remarks"
                                  readonly>${proDic.remarks}</textarea>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {

        layer.msg("SORRY!该项目已存在绩效考核，无法修改,只可查看")
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
    });
    //选择器重绘
    $(".selectpicker").selectpicker({
        width: 'auto'
    });


</script>
</html>
