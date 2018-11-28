<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcTruckToolBar1436426180432" style="padding-top: 0px;">
<!-- 		<div style="float: left"> -->
<!-- 			<shiro:hasPermission name="webresources:sys:SbcTruck:add"> -->
<!-- 				<a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a> -->
<!-- 			</shiro:hasPermission> -->
<!-- 			<shiro:hasPermission name="webresources:sys:SbcTruck:update"> -->
<!-- 				<a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a> -->
<!-- 			</shiro:hasPermission> -->
<!-- 			<shiro:hasPermission name="webresources:sys:SbcTruck:delete"> -->
<!-- 				<a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a> -->
<!-- 			</shiro:hasPermission> -->
<!-- 			<shiro:hasPermission name="webresources:sys:SbcTruck:save"> -->
<!-- 				<a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> -->
<!-- 			</shiro:hasPermission> -->
<!-- 			<shiro:hasPermission name="webresources:sys:SbcTruck:refresh"> -->
<!-- 				  <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>  -->
<!-- 	        </shiro:hasPermission> -->
<!--         </div> -->
        <input class="easyui-searchbox" id="SbcTruckSearchbox1436426180432" />
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="SbcTruckDatagrid1436426180432" style="height: 100%"></table>

<!-- 脚本控制 -->
<script type="text/javascript">
	$(document).ready(
		function() {
	$.extend($.fn.validatebox.defaults.rules, {  
           validTodayDate: {  
               validator: function (value) {  
               	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
               	var ed = dg.datagrid('getEditor', {
					index : dg.datagrid("options").hdCurrentRowIndex,
					field : 'forbidMark'
				});
               	var todayDate = new Date();
               	if($(ed.target).is(':checked')==true){
               		return new Date(value).getTime() >todayDate.getTime();  
               	}else{
               		return true;
               	}
               },  
               message: '日期必须大于当前时间'  
           }  
       });  						
	var dg = $("#SbcTruckDatagrid1436426180432");
	// buttons
	// 增加。
	$("#SbcTruckToolBar1436426180432 a[iconCls='icon-add']").on("click", function() {
		dg.datagrid("hdAdd");
	});
	// 编辑。
	$("#SbcTruckToolBar1436426180432 a[iconCls='icon-edit']").on("click", function() {
		dg.datagrid("hdEdit");
		var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
    	dg.datagrid('getEditor', {index: selectIdx, field: 'truckNo'}).target.prop('disabled', true);
	});
	// 删除。
	$("#SbcTruckToolBar1436426180432 a[iconCls='icon-remove']").on("click", function() {
		dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcTruck/save"});
	});
	// 保存。
	$("#SbcTruckToolBar1436426180432 a[iconCls='icon-save']").on("click",function() {
		dg.datagrid("hdSave",{url : "../webresources/login/SbcTruck/save"});
	});
	// 刷新。
	$("#SbcTruckToolBar1436426180432 a[iconCls='icon-reload']")
			.on("click", function() {
				var value=$("#SbcTruckSearchbox1436426180432").val();
	        	builder.set("q", value);
	        	dg.datagrid("load");
			});
	// 条件类。
	var builder = new HdEzuiQueryParamsBuilder();
	builder.hdEzuiQueryParams.page = 1;
    builder.hdEzuiQueryParams.rows = 20;
    builder.setOrderByClause("truckNo","desc");
	// searchbox
	$("#SbcTruckSearchbox1436426180432").searchbox({
		prompt : "请输入...",
		searcher : function(value, name) {
			 builder.set("q", value);
                builder.set("queryColumns","truckNo,plateNo,truckCorpCod");
                dg.datagrid("load");
		}
	});
	// datagrid
	$("#SbcTruckDatagrid1436426180432")
			.datagrid(
					{
						url : "../webresources/login/SbcTruck/find",
						queryParams : builder.build(),
						method : "post",
						pagination : true,
						singleSelect: true,
			            selectOnCheck:false,
			            checkOnSelect:false,
						//autoLoad:false,
						rownumbers : true,
						pageSize : 20,
						toolbar : "#SbcTruckToolBar1436426180432",
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
				                        field: "truckNo",
				                        title: "<font color='red'>集卡号</font>",
				                        multiSort: true,
				                        halign: "center",
				                        width:80,
				                        editor: {type: "uppercasebox", options: {required:true,validType:['isCodeRepeat["SbcTruckDatagrid1436426180432","SbcTruck","truckNo"]','length[1,10]']}},
				                        sortable: true
				                    },
				                    {
				                        field: "plateNo",
				                        title: "<font color='red'>拖车车牌号</font>",
				                        multiSort: true,
				                        halign: "center",
				                        width:80,
				                        editor: {type: "uppercasebox", options: {required:true,validType:'length[1,10]'}},
				                        sortable: true
				                    },
				                    {
				                        field: "truckCorpCod",
				                        title: "<font color='red'>拖车公司代码</font>",
				                        multiSort: true,
				                        halign: "center",
				                        width:80,
				                        editor: {type: "uppercasebox", options: {required:true,validType:'length[1,20]'}},
				                        sortable: true
				                    },
				                    {
				                        field: "truckTareWgt",
				                        title: "空车默认重量",
				                        multiSort: true,
				                        halign: "center",
				                        width:80,
				                        editor: {type: "numberbox", options: {min:0,max:100000000.99,precision:2}},
				                        sortable: true
				                    },
				                    {
				                        field: "customsRegMark",
				                        title: "海关已登记标志",
				                        multiSort: true,
				                        halign: "center",
				                        align: "center",
				                        width:100,
				                        editor: $.hd.ezui.editor.checkbox,
				                	    formatter: $.hd.ezui.formatter.checkbox2,
				                        sortable: true
				                    },
				                    {
				                        field: "forbidMark",
				                        title: "禁用标志",
				                        multiSort: true,
				                        halign: "center",
				                        align: "center",
				                        width:80,
				                        editor: $.hd.ezui.editor.checkbox,
				                	    formatter: $.hd.ezui.formatter.checkbox2,
				                        sortable: true
				                    },
									 {
					                    field: "forbidDte",			                   
					                    title: "<font color='red'>禁用期限</font>",
					                    multiSort: true,
					                    halign: "center",
					                    width:100,
					                    editor: {type: "datebox", options: {required:true,validType:'validTodayDate'}},
					            		formatter :HdUtils.formatter.date,
					                    sortable: true
					                },
				                    {
				                        field: "forbidTxt",
				                        title: "禁用描述",
				                        multiSort: true,
				                        halign: "center",
				                        width:80,
				                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,400]'}},
				                        sortable: true
				                    },
								/* {
									field : "sysMark",
									title : "系统标识",
									multiSort : true,
									halign : "center",
									align: "center",
									width:80,
									formatter:$.hd.ezui.formatter.checkbox2,
			                        editor:$.hd.ezui.editor.checkbox,
				                        sortable: true
				                }, */
				                {
									field : "abandonedMark",
									title : "作废标志",
									multiSort : true,
									halign : "center",
									align: "center",
									width:80,
									editor: $.hd.ezui.editor.checkbox,
			                	    formatter: $.hd.ezui.formatter.checkbox2,
			                        sortable: true
			                    },{
									field : "description",
									title : "备注",
									multiSort : true,
									halign : "center",
									editor : {type : "uppercasebox",options : {required : false,validType: 'length[0,1000]'}},
									width:180,
									sortable : true
								},{
									field : "insAccount",
									title : '创建人',
									multiSort : true,
									halign : "center",
									required : true,
									width:80,
									sortable : true
								},{
									field : "insTimestamp",
									title : '创建时间',
									multiSort : true,
									halign : "center",
									required : true,
									width:140,
									formatter :HdUtils.formatter.datetime,
									sortable : true
								},{
									field : "updAccount",
									title : "更新人",
									multiSort : true,
									halign : "center",
									required : false,
									width:80,
									sortable : true
								},{
									field : "updTimestamp",
									title : "更新时间",
									multiSort : true,
									halign : "center",
									required : true,
									width:180,
									formatter :HdUtils.formatter.datetime,
									sortable : true
								}
						] ],
// 		                onDblClickCell: function (index) {
// 		                	dg.datagrid("hdEdit");
// 		                	dg.datagrid('getEditor', {index: index, field: 'truckNo'}).target.prop('disabled', true);
// 		                }
					});
	$("#SbcTruckDatagrid1436426180432").datagrid("hdGetColumnNames");
});
</script>
