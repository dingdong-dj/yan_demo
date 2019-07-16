<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/4
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工绩效</title>
</head>
<body>
<div id="main">
    <div id="toolbar">
<%--        <a class="waves-effect btn btn-info btn-sm" href="javascript:createAction();" ><i class="zmdi zmdi-plus"></i> 新增员工绩效</a>--%>
<%--        <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();" ><i class="zmdi zmdi-delete"></i> 删除员工绩效</a>--%>
        <span>考核编号: </span>
        <select id="sysno_find" name="sysno_find" class="selectpicker">
            <option value="${sysno}">${sysno}</option>
        </select>
        <span id="proj_div">
            <span>项目:</span>
            <select id="proj_find" name="proj_find" class="selectpicker">
                <option value="${projNo}">${projNo}</option>
            </select>
            <a class="waves-effect btn btn-warning btn-sm" href="javascript:findList();"><i class="zmdi zmdi-search"></i> 查询</a>
        </span>

    </div>
    <div class="table-responsive">
        <table id="table"></table>
    </div>
</div>

<script type="text/javascript">

    <c:if test ="${sysno == null || sysno == ''}">

        //查询所有考核编号并显示当前时间段或上一个考核时间的考核项目
        $.ajax({
            url: "${pageContext.request.contextPath}/appraise/project/find/all",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#sysno_find").find("option").remove();
                    var list = data.list;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var projOption = "";
                            projOption = "<option value='"+ list[i] + "'>" + list[i] + "</option>";
                            $("#sysno_find").append(projOption);
                        }
                        $("#sysno_find").selectpicker('refresh');
                        //下拉框赋值
                        $("#sysno_find").selectpicker('val',data.sysno);
                        $("#sysno_find").change();
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });

    </c:if>

    <c:if test ="${sysno != null && sysno != ''}">
        $("#proj_div").hide();
    </c:if>

    var $table = $('#table');
    $(function() {
        $table.bsTable({
            toolbar: '#toolbar',
            editable: true,
            singleSelect: true,
            search: false,
            detailView: false,
            clickToSelect: true,
            pageNumber: 1,
            //初始化加载第一页，默认第一页
            pageSize: 10,
            //每页的记录行数（*）
            pageList: [10, 15, 20],
            //可供选择的每页的行数（*）
            url: '${pageContext.request.contextPath}/appraise/people/list',	// 请求后台的URL
            queryParams :queryParams,
            columns: [
                // {field: 'state', checkbox: true},
                {field: 'sysNo', title: '考核编号', align: 'center'},
                {field: 'projNo', title: '项目编号', align: 'center',visible: false},
                {field: 'projName', title: '项目名称', align: 'center'},
                {field: 'empNo', title: '员工编号', align: 'center',visible: false},
                {field: 'empName', title: '员工姓名', align: 'center'},
                {field: 'checkDt', title: '考核周期', align: 'center'},
                {field: 'award', title: '绩效奖金', align: 'center'},
                {field: 'distDt', title: '分配时间', align: 'center'},
                {field: 'distEmp', title: '分配人', align: 'center'},
                {field: 'checkFlag', title: '审核状态', align: 'center',
                    formatter: function(value, row, index) {
                        if(value == "INIT"){
                            return '<span class="label label-info">初始状态</span>';
                        }else if(value == "OK"){
                            return '<span class="label label-info">已审核</span>';
                        }else{
                            return '<span class="label label-info">可公布</span>';
                        }
                    }
                },
                {field: 'remarks', title: '备注', align: 'center'}
                // {field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
            ]
        });
    });

    //得到查询的参数
    function queryParams(params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            limit: params.limit,   //页面大小
            offset: params.offset,  //页码
            order: params.order,  //排序
            sysno:$("#sysno_find").val(),
            projNo:$("#proj_find").val()
        };
        return temp;
    };

    function findList() {
        $table.bootstrapTable('refresh');
    }

    //当考核编号变化项目也相应变化
    $("#sysno_find").change(function () {
        var sysno = $("#sysno_find").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/appraise/project/find/projects",
            async: true,
            data: {sysno:sysno},
            success: function (data) {
                if (data.success) {
                    $("#proj_find").find("option").remove();
                    $("#proj_find").append("<option value=''>   </option>")
                    var list = data.list;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var projOption = "";
                            projOption = "<option value='"+ list[i].projNo + "'>" + list[i].projName + "</option>";
                            $("#proj_find").append(projOption);
                        }
                        $("#proj_find").selectpicker('refresh');
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });
    })



</script>
</body>
</html>