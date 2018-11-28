<%@page import="net.huadong.idev.tpl.privilege.resources.PrivilegeResource"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="net.huadong.idev.tpl.privilege.entity.AuthUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<meta charset="UTF-8">
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="AuthLogToolBar1422252760994">
    <div>
        <!-- TODO:查询条件 -->
        <!--        <fieldset style="float: left;width:100px;height:10px">
                    <input type="radio" name="check" checked="checked">未审
                    <input type="radio" name="check">已审
                </fieldset>
                &nbsp;船名：<input id="shipForecastWebSearchShipNam" type="text" style="width:100px"/>
                 已审核  
                状态：<input id="shipApplyForForecastShipStatId" style="width:60px"/>
                离港日期：<input id="shipApplyForForecastOtherBegDate" style="width:90px" disabled="disabled"/>&nbsp;-
                <input id="shipApplyForForecastEndDate" style="width:90px" disabled="disabled"/>
                <a class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>
                 end 
                <a class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>-->
        <!-- 查询条件 结束-->
        <!-- 查询 -->
        <span style="float:right;">
            <input class="easyui-searchbox" id="AuthLogSearchbox1422252760994"/>
        </span>
        <!-- 查询结束 -->
        <!-- 标准按钮 -->
        <!-- 如果存在 查询条件，请开启-->
        <span style="float:right">
        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="reload">刷新</label></a>
        <!-- 如果存在 查询条件，请开启-->
               </span>
       <label name="begintime">开始日期：</label><input id="startTime" name="startTime" class="easyui-datebox" style="width:100px;">
					-
		<label name="endtime">截止日期：</label><input id="endTime" name="endTime" class="easyui-datebox" style="width:100px;">
        <a class="easyui-linkbutton" iconCls="icon-search" id="_search" plain="false"><label name="search">查询</label></a>
        <!--请选择图表样式：<select id="chart-type" class="easyui-combobox">
                            <option value ="pie">饼图</option>
                            <option value ="column">柱状图</option>
                            <option value ="line">折线图</option>
                            <option value ="spline">曲线图</option>             
                     </select>
                <a class="easyui-linkbutton" iconCls="icon-tip" plain="false" href="javascript:createChart()">生成图表</a>-->

        <!-- 标准按钮 结束-->
    </div>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="AuthLogDatagrid1422252760994" style="height:100%"></table>
<!-- end Datagrid -->
<div id="chart-dlg">
    <div id="chart"></div>
</div>
<div id="chart-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
    <%
    AuthUser user = (AuthUser) SecurityUtils.getSubject().getSession().getAttribute(PrivilegeResource.SESSION_USER);
%>
    var tenId='<%=user.getTenantId().getTenantId()%>'
    $(document).ready(function () {

        $.i18n.properties({
            name: 'log', //资源文件名称
            path: '../i18n/project/', //资源文件路径
            mode: 'map', //用Map的方式使用资源文件中的值
            language: getBrowserLanguage(),
//            language: "en",
            callback: function () {//加载成功后设置显示内容
                $("label").each(function (i) {
                    $(this).html($.i18n.prop($(this).attr("name")));
                });
            }
        });
        
        
        var dg = $("#AuthLogDatagrid1422252760994");
        // buttons
        // 刷新。
        
        $("#AuthLogToolBar1422252760994 a[iconCls='icon-reload']").on("click", function () {
            dg.datagrid("hdReload");
        });
       // 条件类。
        var hdConditions = new HdConditions();

        // 返回后台参数。
        var queryParams = {
            hdConditions: hdConditions.getHdConditions(),
            queryColumns: {}
        };
//        var hdConditions1=new HdConditions();
//        hdConditions1.setAndClause("user.tenantId.tenantId",tenId,"=","and")
//            queryParams.hdConditions=hdConditions1.getHdConditions();
        $("#_search").on("click",function(){
//            var startTime="to_date('"+$("#startTime").datebox('getValue')+"','yyyy-MM-dd hh:mi:ss')";
//            var endTime="to_date('"+$("#endTime").datebox('getValue')+"','yyyy-MM-dd hh:mi:ss')";
            var startTime=$("#startTime").datebox('getValue');
            var endTime=$("#endTime").datebox('getValue');
            var hdConditions2=new HdConditions();
            if(startTime!=""){
                hdConditions2.setAndClause("insTimestamp",startTime,">=","and");
            }
            if(endTime!=""){
                hdConditions2.setAndClause("insTimestamp",endTime+" 23:59:59","<=","and");
            }
//            hdConditions2.setAndClause("user.tenantId.tenantId",tenId,"=","and");
            queryParams.hdConditions=hdConditions2.getHdConditions();
            $("#AuthLogDatagrid1422252760994").datagrid("reload");
        });
        // searchbox
        $("#AuthLogSearchbox1422252760994").searchbox({prompt: "请输入...", searcher: function (value, name) {
                queryParams.q = value;
                $("#AuthLogDatagrid1422252760994").datagrid("reload");
            }});
        // datagrid
        $("#AuthLogDatagrid1422252760994").datagrid({
        	striped:true,
            url: "../webresources/login/AuthLog",
            queryParams: queryParams,
            method: "get",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#AuthLogToolBar1422252760994",
            fit: true,
            fitColumns: false,
            columns: [[
                    {
                        field: "logId",
                        title: '<font color="red">'+$.i18n.prop("logId")+'</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
//                    {
//                        field: "userName",
//                        title: "用户姓名",
//                        multiSort: true,
//                        halign: "center",
//                        editor: {type: "validatebox", options: {required: false}},
//                        sortable: true
//                    },
                    {
                        field: "urlId",
                        title: $.i18n.prop("urlId"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "operRecord",
                        title:$.i18n.prop("operRecord"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "ip",
                        title: $.i18n.prop("ip"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "browser",
                        title: $.i18n.prop("browser"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: $.i18n.prop("insTimestamp"),
                        multiSort: true,
                        halign: "center",
                         formatter: function (value) {
                            if (value != null && value != undefined) {
                                return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                            } else {
                                return value;
                            }
                        },
                        width: 180,
                        editor: {type: "datetimebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "action",
                        title: $.i18n.prop("action"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                ]]});
        $("#AuthLogDatagrid1422252760994").datagrid("hdGetColumnNames");
    });
    function createChart() {
        $("#chart-dlg").dialog({
            title: '生成图表',
            width: 800,
            height: 500,
            padding: 10,
            iconCls: 'icon-save',
            buttons: '#chart-buttons',
            maximizable: true
        });
        var divId = 'chart';
        var type = $("#chart-type").combobox("getValue");
        var s = new ShapeBase();
        s.show("xxx", divId, type);//XXX是查询数据的方法路径
    }

</script>
