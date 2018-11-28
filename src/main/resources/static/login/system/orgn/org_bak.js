$(document).ready(function() {

	
	 var dg = $("#AuthOrgnDatagrid1421220911777"); 
	 dg.datagrid({      
	      url: "/login/AuthOrgn/authorize",
	        queryParams: builder.build(),
	        method: "post",
	        pagination: true,
	        singleSelect: true,
	        rownumbers: true,
	        pageSize: 20,
	        toolbar: "#AuthOrgnToolBar1421220911777",
	        fit: true,
	        fitColumns: false,
	        sortName: 'sorter',
	        sortOrder: 'asc',
	        columns: [[
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
//	                    title: '租户',
	                    title: "集团",
	                    multiSort: true,
	                    halign: "center",
	                    sortable: false
	                },
	                {
	                    field: "text",
//	                    title: '名字',
	                    title: $.i18n.prop("text"),
	                    multiSort: true,
	                    halign: "center",
	                    editor: {type: "validatebox", options: {required: false}},
	                    sortable: true
	                },
	                {
	                    field: "description",
//	                    title: '描述',
	                    title: $.i18n.prop("description"),
	                    multiSort: true,
	                    halign: "center",
	                    editor: {type: "validatebox", options: {required: false}},
	                    sortable: true
	                },
	                {
	                    field: "sorter",
//	                    title: '排序',
	                    title: $.i18n.prop("sorter"),
	                    multiSort: true,
	                    halign: "center",
	                    editor: {type: "numberbox", options: {required: false}},
	                    sortable: true
	                },
	                {
	                    field: "insAccount",
//	                    title: "创建人",
	                    title: $.i18n.prop("insAccount"),
	                    multiSort: true,
	                    halign: "center",
	 //                   editor: {type: "validatebox", options: {required: false}},
	                    sortable: true
	                },
	                {
	                    field: "insTimestamp",
//	                    title: "创建日期",
	                    title: $.i18n.prop("insTimestamp"),
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
	                    //editor: {type: "datetimebox", options: {required: false}},
	                    sortable: true
	                },
	                {
	                    field: "updAccount",
//	                    title: "更新人",
	                    title: $.i18n.prop("updAccount"),
	                    multiSort: true,
	                    halign: "center",
	                    //editor: {type: "validatebox", options: {required: false}},
	                    sortable: true
	                },
	                {
	                    field: "updTimestamp",
//	                    title: "更新日期",
	                    title: $.i18n.prop("updTimestamp"),
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
	                    //editor: {type: "datetimebox", options: {required: false}},
	                    sortable: true
	                }
	            ]]
	    });

});