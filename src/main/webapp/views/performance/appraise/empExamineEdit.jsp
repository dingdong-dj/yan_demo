<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/23
  Time: 9:24
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
    <title>员工绩效审核</title>
</head>
<body>
<div id="main">
    <div id="toolbar">
        <span>考核编号: </span>
        <select id="sysno_find" name="sysno_find" class="selectpicker">
            <option value="${sysno}">${sysno}</option>
        </select>
        <span id="proj_div">
            <span>项目:</span>
            <select id="proj_find" name="proj_find" class="selectpicker">
                <option value="${projNo}">${projName}</option>
            </select>
        </span>

    </div>
    <div class="table-responsive">
        <table id="table"></table>
    </div>
</div>

<script type="text/javascript">

    <c:if test ="${projNo == null || projNo == ''}">
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
            url: '${pageContext.request.contextPath}/appraise/peoman/examine/list',	// 请求后台的URL
            queryParams :queryParams,
            columns: [
                {field: 'sysNo', title: '考核编号', align: 'center'},
                {field: 'projNo', title: '项目编号', align: 'center',visible: false},
                {field: 'projName', title: '项目名称', align: 'center'},
                {field: 'empNo', title: '员工编号', align: 'center',visible: false},
                {field: 'empName', title: '员工姓名', align: 'center'},
                {field: 'checkDt', title: '考核周期', align: 'center'},
                {field: 'award', title: '绩效奖金', align: 'center',
                    editable:{
                        type:'text',
                        title:'绩效奖金'
                    }
                },
                {field: 'distDt', title: '分配时间', align: 'center'},
                {field: 'distEmp', title: '分配人', align: 'center'},
                {field: 'checkFlag', title: '审核状态', align: 'center',
                    editable:{
                        type:'select',
                        title:'项目状态',
                        source:[{value:"INIT",text:"初始状态"},{value:"OK",text:"已审核"},{value:"PUB",text:"可公布"}],
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

    $('#table').on('editable-save.bs.table', function (field, row, oldValue, $el) {
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/appraise/peoman/examine/edit",
            data: { sysNo:oldValue.sysNo,
                    projNo:oldValue.projNo,
                    projName:oldValue.projName,
                    empNo:oldValue.empNo,
                    empName:oldValue.empName,
                    checkDt:oldValue.checkDt,
                    award:oldValue.award,
                    distDt:oldValue.distDt,
                    distEmp:oldValue.distEmp,
                    checkFlag:oldValue.checkFlag,
                    remarks:oldValue.remarks},
            dataType: 'JSON',
            success: function (data) {
                layer.msg(data.msg);
                $table.bootstrapTable('refresh');
            }
        });
    });

</script>
</body>
</html>