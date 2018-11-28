<meta charset="UTF-8">
<div class="easyui-layout" style="width:100%;height:100%;">   
<!-- 	<div data-options="region:'west',title:'系统代码',split:true,collapsible:false" style="width:290px;"> -->
<!-- 		<div id="SysCodeToolBar1475916907308"> -->
<!-- 		    <div> -->
<!-- 		    </div> -->
<!-- 		</div> -->
<!-- 		<table id="SysCodeDatagrid1475916907308" style="height:100%"></table> -->
<!--     </div> -->
<!--     <div data-options="region:'center',title:'系统代码值',split:true" style="width:800px;"> -->
	    <div id="SysCode1ToolBar1475916907308">
		    <div>
		        <span style="float:left;">
		            <shiro:hasPermission name="webresources:login:SysCode:add">
			        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
			        </shiro:hasPermission>
			        <shiro:hasPermission name="webresources:login:SysCode:update">
			        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
			        </shiro:hasPermission>
			        <shiro:hasPermission name="webresources:login:SysCode:delete">
			        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
			        </shiro:hasPermission>
			        <shiro:hasPermission name="webresources:login:SysCode:save">
			        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
			        </shiro:hasPermission>
			        <shiro:hasPermission name="webresources:login:SysCode:refresh">
			        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
			        </shiro:hasPermission>
			        &nbsp;
		        </span>
		        <input class="easyui-searchbox" id="SysCodeSearchbox1475916907308"/>
		    </div>
		</div>
	    <table id="SysCode1Datagrid1475916907308" style="height:100%"></table>
