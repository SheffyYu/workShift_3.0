<meta charset="UTF-8">
<script type="text/javascript" src="/login/sys/shipSelected/ship_selected.js"></script>
<!-- 工具栏 -->
<div id="SbcShipServiceToolBar1436426180432" style="padding-top: 0px;">
		<div style="float:left">
			<!-- 标准按钮 -->
			<shiro:hasPermission name="webresources:sys:SbcShipService:add">
				<a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipService:update">
				<a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipService:delete">
				<a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipService:save">
				<a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="webresources:sys:SbcShipService:refresh">
				<a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
			</shiro:hasPermission>
			<!-- <input type="text" id="shipNam1436426180432" name="shipLineNam"/>
			<input type="hidden" id="shipCod1436426180432" name="shipLineCod"/>
			<a class="easyui-linkbutton" id="shipSelect" plain="false">选航线</a>
			<input type="text" id="shipCompanyNam1436426180432" name="shipCompanyNam"/>
			<input type="hidden" id="shipCompanyCod1436426180432" name="shipCompanyCod"/>
			<a class="easyui-linkbutton" id="shipSelectCompany" plain="false">选船公司</a> -->
			<!-- 标准按钮 结束-->
		</div>
		<input class="easyui-searchbox" id="SbcShipServiceSearchbox1436426180432" />
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="SbcShipServiceDatagrid1436426180432" style="height: 100%"></table>

