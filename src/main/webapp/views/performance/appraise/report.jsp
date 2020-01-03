<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/24
  Time: 8:23
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
    <title>绩效报表</title>
    <style>
        .sumFont{
            font-size: 20px;
            color: #ed7669;
        }
        .award-pay{
            color: #40AFFE;
        }
    </style>
</head>
<body>
<div id="main">

    <div id="toolbar">
        <span class="sumFont">汇总&nbsp&nbsp&nbsp&nbsp</span>
        <span>考核编号: </span>
        <select id="sysno_find" name="sysno_find" class="selectpicker">
            <option value="${sysno}">${sysno}</option>
        </select>
        <a class="waves-effect btn btn-warning btn-sm" href="javascript:findList();"><i class="zmdi zmdi-search"></i> 查询</a>
        <a class="waves-effect btn btn-warning btn-sm" href="javascript:exportExcel();"><i class="zmdi zmdi-save"></i> 导出</a>
    </div>
    <div class="table-responsive">
        <table id="sum-table"></table>
    </div>
    <div hidden id="del-div">
        <div id="toolbar-2">
            <span class="sumFont">绩效明细:</span>
            <span class="sumFont" id="empName"></span>
            <span class="sumFont" id="empNo" hidden></span>
        </div>
        <div class="table-responsive">
            <table id="del-table"></table>
        </div>
    </div>

</div>

<script type="text/javascript">

    $(window).resize(function() {
        var height = getHeight()*0.7;
        $('#sum-table').bootstrapTable('resetView', { height : height });
        $('#del-table').bootstrapTable('resetView', { height : height });
    });
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
                    $("#sysno_find").selectpicker('val',data.sysno);
                }
            } else {
                $.alert(data.msg);
            }
        }
    });


    var $table = $('#sum-table');
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
            url: '${pageContext.request.contextPath}/appraise/peoman/report/list',	// 请求后台的URL
            queryParams :queryParams,
            onClickRow:function(row,$element){
                $("#empName").html(row.empName);
                $("#empNo").val(row.empNo);
                $table1.bootstrapTable('refresh');
                $("#del-div").show();
                window.location.hash = "#del-div";
            },
            columns: [
                // {field: 'state', checkbox: true},
                {field: 'sysno', title: '考核编号', align: 'center'},
                {field: 'empNo', title: '员工编号', align: 'center',visible: false},
                {field: 'empName', title: '员工姓名', align: 'center'},
                {field: 'sumAward', title: '绩效奖金', align: 'center'},
                {field: 'awardPay', title: '已发放金额', align: 'center',
                    formatter: function (value, row, index) {
                        var award  = parseFloat(row.sumAward);
                        var va = parseFloat(value);
                        if (value == "" || value == null) {
                            return '<span class="label label-warning">暂无发放</span>';
                        }

                        if(award <= va){
                            return '<span class="award-pay">'+value+'</span>';
                        }
                        return value;
                    }
                }
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
        };
        return temp;
    };

    function findList() {
        $("#del-div").hide();
        $table.bootstrapTable('refresh');
    }


    var $table1 = $('#del-table');
    $(function() {
        $table1.bsTable({
            toolbar: '#toolbar-2',
            editable: true,
            singleSelect: true,
            search: false,
            detailView: false,
            showRefresh: false,
            showColumns:false,
            pageNumber: 1,
            //初始化加载第一页，默认第一页
            pageSize: 10,
            //每页的记录行数（*）
            pageList: [10, 15, 20],
            //可供选择的每页的行数（*）
            url: '${pageContext.request.contextPath}/appraise/peoman/report/detail',	// 请求后台的URL
            queryParams :queryParams2,
            columns: [
                {field: 'customName', title: '客户名称', align: 'center',width:"30%"},
                {field: 'projName', title: '项目名称', align: 'center',width:"30%"},
                {field: 'award', title: '绩效奖金', align: 'center',width:"20%"},
                {field: 'remarks', title: '备注', align: 'center',width:"20%"}
            ]
        });
    });

    function queryParams2(params) {
        var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
            limit: params.limit,   //页面大小
            offset: params.offset,  //页码
            order: params.order,  //排序
            sysno:$("#sysno_find").val(),
            empNo:$("#empNo").val()
        };
        return temp;
    };


    function exportExcel(){
        var sysno = $("#sysno_find").val();
        console.log(sysno);
        if(sysno == null || sysno == ''||sysno == 'undefined'){
            $.alert("请选择考核编号");
            return false;
        }

        $.confirm({
            type: 'grey',
            animationSpeed: 300,
            title: false,
            content: '导出Excel表格？',
            buttons: {
                confirm: {
                    text: '确认',
                    btnClass: 'waves-effect waves-button',
                    action: function () {
                        index_Tab.addTab("导出Excel", "appraise/peoman/expertExcel?sysno="+sysno);
                    }
                },
                cancel: {
                    text: '取消',
                    btnClass: 'waves-effect waves-button'
                }
            }
        });
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