<!-- 	</div> -->
</div>
<script type="text/javascript">
//var fieldCod;
$(document).ready(function() {
	//var dg = $("#SysCodeDatagrid1475916907308");
	
	// buttons
	// 条件类。
	// var builder = new HdEzuiQueryParamsBuilder();
	// builder.setAndClause("FIELD_COD","CUSTOMER_CLASSIFICATION","=","and");
	// datagrid
// 	$("#SysCodeDatagrid1475916907308").datagrid({
//         	striped:true,
// 		url:"../webresources/login/SysCode/findSysCode",
// 		queryParams:builder.build(),
// 		method:"post",
// 		pagination:false,
// 		singleSelect:true,
// 		checkOnSelect:true,
// 		selectOnCheck:false,
// 		rownumbers:true,
// 		pageSize:20,
// 		toolbar:"#SysCodeToolBar1475916907308",
// 		fit:true,
// 		fitColumns:false,
// 		columns:[[
// 		{
		
// 		field:"FIELD_COD",
// 		title:'字段代码',
// 		multiSort:true,
// 		halign:"center",
// 		hidden:true,
// 		editor:{type:"uppercasebox",options:{required:true}},
// 		sortable:true
// 		}
// 		,
// 		{
		
// 		field:"FIELD_NAM",
// 		title:"字段名称",
// 		multiSort:true,
// 		halign:"center",
// 		editor:{type:"validatebox",options:{required:false}},
// 		sortable:true
// 		}

// 	]],
// 	onSelect:function (rowIndex, rowData) {
// 		fieldCod = rowData.FIELD_COD;
// 		var searchBuilder=new HdEzuiQueryParamsBuilder();
// 		searchBuilder.setAndClause("fieldCod",rowData.FIELD_COD,"=","and");
// 		builder.hdEzuiQueryParams.hdConditions=searchBuilder.hdEzuiQueryParams.hdConditions;
// 		searchBuilder.setOrderByClause("sorter", "asc");//传入orderby
// 	    dg1.datagrid("hdReload");
// 	}});
	var searchBuilder=new HdEzuiQueryParamsBuilder();
	searchBuilder.setAndClause("fieldCod","CUSTOMER_CLASSIFICATION","=","and");
	searchBuilder.setOrderByClause("sorter", "asc");
    var dg1 = $("#SysCode1Datagrid1475916907308");
// buttons
// 增加。
$("#SysCode1ToolBar1475916907308 a[iconCls='icon-add']").on("click",function() {
	   dg1.datagrid("hdAdd",{
           fieldCod:"CUSTOMER_CLASSIFICATION",
           fieldNam:"客户级别"
       });
   // var selected =  $("#SysCodeDatagrid1475916907308").datagrid("getSelected");
//     if(selected!=null) {
//     	dg1.datagrid("hdAdd",{
//     		fieldCod:"CUSTOMER_CLASSIFICATION",
//     		fieldNam:"客户级别"
//         });
// 	} else {
// 		$.messager.alert('警告', '请先选择一条系统代码'); 
// 	}
});
// 编辑。
 $("#SysCode1ToolBar1475916907308 a[iconCls='icon-edit']").on("click",function() {
    dg1.datagrid("hdEdit");
     var selectIdx = dg1.datagrid("options").hdCurrentRowIndex;
    dg1.datagrid('getEditor', {index: selectIdx, field: 'code'}).target.prop('disabled', true);
 });
// 删除。
 $("#SysCode1ToolBar1475916907308 a[iconCls='icon-remove']").on("click",function() {
    dg1.datagrid("hdRealRemove",{url:"../webresources/login/SysCode/save"});
 });
// 保存。
 $("#SysCode1ToolBar1475916907308 a[iconCls='icon-save']").on("click",function() {
	// dg.datagrid("selectRow",i)//选中第一行数据
//     dg1.datagrid("endEdit",1);
    dg1.datagrid("hdSave",{url:"../webresources/login/SysCode/save"});  
 });
// 刷新。
 $("#SysCode1ToolBar1475916907308 a[iconCls='icon-reload']").on("click",function() {
	 var value=$("#SysCodeSearchbox1475916907308").val();
	 searchBuilder.set("q", value);
     dg1.datagrid("load");
	
//     var selected =  $("#SysCodeDatagrid1475916907308").datagrid("getSelected");
//     if(selected!=null) {
//        var searchBuilder=new HdEzuiQueryParamsBuilder();
// 	   searchBuilder.setAndClause("fieldCod",selected.FIELD_COD,"=","and");
// 	   builder.hdEzuiQueryParams.hdConditions=searchBuilder.hdEzuiQueryParams.hdConditions;
// 	   searchBuilder.setOrderByClause("sorter", "asc");//传入orderby
//        dg1.datagrid("hdReload");
//     }
 });
// 条件类。
 //var builder = new HdEzuiQueryParamsBuilder();
// searchbox
$("#SysCodeSearchbox1475916907308").searchbox({prompt:"请输入...",searcher:function(value,name) {
     builder.set("q",value);
     builder.set("queryColumns","name");
     dg1.datagrid("hdReload");
}});
// datagrid
$("#SysCode1Datagrid1475916907308").datagrid({
        	striped:true,
	url:"../webresources/login/SysCode/find",
	queryParams:searchBuilder.build(),
	method:"post",
	pagination:true,
	singleSelect:true,
	checkOnSelect:true,
	//autoLoad:false,
	selectOnCheck:false,
	rownumbers:true,
	pageSize:20,
	toolbar:"#SysCode1ToolBar1475916907308",
	fit:true,
	fitColumns:false,
	columns:[[
    {
	field : 'ck',
	checkbox : true
	}
    ,
	{
	field:"code",
	title:'<font color="red">代码</font>',
	multiSort:true,
	halign:"center",
	width:80,
	editor:{type:"validatebox",options:{required:false, validType: 'maxLength[30]'}},
    editor: {type: "validatebox", options: {required:true, validType: ['isSysCodeRepeat["SysCode1Datagrid1475916907308","code","CUSTOMER_CLASSIFICATION"]','length[1,30]']}},
	sortable:true
	}
	,
	{
	field:"name",
	title:"名称",
	multiSort:true,
	halign:"center",
	width:80,
	editor:{type:"validatebox",options:{required:true, validType: 'maxLength[100]'}},
	sortable:true
	}
	,
	{
	field:"sorter",
	title:"序号",
	multiSort:true,
	halign:"center",
	width:80,
// 	formatter:function(value) {
// 	return HdUtils.formatter.precisionCommon(value,0);  
// 	},
	//要限制输入的最大数，请修改max
	editor:{type:"numberbox",options:{required:false,precision: 0, max: 99999,groupSeparator:','}},
	sortable:true
	}
 	,
 	{
	field:"sysMark",
	title:'系统',
	multiSort:true,
	halign:"center",
	align:"center",
	width:60,
	formatter: $.hd.ezui.formatter.checkbox2,
    editor: $.hd.ezui.editor.checkbox,
	sortable:true
	},
	{ 
		field:"abandonedMark",
		title:'废弃',
		multiSort:true,
		halign:"center",
		align:"center",
		width:60,
		formatter: $.hd.ezui.formatter.checkbox2,
	    editor: $.hd.ezui.editor.checkbox,
		sortable:true
	},
// 	{
// 	field:"customEx1",
// 	title:"自定义字段1",
// 	multiSort:true,
// 	halign:"center",
// 	editor:{type:"validatebox",options:{required:false,validType: 'maxLength[1000]'}},
// 	sortable:true
// 	}
// 	,
// 	{
// 	field:"customEx2",
// 	title:"自定义字段2",
// 	multiSort:true,
// 	halign:"center",
// 	editor:{type:"validatebox",options:{required:false,validType: 'maxLength[1000]'}},
// 	sortable:true
// 	}
// 	,
// 	{
// 	field:"customEx3",
// 	title:"自定义字段3",
// 	multiSort:true,
// 	halign:"center",
// 	editor:{type:"validatebox",options:{required:false,validType: 'maxLength[1000]'}},
// 	sortable:true
// 	}
// 	,
// 	{
// 	field:"customEx4",
// 	title:"自定义字段4",
// 	multiSort:true,
// 	halign:"center",
// 	editor:{type:"validatebox",options:{required:false,validType: 'maxLength[1000]'}},
// 	sortable:true
// 	},
// 	{
// 		field:"customEx5",
// 		title:"自定义字段5",
// 		multiSort:true,
// 		halign:"center",
// 		editor:{type:"validatebox",options:{required:false,validType: 'maxLength[1000]'}},
// 		sortable:true
// 	},
// 	{
// 		field:"customEx6",
// 		title:"自定义字段6",
// 		multiSort:true,
// 		halign:"center",
// 		editor:{type:"validatebox",options:{required:false,validType: 'maxLength[1000]'}},
// 		sortable:true
// 	},
	{
	field:"description",
	title:"备注",
	multiSort:true,
	width:80,
	halign:"center",
	editor:{type:"validatebox",options:{required:false,validType: 'maxLength[1000]'}},
	sortable:true
	},
	{
        field: "insAccount",
        title: '创建人',
        multiSort: true,
        halign: "center",
        width:80,
        sortable: true
    },
    {
        field: "insTimestamp",
        title: '创建时间',
        formatter: $.hd.ezui.formatter.datetime,
        multiSort: true,
        halign: "center",
        width:130,
        sortable: true
    },
    {
        field: "updAccount",
        title: '更新人',
        multiSort: true,
        width:80,
        halign: "center",
        sortable: true
    },
    {
        field: "updTimestamp",
        title: '更新时间',
        formatter: $.hd.ezui.formatter.datetime,
        multiSort: true,
        halign: "center",
        width:130,
        sortable: true
    },
]],
onDblClickRow: function (index, data) {
	dg1.datagrid("hdEdit"); 
	dg1.datagrid('getEditor', {index: index, field: 'code'}).target.prop('disabled', true);
}
});



});
</script>