<!-- 脚本控制 -->
<script type="text/javascript">
$(document).ready(function() {
	
	$("#shipSelect").on("click",function(){
		var shipNam=$("#SbcShipServiceToolBar1436426180432 input[name='shipLineNam']").val();
		var shipCod=$("#SbcShipServiceToolBar1436426180432 input[name='shipLineCod']").val();
		openSelectShipLineDialog($("#shipCod1436426180432"),$("#shipNam1436426180432"),shipCod,shipNam);
	});
	$("#shipSelectCompany").on("click",function(){
		var shipCompanyNam=$("#SbcShipServiceToolBar1436426180432 input[name='shipCompanyNam']").val();
		var shipCompany=$("#SbcShipServiceToolBar1436426180432 input[name='shipCompanyCod']").val();
		openSelectShipCompanyDialog($("#shipCompanyCod1436426180432"),$("#shipCompanyNam1436426180432"),shipCompany,shipCompanyNam);
	});

	var dg = $("#SbcShipServiceDatagrid1436426180432");
	// buttons
	// 增加。
	$("#SbcShipServiceToolBar1436426180432 a[iconCls='icon-add']").on("click", function() {
		dg.datagrid("hdAdd");
	});
	// 编辑。
	$("#SbcShipServiceToolBar1436426180432 a[iconCls='icon-edit']").on("click",
		function() {
			dg.datagrid("hdEdit");
			var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
			dg.datagrid('getEditor', {index : selectIdx,field : 'shipServiceCod'}).target.prop('disabled', true);
	});
	// 删除。
	$("#SbcShipServiceToolBar1436426180432 a[iconCls='icon-remove']").on("click",
		function() {dg.datagrid("hdRealRemove",{url : "../webresources/login/SbcShipService/save"});
	});
	// 保存。
	$("#SbcShipServiceToolBar1436426180432 a[iconCls='icon-save']").on("click",
		function() {dg.datagrid("hdSave",{url : "../webresources/login/SbcShipService/save"});
	});
	// 刷新。
	$("#SbcShipServiceToolBar1436426180432 a[iconCls='icon-reload']").on("click",
		function() {
		var value=$("#SbcShipServiceSearchbox1436426180432").val();
    	builder.set("q", value);
    	dg.datagrid("load");
	});
	// 条件类。
	var builder = new HdEzuiQueryParamsBuilder();
	 builder.hdEzuiQueryParams.page = 1;
     builder.hdEzuiQueryParams.rows = 20;
     builder.setOrderByClause("shipServiceId","desc");
	// searchbox
	$("#SbcShipServiceSearchbox1436426180432").searchbox({prompt : "请输入...",
		searcher : function(value, name) {
			builder.set("q", value);
			builder.set("queryColumns","shipServiceCod,cnShipServiceNam,enShipServiceNam,courseCod");
			dg.datagrid("load");
			}
	});
	// datagrid
	$("#SbcShipServiceDatagrid1436426180432").datagrid({
		                striped:true,
						url : "../webresources/login/SbcShipService/find",
						queryParams : builder.build(),
						method : "post",
						pagination : true,
						singleSelect: true,
			            selectOnCheck:false,
			            checkOnSelect:false,
			            sortOrder: 'desc',//按更新时间倒序
			            sortName: 'updTimestamp',
						//autoLoad:false,
						rownumbers : true,
						pageSize : 20,
						toolbar : "#SbcShipServiceToolBar1436426180432",
						fit : true,
						fitColumns : false,
						columns : [ [
								{
									field : "ck",
									checkbox : true
								},
								{
									field : "shipServiceId",
									title : '<font color="red">航线代码ID</font>',
									multiSort : true,
									halign : "center",
									sortable : true,
									hidden : true
								},
								{
									field : "shipServiceCod",
									title : '<font color="red">航线代码</font>',
									multiSort : true,
									width:100,
									halign : "center",
									editor : {
										type : "uppercasebox",
										options : {
											required : true,
											validType : [
													'isCodeRepeat["SbcShipServiceDatagrid1436426180432","SbcShipService","shipServiceCod"]',
													'length[1,20]' ]
										}
									},
									sortable : true
								},
								{
									field : "courseCod",
									title : "航向代码",
									multiSort : true,
									halign : "center",
									width:100,
									  editor: {
					                        type: 'combogrid',
					                        options: HdUtils.code.sbcCourse({
					                            parentId: '#SbcShipServiceDatagrid1436426180432',width: 80,
					                            fieldMapping: {courseCod: 'courseCod',cnCourseNam: 'cnCourseNam',},
					                            required: false
					                        })
					                    },
					                    formatter: function (value, row, index) {
				                            return row.cnCourseNam;
				                        },
									sortable : true
								},
								{
									field : "enShipServiceNam",
									title : "航线英文名称",
									multiSort : true,
									width:100,
									halign : "center",
									editor : {
										type : "uppercasebox",
										options : {
											required : false,
											validType : 'length[0,60]'
										}
									},
									sortable : true
								},
								{
									field : "cnShipServiceNam",
									title : '航线中文名称',
									multiSort : true,
									width:100,
									halign : "center",
			                        //editor: {type: "validatebox", options: {required:false,validType: 'length[0,60]'}},
			                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,60]'}},
									sortable : true
								},
								{
									field : "serviceTyp",
									title : '<font color="red">航线类别</font>',
									multiSort : true,
									halign : "center",
									editor: {
			                            type: "combobox",
			                            options: HdUtils.code.scode({fieldCod: 'SERVICE_TYP'}, {required: true})
			                        },
			                        formatter: function (value) {
			                            if (value === null || value === '')
			                                return;
			                            var list = HdUtils.global.scode.query({fieldCod: 'SERVICE_TYP', code: value});
			                            return list.length > 0 ? list[0].name : "";
			                        },
									sortable : true,
									width:80
								},
								{
									field : "mainMark",
									title : "干支线标志",
									multiSort : true,
									halign : "center",
									width:80,
									formatter : function(value) {
										if ("0" == value) {
											return "支线";
										} else if ("1" == value) {
											return "干线";
										}
									},
									editor : {
										type : 'combobox',
										options : {
											valueField : 'value',
											textField : 'label',
											width:100,
											data : [
													{
														label : '支线',
														value : '0'
													},
													{
														label : '干线',
														value : '1'
													} ],
											panelHeight : "auto"
										}
									},
									sortable : true
								},
								{
									field : "oceanMark",
									title : "近远洋标志",
									multiSort : true,
									width:80,
									halign : "center",
									formatter : function(value) {
										if ("1" == value) {
											return "远洋";
										} else if ("0" == value) {
											return "近洋";
										}
									},
									editor : {
										type : 'combobox',
										options : {
											valueField : 'value',
											textField : 'label',
											width:100,
											data : [
													{
														label : '远洋',
														value : '1'
													},
													{
														label : '近洋',
														value : '0'
													} ],
											panelHeight : "auto"
										}
									},
									sortable : true
								},
								{
									field : "tradeMark",
									title : '<font color="red">贸易性质</font>',
									multiSort : true,
									halign : "center",
									width:80,
									editor: {
			                            type: "combobox",
			                            options: HdUtils.code.scode({fieldCod: 'TRADE_MARK'}, {required: true})
			                        },
			                        formatter: function (value) {
			                            if (value === null || value === '')
			                                return;
			                            var list = HdUtils.global.scode.query({fieldCod: 'TRADE_MARK', code: value});
			                            return list.length > 0 ? list[0].name : "";
			                        },
									sortable : true
								},
								/* {
									field : "sysMark",
									title : '系统标识',
									multiSort : true,
									width:80,
									halign : "center",
									align : "center",
								    editor: $.hd.ezui.editor.checkbox,
				                	formatter: $.hd.ezui.formatter.checkbox2,
									sortable : true
								}, */
								{
									field : "abandonedMark",
									title : '作废标志',
									multiSort : true,
									halign : "center",
									align : "center",
									width:80,
								    editor: $.hd.ezui.editor.checkbox,
				                	formatter: $.hd.ezui.formatter.checkbox2,
									sortable : true
								},
								{

									field : "description",
									title : "备注",
									multiSort : true,
									halign : "center",
									width:180,
									editor : {
										type : "validatebox",
										options : {
											required : false,
											validType : 'length[0,1000]'
										}
									},
									sortable : true,
									width:90
								},
								{

									field : "insAccount",
									title : '创建人',
									multiSort : true,
									halign : "center",
									required : true,
									width:80,
									sortable : true
								},
								{

									field : "insTimestamp",
									title : '创建时间',
									multiSort : true,
									halign : "center",
									required : true,
									width:140,
									formatter : HdUtils.formatter.datetime,
									sortable : true
								},
								{

									field : "updAccount",
									title : "更新人",
									multiSort : true,
									halign : "center",
									required : false,
									width:80,
									sortable : true
								},
								{

									field : "updTimestamp",
									title : "更新时间",
									multiSort : true,
									halign : "center",
									required : true,
									width:140,
									formatter : HdUtils.formatter.datetime,
									sortable : true
								}

						] ],
						onDblClickCell : function(index) {
							dg.datagrid("hdEdit");
							dg.datagrid('getEditor', {index : index,field : 'shipServiceCod'
							}).target.prop('disabled', true);
						}
					});
});
</script>
