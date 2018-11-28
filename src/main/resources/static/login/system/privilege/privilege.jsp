<!--
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
-->
<meta charset="UTF-8">
<!-- 权限管理 ws -->
<!-- 工具栏 -->
<div class="easyui-layout" style="width:100%;height:100%;" fit="true">
    <div data-options="region:'west',split:true,tools:[
                {
                    iconCls:'icon-reload',
                    handler:function(){$('#privilege_tree').tree('reload');}
                }]," title="权限树"  style="width:200px;">
        <ul  id="privilege_tree"></ul>
    </div>
    <div data-options="region:'center',split:true" title="权限列表" style="">
        <div id="AuthPrivilegeToolBar1426567235258">
            <div>
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
                </shiro:hasPermission>&nbsp;
            </div>
<!--             <shiro:hasPermission name="webresources:login:AuthPrivilege:find"> -->
<!--                         <input class="easyui-searchbox" id="AuthPrivilegeSearchbox1426567235258"/> -->
<!--              </shiro:hasPermission> -->
			 &nbsp;  
        </div>
        <!-- Datagrid -->
        <table id="AuthPrivilegeDatagrid1426567235258" style="height:100%"></table>
        <!-- end Datagrid -->
        <div id="chart-dlg">
            <div id="chart"></div>
        </div>
        <div id="chart-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
        </div>
    </div>
    <div data-options="region:'east',split:true" title="资源列表" style="width:270px;">
        <div id="privilege_AuthResourceToolBar">
            <div>
                <shiro:hasPermission name="webresources:login:AuthPrivilege:savePrivilegeResource">
                    <a class="easyui-linkbutton" iconCls="icon-add" plain="false"><label name="add">增加</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthPrivilege:deletePrivilegeResource">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="false"><label name="delete">删除</label></a>
                </shiro:hasPermission>
            </div>
        </div>
        <!-- 工具栏 结束 -->
        <!-- Datagrid -->
        <table id="privilege_AuthResourceDatagrid" style="height:100%"></table>
    </div>
