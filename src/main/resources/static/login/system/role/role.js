
var roleId = '';
var dg = $("#AuthRoleDatagrid1420351793293");
var ttree = $('#tenantRoleTree');
var rtree = $('#resourseTree');
var level = 0;
var builder = new HdEzuiQueryParamsBuilder();
builder.setOrderByClause("sorter", "asc");//传入orde
var queryValue = "";
var ttt = '1';

//当树正在加载时禁用datagrid,防止多次点击@Author zhangdh
function MaskIt(obj) {
 　　   var hoverdiv = '<div class="divMask" style="position: absolute; width: 100%; height: 100%; left: 0px; top: 0px;  opacity: 0; filter: alpha(opacity=0);z-index:5;"></div>';
    $(obj).wrap('<div class="position:relative;"></div>');
 　　   $(obj).before(hoverdiv);
 　　   $(obj).data("mask",true);
}
//树加载完成后启用datagrid@Author zhangdh
function UnMaskIt(obj) {
 　　 if($(obj).data("mask")==true) {
 　　　　     $(obj).parent().find(".divMask").remove();
 　　　　     $(obj).unwrap();
 　　　　     $(obj).data("mask",false);
    }
    $(obj).data("mask",false);
}

function expand3(node, level) {
    var childrens = ttree.tree('getChildren', node.target);
    if (childrens.length > 0) {
        level = level + 1;
        for (var i = 0; i < childrens.length; i++) {
            var temp = childrens[i];

            var flag = ttree.tree('isLeaf', temp.target);
            if (!flag) {
                if (level < 3) {
                    ttree.tree('expand', temp.target);
                } else {
                    ttree.tree('collapse', temp.target);
                }
                level = expand3(childrens[i], level);
            }
        }
    }
    return level;
}

//展开节点到第二层
function collapsenode(node) {
	if(node.children!=null&&node.children.length>0) {
		var childrens = rtree.tree('getChildren', node.target);
	    if (node.level < 2) {
	    	rtree.tree('expand', node.target);
	        for (var i = 0; i < childrens.length; i++) {
	            collapsenode(childrens[i]);
	        }
	    }
	}
}

