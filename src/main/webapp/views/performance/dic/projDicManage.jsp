<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/global.jsp" %>
<%@ include file="/common/include_common.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>项目管理</title>
</head>
<body>
<div id="main">
    <div id="toolbar">
        <a class="waves-effect btn btn-info btn-sm" href="javascript:createAction();" ><i class="zmdi zmdi-plus"></i> 新增项目</a>
        <a class="waves-effect btn btn-warning btn-sm" href="javascript:updateAction();"><i class="zmdi zmdi-edit"></i>编辑查看</a>
        <a class="waves-effect btn btn-danger btn-sm" href="javascript:deleteAction();" ><i class="zmdi zmdi-delete"></i> 删除项目</a>
    </div>
    <div class="table-responsive">
        <table id="table"></table>
    </div>

</div>
<div id="ratios" class="crudDialog" hidden>
    <form id="ratioForm">
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-md-2 "
                 style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">战略意义：</label>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <input type="text" id="ratio1" name="ratio1" class="form-control" readonly/>
                </div>
            </div>
            <div class="col-md-2 text-left"
                 style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">实施难度：</label>
            </div>
            <div class="col-md-4 ">
                <div class="form-group">
                    <input type="text" id="ratio2" name="ratio2" class="form-control" readonly/>
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-md-2 text-left"
                 style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">实施周期：</label>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <input type="text" id="ratio3" name="ratio3" class="form-control" readonly/>
                </div>
            </div>
            <div class="col-md-2 text-left"
                 style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">项目收益：</label>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <input type="text" id="ratio4" name="ratio4" class="form-control" readonly/>
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
            <div class="col-md-2 text-left"
                 style="background-color: #FFEEDD; line-height: 26px; vertical-align: middle;">
                <label style="margin-top: 5px; font-size: 14px; color: grey;">维护成本：</label>
            </div>
            <div class="col-md-4">
                <div class="form-group">
                    <input type="text" id="ratio5" name="ratio5" class="form-control" readonly/>
                </div>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    var $table = $('#table');
    $(function() {
        $table.bsTable({
            toolbar: '#toolbar',
            search:true,
            detailView: false,
            singleSelect: true,
            pageNumber: 1,
            //初始化加载第一页，默认第一页
            pageSize: 10,
            //每页的记录行数（*）
            pageList: [10, 15, 20],
            //可供选择的每页的行数（*）
            url: '${pageContext.request.contextPath}/dic/proj/list',	// 请求后台的URL
            columns: [
                {field: 'state', checkbox: true},
                {field: 'projNo', title: '项目编号', align: 'center'},
                {field: 'projName', title: '项目名', align: 'center'},
                {field: 'totalFee', title: '总金额', align: 'center'},
                {field: 'leftFee', title: '应收尾款', align: 'center'},
                {field: 'statusFlag', title: '项目状态', align: 'center',
                    editable:{
                        type:'select',
                        title:'项目状态',
                        source:[{value:"立项",text:"立项"},{value:"招标",text:"招标"},{value:"已签合同",text:"已签合同"},
                            {value:"实施中",text:"实施中"},{value:"已完成",text:"已完成"}],
                    }
                },
                {field: 'contractDt', title: '合同签订时间', align: 'center'},
                {field: 'projStart', title: '项目开始时间', align: 'center'},
                {field: 'projEnd', title: '项目结束时间', align: 'center'},
                {field: 'customName', title: '客户', align: 'center'},
                {field: 'customNo', title: '客户编号', align: 'center',visible: false},
                {field: 'empName', title: '项目经理', align: 'center'},
                {field: 'empNo', title: '项目经理编号', align: 'center',visible: false},
                {field: 'ratio1', title: '战略意义', align: 'center',visible: false},
                {field: 'ratio2', title: '实施难度', align: 'center',visible: false},
                {field: 'ratio3', title: '实施周期', align: 'center',visible: false},
                {field: 'ratio4', title: '项目收益', align: 'center',visible: false},
                {field: 'ratio5', title: '维护成本', align: 'center',visible: false},
                {field: 'remarks', title: '备注', align: 'center',visible: false},
                {field: 'action', title: '操作', align: 'center', formatter: 'actionFormatter', events: 'actionEvents', clickToSelect: false}
            ]
        });
    });
    function actionFormatter(value, row, index) {
        return [
            '<a class="ratio ml10" href="javascript:void(0)" data-toggle="tooltip" title="参数查看"><i class="glyphicon glyphicon-eye-open"></i></a>　',
            '<a class="edit ml10" href="javascript:void(0)" data-toggle="tooltip" title="编辑"><i class="glyphicon glyphicon-edit"></i></a>　 ',
            '<a class="remove ml10" href="javascript:void(0)" data-toggle="tooltip" title="删除"><i class="glyphicon glyphicon-remove"></i></a>'
        ].join('');
    }


    $('#table').on('editable-save.bs.table', function (field, row, oldValue, $el) {
        var projNo = oldValue.projNo;
        var statusFlag = oldValue.statusFlag;
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/dic/proj/edit/flag",
            data: {projNo:projNo,statusFlag:statusFlag},
            dataType: 'JSON',
            success: function (data) {
                layer.msg(data.msg);
                $table.bootstrapTable('refresh');
            }
        });
    });

    window.actionEvents = {
        'click .edit': function (e, value, row, index) {
            var projNo = row.projNo;
            $.ajax({
                url: '${pageContext.request.contextPath}/dic/proj/isUsed',
                type: "post",
                data: {
                    projNo: projNo
                },
                traditional: true,//这里设为true就可以了
                success: function (data) {
                    if("1" == data.status) {
                        index_Tab.addTab(row.projName + " - 查看", "dic/proj/look/one?projNo=" + row.projNo);
                    }else{
                        index_Tab.addTab(row.projName + " - 修改", "dic/proj/find/one?projNo=" + row.projNo);
                    }
                }
            });
        },
        'click .remove': function (e, value, row, index) {
            $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除该项目吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = [];
                            ids.push(row.projNo);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/dic/proj/deletes',
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
        },
        'click .ratio': function (e, value, row, index) {
            $("#ratio1").val(row.ratio1);
            $("#ratio2").val(row.ratio2);
            $("#ratio3").val(row.ratio3);
            $("#ratio4").val(row.ratio4);
            $("#ratio5").val(row.ratio5);
            layer.open({
                type:1,
                area:['600px','400px'],
                title:"参数查看",
                content:$('#ratios'),
                btn:['确定'],
                yes:function () {
                    layer.closeAll(); //关闭当前窗口
                }
            })
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
        index_Tab.addTab("项目新增", "dic/proj/addOrEditPage");
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
                content: '确认删除该项目吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = [];
                            rows.forEach(function (item,i) {
                                ids.push(item.projNo);
                            })
                            $.ajax({
                                url: '${pageContext.request.contextPath}/dic/proj/deletes',
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

    // 编辑
    function updateAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length != 1) {
            $.confirm({
                title: false,
                content: '请选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        }else {
            var projNo = rows[0].projNo;
            $.ajax({
                url: '${pageContext.request.contextPath}/dic/proj/isUsed',
                type: "post",
                data: {
                    projNo: projNo
                },
                traditional: true,//这里设为true就可以了
                success: function (data) {
                    if("1" == data.status) {
                        index_Tab.addTab(rows[0].projName + " - 查看", "dic/proj/look/one?projNo=" + rows[0].projNo);
                    }else{
                        index_Tab.addTab(rows[0].projName + " - 修改", "dic/proj/find/one?projNo=" + rows[0].projNo);
                    }
                }
            });
        }
    }
</script>
</body>
</html>