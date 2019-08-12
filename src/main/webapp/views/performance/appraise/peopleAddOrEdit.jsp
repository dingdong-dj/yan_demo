<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/11
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/include_common.jsp"%>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工绩效添加修改页</title>
</head>
<body>
<form id="dataForm" method="post">
    <div id="toolbar" align="left" style="background: #F5F5F5;">
            <c:if test="${pAward.sysNo != null && pAward.sysNo != ''}">
                <button id="update-btn" class="waves-effect btn btn-success btn-sm"
                        style="margin-left: 10px;" type="button" href="javascript:;"><i class="zmdi zmdi-save"></i>修改
            </c:if>
            <c:if test="${pAward.sysNo == null || pAward.sysNo == ''}">
                    <button id="save-btn" class="waves-effect btn btn-success btn-sm"
                            style="margin-left: 10px;" type="button" href="javascript:;"><i class="zmdi zmdi-save"></i>保存
            </c:if>

        </button>
    </div>
    <div class="container col-xs-11"
         style="margin-top: 30px; margin-left: 50px; display: table;">
        <div id="noSelDiv" style="display: none;" class="row">
            <div class="col-xs-11">
                <div class="alert alert-danger alert-dismissible" role="alert">
                    <strong>警告！</strong> 请选择左侧角色节点再进行操作。
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-xs-8 text-left"
                 style="background-color: #F5E3C7; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">当前项目绩效金额为:${lastFee}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp已分配绩效:${sumAward}</label>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-xs-4 text-left"
                 style="background-color: #E6E6F2; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">员工名称：</label>
            </div>
            <div class="col-xs-7">
                <select id="empNo" name="empNo" class="selectpicker">
                </select>
            </div>
        </div>

        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-xs-4 text-left"
                 style="background-color: #E6E6F2; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">绩效奖金：</label>
            </div>
            <div class="col-xs-7">
                <div class="form-group">
                    <input type="text" id="award" name="award"
                           value="${pAward.award}" class="form-control"
                           placeholder="绩效奖金" onkeyup="value=value.replace(/[^\d.]/g,'')"/>
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;display: none">
            <div class="col-xs-4 text-left"
                 style="background-color: #E6E6F2; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">审核状态：</label>
            </div>
            <div class="col-xs-7">
<%--                <select id="checkFlag" name="checkFlag" class="selectpicker">--%>
<%--                    <option value="INIT">待审核</option>--%>
<%--                    <option value="OK">已审核</option>--%>
<%--                    <option value="PUB">可公布</option>--%>
<%--                </select>--%>
                <input id="checkFlag" name="checkFlag" value="INIT">
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-xs-4 text-left"
                 style="background-color: #E6E6F2; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">分配时间：</label>
            </div>
            <div class="col-xs-5">
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
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-xs-4 text-left"
                 style="background-color: #E6E6F2; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">备注说明：</label>
            </div>
            <div class="col-xs-7">
                <div class="form-group">
                        <textarea type="text" class="form-control" rows="2" id="remarks" name="remarks"
                                  placeholder="请输入描述">${pAward.remarks}</textarea>
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;display: none;">
            <input type="hidden" id="sysNo" name="sysNo" value="${sysno}" />
            <input type="hidden" id="projNo" name="projNo" value="${projNo}" />
            <input type="hidden" id="projName" name="projName" value="${projName}" />
            <input type="hidden" id="checkDt" name="checkDt" value="${sysno}" />
        </div>
    </div>
</form>
</body>
<script type="text/javascript">
    $(function() {
        // 下拉框赋值
        $('#checkFlag').selectpicker('val', '${pAward.checkFlag}');

        //查询所有员工信息
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
                            var projOption = "";
                            projOption = "<option value='"+ list[i].empNo + "'>" + list[i].empName + "</option>";
                            $("#empNo").append(projOption);
                        }
                        $("#empNo").selectpicker('refresh');
                        //下拉框赋值
                        $("#empNo").selectpicker('val','${pAward.empNo}');
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });

        <c:if test="${pAward.sysNo == null || pAward.sysNo == ''}">
            var time = getNowDate();
            $("#distDt").val(time);
            $("#distDt").val(time);
        </c:if>

        <c:if test ="${pAward.sysNo != null && pAward.sysNo != ''}">
            $("#empNo").attr("disabled",true);
            $("#checkFlag").val("${pAward.checkFlag}");
        </c:if>

        // 表单效验
        $('form').bootstrapValidator({
            //container : "tooltip",
            container : "popover",
            message : 'This value is not valid',
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            fields : {
                'empNo' : {
                    validators : {
                        notEmpty : {
                            message : '员工不能为空'
                        }
                    }
                },
                'award' : {
                    validators : {
                        notEmpty : {
                            message : '绩效不能为空'
                        }
                    }
                }
            }
        });

        // 保存提交验证
        $('#save-btn').click(function() {
            createPAward();
        });

        function createPAward() {
            if (!formCheck()) {
                return;
            }
            // 获取form表单中的值
            var formData = $('#dataForm').serialize();
            var empName =  $("#empNo option:selected").text();
            $.post('${pageContext.request.contextPath}/appraise/people/save', $.param({'empName':empName})+'&'+formData, function(data) {
                if('1' == data.status){
                    $.alert(data.msg);
                    return;
                }
                $.alert(data.msg);
                parent.location.reload();
            });
        }

        function formCheck(){
            if ($("#empNo").val() == null || $("#empNo").val() == ''||$("#empNo").val() == 'undefined') {
                $.alert("请选择员工");
                return false;
            }

            if ($("#award").val() == "" || $("#award").val() == null || $("#award").val() == "undefined") {
                $.alert("请输入绩效奖金");
                return false;
            }

            if ($("#checkFlag").val() !="INIT") {
                $.alert("该人员绩效已审核发布，无法修改");
                return false;
            }

            return true;
        }

        // 修改提交
        $('#update-btn').click(function() {
            updatePAward();

        });

        function updatePAward(){
            $("#empNo").attr("disabled",false);
            if (!formCheck()) {
                return;
            }
            var formData = $('#dataForm').serialize();
            var empName =  $("#empNo option:selected").text();
            $.post('${pageContext.request.contextPath}/appraise/people/update', $.param({'empName':empName})+'&'+formData, function(data) {
                if('1' == data.status){
                    $.alert(data.msg);
                    return;
                }
                $.alert(data.msg);
            });
        }
    });

    function getNowDate(){
        var myDate = new Date;
        var year = myDate.getFullYear(); //获取当前年
        var mon = myDate.getMonth() + 1; //获取当前月
        var date = myDate.getDate(); //获取当前日

        return year+"-"+mon+"-"+date;

    }


</script>
</html>