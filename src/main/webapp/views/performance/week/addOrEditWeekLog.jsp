<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/19
  Time: 10:06
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
    <title>周报添加</title>
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
            <div class="row" style="margin-top: 10px; margin-bottom: 10px; display: none">
                <div class="col-md-7">
                    <div class="form-group">
                        <input type="text" id="sysno" name="sysno"
                               value="${vaBooking.sysno}" class="form-control"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 5px; margin-bottom: 5px;">
                <div class="col-md-2"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">员工：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="empNo" name="empNo"
                               value="${vaBooking.cardNo}" class="form-control"
                               placeholder="选择员工"/>
                    </div>
                </div>
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">周号：</label>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <input type="text" id="weekNo" name="weekNo"
                               value="${vaBooking.cardNo}" class="form-control"
                               placeholder="周号"/>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">周报主题：</label>
                </div>
                <div class="col-md-10">
                    <div class="form-group">
                        <textarea type="text" class="form-control" rows="1" id="titleName" name="titleName"
                                  placeholder="可以写医院名或研发中心">${pAward.remarks}</textarea>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-2 text-left"
                     style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                    <label style="margin-top: 5px; font-size: 14px; color: grey;">周报主题：</label>
                </div>
                <div class="col-md-10">
                    <div class="form-group">
                        <textarea type="text" class="form-control" rows="3" id="sumText" name="sumText"
                                  placeholder="可以写医院名或研发中心">${pAward.remarks}</textarea>
                    </div>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="form-group  col-md-11" style="text-align: center">
                    <div style="margin:10px 0px 10px 5px">
                        <label style="margin-top: 5px; font-size: 1.5rem;">接种计划</label>
                    </div>
                    <table id="formTable" class="table"></table>
                </div>
            </div>
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                <div class="form-group  col-md-11" style="text-align: center">
                    <c:if test="${vaBooking.vaCode == 'hdcv'}">
                        <div class="form-group" style="text-align: center">
                            <button class="btn btn-info btn-lg" type="button" id="registerFormPrint">狂犬病预防处理记录打印预览</button>
                        </div>
                    </c:if>
                </div>
            </div>
        </form>


    </div>
