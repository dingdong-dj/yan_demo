<%--
  Created by IntelliJ IDEA.
  User: djson
  Date: 2019/7/23
  Time: 9:00
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
    <title>员工绩效审核</title>
</head>
<body>

<div class="layout-left">
    <div id="toolbar" align="left" style="background: #F5F5F5;">
        <span class="proj">人员审核</span>
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
        url: "${pageContext.request.contextPath}/appraise/peoman/examine/tree",
        async: false,
        success: function (data) {
            if (data.success) {
                 var list = data.list;
                var sysno = data.sysno;
                for (var i = 0; i < sysno.length; i++) {
                    var PMain = [];
                    for(var j=0;j<list.length;j++){
                        if(list[j].sysNo == sysno[i]) {
                            PMain.push({"id":list[j].projNo,"name":list[j].projName,"pid":list[j].sysNo,"lastFee":list[j].lastFee,"type":"2"});
                        }
                    }
                   treeNode.push({"id":sysno[i],"name":sysno[i],"children":PMain,"type":"1"});
                    //treeNode.push({"id":sysno[i],"name":sysno[i],"type":"1"});
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

    var node = treeObj.getNodes()[0];
    treeObj.selectNode(node);
    setting.callback.onClick(null, treeObj.setting.treeId, node);
    // 设置样式
    function setFontCss(treeId, treeNode) {
        return treeNode.valid == false ? {color:"red"} : {};
    };
    // tree 点击事件
    function zTreeOnClick(event, treeId, treeNode) {
        if("1" == treeNode.type){
            var id = treeNode.id;
            $("#content_iframe").attr("src", "${pageContext.request.contextPath}/appraise/peoman/" + id + "/examine");
        }else if("2" == treeNode.type){
            var id = treeNode.pid +"," +treeNode.id+","+treeNode.name;
            $("#content_iframe").attr("src", "${pageContext.request.contextPath}/appraise/peoman/" + id + "/examine");
        }
    }


</script>
</html>
