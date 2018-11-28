<%@page import="net.huadong.idev.tpl.privilege.resources.PrivilegeResource"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="net.huadong.idev.tpl.privilege.entity.AuthUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" data-options="fit:true"  style="height:100%;width:100%;border: 0px">
    <div id="AuthLogAccessToolBar1427272337958" data-options="region:'north'" style="border: 0px">
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
            <input class="easyui-searchbox" id="AuthLogAccessSearchbox1427272337958"/>
        </span>
        <!-- 查询结束 -->
        <!-- 标准按钮 -->
        <!-- 如果存在 查询条件，请开启-->
        <!--<span style="float:right">
        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>-->
        <!-- 如果存在 查询条件，请开启-->
               <!--</span>-->
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
        <table id="AuthLogAccessDatagrid1427272337958" style="height:95%"  data-options="region:'center'"></table>
        <!-- end Datagrid -->
        <!--<div id="chart-dlg">
            <div id="chart"></div>
        </div>
        <div id="chart-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
        </div>-->
        
</div>
<%
    AuthUser user = (AuthUser) SecurityUtils.getSubject().getSession().getAttribute(PrivilegeResource.SESSION_USER);
%>
<!-- 脚本控制 -->
<script type="text/javascript">
    var tenId='<%=user.getTenantId().getTenantId()%>'
$(document).ready(function() {

    $.i18n.properties({
        name: 'log_access', //资源文件名称
        path: '../i18n/project/', //资源文件路径
        mode: 'map', //用Map的方式使用资源文件中的值
        language: getBrowserLanguage(),
//        language: "en",
        callback: function () {//加载成功后设置显示内容
            $("label").each(function (i) {
                $(this).html($.i18n.prop($(this).attr("name")));
            });
        }
    });
    
	
           // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
//        var hdConditions = new HdConditions();
//        // 返回后台参数。
//        var queryParams = {
//            hdConditions: hdConditions.getHdConditions(),
//            queryColumns: {}
//        };
//        var hdConditions1=new HdConditions();
////        hdConditions1.setAndClause("user.tenantId.tenantId",tenId,"=","and")
//            queryParams.hdConditions=hdConditions1.getHdConditions();
    var dg = $("#AuthLogAccessDatagrid1427272337958");
    // buttons
    // 增加。
    // 刷新。
                $("#AuthLogAccessToolBar1427272337958 a[iconCls='icon-reload']").on("click",function() {
        dg.datagrid("hdReload");
    });
    $("#_search").on("click",function(){
//            var startTime="to_date('"+$("#startTime").datebox('getValue')+"','yyyy-MM-dd hh:mi:ss')";
//            var endTime="to_date('"+$("#endTime").datebox('getValue')+"','yyyy-MM-dd hh:mi:ss')";
            var startTime=$("#startTime").datebox('getValue');
            var endTime=$("#endTime").datebox('getValue');
//            var hdConditions2=new HdConditions();
            if(startTime!=""){
                builder.setAndClause("insTimestamp",startTime,">=","and");
            }                                     
            if(endTime!=""){
                builder.setAndClause("insTimestamp",endTime+" 23:59:59","<=","and")
            }
//            hdConditions2.setAndClause("user.tenantId.tenantId",tenId,"=","and")
//            queryParams.hdConditions=hdConditions2.getHdConditions();
            dg.datagrid({
                queryParams: builder.build()
            });
            $("#AuthLogAccessDatagrid1427272337958").datagrid("reload");
        });
    // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        // 返回后台参数。
//        var queryParams = {
//            builder: builder.build(),
//            queryColumns: {}
//        };
    // searchbox
    $("#AuthLogAccessSearchbox1427272337958").searchbox({prompt:"请输入...",searcher:function(value,name) {
            builder.set("q",value);
            builder.set("queryColumns","function");
            dg.datagrid("hdReload");
        }});
    // datagrid
$("#AuthLogAccessDatagrid1427272337958").datagrid({
        	striped:true,
    url:"../webresources/login/AuthLogAccess/find",
    queryParams:builder.build(),
    method:"post",
    pagination:true,
    singleSelect:true,
    rownumbers:true,
    pageSize:20,
    toolbar:"#AuthLogAccessToolBar1427272337958",
    fit:true,
    fitColumns:false,
    columns:[[
{
    field:"accessId",
    title:'<font color="red">'+$.i18n.prop("accessId")+'</font>',
    multiSort:true,
    halign:"center",
    hidden:true,
sortable:true
},
{
    field:"userName",
    title:'<font color="red">'+$.i18n.prop("userName")+'</font>',
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:true}},
sortable:true
},
{
    field:"ip",
    title:$.i18n.prop("ip"),
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:true
},
{
    field:"browser",
    title:$.i18n.prop("browser"),
    multiSort:true,
    width: 250,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:true
},
{
    field:"function",
    title:$.i18n.prop("function"),
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:true
},
{
    field:"resourceName",
    title:$.i18n.prop("resourceName"),
    width: 180,
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:false
},
{
    field:"insTimestamp",
    title:$.i18n.prop("insTimestamp"),
    multiSort:true,
    halign:"center",
formatter:function(value) {
    if(value != null && value != undefined) {
    return new Date(value).format("yyyy-MM-dd hh:mm:ss");
} else {
    return value;
}
}, 
width:180,
    editor:{type:"datetimebox",options:{required:false}},
sortable:true
}

]]});
$("#AuthLogAccessDatagrid1427272337958").datagrid("hdGetColumnNames");
});
function createChart(){
                 $("#chart-dlg").dialog({
                            title: '生成图表',
                            width: 800,
                            height: 500,
                            padding: 10,
                            iconCls: 'icon-save',
                            buttons: '#chart-buttons',
                            maximizable: true
                        });
                        var divId='chart';
                        var type=$("#chart-type").combobox("getValue");
               var s=new ShapeBase();
               s.show("xxx",divId,type);//XXX是查询数据的方法路径
}

</script>
