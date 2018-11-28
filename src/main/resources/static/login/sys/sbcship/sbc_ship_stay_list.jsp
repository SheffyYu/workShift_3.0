<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcShipStayToolBar1436426180432" style="padding-top: 0px;">
		<div style="float:left;">
			<!-- 标准按钮 -->
			<shiro:hasPermission name="webresources:sys:SbcShipStay:add">
				<a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipStay:update">
				<a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipStay:delete">
				<a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipStay:save">
				<a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipStay:refresh">
				  <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> 
	        </shiro:hasPermission>
        </div>
        <input class="easyui-searchbox" id="SbcShipStaySearchbox1436426180432" />
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="SbcShipStayDatagrid1436426180432" style="height: 100%"></table>
<!-- end Datagrid -->
<!-- 脚本控制 -->
<script type="text/javascript">
	$(document).ready(function() {
var dg = $("#SbcShipStayDatagrid1436426180432");
// buttons
// 增加。
$("#SbcShipStayToolBar1436426180432 a[iconCls='icon-add']").on("click", function() {
	dg.datagrid("hdAdd");
});
// 编辑。
$("#SbcShipStayToolBar1436426180432 a[iconCls='icon-edit']").on("click", function() {
	dg.datagrid("hdEdit");
	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
             dg.datagrid('getEditor', {index: selectIdx, field: 'shipStayCod'}).target.prop('disabled', true);
});
// 删除。
$("#SbcShipStayToolBar1436426180432 a[iconCls='icon-remove']").on("click", function() {
	dg.datagrid("hdRealRemove",{url : "../webresources/login/SbcShipStay/save"});
});
// 保存。
$("#SbcShipStayToolBar1436426180432 a[iconCls='icon-save']").on("click",function() {
	dg.datagrid("hdSave",{url : "../webresources/login/SbcShipStay/save"});
});
// 刷新。
$("#SbcShipStayToolBar1436426180432 a[iconCls='icon-reload']").on("click", function() {
	var value=$("#SbcShipStaySearchbox1436426180432").val();
	builder.set("q", value);
	dg.datagrid("load");
});
// 条件类。
var builder = new HdEzuiQueryParamsBuilder();
// searchbox
$("#SbcShipStaySearchbox1436426180432").searchbox({
	prompt : "请输入...",
	searcher : function(value, name) {
		    builder.set("q", value);
               builder.set("queryColumns","shipStayCod,cnShipStayNam,enShipStayNam");
               dg.datagrid("load");
	}
});
// datagrid
$("#SbcShipStayDatagrid1436426180432")
		.datagrid(
				{
					url : "../webresources/login/SbcShipStay/find",
					queryParams : builder.build(),
					method : "post",
					pagination : true,
					singleSelect: true,
		            selectOnCheck:false,
		            checkOnSelect:false,
					rownumbers : true,
					pageSize : 20,
					//autoLoad:false,
					toolbar : "#SbcShipStayToolBar1436426180432",
					fit : true,
					fitColumns : false,
					sortOrder: 'desc',
			        sortName: 'updTimestamp',
					columns: [[
					           {
			                        field: "ck",
			   					    checkbox: true
			                    },
		                       {
		                           field: "shipStayId",
		                           title: '<font color="red">停时ID</font>',
		                           multiSort: true,
		                           halign: "center",
		                           hidden:true,
		                           sortable: true
		                       },
		                       {
		                           field: "shipStayCod",
		                           title: '<font color="red">停时代码</font>',
		                           multiSort: true,
		                           halign: "center",
		                           width:80,
		                           editor: {type: "uppercasebox", options: {required:true,validType:['isCodeRepeat["SbcShipStayDatagrid1436426180432","SbcShipStay","shipStayCod"]','length[1,10]']}},
		                           sortable: true
		                       },
		                       {
		                           field: "enShipStayNam",
		                           title: "停时英文名称",
		                           multiSort: true,
		                           halign: "center",
		                           width:120,
		                           editor: {type: "uppercasebox", options: {required:false,validType:'length[0,60]'}},
		                           sortable: true
		                       },

		                       {
		                           field: "cnShipStayNam",
		                           title: "停时中文名称",
		                           multiSort: true,
		                           halign: "center",
		                           width:100,
		                           editor: {type: "validatebox", options: {required:false,validType:'length[0,60]'}},
		                           sortable: true
		                       },
							/* {
								field : "sysMark",
								title : "系统标识",
								multiSort : true,
								halign : "center",
								align : "center",
								width:80,
							    editor: $.hd.ezui.editor.checkbox,
			                	formatter: $.hd.ezui.formatter.checkbox2,
			                    sortable: true
			                }, */
							{
								field : "abandonedMark",
								title : "作废标志",
								multiSort : true,
								halign : "center",
								align : "center",
								width:80,
							    editor: $.hd.ezui.editor.checkbox,
			                	formatter: $.hd.ezui.formatter.checkbox2,
		                        sortable: true
		                    },
		                    {
								field : "description",
								title : "备注",
								multiSort : true,
								halign : "center",
								editor : {
									type : "validatebox",
									options : {required:false,
										validType:'length[0,1000]'
									}
								},
								sortable : true,
								width:180
							},
							{

								field : "insAccount",
								title : '创建人',
								multiSort : true,
								halign : "center",
								width:80,
								sortable : true
							},
							{
								field : "insTimestamp",
								title : '创建时间',
								multiSort : true,
								halign : "center",
								width:140,
								formatter :HdUtils.formatter.datetime,
								sortable : true
							},
							{

								field : "updAccount",
								title : "更新人",
								multiSort : true,
								halign : "center",
								width:80,
								sortable : true
							},
							{

								field : "updTimestamp",
								title : "更新时间",
								multiSort : true,
								halign : "center",
								width:140,
								formatter : HdUtils.formatter.datetime,
								sortable : true
							}

					] ],
					onDblClickCell: function (index) {
		            	dg.datagrid("hdEdit");
		            	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
		                dg.datagrid('getEditor', {index: selectIdx, field: 'shipStayCod'}).target.prop('disabled', true);
		            }
				});
});

</script>
