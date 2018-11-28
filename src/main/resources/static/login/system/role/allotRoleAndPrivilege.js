
var roleId = '';
var userId = '';
//var ptree = $('#privilegeTree');
var bloading;
var dg = $("#RoleDatagrid");
var rptree = $('#resoursePTree');
var usertree = $('#usrTree');
function showDetail(roleId) {
	HdUtils.dialog.setValue({roleId:roleId,userId:userId});
    HdUtils.dialog.show({title: "角色与功能资源详细信息", href: "../login/system/role/roleTree.jsp", width: 290, height: 605, isSaveHandler: false});

}
function saveGroupRoleUser(checked, roleId, userId, node) {
	if (checked)
    {
        // save
        $.ajax({
            url: '../webresources/login/AuthRole/addRoleUser/' + roleId + '/' + userId,
            method: 'GET',
            dataType: 'json',
            contentType: "application/json",
            data: $.toJSON({deletedRows: [], updatedRows: [], insertedRows: []}),
            success: function(data) {
                //ptree.tree('reload');
            }
        });
    }
    else
    {
        // delete
        $.ajax({
            url: '../webresources/login/AuthRole/removeRoleUser/' + roleId + '/' + userId,
            method: 'GET',
            dataType: 'json',
            contentType: "application/json",
            data: $.toJSON({deletedRows: [], updatedRows: [], insertedRows: []}),
            success: function(data) {
                //ptree.tree('reload');
            }
        });
    }
}
function collapsenode(node)
{
    var childrens = usertree.tree('getChildren', node.target);
    if (node.level < 3)
    {
    	usertree.tree('expand', node.target);
        for (var i = 0; i < childrens.length; i++)
        {
            collapsenode(childrens[i]);
        }
    }

}
var ztree = $('#resourseTree');
ztree.tree({
    url: '../webresources/login/VjPrivilegeResource/getAllTree',
    method: 'GET',
    checkbox: true,
    onBeforeLoad: function(node, param) {
        bloading = true;
    },
    onLoadSuccess: function(node, data) {
        bloading = false;
    },
    onCheck: function(node, checked) {
        var dgSelected = usertree.tree('getSelected');
        if (dgSelected == null)
        {
            return;
        }
        if (dgSelected.type != "USER")
        {
            HdUtils.messager.info("请选择一个员工！");
            return;
        }

        var rolid = dgSelected.id;
        var privilegeid = node.id;
        // saveSelfPermission(checked, rolid, privilegeid, node);
    }
});
usertree.tree({
    url: '../webresources/login/VjUserTree/getUserTreeWithLevel',
    method: 'GET',
    animate: false,
    onBeforeLoad: function(node, param) {
        bloading = true;
    },
    onLoadSuccess: function(node, data) {
        bloading = false;
        usertree.tree("collapseAll");
        var data1 = usertree.tree("getRoots");

        for (var i = 0; i < data1.length; i++)
        {
            collapsenode(data1[i]);
        }

    },
    onSelect: function(node) {
        if (node.type != "USER")
        {
            HdUtils.messager.info("请选择一个员工！");
            return;
        }
        userId = node.id;
//            ptree.tree({url: '../webresources/login/AuthPrivilege/normal/PrivillegeResources/findAllPrivilegeForTreeByUser?userId=' + node.id});
        ztree.tree({url: '../webresources/login/VjPrivilegeResource/normal/PrivillegeResources/findResourcesForTreeByUser?userId=' + node.id});
        $("#RoleDatagrid").datagrid({
        	striped:true,url: '../webresources/login/AuthRole/findRoleByUserId?userId=' + node.id + '&tenantId=' + node.tenantId});
        rptree.tree({url: '../webresources/login/VjPrivilegeResource/normal/PrivillegeResources/findUPResourcesForTree?&userId=' + userId});
    }

});
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
//    var hdConditions = new HdConditions();
//    hdConditions.setAndClause("tenantId_tenantId", "-1", "=", "AND");
//    var queryParams = {
//        hdConditions: hdConditions.getHdConditions(),
//        queryColumns: {}
//    };

    // datagrid

	$("#RoleDatagrid").datagrid({
        	striped:true,
         // url: "../webresources/login/AuthRole/find",
       //url: "",
//  queryParams: queryParams,
        method: "get",
        //pagination: true,
        singleSelect: true,
        rownumbers: true,
        pageSize: 50,
        selectOnCheck: false,
        checkOnSelect: false,
        fit: true,
        fitColumns: false,
        onSelect: function(rowIndex, rowData)
        {
            roleId = rowData.roleId;

        },
        onCheckAll: function(rows) {
            var dgSelected = usertree.tree('getSelected');
            if (dgSelected == null)
            {
                return;
            }
            if (dgSelected.type != "USER")
            {
                HdUtils.messager.info("请选择一个员工！");
                return;
            }
            for (var i = 0; i < rows.length; i++) {
                saveGroupRoleUser(true, rows[i].roleId, dgSelected.id);
            }
        },
        onUncheckAll: function(rows) {
            var dgSelected = usertree.tree('getSelected');
            if (dgSelected == null)
            {
                return;
            }
            if (dgSelected.type != "USER")
            {
                HdUtils.messager.info("请选择一个员工！");
                return;
            }
            for (var i = 0; i < rows.length; i++) {
                saveGroupRoleUser(false, rows[i].roleId, dgSelected.id);
            }
        },
        onCheck: function(rowIndex, rowData)
        {
            
        	if (rowIndex >= 0)
            {
                var dgSelected = usertree.tree('getSelected');
                if (dgSelected == null)
                {
                    return;
                }
                if (dgSelected.type != "USER")
                {
                    HdUtils.messager.info("请选择一个员工！");
                    return;
                }
                saveGroupRoleUser(true, rowData.roleId, dgSelected.id);
            }
        },
        onUncheck: function(rowIndex, rowData)
        {
            if (rowIndex >= 0)
            {
                var dgSelected = usertree.tree('getSelected');
                if (dgSelected == null)
                {
                    return;
                }
                if (dgSelected.type != "USER")
                {
                    HdUtils.messager.info("请选择一个员工！");
                    return;
                }
                saveGroupRoleUser(false, rowData.roleId, dgSelected.id);
            }
        },
        onDblClickRow: function(rowIndex, rowData) {
            showDetail(rowData.roleId);
        },
//        onSelect: function(rowIndex, rowData)
//        {
//            if (rowData.roleId != null && rowData.roleId != undefined) {
//                ptree.tree({url: '../webresources/login/AuthPrivilege/normal/PrivillegeResources/findAllPrivilegeForTree?roleId=' + rowData.roleId});
//                rtree.tree({url: '../webresources/login/VjPrivilegeResource/normal/PrivillegeResources/findResourcesForTree?roleId=' + rowData.roleId});
//            }
//
//
//        },
        columns: [[
                   {
                       field: "checked",
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
                    sortable: true,
                    hidden: true,
                    formatter: function(value) {
                        if (value != null && value != undefined) {
                            if (value.tenantId != null && value.tenantId != undefined) {
                                return value.tenantId;
                            } else {
                                return value;
                            }
                        } else {
                            return "";
                        }
                    },
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
                    title: $.i18n.prop("allotname"),
                    multiSort: true,
                    halign: "center",
                    width: 110,
//                    editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                 {
                    field: "detail",
                    title: $.i18n.prop("allotdetail"),
                    multiSort: true,
                    halign: "center",
                    align: "center",
                    width: 70,
                    formatter: function(val, row, idx) {
                        return "<input type='button' value='查看' onclick='showDetail(\"" + row.roleId + "\")'/>";
                    }
                },
                {
                    field: "description",
                    title: $.i18n.prop("allotdescription"),
                    multiSort: true,
                    halign: "center",
                    width: 100,
//                    editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "updAccount",
                    title: $.i18n.prop("allotupdAccount"),
                    multiSort: true,
                    halign: "center",
                    width: 60,
                    //  editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "updTimestamp",
                    title: $.i18n.prop("allotupdTimestamp"),
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
                    field: "insAccount",
                    title: $.i18n.prop("allotinsAccount"),
                    multiSort: true,
                    halign: "center",
                    width: 60,
                    // editor: {type: "validatebox", options: {required: false}},
                    sortable: true
                },
                {
                    field: "insTimestamp",
                    title: $.i18n.prop("allotinsTimestamp"),
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
                }
            ]], onLoadSuccess: function(data) {
            if (data) {
                $.each(data.rows, function(index, item) {
                    if (item.checked) {
                    	$("#RoleDatagrid").datagrid('checkRow', index);
                    }
                });
            }

        }

    });
    $("#RoleDatagrid").datagrid("hdGetColumnNames");
});


