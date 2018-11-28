<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="findToolBar1428368217397">
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
            <input class="easyui-searchbox" id="findSearchbox1428368217397"/>
        </span>
        <!-- 查询结束 -->
        <!-- 标准按钮 -->
        <!-- 如果存在 查询条件，请开启-->
<!--        <span style="float:right">-->
        <shiro:hasPermission name="webresources:login:matername:add">
        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:matername:update">
        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:matername:delete">
        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:matername:save">
        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:matername:refresh">
        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
        &nbsp;
        <!-- 如果存在 查询条件，请开启-->
<!--        </span>-->
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
<table id="findDatagrid1428368217397" style="height:100%"></table>
<!-- end Datagrid -->
<div id="chart-dlg">
    <div id="chart"></div>
</div>
<div id="chart-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
$(document).ready(function() {
    var dg = $("#findDatagrid1428368217397");
    // buttons
    // 增加。
    $("#findToolBar1428368217397 a[iconCls='icon-add']").on("click",function() {
        dg.datagrid("hdAdd");
    });
    // 编辑。
        $("#findToolBar1428368217397 a[iconCls='icon-edit']").on("click",function() {
        dg.datagrid("hdEdit");
    });
    // 删除。
            $("#findToolBar1428368217397 a[iconCls='icon-remove']").on("click",function() {
        dg.datagrid("hdRemove");
    });
    // 保存。
        $("#findToolBar1428368217397 a[iconCls='icon-save']").on("click",function() {
            dg.datagrid("hdSave",{url:"../webresources/login/find/save"});  
        dg.datagrid("hdSave");
    });
    // 刷新。
                $("#findToolBar1428368217397 a[iconCls='icon-reload']").on("click",function() {
        dg.datagrid("hdReload");
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
    $("#findSearchbox1428368217397").searchbox({prompt:"请输入...",searcher:function(value,name) {
            builder.set("q",value);
            builder.set("queryColumns","text");
            dg.datagrid("hdReload");
        }});
    // datagrid
$("#findDatagrid1428368217397").datagrid({
        	striped:true,
    url:"../webresources/login/matername/find",
    queryParams:builder.build(),
    method:"post",
    pagination:true,
    singleSelect:true,
    rownumbers:true,
    pageSize:20,
    toolbar:"#findToolBar1428368217397",
    fit:true,
    fitColumns:false,
    columns:[[
{
    field:"MATER_KIND_NAM",
    title:'<font color="red">类别名称</font>',
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:true}},
sortable:true
},
{
    field:"MATER_NAM",
    title:'<font color="red">物资名称</font>',
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:true}},
sortable:true
},

]]});
$("#findDatagrid1428368217397").datagrid("hdGetColumnNames");
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
