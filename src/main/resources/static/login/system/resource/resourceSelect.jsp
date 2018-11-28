
<!--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
__>
<meta charset="UTF-8">
<!--资源选择调用 ws-->
<!-- 工具栏 -->
<div id="resourceSelectAuthResourceToolBar" >
        <!-- 查询 -->
            查询条件：<input class="easyui-searchbox" id="resourceSelect_AuthResourceSearchbox"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="resourceSelect_AuthResourceDatagrid" ></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    var resourceSelect_dg;
    $(document).ready(function() {

        $.i18n.properties({
            name: 'tenant', //资源文件名称
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
        
        
        resourceSelect_dg = $("#resourceSelect_AuthResourceDatagrid");
        // 条件类。
        var hdConditions = new HdConditions();

        // 返回后台参数。
        var queryParams = {
            hdConditions: hdConditions.getHdConditions(),
            queryColumns: {}
        };
                // 返回后台参数。
        var builder = new HdEzuiQueryParamsBuilder();
        // searchbox
        $("#resourceSelect_AuthResourceSearchbox").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "PERMISSIONS,NAME,DTYPE,RESOURCE_TYP,DESCRIPTION");
                $("#resourceSelect_AuthResourceDatagrid").datagrid("reload");
            }});
        // datagrid
        resourceSelect_dg = $("#resourceSelect_AuthResourceDatagrid").datagrid({
        	striped:true,
            url: "../webresources/login/AuthResource/resourcesSelect/" + privilege_selected_grid_id,
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: false,
            autoLoad:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#resourceSelectAuthResourceToolBar",
            fit: true,
            fitColumns: false,
            columns: [[
                    {field: 'RESOURCE_ID', title: 'RESOURCE_ID', checkbox: true},
                    {
                        field: "PERMISSIONS",
                        title: "编码",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        width: 80,
                        field: "DTYPE",
                        title: '<font color="red">类型</font>',
                        multiSort: true,
                        halign: "center",
                        formatter: function(value) {
                            if ("0" == value) {
                                return "资源";
                            }
                            else if ("1" == value) {
                                return "按钮";
                            }
                            else if ("2" == value) {
                                return "元素";
                            }
                            // return HdUtils.formatter.precisionCommon(value,0);  
                        },
                        sortable: true
                    },
                    {
                        field: "NAME",
                        title: "名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "RESOURCE_TYP",
                        title: "资源描述",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "DESCRIPTION",
                        title: "详细描述",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                ]]});
        $("#resourceSelect_AuthResourceDatagrid").datagrid("hdGetColumnNames");
    });
</script>