</div>
</body>
<script type="text/javascript">
    var $registerTable = $('#formTable');
    $(function () {


        <c:if test="${vaBooking.sysno == null || vaBooking.sysno == ''}">
        //随机字符串（30位）
        var randomString = Math.random().toString(36).substr(2) + Math.random().toString(36).substr(2) + Math.random().toString(36).substr(2);
        //ID前台生成
        $("#sysno").val(randomString);
        </c:if>

        // 生产厂家数据缓存
        var manufCache;

        //绘制表格
        $registerTable.bsTable({
            toolbar: '#toolbar',
            singleSelect: true,
            search: true,
            height: 0,
            idField: 'lineNo',
            clickToSelect: true,
            detailView: false,
            pagination: false,
            //是否开启分页（*）
            pageNumber: 1,
            //初始化加载第一页，默认第一页
            pageSize: 8,
            //每页的记录行数（*）
            sidePagination: "client",
            //分页方式：client客户端分页，server服务端分页（*）
            columns: [
                /*{field: 'state', checkbox: true},*/
                {
                    field: 'state',
                    checkbox: true
                },
                {
                    field: 'sysno',
                    title: '系统编码',
                    align: 'center',
                    visible: false
                },
                {
                    field: 'lineNo',
                    title: '行号',
                    align: 'center',
                    visible: false
                },
                {
                    field: 'vaName',
                    title: '疫苗名称',
                    align: 'center',
                    editable: {
                        type: 'select',
                        title: '疫苗名称',
                        disabled: true,
                        mode: 'inline',
                        source: function () {
                            var result = [];
                            $.ajax({
                                url: "${pageContext.request.contextPath}/vaccine/register/getEnum?type=vaName",
                                async: false,
                                type: "post",
                                data: {},
                                success: function (data) {
                                    if (data.success) {
                                        var list = data.enumList;
                                        if (list) {
                                            $.each(list,
                                                function (key, value) {
                                                    result.push({
                                                        value: value.ecode,
                                                        text: value.ename
                                                    });
                                                });
                                        }
                                    } else {
                                        $.alert(data.msg);
                                    }
                                }
                            });
                            return result;
                        }
                    }
                },
                {
                    field: 'planDt',
                    title: '计划日期',
                    align: 'center',
                    editable: {
                        type: 'date',
                        disabled: true,
                        title: '接种日期'
                    }
                },
                {
                    field: 'execDt',
                    title: '接种日期',
                    align: 'center',
                    editable: {
                        type: 'date',
                        disabled: true,
                        title: '接种日期'
                    }
                },
                {
                    field: 'batchNo',
                    title: '疫苗批次',
                    align: 'center',
                    editable: {
                        type: 'text',
                        clear: false,
                        //onblur:'ignore',
                        showbuttons: false,
                        disabled: true,

                        mode: 'inline'
                    }
                },
                {
                    field: "manufNo",
                    title: "生产厂家",
                    align: 'center',
                    editable: {
                        type: 'select',
                        title: '生产厂家',
                        disabled: true,
                        mode: 'inline',
                        source: function () {
                            var result = [];
                            $.ajax({
                                url: "${pageContext.request.contextPath}/vaccine/register/getEnum?type=factory",
                                async: false,
                                type: "post",
                                data: {},
                                success: function (data) {
                                    if (data.success) {
                                        var list = data.enumList;
                                        if (list) {
                                            $.each(list,
                                                function (key, value) {
                                                    result.push({
                                                        value: value.ecode,
                                                        text: value.ename
                                                    });
                                                });
                                        }
                                    } else {
                                        $.alert(data.msg);
                                    }
                                }
                            });
                            return result;
                        }
                    }
                },
                {
                    field: 'manufName',
                    title: '生产厂家名称',
                    visible: false,
                    align: 'center',
                    editable: {
                        type: 'text',
                        clear: false,
                        //onblur:'ignore',
                        disabled: true,
                        showbuttons: false,

                        mode: 'inline'
                    }
                },
                {
                    field: 'vaHosp',
                    title: '接种医院编号',
                    align: 'center',
                    visible: false,
                    editable: {
                        type: 'text',
                        clear: false,
                        //onblur:'ignore',
                        disabled: true,
                        showbuttons: false,

                        mode: 'inline'
                    }
                },
                {
                    field: 'vaHospname',
                    title: '接种医院名称',
                    align: 'center',
                    visible: false,
                    editable: {
                        type: 'text',
                        clear: false,
                        //onblur:'ignore',
                        disabled: true,
                        showbuttons: false,

                        mode: 'inline'
                    }
                },
                {
                    field: 'vaOper',
                    title: '接种人',
                    align: 'center',
                    editable: {
                        type: 'text',
                        clear: false,
                        //onblur:'ignore',
                        disabled: true,
                        showbuttons: false,

                        mode: 'inline'
                    }
                },
                {
                    field: 'drugBarcode',
                    title: '药品监管码',
                    align: 'center',
                    editable: {
                        type: 'text',
                        clear: false,
                        //onblur:'ignore',
                        disabled: true,
                        showbuttons: false,

                        mode: 'inline'
                    }
                },
                {
                    field: "vaLeft",
                    title: "存苗",
                    align: 'center',
                    editable: {
                        type: 'text',
                        clear: false,
                        //onblur:'ignore',
                        disabled: true,
                        showbuttons: false,

                        mode: 'inline'
                    }
                },
                {
                    field: "statusFlag",
                    title: "状态",
                    align: 'center',
                    editable: {
                        type: 'select',
                        title: '状态',
                        disabled: true,
                        source: [{
                            value: "init",
                            text: "初始"
                        },
                            {
                                value: "done",
                                text: "完成接种"
                            },
                            {
                                value: "cancel",
                                text: "终止接种"
                            }]
                    }
                },
                {
                    field: "feedback",
                    title: "异常反应",
                    align: 'center',
                    editable: {
                        type: 'select',
                        title: '异常反应',
                        mode: 'inline',
                        disabled: true,
                        source: function () {
                            var result = [];
                            $.ajax({
                                url: "${pageContext.request.contextPath}/vaccine/register/getEnum?type=show",
                                async: false,
                                type: "post",
                                data: {},
                                success: function (data) {
                                    if (data.success) {
                                        var list = data.enumList;
                                        if (list) {
                                            $.each(list,
                                                function (key, value) {
                                                    result.push({
                                                        value: value.ecode,
                                                        text: value.ename
                                                    });
                                                });
                                        }
                                    } else {
                                        $.alert(data.msg);
                                    }
                                }
                            });
                            return result;
                        }
                    }
                },
                {
                    field: 'remarks',
                    title: '备注',
                    align: 'center',
                    editable: {
                        type: 'textarea',
                        title: '备注',
                        onblur: 'submit',
                        showbuttons: false
                    }
                },
            ]
        });

        //表格列联动（载入接种人，更改状态值）
        function vaOperChange(index) {
            $registerTable.bootstrapTable('updateCell', {
                index : index,
                field: 'vaOper',
                value: '${sysUser.userName}'
            });

            $registerTable.bootstrapTable('updateCell', {
                index : index,
                field: 'statusFlag',
                value: 'done'
            });
        }

        //表格列联动（与生产厂家编号关联）
        function manufNoChange(value, index) {
            var manufNameChange;
            for(var i = 0; i < manufCache.length; i++){
                if(manufCache[i].ecode == value){
                    manufNameChange = manufCache[i].ename;
                }
            }
            $registerTable.bootstrapTable('updateCell', {
                index : index,
                field: 'manufName',
                value: manufNameChange
            });
        }

        $('#username').on('save', function(e, params) {
            alert('Saved value: ' + params.newValue);
        });



        <c:if test="${vaBooking.vaCode == 'hdcv'}">
        loadSecondary();
        </c:if>

        // 性别下拉框赋值
        $('#patSex').selectpicker('val', '${vaBooking.patSex}');

        //接种计划表单验证通过标志
        var validateCheck = true;





        //施治记录更新
        $('#planUpdate').click(function () {
            var jsonPlanList = $registerTable.bootstrapTable('getData');
            var jsonPlanListData = JSON.stringify(jsonPlanList);
            var checkmsg = "请填报关键项数据：";
            //接种计划表单验证
            for(var i = 0; i < jsonPlanList.length; i++){
                //只对更改过接种日期的数据进行验证
                if(jsonPlanList[i].execDt != ''){
                    if(jsonPlanList[i].vaName == ''){
                        validateCheck = false;
                        checkmsg += "疫苗名称、";
                    }
                    if(jsonPlanList[i].manufNo == ''){
                        validateCheck = false;
                        checkmsg += "生产厂家、";
                    }
                    if(jsonPlanList[i].batchNo == ''){
                        validateCheck = false;
                        checkmsg += "疫苗批次、";
                    }
                    if(jsonPlanList[i].vaOper == ''){
                        validateCheck = false;
                        checkmsg += "接种人、";
                    }
                    if(jsonPlanList[i].statusFlag == ''){
                        validateCheck = false;
                        checkmsg += "接种状态";
                    }
                }
                if(!validateCheck){
                    $.alert(checkmsg);
                    validateCheck = true;
                    return;
                }
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/vaccine/register/updateplan",
                type: "post",
                data: {
                    planData: jsonPlanListData,
                },
                success: function (data) {
                    if (!data.success) {
                        $.alert(data.msg);
                    } else {
                        $.alert(data.msg);
                    }
                }
            });
        })


        //如果有接种计划则载入，如无则载入预设值
        $.ajax({
            url: "${pageContext.request.contextPath}/vaccine/register/registerConfirm",
            type: "post",
            data: {
                sysno: $("#sysno").val()
            },
            success: function (data) {
                if (!data.success) {
                    $.alert(data.msg);

                } else {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/vaccine/plan/getSpecial",
                        type: "post",
                        data: {
                            sysno: $("#sysno").val()
                        },
                        success: function (data) {
                            if (!data.success) {
                                $.alert("该患者免疫接种计划获取失败，请检查");
                            } else {
                                $registerTable.bootstrapTable('load', data.planList);

                            }
                        }
                    });
                }
            }
        });


        //网页打开时疫苗列表选项动态加载
        $.ajax({
            url: "${pageContext.request.contextPath}/vaccine/register/getVaCode",
            async: true,
            data: {},
            success: function (data) {
                if (data.success) {
                    $("#vaCode").find("option").remove();
                    var list = data.vaCodeTypeList;
                    if (list) {
                        for (var i = 0; i < list.length; i++) {
                            var optionString = "";
                            optionString = "<option value=\""
                                + list[i].vaCode + "\">"
                                + list[i].vaName + "</option>";
                            $("#vaCode").append(optionString);

                        }
                        $("#vaCode").selectpicker('refresh');
                        //疫苗下拉框赋值
                        $("#vaCode").selectpicker('val', '${vaBooking.vaCode}');
                    }
                } else {
                    $.alert(data.msg);
                }
            }
        });



        //打印处理函数
        $("#registerFormPrint").click(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/vaccine/register/registerConfirm",
                type: "post",
                data: {
                    sysno: $("#sysno").val()
                },
                success: function (data) {
                    if (!data.success) {
                        $.alert(data.msg);
                    } else {
                        index_Tab.addTab("狂犬病预防处理记录打印预览", "vaccine/register/printVaVpHdForm?sysno=" + $("#sysno").val());
                    }
                }
            });

        });


        //window.parent慎用
        var top_tabs = $("#tabs", window.parent.document);//window.parent.document.getElementById("");

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

        //加载后回调
        function getCallback(data, show) {
            $("#tryLoad").html(data);
            show();
        }

        //显示附表
        function secondaryShow() {
            $("#tryLoad").show("normal", "swing");
            $("#openSecondery").show("normal", "swing");
        }

        //隐藏附表
        function secondaryhide() {
            $("#tryLoad").hide("normal", "swing");
            $("#openSecondery").hide("normal", "swing");
        }

        //加载附表数据并显示
        function loadSecondary() {
            $.get('${pageContext.request.contextPath}/vaccine/register/secondaryAddOrEditPage2N?sysno=' + $("#sysno").val(), function (data) {
                getCallback(data, secondaryShow);
            });
        }

    });


    //选择器重绘
    $(".selectpicker").selectpicker({
        width: 'auto'
    });

    //选择器禁用
    $('.selectpicker').prop('disabled', true);

</script>
</html>