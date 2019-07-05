<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>客户管理</title>
</head>
<body>
<div id="main">
    <div id="toolbar">
        <a class="waves-effect btn btn-info btn-sm" href="javascript:createAction();" ><i class="zmdi zmdi-plus"></i> 新增客户</a>
        <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();" ><i class="zmdi zmdi-delete"></i> 删除客户</a>
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
            url: '${pageContext.request.contextPath}/dic/custom/list',	// 请求后台的URL
            columns: [
                {field: 'state', checkbox: true},
                {field: 'customId', title: '客户编号', align: 'center'},
                {field: 'customName', title: '客户名称', align: 'center'},
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
            $("#customId").val(row.customId);
            $("#customName").val(row.customName);
            $("#customId").attr("readOnly","true");
            layer.open({
                type:1,
                area:['400px','400px'],
                title:"客户编辑",
                content:$('#createDialog'),
                btn:['确定','取消'],
                yes:function () {
                    var customId = $("#customId").val();
                    var customName = $("#customName").val();
                    if(customName == '' || customName == "undefined" || customName == null){
                        layer.msg('请输入客户名称');
                        return;
                    }
                    var customForm = $('#customForm').serializeArray();
                    $.post('${pageContext.request.contextPath}/dic/custom/update',customForm,function (data) {
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
                content: '确认删除该客户吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = [];
                            ids.push(row.customId);
                            console.log(ids);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/dic/custom/deletes',
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
        $("#customId").attr("readOnly",false);
        $("#customId").val("");
        $("#customName").val("");
        layer.open({
            type:1,
            area:['400px','400px'],
            title:"新增客户",
            content:$('#createDialog'),
            btn:['确定','取消'],
            yes:function () {
                var customId = $("#customId").val();
                var customName = $("#customName").val();
                if(customId == '' || customId == "undefined" || customId == null){
                    layer.msg('请输入客户编号');
                    return;
                }
                if(customName == '' || customName == "undefined" || customName == null){
                    layer.msg('请输入客户姓名');
                    return;
                }
                var customForm = $('#customForm').serializeArray();
                $.post('${pageContext.request.contextPath}/dic/custom/save',customForm,function (data) {
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
                content: '确认删除该客户吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = [];
                            rows.forEach(function (item,i) {
                                ids.push(item.customId);
                            })
                            $.ajax({
                                url: '${pageContext.request.contextPath}/dic/custom/deletes',
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

    // 子页面下调用选项卡对象
    var index_Tab = {
        addTab: function (title, url) {
            var index = url.replace(/\./g, '_').replace(/\//g, '_').replace(/:/g, '_').replace(/\?/g, '_').replace(/,/g, '_').replace(/=/g, '_').replace(/&/g, '_');
            // 如果存在选项卡，则激活，否则创建新选项卡
            if ($('#tab_' + index, window.parent.document).length == 0) {
                // 添加选项卡
                $('.content_tab li', window.parent.document).removeClass('cur');
                var tab = '<li id="tab_' + index + '" data-index="' + index + '" class="cur"><a class="waves-effect waves-light">' + title + '</a></li>';//<i class="zmdi zmdi-close"></i><
                $('.content_tab>ul', window.parent.document).append(tab);
                // 添加iframe
                $('.iframe', window.parent.document).removeClass('cur');
                var iframe = '<div id="iframe_' + index + '" class="iframe cur"><iframe class="tab_iframe" src="' + url + '" width="100%" frameborder="0" scrolling="auto" onload="changeFrameHeight(this)"></iframe></div>';
                $('.content_main', window.parent.document).append(iframe);
                initScrollShow();
                $('.content_tab>ul', window.parent.document).animate({scrollLeft: window.parent.document.getElementById('tabs').scrollWidth - window.parent.document.getElementById('tabs').clientWidth}, 200, function () {
                    initScrollState();
                });
            } else {
                $('#tab_' + index, window.parent.document).trigger('click');
            }
        },
        closeTab: function ($item) {
            var closeable = $item.data('closeable');
            if (closeable != false) {
                // 如果当前时激活状态则关闭后激活左边选项卡
                if ($item.hasClass('cur')) {
                    $item.prev().trigger('click');
                }
                // 关闭当前选项卡
                var index = $item.data('index');
                $('#iframe_' + index).remove();
                $item.remove();
            }
            initScrollShow();
        }
    }
</script>
</body>
<!-- 新增 -->
<div id="createDialog" class="crudDialog" hidden>
    <form id="customForm">
        <div class="form-group">
            <label for="customId">客户编号</label>
            <input name = "customId" id="customId" type="text" class="form-control">
        </div>
        <div class="form-group">
            <label for="customName">客户姓名</label>
            <input name = "customName" id="customName" type="text" class="form-control">
        </div>
    </form>
</div>
</html>