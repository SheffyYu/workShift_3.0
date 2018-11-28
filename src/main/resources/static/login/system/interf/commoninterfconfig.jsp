<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="CommonInterfConfigToolBar1471913717478">
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
            <input class="easyui-searchbox" id="CommonInterfConfigSearchbox1471913717478"/>
        </span>
        <!-- 查询结束 -->
        <!-- 标准按钮 -->
        <!-- 如果存在 查询条件，请开启-->
        <!--        <span style="float:right">-->
        <shiro:hasPermission name="webresources:login:CommonInterfConfig:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:CommonInterfConfig:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:CommonInterfConfig:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:CommonInterfConfig:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:CommonInterfConfig:refresh">
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
<table id="CommonInterfConfigDatagrid1471913717478" style="height:100%"></table>
<!-- end Datagrid -->


<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#CommonInterfConfigDatagrid1471913717478");
        // buttons
        // 增加。
        $("#CommonInterfConfigToolBar1471913717478 a[iconCls='icon-add']").on("click", function () {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#CommonInterfConfigToolBar1471913717478 a[iconCls='icon-edit']").on("click", function () {
            dg.datagrid("hdEdit");
        });
        // 删除。
        $("#CommonInterfConfigToolBar1471913717478 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRemove");
        });
        // 保存。
        $("#CommonInterfConfigToolBar1471913717478 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/normal/CommonInterfConfig/save"});
        });
        // 刷新。
        $("#CommonInterfConfigToolBar1471913717478 a[iconCls='icon-reload']").on("click", function () {
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
        $("#CommonInterfConfigSearchbox1471913717478").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "interfValue");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#CommonInterfConfigDatagrid1471913717478").datagrid({
        	striped:true,
            url: "../webresources/normal/CommonInterfConfig/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#CommonInterfConfigToolBar1471913717478",
            fit: true,
            fitColumns: false,
            columns: [[
                    {
                        field: "interfId",
                        title: '<font color="red">xxx</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    }
                    ,
                    {
                        field: "sqlType",
                        title: '<font color="red">sql类型</font>',
                        multiSort: true,
                        halign: "center",
                        formatter: function (value) {
                            if ("1" == value) {
                                return "insert";
                            }
                            else if ("2" == value) {
                                return "update";
                            }
                            else if ("3" == value) {
                                return "delete";
                            }
                            else if ("4" == value) {
                                return "select";
                            }
                            else if ("5" == value) {
                                return "procreturn";
                            }
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: 'insert',
                                        value: '1'
                                    }, {
                                        label: 'update',
                                        value: '2'
                                    }, {
                                        label: 'delete',
                                        value: '3'
                                    }, {
                                        label: 'select',
                                        value: '4'
                                    }, {
                                        label: 'procreturn',
                                        value: '5'
                                    }],
                                required: true
                            }},
                        sortable: true
                    }
                    ,
                    {
                        field: "interfValue",
                        title: '<font color="red">值</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: true}},
                        sortable: true
                    }
                    ,
                    {
                        field: "idSign",
                        title: '<font color="red">唯一标记</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: true}},
                        sortable: true
                    }
                    ,
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
//editor:{type:"validatebox",options:{required:false}},
                        sortable: true
                    }
                    ,
                    {
                        field: "insTimestamp",
                        title: "创建时间",
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
//editor:{type:"validatebox",options:{required:false}},
                        sortable: true
                    }
                    ,
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
//editor:{type:"validatebox",options:{required:false}},
                        sortable: true
                    }
                    ,
                    {
                        field: "updTimestamp",
                        title: "更新时间",
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
//editor:{type:"validatebox",options:{required:false}},
                        sortable: true
                    }
                    ,
                    {
                        field: "filter",
                        title: "是否过滤权限",
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        formatter: function (value) {
                            if ("1" == value) {
                                return "是";
                            }
                            else {
                                return "否";
                            }

                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: '否',
                                        value: '0'
                                    }, {
                                        label: '是',
                                        value: '1'
                                    }],
                                required: false
                            }},
                        sortable: true
                    } ,
                    {
                        field: "accessAddress",
                        title: "访问地址示例",
                        multiSort: true,
                        halign: "center",
                        formatter: function (value,row) {
                        if(row.sqlType=="4"){
                            return "../webresources/normal/CommonInterfConfig/interf?id="+row.idSign+"&mparams=您的参数，多个参数以逗号隔开&page=您的页码&limit=每页显示数量";
                        }else if(row.sqlType=="5"){
                            return "../webresources/normal/CommonInterfConfig/interf?id="+row.idSign+"&mparams=您的参数，多个参数以逗号隔开&outindexs=返回参数位置索引，从0开始计数，多个参数以逗号隔开";
                        }else{
                            return "../webresources/normal/CommonInterfConfig/interf?id="+row.idSign+"&mparams=您的参数，多个参数以逗号隔开";
                        }
                        },
                        
                        sortable: true
                    }

                ]]});
        $("#CommonInterfConfigDatagrid1471913717478").datagrid("hdGetColumnNames");
    });


</script>
