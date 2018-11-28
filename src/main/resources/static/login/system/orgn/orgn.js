
$(document).ready(function() {
        $.i18n.properties({
        name: 'orgn', //资源文件名称
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
    var dg = $("#AuthOrgnDatagrid1421220911777"); 
    var orgn_selected_tree_id = null;
    var orgn_selected_grid_id = null;
    var orgn_selected_column = null;
    
    $('#orgnTree').tree({
          method: "get",
          url: "../webresources/login/TenantOrgn/vj/myFindAllForTree?s="+Math.random(),    
          loadFilter: MyLoadFilter,    
        }); 
        function MyLoadFilter(data, parent) {
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
                 if (node.type==='TENANT') {
                    node.iconCls = "hd-orgtree-folder";
                } else if (node.type==='ORGN') {
                    node.iconCls = "hd-orgtree-file";
                }
                if (node.id == undefined) {
                    node.id = '_node_' + (serno++);
                }
                if(node.level<3){
                  if (node.children) {
                    node.children1 = node.children;
                    todo = todo.concat(node.children1);
                }   
                }else{
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
        orgn_selected_tree_id=node.id;
        var tbuilder = new HdEzuiQueryParamsBuilder();
            if ("TENANT" == node.type) {
                if(node.id==0){
                   $("#AuthOrgnToolBar1421220911777 a[iconCls='icon-add']").linkbutton('disable');
                }else{
                   $("#AuthOrgnToolBar1421220911777 a[iconCls='icon-add']").linkbutton('enable'); 
                   }
                tbuilder.setAndClause("tenantId.tenantId", node.tenantId, "=", "AND");
                orgn_selected_grid_id=node.tenantId;
                orgn_selected_column="tenantId.tenantId";
            } else {
                tbuilder.setAndClause("parentId", node.orgnId, "=", "AND");
                orgn_selected_grid_id=node.orgnId;
                orgn_selected_column="parentId";
            }
             var queryValue = $("#AuthOrgnSearchbox1421220911777").searchbox('getValue');
             if(queryValue!==null||queryValue!==''){ tbuilder.set("q", queryValue);}
//          builder.set("queryColumns","text");
            $('#AuthOrgnDatagrid1421220911777').datagrid({
                url:"../webresources/login/AuthOrgn/find",
                queryParams: tbuilder.build()
            });
        };
        opts.onLoadSuccess = function (node) {
            if (orgn_selected_tree_id != null)
            {
                var node = $('#orgnTree').tree('find', orgn_selected_tree_id);

                $('#orgnTree').tree('select', node.target);
                var builder = new HdEzuiQueryParamsBuilder();
                if ("TENANT" == node.type) {
                    builder.setAndClause("tenantId.tenantId", node.tenantId, "=", "AND");
                } else {
                    builder.setAndClause("parentId", node.orgnId, "=", "AND");
                }
                var queryValue = $("#AuthOrgnSearchbox1421220911777").searchbox('getValue');
                builder.set("q", queryValue);
//          builder.set("queryColumns","text");
                $('#AuthOrgnDatagrid1421220911777').datagrid({
                    url: "../webresources/login/AuthOrgn/find",
                    queryParams: builder.build()
                });
            }

        }
        return data;
    }
    // buttons
    // 增加。
    $("#AuthOrgnToolBar1421220911777 a[iconCls='icon-add']").on("click", function() {
        if ($('#orgnTree').tree("getSelected") == undefined) {
            HdUtils.messager.info("请选择一个租户或者组织！");
            return;
        }
       var tid = $('#orgnTree').tree("getSelected").tenantId;
        if($('#orgnTree').tree("getSelected").id==0){
            return;
        }
       if ("ORGN" == $('#orgnTree').tree("getSelected").type) {
           var pid=$('#orgnTree').tree("getSelected").orgnId;
              row={parentId:pid,tenantId:tid};
            }else{
              row={tenantId:tid,parentId:tid};  
            }  
        dg.datagrid("hdAdd",row);
        $('#orgnTree').tree('options')
    });
         
    // 编辑。
    $("#AuthOrgnToolBar1421220911777 a[iconCls='icon-edit']").on("click", function() {
        dg.datagrid("hdEdit");
    });
    // 删除。
    $("#AuthOrgnToolBar1421220911777 a[iconCls='icon-remove']").on("click", function() {
        var deleteData=dg.datagrid("getSelected");
        if(deleteData==undefined){
         HdUtils.messager.info("请选择一个组织！");
         return;   
        }
        $.ajax({
                type: "GET",
                url: "../webresources/login/AuthOrgn/checkDeleteOrgn?t=" + Math.random(),
                contentType: "application/json",
                dataType: "json",
                data: {orgnId : deleteData.orgnId},
                success: function(data) {
                	dg.datagrid("hdRemove", {url: "../webresources/login/AuthOrgn/save"});
                },
                error: function(data) {
                    HdUtils.messager.info('该组织存在以下关联：<br/><font color="red">'+data.responseText+'</font><br/>请解除关联后再进行删除操作！');
                }
            });
    });
    // 保存。
    $("#AuthOrgnToolBar1421220911777 a[iconCls='icon-save']").on("click", function() {
    	   dg.datagrid("hdSave", {url: "../webresources/login/AuthOrgn/save", 
//    		   callback: function() {
//               $('#orgnTree').tree({url: "../webresources/login/TenantOrgn/vj/myFindAllForTree?s="+Math.random()});
//           }
    	   });
    });
    // 刷新。
    $("#AuthOrgnToolBar1421220911777 a[iconCls='icon-reload']").on("click", function() {
        dg.datagrid("hdReload");
    });
// 返回后台参数。
    var builder = new HdEzuiQueryParamsBuilder();
    $("#AuthOrgnSearchbox1421220911777").searchbox({prompt: "请输入...", searcher: function(value, name) {
//            queryParams.q=value;
//            queryParams.queryColumns="text";
            builder.set("q",value);
            builder.set("queryColumns","text,description");
            builder.setAndClause(orgn_selected_column, orgn_selected_grid_id, "=", "AND");
                // buttons
            dg.datagrid({
                queryParams: builder.build()
            });
            //dg.datagrid("hdReload");
        }});
    dg.datagrid({      
//      url: "../webresources/login/AuthOrgn/find",
        queryParams: builder.build(),
        method: "post",
        pagination: true,
        singleSelect: true,
        rownumbers: true,
        pageSize: 30,
        toolbar: "#AuthOrgnToolBar1421220911777",
        fit: true,
        fitColumns: false,
        sortName: 'sorter',
        sortOrder: 'asc',
        columns: [[
				{
				    field: "ck",
				    checkbox: true
				},
                {
                    field: "orgnId",
                    title: '<font color="red">标识</font>',
                    multiSort: true,
                    halign: "center",
                    sortable: true,
                    hidden:true,
                }, {
                    field: "parentId",
                    title: '父标识',
                    multiSort: true,
                    halign: "center",
                    sortable: true,
                    hidden:true,
                },
                {
                    field: "tenantId",
                    title: '租户ID',
                    multiSort: true,
                    halign: "center",                  
                    sortable: true,
                    hidden:true,
                },
                {
                    field: "tenantName",
                    title: '集团',
                    multiSort: true,
                    halign: "center",
                    align: "center",
                    width:120,
                    sortable: false
                },
                {
                    field: "text",
                    title: '部门名称',
                    multiSort: true,
                    align: "center",
                    halign: "center",
                    width:120,
                    editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                {field: "companyCod",
			        title: '所属公司',
			        multiSort: true,
			        halign: "center",
			        align: "center",
			        width:100,
			        editor: {
                        type: 'combogrid',
                        options: HdUtils.code.findVwGroupOrgn({
                            parentId: '#AuthOrgnDatagrid1421220911777',width: 80,
                            fieldMapping: {companyCod: 'companyCod',companyNam: 'companyNam',},
                            required: false
                        })
                    },
                    formatter: function(value,row) {
                    	var str='';
                    	if(value=="GPG"){str= "集团";}
                        if(value=="NCT"){str= "南沙一期";}
                        if(value=="GOCT"){str= "南沙二期";}
                        if(value=="NICT"){str= "南沙三期";}
                        if(value=="GCT"){str= "GCT";}
                        if(value=="HNCT"){str= "河南公司";}
                        if(value=="HPCT"){str= "黄埔公司";}
                        if(value=="SHCT"){str= "穗航码头";}
                        if(value=="GPDT"){str= "数据公司";}
                        if(value=="XSCT"){str= "新沙公司";}
                        if(value=="CCCT"){str= "中交龙沙";}
                    	return str;
                    	
                    },
			        sortable: true
              },
                {
                    field: "description",
//                    title: '描述',
                    title: $.i18n.prop("description"),
                    multiSort: true,
                    halign: "center",
                    width:120,
                    editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "sorter",
//                    title: '排序',
                    title: $.i18n.prop("sorter"),
                    multiSort: true,
                    halign: "center",
                    width:80,
                    formatter: function(value) {
                        return HdUtils.formatter.precisionCommon(value, 0);
                    },
                    editor: {type: "numberbox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "insAccount",
//                    title: "创建人",
                    title: $.i18n.prop("insAccount"),
                    multiSort: true,
                    width:60,
                    halign: "center",
                    sortable: true
                },
                {
                    field: "insTimestamp",
//                    title: "创建日期",
                    title: $.i18n.prop("insTimestamp"),
                    multiSort: true,
                    halign: "center",
                    align: "center",
                    width: 130,
                    formatter: $.hd.ezui.formatter.datetime,
                    sortable: true
                },
                {
                    field: "updAccount",
//                    title: "更新人",
                    title: $.i18n.prop("updAccount"),
                    multiSort: true,
                    width:60,
                    halign: "center",
                    sortable: true
                },
                {
                    field: "updTimestamp",
//                    title: "更新日期",
                    title: $.i18n.prop("updTimestamp"),
                    multiSort: true,
                    halign: "center",
                    align: "center",
                    width: 130,
                    formatter: $.hd.ezui.formatter.datetime,
                    sortable: true
                }
            ]]
    });
});