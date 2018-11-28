<meta charset="UTF-8">
<!--<script>
    var langu = $('#lang').combobox('getValue');
    if ('en' == langu) {
        $.getScript('../js/locale/easyui-lang-en.js', function() {
            changeLang();
        });
    } else {
        $.getScript('../js/locale/easyui-lang-zh_CN.js', function() {
            changeLang();
        });
    }
</script>-->

<script>
    var authTenantId = '';
    var id = '';
    var tenant_selected_tree_id="";
    function myLoadFilter(data, parent) {
//        data = eval(data);//转换为json对象 
        var state = $.data(this, 'tree');
        function setData() {
            var serno = 1;
            var todo = [];
            for (var i = 0; i < data.length; i++) {
                todo.push(data[i]);
            }
            while (todo.length) {
                var node = todo.shift();
                if (node.id == undefined) {
                    node.id = '_node_' + (serno++);
                }
               
                if (node.children) {
                    node.iconCls = "hd-orgtree-folder";
                } else {
                    node.iconCls = 'hd-orgtree-file';
                }
                if (node.level < 3) {  
                    if (node.children) {
                        node.children1 = node.children;
                        todo = todo.concat(node.children1);  
                    }
                } else {
                    if (node.children) {
                        node.state = 'closed';
                        node.children1 = node.children;
                        node.children = undefined;
                        todo = todo.concat(node.children1);
                    }
                }
            }
            state.tdata = data;
        }
        function find(id) {
            var data = state.tdata;

            var cc = [data];
            while (cc.length) {
                var c = cc.shift();
                for (var i = 0; i < c.length; i++) {
                    var node = c[i];
                    if (node.id == id) {
                        return node;
                    } else if (node.children1) {
                        cc.push(node.children1);
                    }
                }
            }
            return null;
        }
        setData();
        var t = $(this);
        var opts = t.tree('options');
        opts.onBeforeExpand = function (node) {
            var n = find(node.id);
            if (n.children && n.children.length) {
                return
            }
            if (n.children1) {
                var filter = opts.loadFilter;
                opts.loadFilter = function (data) {
                    return data;
                };
                t.tree('append', {
                    parent: node.target,
                    data: n.children1
                });
                opts.loadFilter = filter;
                n.children = n.children1;
            }

        };
        opts.onClick = function (node) {
            authTenantId = node.tenantId;
            id = node.id;
            var builder = new HdEzuiQueryParamsBuilder();
            if(node.id==0){
                   $("#AuthTenantToolBar1420351793293 a[iconCls='icon-add']").linkbutton('disable');
                   //builder.setAndClause("top", node.tenantId, "=", "AND");
                }else{
                   $("#AuthTenantToolBar1420351793293 a[iconCls='icon-add']").linkbutton('enable'); 
                   }
            
            builder.setAndClause("parentId", node.tenantId, "=", "AND");
            var queryValue = $("#AuthTenantSearchbox1420351793293").searchbox('getValue');
            builder.set("q", queryValue);
            var queryParams = builder.build();
            $('#AuthTenantDatagrid1420351793293').datagrid({
                url: "/webresources/login/authTenant/find",
                queryParams: queryParams
            });

            // $('#AuthTenantDatagrid1420351793293').datagrid({queryParams: {pid: node.tenantId}});
        };
        opts.onLoadSuccess = function (node) {
            if (tenant_selected_tree_id != null&&tenant_selected_tree_id!="")
            {
                var node = $('#tenantTree').tree('find', tenant_selected_tree_id);
                $('#tenantTree').tree('select', node.target);
                var builder = new HdEzuiQueryParamsBuilder();
                builder.setAndClause("parentId", node.tenantId, "=", "AND");
                var queryValue = $("#AuthTenantSearchbox1420351793293").searchbox('getValue');
                builder.set("q", queryValue);
                $('#AuthTenantDatagrid1420351793293').datagrid({
                    url: "/webresources/login/authTenant/find",
                    queryParams: builder.build()
                });
                //tenant_selected_tree_id = null;
            }

        }
        return data;
    }
    $(document).ready(function () {
        
        $.i18n.properties({
            name: 'tenant', //资源文件名称
            path: '../i18n/project/', //资源文件路径
            mode: 'map', //用Map的方式使用资源文件中的值
            language: getBrowserLanguage(),
//            language: "en",
            callback: function () {//加载成功后设置显示内容
                $("label").each(function (i) {
                    $(this).html($.i18n.prop($(this).attr("name")));
                });
            }
        });
        
         $('#tenantTree').tree({
          method: "get",
          url: "../webresources/login/authTenant/getAllTree?s="+Math.random(),    
          loadFilter: myLoadFilter    
        }); 
        var tenant_selected_tree_id = null;
        var dg = $("#AuthTenantDatagrid1420351793293");
        // buttons
        // 增加。
        $("#AuthTenantToolBar1420351793293 a[iconCls='icon-add']").on("click", function () {
            if (id === 0) {
                //$("#AuthTenantToolBar1420351793293 a[iconCls='icon-add']").hide();
                return;
            } else {
                //$("#AuthTenantToolBar1420351793293 a[iconCls='icon-add']").show();
                if ($('#tenantTree').tree("getSelected") == undefined) {
                    HdUtils.messager.info("请选择一个租户");
                    return;
                }
                var tid = $('#tenantTree').tree("getSelected").tenantId;
                row = {parentId: tid};
                dg.datagrid("hdAdd", row);
            }
        });
     // 编辑。
        $("#AuthTenantToolBar1420351793293 a[iconCls='icon-edit']").on("click", function () {
            dg.datagrid("hdEdit");
        });
     // 删除。
        $("#AuthTenantToolBar1420351793293 a[iconCls='icon-remove']").on("click", function () {
            var data = dg.datagrid("getSelected");
            if (data===null||data===undefined) {
                HdUtils.messager.info('请选择一个租户进行删除！');
                return;
            }
            $.ajax({
                type: "GET",
                url: "../webresources/login/authTenant/validateDelete?t=" + Math.random(),
                contentType: "application/json",
                dataType: "json",
                async:false,
                data: {tenantId : data.tenantId},
                success: function(data) {
                    dg.datagrid("hdRemove");
                    /* dg.datagrid("hdRealRemove", {url: "../webresources/login/authTenant/save", callback: function () {
                        $('#tenantTree').tree({url: '../webresources/login/authTenant/getAllTree?s='+Math.random()});
                    }}); */
                    //$('#tenantTree').tree({url: '../webresources/login/authTenant/getAllTree'});
                },
                error: function(data) {
                    HdUtils.messager.info('该租户存在以下关联：<br/><font color="red">'+data.responseText+'</font><br/>è¯·è§£é¤å³èååè¿è¡å é¤æä½ï¼');
                }
            });
        });
     // 保存。
        $("#AuthTenantToolBar1420351793293 a[iconCls='icon-save']").on("click", function () {
        	var dgRows = dg.datagrid("getRows");
        	for(var i=0;i<dgRows.length;i++) {
        		dg.datagrid("endEdit",i);
        		
        	}
        	var changes = dg.datagrid("getChanges");
        	dg.datagrid("hdSave", {url: "../webresources/login/authTenant/save", callback: function () {
                    $('#tenantTree').tree({url: '../webresources/login/authTenant/getAllTree?s='+Math.random()});
                }});

        });
     // 刷新。
        $("#AuthTenantToolBar1420351793293 a[iconCls='icon-reload']").on("click", function () {
            dg.datagrid("hdReload");
        });
        //hdConditions.setAndClause("parentId","-1", "=", "AND");
        // 返回后台参数。
        var builder = new HdEzuiQueryParamsBuilder();
        // searchbox
        $("#AuthTenantSearchbox1420351793293").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "text,phone,address");
                builder.setAndClause("parentId", authTenantId, "=", "AND");
                $('#AuthTenantDatagrid1420351793293').datagrid({
                    queryParams: builder.build()
                });
                //dg.datagrid("hdReload");
            }});
        // datagrid
        dg.datagrid({
            //url: "/webresources/login/authTenant/findAll",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#AuthTenantToolBar1420351793293",
            fit: true,
            fitColumns: false,
            frozenColumns:[[   
                     {
                        field: "tenantId",
                        title: '<font color="red">租户标识</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "parentId",
                        title: "父ID",
                        multiSort: true,
                        halign: "center",
//                    editor: {type: "validatebox", options: {required: false}},
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "text",
                        title: "集团名称",

                        //title: $.i18n.prop("text"),
                        multiSort: true,
                        halign: "center",
                        width: 160,
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    }
                    
            ]],
            columns: [[
					{
					    field: "tenantTypName",
					    title: "租户类型Id",
					    multiSort: true,
					    align: "center",
					    sortable: true,
					    width: 100,
					    hidden:true
					},
					{
					    field: "tenantTypId",
					//    title: "租户类型",
					    title: '公司类型',
					    multiSort: true,
					    align: "center",
					    sortable: true,
					    width: 140,
					    editor: 
					    {
					        type:"combogrid",
					        options: HdUtils.code.tenantTyp({
					            required: true,
					            parentId: $("#AuthTenantDatagrid1420351793293"),
					            fieldMapping:{tenantTypId:"TENANT_TYP_ID",tenantTypName:"TENANT_TYP_NAM"}
					        })
					    } ,
					    formatter: function (value, row, index) {
							return row.tenantTypName;
					    } 
					} ,
                    /* {
                        field: "tenantTypName",
//                        title: "租户类型",
                        title: $.i18n.prop("tenantTypName"),
                        multiSort: true,
                        align: "center",
                        sortable: true,
                        width: 100,
                        editor: 
                        {
                            type:"combogrid",
                            options: HdUtils.code.tenantTyp({
                                required: true,
                                parentId: $("#AuthTenantDatagrid1420351793293"),
                                fieldMapping:{tenantTypId:"TENANT_TYP_ID",tenantTypName:"TENANT_TYP_NAM"}
                            })
                        },
                        formatter: function (value, row, index) {
                    		return value;
                        }
                    } , */
                    {
                        field: "phone",
//                        title: "电话号码",
                        title: $.i18n.prop("phone"),
                        multiSort: true,
                        halign: "center",
                        width: 120,
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "address",
//                        title: "地址",
                        title: $.i18n.prop("address"),
                        multiSort: true,
                        halign: "center",
                        width: 160,
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
//                        title: "创建人",
                        title: $.i18n.prop("insAccount"),
                        multiSort: true,
                        halign: "center",
                        width: 60,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
//                      title: "创建日期",
                        title: $.i18n.prop("insTimestamp"),
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        width: 130,
                        sortable: true
                    },
                    {
                        field: "updAccount",
//                        title: "更新人",
                        title: $.i18n.prop("updAccount"),
                        multiSort: true,
                        halign: "center",
                        width: 60,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
//                        title: "更新日期",
                        title: $.i18n.prop("updTimestamp"),
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        width: 130,
                        sortable: true
                    }
                ]]
        });
        dg.datagrid("hdGetColumnNames");
        //dg.datagrid("columnMoving");
    }

    );

