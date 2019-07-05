<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工管理</title>
</head>
<body>
<div id="main">
    <div id="toolbar">
        <a class="waves-effect btn btn-info btn-sm" href="javascript:createAction();" ><i class="zmdi zmdi-plus"></i> 新增员工</a>
        <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();" ><i class="zmdi zmdi-delete"></i> 删除员工</a>
    </div>
    <table id="table"></table>
</div>

<script type="text/javascript">
    var $table = $('#table');
    $(function() {
        $table.bsTable({
            toolbar: '#toolbar',
            search:true,
            detailView: false,
            pageNumber: 1,
            //初始化加载第一页，默认第一页
            pageSize: 10,
            //每页的记录行数（*）
            pageList: [10, 15, 20],
            //可供选择的每页的行数（*）
            url: '${pageContext.request.contextPath}/dic/emp/list',	// 请求后台的URL
            columns: [
                {field: 'state', checkbox: true},
                {field: 'empNo', title: '员工编号', align: 'center'},
                {field: 'empName', title: '员工名称', align: 'center'},
                {field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
            ]
        });
    });
    function actionFormatter(value, row, index) {
        return [
            '<a class="edit ml10" href="javascript:void(0)" data-toggle="tooltip" title="编辑"><i class="glyphicon glyphicon-edit"></i></a>　',
            '<a class="remove ml10" href="javascript:void(0)" data-toggle="tooltip" title="删除"><i class="glyphicon glyphicon-remove"></i></a>'
        ].join('');
    }

    window.actionEvents = {
        'click .edit': function (e, value, row, index) {
            // alert('You click edit icon, row: ' + JSON.stringify(row));
            // console.log(value, row, index);
            $("#empNo").val(row.empNo);
            $("#empName").val(row.empName);
            $("#empNo").attr("readOnly","true");
            layer.open({
                type:1,
                area:['400px','400px'],
                title:"员工编辑",
                content:$('#createDialog'),
                btn:['确定','取消'],
                yes:function () {
                    var empNo = $("#empNo").val();
                    var empName = $("#empName").val();
                    if(empName == '' || empName == "undefined" || empName == null){
                        layer.msg('请输入员工姓名');
                        return;
                    }
                    var empForm = $('#empForm').serializeArray();
                    $.post('${pageContext.request.contextPath}/dic/emp/update',empForm,function (data) {
                        if("1" == data.status){
                            layer.msg(data.msg);
                            return;
                        }
                        $table.bootstrapTable('refresh');
                        layer.closeAll();
                        layer.msg(data.msg);
                    })
                },
                btn2:function () {
                    layer.close(); //关闭当前窗口
                }
            })
        },
        'click .remove': function (e, value, row, index) {
            $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除该员工吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = [];
                            ids.push(row.empNo);
                            console.log(ids);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/dic/emp/deletes',
                                type: "post",
                                data: {
                                    ids: ids
                                },
                                traditional: true,//这里设为true就可以了
                                success: function (data) {
                                    if("1" == data.status){
                                        layer.msg(data.msg);
                                    }else{
                                        layer.msg(data.msg);
                                        $table.bootstrapTable('refresh');
                                    }
                                }
                            });
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
            // alert('You click remove icon, row: ' + JSON.stringify(row));
            // console.log(value, row, index);

        }
    };
    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
        });
        return html.join('');
    }
    // 新增
    function createAction() {
        $("#empNo").attr("readOnly",false);
        $("#empNo").val("");
        $("#empName").val("");
        layer.open({
            type:1,
            area:['400px','400px'],
            title:"新增员工",
            content:$('#createDialog'),
            btn:['确定','取消'],
            yes:function () {
                var empNo = $("#empNo").val();
                var empName = $("#empName").val();
                if(empNo == '' || empNo == "undefined" || empNo == null){
                    layer.msg('请输入员工编号');
                    return;
                }
                if(empName == '' || empName == "undefined" || empName == null){
                    layer.msg('请输入员工姓名');
                    return;
                }
                var empForm = $('#empForm').serializeArray();
                $.post('${pageContext.request.contextPath}/dic/emp/save',empForm,function (data) {
                    if("1" == data.status){
                        layer.msg(data.msg);
                        return;
                    }
                    $table.bootstrapTable('refresh');
                    layer.closeAll()    ;
                    layer.msg(data.msg);
                })
            },
            btn2:function () {
                layer.close(); //关闭当前窗口
            }
        })
    }

    // 删除
    function deleteAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length == 0) {
            $.confirm({
                title: false,
                content: '请至少选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除该员工吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = [];
                            rows.forEach(function (item,i) {
                                ids.push(item.empNo);
                            })
                            $.ajax({
                                url: '${pageContext.request.contextPath}/dic/emp/deletes',
                                type: "post",
                                data: {
                                    ids: ids
                                },
                                traditional: true,//这里设为true就可以了
                                success: function (data) {
                                    if("1" == data.status){
                                        layer.msg(data.msg);
                                    }else{
                                        layer.msg(data.msg);
                                        $table.bootstrapTable('refresh');
                                    }
                                }
                            });
                            // for (var i in rows) {
                            //     console.log(i);
                            //     ids.push(rows[i].systemId);
                            // }
                            // $.alert('删除：id=' + ids.join("-"));
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        }
    }

</script>
</body>
<!-- 新增 -->
<div id="createDialog" class="crudDialog" hidden>
    <form id="empForm">
        <div class="form-group">
            <label for="empNo">员工编号</label>
            <input name = "empNo" id="empNo" type="text" class="form-control">
        </div>
        <div class="form-group">
            <label for="empName">员工姓名</label>
            <input name = "empName" id="empName" type="text" class="form-control">
        </div>
    </form>
</div>
</html>