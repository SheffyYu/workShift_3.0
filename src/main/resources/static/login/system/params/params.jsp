<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SysParamsToolBar1427270703035">
    <div>
        <span style="float:right;">
            <input class="easyui-searchbox" id="SysParamsSearchbox1427270703035"/>
        </span>
        <shiro:hasPermission name="webresources:login:AuthTenant:add">
                    <a class="easyui-linkbutton" iconCls="icon-add" plain="false"><label name="add">增加</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:update">
                    <a class="easyui-linkbutton" iconCls="icon-edit" plain="false"><label name="edit">编辑</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:delete">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="false"><label name="delete">删除</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:save">
                    <a class="easyui-linkbutton" iconCls="icon-save" plain="false"><label name="save">保存</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:refresh">
                    <a class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="reload">刷新</label></a>
                </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SysParams:flush">				
            <a id="flushSysParamsCache" class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="RefreshCache">刷新缓存</label></a>
        </shiro:hasPermission>
        &nbsp;
    </div>
</div>
<table id="SysParamsDatagrid1427270703035" style="height:100%"></table>
<div id="chart-dlg">
    <div id="chart"></div>
</div>
<div id="chart-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
    	 $.i18n.properties({
             name: 'params', //资源文件名称
             path: '../i18n/project/', //资源文件路径
             mode: 'map', //用Map的方式使用资源文件中的值
             language: getBrowserLanguage(),
//             language: "en",
             callback: function () {//加载成功后设置显示内容
                 $("label").each(function (i) {
                     $(this).html($.i18n.prop($(this).attr("name")));
                 });
             }
         });
    	 
        var dg = $("#SysParamsDatagrid1427270703035");
        // buttons
        // 增加。
        $("#SysParamsToolBar1427270703035 a[iconCls='icon-add']").on("click", function () {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SysParamsToolBar1427270703035 a[iconCls='icon-edit']").on("click", function () {
            dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SysParamsToolBar1427270703035 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRemove");
        });
        // 保存。
        $("#SysParamsToolBar1427270703035 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SysParams/save"});
        });
        // 刷新。
        $("#SysParamsToolBar1427270703035 a[iconCls='icon-reload']").on("click", function () {
            dg.datagrid("hdReload");
        });
        // 刷新缓存
        $("#flushSysParamsCache").on("click", function () {
            $.ajax({
                    type: "GET",
                    url: "../webresources/login/SysParams/flush?t=" + Math.random(),
                    contentType: "application/json",
                    dataType: "json",
                    success: function(data) {
                        HdUtils.messager.info('刷新成功');
                        HdUtils.dialog.close();
                    },
                    error: function(data) {
                        HdUtils.messager.info(data.responseText);
                    }
                });
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
        $("#SysParamsSearchbox1427270703035").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "key");
                dg.datagrid("hdReload");
            }});
        //列声明
        var columns = [];
        var column = [];
        column.push({
            field: "paramsId",
            hidden : true
        });
        column.push({
            field: "key",
            title: '<font color="red">'+$.i18n.prop("key")+'</font>',
            width: '200',
            multiSort: true,
            halign: "center",
            editor: {type: "validatebox", options: {required: true}},
            //formatter: function (val, row, idx) {
            //    return row.sysParamsPK.key;
            //},
            sortable: true
        });
        column.push({
            field: "type",
            width: '150',
            title: '<font color="red">'+$.i18n.prop("type")+'</font>',
            multiSort: true,
            halign: "center",
            editor: {type: "validatebox", options: {required: true}},
            //formatter: function (val, row, idx) {
            //    return row.sysParamsPK.type;
            //},
            sortable: true
        });
        column.push({
            field: "value",
            width: '100',
            title: $.i18n.prop("value"),
            multiSort: true,
            halign: "center",
            editor: {type: "validatebox", options: {required: false}},
            sortable: true
        });
        columns.push(column);
        // datagrid
        $("#SysParamsDatagrid1427270703035").datagrid({
        	striped:true,
            url: "../webresources/login/SysParams/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SysParamsToolBar1427270703035",
            fit: true,
            fitColumns: false,
            columns: columns
        });
        $("#SysParamsDatagrid1427270703035").datagrid("hdGetColumnNames");
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
