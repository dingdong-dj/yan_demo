<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/11
  Time: 8:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/common/global.jsp"%>
<%@ include file="/common/include_common.jsp"%>
<style>
    <!-- /* 左右布局 */
    .layout-left {
        position: fixed;
        width: 200px;
        background: #fff;
        height: 100%;
        transition: all;
        -webkit-transition-duration: .3s;
        transition-duration: .3s;
        z-index: 10;
        overflow-y: auto;
        box-shadow: 1px 0 4px rgba(0, 0, 0, .3);
    }

    .layout-right {
        position: fixed;
        width: calc(100% -200px);
        background: #fff;
        left: 200px;
        height: 100%;
    }
    .proj{
        font-size: 15px;
    }
</style>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>员工绩效管理</title>
</head>
<body>

<div class="layout-left">
    <div id="toolbar" align="left" style="background: #F5F5F5;">
        <span class="proj">管理项目</span>
        <a id="add-btn" class="waves-effect btn btn-info btn-sm" style="margin-right: 5px;display: none;" href="javascript:roleAdd();"><i class="zmdi zmdi-plus"></i> 添加</a>
        <a id="delete-btn" class="waves-effect btn btn-danger btn-sm" style="margin-right: 5px;display: none;" href="javascript:roleDelete();" ><i class="zmdi zmdi-delete"></i> 删除</a>
    </div>
    <div id="ztree" class="ztree"></div>
</div>
<div class="layout-right">
    <iframe id="content_iframe" class="tab_iframe" frameborder="0"
            width="800" height="500" scrolling="yes"></iframe>
</div>
</body>
<script type="text/javascript">
    var treeNode = [];
    //查询所有考核周期并生成select
    $.ajax({
        url: "${pageContext.request.contextPath}/appraise/peoman/tree",
        async: false,
        success: function (data) {
            if (data.success) {
                var list = data.list;
                var sysno = data.sysno;
                var palist = data.palist;
                for (var i = 0; i < sysno.length; i++) {
                    var PMainEmp = [];
                    for(var j=0;j<list.length;j++){
                        var pAward = [];
                        for(var k=0;k<palist.length;k++){
                            if(list[j].sysNo == palist[k].sysNo && list[j].projNo == palist[k].projNo){
                                pAward .push({"id":palist[k].empNo,"name":palist[k].empName,"pid":palist[k].projNo,"type":"3","sysno":palist[k].sysNo,"projName":palist[k].projName})
                            }
                        }
                        if(list[j].sysNo == sysno[i]) {
                            PMainEmp.push({"id":list[j].projNo,"name":list[j].projName,"pid":list[j].sysNo,"lastFee":list[j].lastFee,"children":pAward,"type":"2"});
                        }
                    }
                    treeNode.push({"id":sysno[i],"name":sysno[i],"children":PMainEmp,"type":"1"});
                }
            } else {
                $.alert(data.msg);
            }
        }
    });

    var treeObj;
    var setting = {
        view: {
            fontCss: setFontCss
        },
        callback : {
            //beforeClick: zTreeBeforeClick,
            onClick : zTreeOnClick
        }
    };
    // 初始化 tree 数据
    treeObj = $.fn.zTree.init($('#ztree'), setting,treeNode);
    var nodes = treeObj.getNodes();
    if (nodes.length>0) {
        for(var i=0;i<nodes.length;i++){
            treeObj.expandNode(nodes[i], true, false, false);
        }
    }

    var node = treeObj.getNodes()[0];
    treeObj.selectNode(node);
    setting.callback.onClick(null, treeObj.setting.treeId, node);
    // 设置样式
    function setFontCss(treeId, treeNode) {
        return treeNode.valid == false ? {color:"red"} : {};
    };
    // 禁止第一节点被选中
    /*
    function zTreeBeforeClick(treeId, treeNode, clickFlag) {
        return (treeNode.level != '0');
    }
     */
    var lastSelected;
    var lastChecked;
    // tree 点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        console.log(treeNode);
        if("1" == treeNode.type){
            $("#delete-btn").hide();
            $("#add-btn").hide();
            var id = treeNode.id;
            $("#content_iframe").attr("src", "${pageContext.request.contextPath}/appraise/peoman/" + id + "/list");
        }else if("2" == treeNode.type){
            $("#delete-btn").hide();
            $("#add-btn").show();
            var id = treeNode.pid +"," +treeNode.id+","+treeNode.name;
            $("#content_iframe").attr("src", "${pageContext.request.contextPath}/appraise/peoman/" + id + "/list");
        }else {
            $("#delete-btn").show();
            $("#add-btn").show();
            var parent = treeNode.getParentNode();
            var id = parent.pid + "," + parent.id+","+parent.name+","+treeNode.id;
            $("#content_iframe").attr("src", "${pageContext.request.contextPath}/appraise/peoman/" + id + "/edit");
        }
    }

    // 删除 tree 节点
    function roleDelete() {
        var nodes = treeObj.getSelectedNodes();
        if (nodes != '') {
            $.confirm({
                type : 'red',
                animationSpeed : 300,
                title : false,
                content : '确认删除[' + nodes[0].name + ']绩效吗？',
                buttons : {
                    confirm : {
                        text : '确认',
                        btnClass : 'waves-effect waves-button',
                        action : function() {
                            $.post('${pageContext.request.contextPath}/appraise/people/deletes', {"sysno":nodes[0].sysno, "projNo": nodes[0].pid,"empNo": nodes[0].id}, function(data){
                                if('1' == data.status){
                                    $.alert(data.msg);
                                    return;
                                }
                                $.alert(data.msg);
                                location.reload();
                            });
                        }
                    },
                    cancel : {
                        text : '取消',
                        btnClass : 'waves-effect waves-button'
                    }
                }
            });
        } else {
            $.confirm({
                title : false,
                content : '请选择需要删除的菜单！',
                autoClose : 'cancel|3000',
                backgroundDismiss : true,
                buttons : {
                    cancel : {
                        text : '取消',
                        btnClass : 'waves-effect waves-button'
                    }
                }
            });
        }
    }

    function roleAdd() {
        var nodes = treeObj.getSelectedNodes();
        if(nodes[0].type == "2"){
            var id = nodes[0].pid +"," +nodes[0].id+","+nodes[0].name;
        }else{
            var id = nodes[0].sysno+","+nodes[0].pid +","+nodes[0].projName;
        }

        $("#content_iframe").attr("src", "${pageContext.request.contextPath}/appraise/peoman/" + id + "/edit");
    }
</script>
</html>