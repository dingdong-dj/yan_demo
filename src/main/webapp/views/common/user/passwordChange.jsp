<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/26
  Time: 8:35
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
    <title>密码修改</title>
</head>
<body>
<div id="main" style=";background: #fff;left: 15%;">
    <div class="container col-md-12"
         style="margin-top: 30px; margin-left: 50px; display: table;">
        <form id="dataForm" method="post">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">旧密码：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="password" id="old-password" name="old-password" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">新密码：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="password" id="new-password" name="new-password" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-4 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">新密码确认：</label>
                </div>
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="password" id="new-again" name="new-again" class="form-control"/>
                    </div>
                </div>
            </div>
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
        $("#old-password").val("");
        //必填项检查
        function formCheck() {
            if ($("#old-password").val() == "" || $("#old-password").val() == null) {
                $.alert("旧密码不能为空");
                return false;
            }

            if ($("#new-password").val() == "" || $("#new-password").val() == null) {
                $.alert("新密码不能为空");
                return false;
            }

            if ($("#new-again").val() == "" || $("#new-again").val() == null) {
                $.alert("新密码确认不能为空");
                return false;
            }

            if($("#new-password").val() != $("#new-again").val()){
                $.alert("两次密码不相同");
                return false;
            }
            return true;
        }


        function createOrUpdate() {
            if (!formCheck()) {
                return;
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/common/user/password/change",
                type: "post",
                data: {
                    oldPd: $("#old-password").val(),
                    newPd: $("#new-password").val()
                },
                success: function (data) {
                    if('1' == data.status){
                        $.alert(data.msg);
                        return;
                    }
                    $.alert(data.msg);
                    $("#old-password").val("");
                    $("#new-password").val("");
                    $("#new-again").val("");
                }
            });
        }

        //防止数据重复创建
        $("#userFormSubmit").click( function () {
            createOrUpdate();
        });

    });

</script>
</html>