$(document).ready(function() {
	$.i18n.properties({
        name: 'role', //资源文件名称
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
	
	

    // buttons
    // 增加。
    $("#AuthRoleToolBar1420351793293 a[iconCls='icon-add']").on("click", function() {
        if ($('#tenantRoleTree').tree("getSelected") == undefined) {
            HdUtils.messager.info('请选择一个租户');
            return;
        }
        if ($('#tenantRoleTree').tree("getSelected").id == '0') {
            HdUtils.messager.info('不能在该节点下增加角色!');
            return;
        }
        var tenantId = $('#tenantRoleTree').tree("getSelected").tenantId;
        row = {tenantId: tenantId};
        $("#AuthRoleDatagrid1420351793293").datagrid("hdAdd", row);
    });
    // 编辑。
    $("#AuthRoleToolBar1420351793293 a[iconCls='icon-edit']").on("click", function() {
    	$("#AuthRoleDatagrid1420351793293").datagrid("hdEdit");
    });
    // 删除。
    $("#AuthRoleToolBar1420351793293 a[iconCls='icon-remove']").on("click", function() {
        $.ajax({
            url: '../webresources/login/AuthRole/checkRoleResourse/' + roleId,
            method: 'GET',
            dataType: 'json',
            contentType: "application/json",
            success: function(data) {
            	if (data == true) {
                    HdUtils.messager.info('该角色已被用户授权，无法删除!');
                } else {
                	$("#AuthRoleDatagrid1420351793293").datagrid("hdRealRemove",{url: "../webresources/login/AuthRole/save"});

                }
            }
        });

    });
    // 保存。
    $("#AuthRoleToolBar1420351793293 a[iconCls='icon-save']").on("click", function() {
    	$("#AuthRoleDatagrid1420351793293").datagrid("hdSave", {url: "../webresources/login/AuthRole/save"});
        // rtree.tree({url: '../webresources/login/VjPrivilegeResource/normal/PrivillegeResources/findResourcesForTree?roleId=' + roleId + "&t=" + Math.random()});
    });

    // 刷新。
    $("#AuthRoleToolBar1420351793293 a[iconCls='icon-reload']").on("click", function() {
    	$("#AuthRoleDatagrid1420351793293").datagrid("hdReload");
    });
    builder.setOrderByClause("sorter", "asc");//传入orde
    // searchbox
    $("#AuthRoleSearchbox1420351793293").searchbox({prompt: "请输入...", searcher: function(value, name) {
            builder.set("q", value);
            builder.setOrderByClause("sorter", "asc");//传入orde
            builder.set("queryColumns", "name");
            $("#AuthRoleDatagrid1420351793293").datagrid("hdReload");
        }});
    // datagrid
    $("#AuthRoleDatagrid1420351793293").datagrid({
        	striped:true,
        url: "../webresources/login/AuthRole/find",
        //url: "",
        queryParams: builder.build(),
        method: "post",
        pagination: true,
        singleSelect: true,
        rownumbers: true,
        autoLoad:false,
        pageSize: 20,
        sortName:'sorter',
        sortOrder:'asc',
        toolbar: "#AuthRoleToolBar1420351793293",
        fit: true,
        fitColumns: false,
        onSelect: function(rowIndex, rowData)
        {
            roleId = rowData.roleId;
            if (rowData.roleId != null && rowData.roleId != undefined) {
                rtree.tree({url: '../webresources/login/VjPrivilegeResource/normal/PrivillegeResources/findResourcesForTree?roleId=' + roleId + "&t=" + Math.random()});
            }
        },
        columns: [[
				{
				    field: "ck",
				    checkbox: true
				},
                {
                    field: "roleId",
                    title: "标识",
                    multiSort: true,
                    halign: "center",
                    // editor: {type: "validatebox", options: {required: false}},
                    sortable: true,
                    hidden: true
                },
                {
                    field: "tenantId",
                    title: "租户",
                    multiSort: true,
                    halign: "center",
                    sortable: false,
                    hidden: true,
                }, {
                    field: "tenantName",
                    title: "集团",
                    multiSort: true,
                    halign: "center",
                    width:160,
                    sortable: false
                },
//                {
//                    field: "parentId",
//                    title: "父标识",
//                    multiSort: true,
//                    halign: "center",
//                    editor: {type: "validatebox", options: {required: false}},
//                    sortable: true
                //                },
                {
                    field: "name",
                    title:$.i18n.prop("name"),
                    multiSort: true,
                    halign: "center",
                    width:120,
                    editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "description",
                    title: $.i18n.prop("description"),
                    multiSort: true,
                    halign: "center",
                    width:200,
                    editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "isAdmin",
                    title: $.i18n.prop("isAdmin"),
                    multiSort: true,
                    halign: "center",
                    align: "center",
                    sortable: true,
                    width:50,
                    formatter:$.hd.ezui.formatter.checkbox2,
                    editor:$.hd.ezui.editor.checkbox
                },
                {
                    field: "sorter",
                    title: "排序",
                    multiSort: true,
                    halign: "center",
                    align: "center",
                    width:50,
                    formatter: function(value) {
                        return HdUtils.formatter.precisionCommon(value, 0);
                    },
                    editor: {type: "numberbox", options: {required: false, precision: 0, max: 9999999999.999, groupSeparator: ','}},
                    sortable: true
                },
                {
                    field: "insAccount",
                    title: $.i18n.prop("insAccount"),
                    multiSort: true,
                    halign: "center",
                    width:60,
                    // editor: {type: "validatebox", options: {required: false}},
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
                    //editor: {type: "datetimebox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "updAccount",
                    title: $.i18n.prop("updAccount"),
                    multiSort: true,
                    halign: "center",
                    width:60,
                    //  editor: {type: "validatebox", options: {required: false}},
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
                    //  editor: {type: "datetimebox", options: {required: false}},
                    sortable: true
                }
            ]]});
    $("#AuthRoleDatagrid1420351793293").datagrid("hdGetColumnNames");
    ttree.tree({
        url: '../webresources/login/authTenant/getAllTree',
        method: 'get',
        // animate: true,
        // loadFilter: treeLoadFilter,
        onBeforeLoad: function(node, param) {
            bloading = true;
        },
        onLoadSuccess: function(node, data) {
            bloading = false;
            //var data1 = ttree.tree("getRoot");
            var data1 = $('#tenantRoleTree').tree("getRoots");
            expand3(data1, 1);

        }, onClick: function(node) {
//            queryValue = $("#AuthRoleSearchbox1420351793293").searchbox('getValue');
//            builder.set("q", queryValue);
        	builder = new HdEzuiQueryParamsBuilder();
           	//builder.setAndClause("orgnId", node.tenantId+"%", "like", "AND");
            builder.setAndClause("tenantId_tenantId", node.tenantId, "=", "AND");
            var queryParams = builder.build();
            $('#AuthRoleDatagrid1420351793293').datagrid({
                queryParams: queryParams
            });
        }
    });
    rtree.tree({
       // url: '../webresources/login/VjPrivilegeResource/getAllTree'+ "?s=" + Math.random(),
    	url: '../webresources/login/VjPrivilegeResource/getAllTreeWithLevel'+ "?s=" + Math.random(),
        method: 'get',
        animate: true,
        checkbox: true,
        onBeforeLoad: function(node, param) {
            bloading = true;
            document.getElementById("bgMask20170811zhangdh").style.display ="block";
            document.getElementById("showMask20170811zhangdh").style.display ="block";
            // $.messager.progress({  title : "请等待",text : "加载中..." }); 
            MaskIt($('#AuthRoleToolBar1420351793293'));
        },
        onLoadSuccess: function(node, data) {
        	//$.messager.progress('close');
        	UnMaskIt($('#AuthRoleToolBar1420351793293'));
        	document.getElementById("bgMask20170811zhangdh").style.display ='none';
            document.getElementById("showMask20170811zhangdh").style.display ='none';
            bloading = false;
            rtree.tree("collapseAll");
            var data1 = rtree.tree("getRoots");
            for (var i = 0; i < data1.length; i++) {
                collapsenode(data1[i]);
            }
        },
        onCheck: function(node, checked) {
        }
    });

});

