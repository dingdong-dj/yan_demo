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
    <title>项目绩效</title>
</head>
<body>
<div id="main">
    <div id="toolbar">
        <a class="waves-effect btn btn-info btn-sm" href="javascript:createAction();" ><i class="zmdi zmdi-plus"></i> 新增考核项目</a>
        <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();" ><i class="zmdi zmdi-delete"></i> 删除考核项目</a>
        <a class="waves-effect btn btn-warning btn-sm" href="javascript:updateAction();" ><i class="zmdi zmdi-refresh"></i> 考核刷新</a>
        <spa>考核编号: </spa>
        <select id="sysno_find" name="sysno_find" class="selectpicker">
        </select>
        <a class="waves-effect btn btn-warning btn-sm" href="javascript:findList();"><i class="zmdi zmdi-search"></i> 查询</a>
    </div>
    <div class="table-responsive">
        <table id="table"></table>
    </div>
</div>

<script type="text/javascript">
    var sumFee = [];
    function setSumFee(){
        $.ajax({
            url: '${pageContext.request.contextPath}/appraise/project/content',
            type: "post",
            async: false, //更改为同步
            data: {
                sysno: $("#sysno_find").val()
            },
            success: function (data) {
                sumFee = data;
                console.log(sumFee);
            }
        })
    }
    //查询所有考核编号并显示当前时间段或上一个考核时间的考核项目
    $.ajax({
        url: "${pageContext.request.contextPath}/appraise/project/find/all",
        async: false,
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
                }
            } else {
                $.alert(data.msg);
            }
        }
    });

    $.ajax({
        url: '${pageContext.request.contextPath}/appraise/project/content',
        type: "post",
        data: {
            sysno: $("#sysno_find").val()
        },
        success: function (data) {
            sumFee = data;
        }
    })


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
            url: '${pageContext.request.contextPath}/appraise/project/list',	// 请求后台的URL
            showFooter:true,
            queryParams :queryParams,
            columns: [
                {field: 'state', checkbox: true},
                {field: 'sysNo', title: '考核编号', align: 'center',visible: false},
                {field: 'projNo', title: '项目编号', align: 'center',visible: false},
                {field: 'projName', title: '项目名称', align: 'center',
                    footerFormatter:function(value){
                        return '<span class="label label-info">总计</span>';
                    }},
                {field: 'customId', title: '客户编号', align: 'center',visible: false},
                {field: 'customName', title: '客户名称', align: 'center'},
                {field: 'checkYear', title: '考核年度', align: 'center'},
                {field: 'checkDt', title: '考核周期', align: 'center'},
                {field: 'backFee', title: '本季回款', align: 'center',
                footerFormatter:function(value){
                    return '<span class="label label-info">'+sumFee.sumBackFee+'</span>';
                }},
                {field: 'validFee', title: '有效金额', align: 'center',
                footerFormatter:function(value){
                    return '<span class="label label-info">'+sumFee.sumVaildFee+'</span>';
                }},
                {field: 'kSumn', title: '绩效值', align: 'center',
                    footerFormatter:function(value){
                        return '<span class="label label-info">'+sumFee.sumKsum+'</span>';
                    }
                },
                {field: 'lastFee', title: '最终金额', align: 'center',
                    footerFormatter:function(value){
                        return '<span class="label label-info">'+sumFee.sumLastFee+'</span>';
                    }
                },
                {field: 'fillDt', title: '考核时间', align: 'center'},
                {field: 'backDt', title: '回款时间', align: 'center'},
                {field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false,width:'60px'}
            ]
        });
    });
    function actionFormatter(value, row, index) {
        return [
            '<a class="edit ml10" href="javascript:void(0)" data-toggle="tooltip" title="编辑"><i class="glyphicon glyphicon-edit"></i></a>　',
            '<a class="remove ml10" href="javascript:void(0)" data-toggle="tooltip" title="删除"><i class="glyphicon glyphicon-remove"></i></a>'
        ].join('');
    }

    //得到查询的参数
    function queryParams(params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            limit: params.limit,   //页面大小
            offset: params.offset,  //页码
            order: params.order,  //排序
            sysno:$("#sysno_find").val(),
        };
        return temp;
    };
    window.actionEvents = {
        'click .edit': function (e, value, row, index) {
            index_Tab.addTab("考核项目修改", "appraise/project/find/one?sysno=" + row.sysNo+"&projNo=" + row.projNo);
        },
        //删除
        'click .remove': function (e, value, row, index) {
            $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除该考核项目吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/appraise/project/deletes',
                                type: "post",
                                data: {
                                    sysno: row.sysNo,
                                    projNo:row.projNo
                                },
                                traditional: true,//这里设为true就可以了传参
                                success: function (data) {
                                    if("1" == data.status){
                                        layer.msg(data.msg);
                                    }else{
                                        layer.msg(data.msg);
                                        setSumFee();
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
        index_Tab.addTab("新增考核项目", "appraise/project/addOrEditPage");
    }

    function findList() {
        setSumFee();
        $table.bootstrapTable('refresh');
    }

    function updateAction(){
        var sysno = $("#sysno_find").val();
        $.ajax({
            url: '${pageContext.request.contextPath}/appraise/project/refresh',
            type: "post",
            data: {
                sysno: sysno
            },
            traditional: true,//这里设为true就可以了传参
            success: function (data) {
                if("1" == data.status){
                    layer.msg(data.msg);
                }else{
                    layer.msg(data.msg);
                    setSumFee();
                    $table.bootstrapTable('refresh');
                }
            }
        });
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
                content: '确认删除该考核项目吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var pMain = rows[0];

                            $.ajax({
                                url: '${pageContext.request.contextPath}/appraise/project/deletes',
                                type: "post",
                                data: {
                                    sysno: pMain.sysNo,
                                    projNo:pMain.projNo
                                },
                                traditional: true,//这里设为true就可以了
                                success: function (data) {
                                    if("1" == data.status){
                                        layer.msg(data.msg);
                                    }else{
                                        layer.msg(data.msg);
                                        setSumFee();
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

    function initScrollShow() {
        if (window.parent.document.getElementById('tabs').scrollWidth > window.parent.document.getElementById('tabs').clientWidth) {
            $('.content_tab', window.parent.document).addClass('scroll');
        } else {
            $('.content_tab', window.parent.document).removeClass('scroll');
        }
    }

    function initScrollState() {
        if ($('.content_tab>ul', window.parent.document).scrollLeft() == 0) {
            $('.tab_left>a', window.parent.document).removeClass('active');
        } else {
            $('.tab_left>a', window.parent.document).addClass('active');
        }
        if (($('.content_tab>ul', window.parent.document).scrollLeft() + window.parent.document.getElementById('tabs').clientWidth) >= window.parent.document.getElementById('tabs').scrollWidth) {
            $('.tab_right>a', window.parent.document).removeClass('active');
        } else {
            $('.tab_right>a', window.parent.document).addClass('active');
        }
    }

</script>
</body>
</html>