</script>
<div class="easyui-layout" data-options="fit:true" style="height:100%;width:100%">
    <div data-options="region:'west',split:true,title:'集团'"
         style="width:280px;padding:10px;">
        <ul  id="tenantTree" class="easyui-tree"></ul>
    </div>
    <div  data-options="region:'center',title:''">
        <div id="AuthTenantToolBar1420351793293">
            <div style="float:left;">             
                
                   
                <!-- 查询结束 -->
                <!-- 标准按钮 -->
                <!-- 如果存在 查询条件，请开启--><!--<span style="float:right">-->
               <shiro:hasPermission name="webresources:login:authTenant:add">
                    <a class="easyui-linkbutton" iconCls="icon-add" plain="false"><label name="add">增加 </label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:authTenant:update">
                    <a class="easyui-linkbutton" iconCls="icon-edit" plain="false"><label name="edit">编辑</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:authTenant:delete">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="false"><label name="delete">删除</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:authTenant:save">
                    <a class="easyui-linkbutton" iconCls="icon-save" plain="false"><label name="save">保存</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:authTenant:refresh">
                    <a class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="reload">刷新</label></a>
                </shiro:hasPermission>&nbsp;
                <!-- 如果存在 查询条件，请开启--><!--</span>-->
                <!-- 标准按钮 结束-->
            </div>
             <input class="easyui-searchbox" id="AuthTenantSearchbox1420351793293"/>
        </div>
        <table id="AuthTenantDatagrid1420351793293" style="height:100%"></table>
    </div>
</div>
