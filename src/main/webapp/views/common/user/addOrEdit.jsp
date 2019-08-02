<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/25
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户添加修改页</title>
</head>
<body>
<div id="main" style=";background: #fff;left: 15%;">
    <div class="container col-md-12"
         style="margin-top: 30px; margin-left: 50px; display: table;">
        <form id="dataForm" method="post">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">用户ID：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="text" id="userId" name="userId"
                               value="${sysUser.userId}" class="form-control"
                               placeholder="用户ID" readonly/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">账户名：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="text" id="userCode" name="userCode"
                               value="${sysUser.userCode}" class="form-control"
                               placeholder="账户名"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">员工姓名：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="text" id="userName" name="userName"
                               value="${sysUser.userName}" class="form-control"
                               placeholder="员工姓名"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">加入时间：</label>
                </div>
                <div class="col-md-7">
                    <div class="input-group date form_date col-md-16">
                        <input id="userJoindate" name="userJoindate" class="form-control" size="16" type="text" value="${sysUser.userJoindate}"
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
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">邮箱：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="text" id="userEmail" name="userEmail"
                               value="${sysUser.userEmail}" class="form-control"
                               placeholder="邮箱"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">电话：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="text" id="userPhone" name="userPhone"
                               value="${sysUser.userPhone}" class="form-control"
                               placeholder="电话"/>
                    </div>
                </div>
            </div>

            <input hidden name="userType" id="userType" value="general">
            <input hidden name="userValid" id="userValid" value="1">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="form-group  col-md-11" style="text-align: center">
                    <div class="form-group" style="text-align: center">
                        <button class="btn btn-success btn-lg" type="button" id="userFormSubmit">提交</button>
                    </div>
                </div>
            </div>
        </form>


    </div>
</div>
</body>
<script type="text/javascript">
    $(function () {
        var flag = ${flag};
        <c:if test="${flag =='1' || flag == '' || flag == null}">
            //网页打开时根据员工表自动生成员工id
            $.ajax({
                url: "${pageContext.request.contextPath}/dic/emp/auto/id",
                async: true,
                data: {},
                success: function (data) {
                    if (data.success) {
                        $("#userId").val(data.userId);
                    }
                }
            });
        </c:if>

        <c:if test="${flag == '0'}">
            $("#userCode").attr("readOnly","true");
        </c:if>

        //必填项检查
        function formCheck() {
            if ($("#userId").val() == "" || $("#userId").val() == null) {
                $.alert("用户ID不能为空");
                return false;
            }

            if ($("#userCode").val() == "" || $("#userCode").val() == null) {
                $.alert("账户名不能为空");
                return false;
            }

            if ($("#userName").val() == "" || $("#userName").val() == null) {
                $.alert("员工姓名不能为空");
                return false;
            }
            if ($("#userJoindate").val() == "" || $("#userJoindate").val() == null) {
                $.alert("加入时间不能为空");
                return false;
            }
            return true;
        }


        function createOrUpdate() {
            if (!formCheck()) {
                return;
            }
            if(flag == "1"){
                $.ajax({
                    url: "${pageContext.request.contextPath}/common/user/save",
                    type: "post",
                    data: {
                        userId: $("#userId").val(),
                        userCode: $("#userCode").val(),
                        userName: $("#userName").val(),
                        userJoindate:$("#userJoindate").val(),
                        userEmail:$("#userEmail").val(),
                        userPhone:$("#userPhone").val(),
                        userType: $("#userType").val(),
                        userValid: $("#userValid").val()
                    },
                    success: function (data) {
                        if('1' == data.status){
                            $.alert(data.msg);
                            return;
                        }
                        $.alert(data.msg);
                        location.reload();
                    }
                });
            }else{
                $.ajax({
                    url: "${pageContext.request.contextPath}/common/user/update",
                    type: "post",
                    data: {
                        userId: $("#userId").val(),
                        userCode: $("#userCode").val(),
                        userName: $("#userName").val(),
                        userJoindate:$("#userJoindate").val(),
                        userEmail:$("#userEmail").val(),
                        userPhone:$("#userPhone").val()
                    },
                    success: function (data) {
                        if('1' == data.status){
                            $.alert(data.msg);
                            return;
                        }
                        $.alert(data.msg);
                        location.reload();
                    }
                });
            }
        }

        //防止数据重复创建
        $("#userFormSubmit").click( function () {
            createOrUpdate();
        });

    });

</script>
</html>