</div>
<!-- 脚本控制 -->
<script type="text/javascript">
    var dg1 = null;
    var privilege_selected_tree_id = null;
    var privilege_selected_grid_id = null;
    var privilege_AuthResourceDatagrid = null;
    $(document).ready(function() {
    	$.i18n.properties({
            name: 'privilege', //资源文件名称
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
    	
        var dg = $("#AuthPrivilegeDatagrid1426567235258");
        // buttons
        // 增加。
        $("#AuthPrivilegeToolBar1426567235258 a[iconCls='icon-add']").on("click", function() {
            var node = $('#privilege_tree').tree('getSelected');
            if (node) {
                var s = node.privilegeId;
                row = {parentId: s};
                dg.datagrid("hdAdd", row);
            }
            else {
                HdUtils.messager.info("请先选择权限树节点");
            }
        });
        // 编辑。
        $("#AuthPrivilegeToolBar1426567235258 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
        });
        // 删除。
        $("#AuthPrivilegeToolBar1426567235258 a[iconCls='icon-remove']").on("click", function() {
            var row = $('#AuthPrivilegeDatagrid1426567235258').datagrid('getSelected');
            if (row) {
                $.ajax({
                    type: 'post',
                    url: "../webresources/login/AuthPrivilege/checkDelete",
                    contentType: "application/x-www-form-urlencoded",
                    data: {'privilegeId': row.privilegeId},
                    dataType: 'text',
                    success: function(data) {
                        if (data == "") {
                        	dg.datagrid("hdRealRemove", {url: "../webresources/login/AuthPrivilege/save", callback: function() {
                                $('#privilege_tree').tree('reload');
                                dg.datagrid("reload");
                            }});
                        }
                        else {
                            data = data.replace("000", "资源与该权限已经关联");
                            data = data.replace("001", "用户与该权限已经关联");
                            data = data.replace("002", "角色与该权限已经关联");
                            HdUtils.messager.info(data + ",不能进行删除操作，如要删除请先删除相关联的关系数据！");
                        }
                    }
                });
            }
            else
            {
                HdUtils.messager.info("请选中一行数据！");
            }
        });
        // 保存。
        $("#AuthPrivilegeToolBar1426567235258 a[iconCls='icon-save']").on("click", function() {
        	dg.datagrid("hdIsEndEdit");
            dg.datagrid("hdSave", {url: "../webresources/login/AuthPrivilege/save",});
//             	callback: function() {      
//                    // $('#privilege_tree').tree('reload');
//                     dg.datagrid("reload");
//                     //$("#privilege_tree").tree({url: '../webresources/login/AuthPrivilege/getAllTree?t=' + Math.random(),}),
//                 }
            
        });
        // 刷新。
        $("#AuthPrivilegeToolBar1426567235258 a[iconCls='icon-reload']").on("click", function() {
            dg.datagrid("hdReload");
        });
        // 返回后台参数。
        var builder = new HdEzuiQueryParamsBuilder();
        // searchbox
        $("#AuthPrivilegeSearchbox1426567235258").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "text");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#AuthPrivilegeDatagrid1426567235258").datagrid({
        	striped:true,
            url: "../webresources/login/AuthPrivilege/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#AuthPrivilegeToolBar1426567235258",
            fit: true,
            fitColumns: false,
            autoLoad: false,
            sortName: 'sorter',
            sortOrder: 'asc',
            onSelect: function(rowIndex, rowData) {
                privilege_selected_grid_id = rowData.privilegeId;
                $('#privilege_AuthResourceDatagrid').datagrid('reload', {
                    privilegeId: rowData.privilegeId
                });
            },
            columns: [[
						{
						    field: "ck",
						    checkbox: true
						},
                       {
                        field: "privilegeId",
                        title: '<font color="red">标识</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "parentId",
                        title: "父标识",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "text",
                        title: $.i18n.prop("text"),
                        multiSort: true,
                        halign: "center",
                        width:110,
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "url",
                        title: "URL",
                        multiSort: true,
                        halign: "center",
                        width:350,
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "sorter",
                        title: $.i18n.prop("sorter"),
                        multiSort: true,
                        halign: "center",
                        width:50,
                        formatter: function(value) {
                            return HdUtils.formatter.precisionCommon(value, 0);
                        },
                        editor: {type: "numberbox", options: {required: false, precision: 0, max: 9999999999.999, groupSeparator: ','}},
                        sortable: true
                    },
                    {
                        width: 50,
                        field: "state",
                        title: $.i18n.prop("state"),
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        formatter: function(value) {
                            if ("open" == value) {
                                return "开启";
                            }
                            else if ("closed" == value) {
                                return "关闭";
                            }
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: '开启',
                                        value: 'open'
                                    }, {
                                        label: '关闭',
                                        value: 'closed'
                                    }],
                                required: true
                            }},
                        sortable: true
                    },
                    {
                        width: 80,
                        field: "openType",
                        title: $.i18n.prop("open"),
                        multiSort: true,
                        halign: "center",
                        formatter: function(value) {
                            if ("1" == value) {
                                return "iframe";
                            }
                            else if ("0" == value) {
                                return "tab";
                            }
                            else if ("2" == value) {
                                return "window";
                            }
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: 'iframe',
                                        value: '1'
                                    }, {
                                        label: 'tab',
                                        value: '0'
                                    }, {
                                        label: 'windwow',
                                        value: '2'
                                    }],
                                required: true
                            }},
                        sortable: true
                    },
                    {
                        field: "iconCls",
                        title: $.i18n.prop("iconCls"),
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: $.i18n.prop("insAccount"),
                        multiSort: true,
                        halign: "center",
                        width: 60,
                        //  editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: $.i18n.prop("insTimestamp"),
                        multiSort: true,
                        halign: "center",
                        formatter: function(value) {
                            if (value != null && value != undefined) {
                                return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                            } else {
                                return value;
                            }
                        },
                        width: 130,
                        //  editor: {type: "datetimebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: $.i18n.prop("updAccount"),
                        multiSort: true,
                        halign: "center",
                        width: 60,
                        // editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: $.i18n.prop("updTimestamp"),
                        multiSort: true,
                        halign: "center",
                        formatter: function(value) {
                            if (value != null && value != undefined) {
                                return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                            } else {
                                return value;
                            }
                        },
                        width: 130,
                        // editor: {type: "datetimebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "description",
                        title: $.i18n.prop("description"),
                        multiSort: true,
                        halign: "center",
                        width: 200,
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    }
                ]]});
        
        $("#privilege_tree").tree({
            url: '../webresources/login/AuthPrivilege/getAllTree?t=' + Math.random(),
            method: 'get',
            idField: 'privilegeId',
            treeField: 'privilegeId',
            parentField: 'parentId',
//             onBeforeLoad: function(node, param) {
//             	$.messager.progress({title:'请稍候',msg:'数据加载中...'});
//             },
//             onLoadSuccess: function(node, data) {
//                 $.messager.progress('close');
//             },
            onClick: function(node) {
                privilege_selected_tree_id = node.id;
                // 返回后台参数。
               //  var builder11 = new HdEzuiQueryParamsBuilder();
                 var builder11 = new HdEzuiQueryParamsBuilder();
                //if (node.privilegeId != "0") {
                    builder11.setAndClause("parentId", node.privilegeId, "=", "AND");
                //}
                $("#AuthPrivilegeDatagrid1426567235258").datagrid("load",builder11.build());

               // $('#AuthPrivilegeDatagrid1426567235258').datagrid({ queryParams: builder.build()});
                //$("#AuthPrivilegeDatagrid1426567235258").datagrid("load");
                privilege_selected_grid_id = null;
            },
             /* onLoadSuccess: function(node, data) {
                if (privilege_selected_tree_id != null)
                {
                    var node = $('#privilege_tree').tree('find', privilege_selected_tree_id);
                    $('#privilege_tree').tree('select', node.target);
                    builder = new HdEzuiQueryParamsBuilder();
                    builder.setAndClause("parentId", node.privilegeId, "=", "AND");
                    var queryParams = builder.build();
                    $('#AuthPrivilegeDatagrid1426567235258').datagrid({
                        queryParams: queryParams
                    });
                    privilege_selected_grid_id = null;
                }

            }  */
        });
        dg1 = $("#AuthResourceDatagrid1426483003737");
        // buttons
        // 增加。
        $("#privilege_AuthResourceToolBar a[iconCls='icon-add']").on("click", function() {
            if (privilege_selected_grid_id == null || privilege_selected_grid_id == '') {
                HdUtils.messager.info("请选择一条权限记录！");
                return;
            }
            HdUtils.dialog.show({title: "资源选择", href: "../login/system/resource/resourceSelect.jsp", width: 700, height: 500, isSaveHandler: true});
            HdUtils.dialog.setValue({saveHandler: function() {
                    var row = resourceSelect_dg.datagrid('getSelections');
                    if (row == undefined) {
                        return;
                    }
                    var ids = "";
                    $(row).each(function() {
                        ids += this.RESOURCE_ID + ",";
                    });
                    $.ajax({
                        type: 'post',
                        url: "../webresources/login/AuthPrivilege/savePrivilegeResource",
                        contentType: "application/x-www-form-urlencoded",
                        data: {'privilegeId': privilege_selected_grid_id, 'ids': ids},
                        success: function(data) {
                            $('#privilege_AuthResourceDatagrid').datagrid('reload', {
                                privilegeId: privilege_selected_grid_id
                            });
                            $('#resourceSelect_AuthResourceDatagrid').datagrid('reload');
                        }
                    });
                }});
            
        });
        // 删除。
        $("#privilege_AuthResourceToolBar a[iconCls='icon-remove']").on("click", function() {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/AuthPrivilege/save"});
        	//张艳明改
//             var row = privilege_AuthResourceDatagrid.datagrid('getSelections');
//             if (row.length < 1) {
//                 HdUtils.messager.info("请选择一条资源记录！");
//                 return;
//             }
//             var ids = "";
//             $(row).each(function() {
//                 ids += this.RESOURCE_ID + ",";
//             });
//             $.messager.confirm(Resources.WB_CONFIRM, "确定删除该权限？", function(r) {
//                 if (r) {
//                     $.ajax({
//                         type: 'post',
//                         url: "../webresources/login/AuthPrivilege/deletePrivilegeResource",
//                         contentType: "application/x-www-form-urlencoded",
//                         data: {'privilegeId': privilege_selected_grid_id, 'ids': ids},
//                         success: function(data) {
//                             $('#privilege_AuthResourceDatagrid').datagrid('reload', {
//                                 privilegeId: privilege_selected_grid_id
//                             });
//                         }
//                     });
//                 }
//             });
        });
        // datagrid
        privilege_AuthResourceDatagrid = $("#privilege_AuthResourceDatagrid").datagrid({
        	striped:true,
            url: "../webresources/login/AuthPrivilege/getByPrivilegeId",
            method: "get",
            pagination: false,
            singleSelect: true,
            rownumbers: true,
            autoLoad: false,
            pageSize: 10000,
            toolbar: "#privilege_AuthResourceToolBar",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "PERMISSIONS",
                        title: $.i18n.prop("PERMISSIONS"),
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "RESOURCE_ID",
                        title: '<font color="red">标识</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        width: 80,
                        field: "DTYPE",
                        title: $.i18n.prop("DTYPE"),
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
                        title: $.i18n.prop("NAME"),
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "RESOURCE",
                        title: $.i18n.prop("RESOURCE"),
                        multiSort: true,
                        halign: "center",
                        hidden: false,
                        sortable: true
                    },
                    {
                        field: "DESCRIPTION",
                        title: $.i18n.prop("DESCRIPTION"),
                        multiSort: true,
                        halign: "center",
                        hidden: false,
                        sortable: true
                    }
                ]]});
    });
</script>
