<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MachPlacToolBar1487043053991" style="padding-top: 0px;">
	<div style="float:left">
		<a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	</div>
	<input class="easyui-searchbox" id="MachPlacSearchbox1487043053991" />
</div>
<table id="MachPlacDatagrid1487043053991" style="height: 100%"></table>
<script type="text/javascript">
	$(document).ready(
			function() {
				var dialogTitleAddF = "增加";
				var dialogTitleEditF = "编辑";
				var diog = $("#MachPlacDialog1487043053991");
				var dg = $("#MachPlacDatagrid1487043053991");
				var colNum3 = 2;//接收一下，自动调整diog.dialog的宽度
				var colNum4 = 2;//接收一下，自动调整diog.dialog的高度
				// buttons
				// 刷新。
				$("#MachPlacToolBar1487043053991 a[iconCls='icon-reload']").on(
						"click", function() {
							var value=$("#MachPlacSearchbox1487043053991").val();
				        	builder.set("q", value);
							dg.datagrid("hdReload");
						});
				// 条件类。
				var builder = new HdEzuiQueryParamsBuilder();
				 builder.hdEzuiQueryParams.page = 1;
			        builder.hdEzuiQueryParams.rows = 20;
			        builder.setOrderByClause("guid","desc");
				// searchbox
				$("#MachPlacSearchbox1487043053991").searchbox(
						{
							prompt : "请输入...",
							searcher : function(value, name) {
								builder.set("q", value);
								builder.set("queryColumns", "machCod,machDriverCod,curShipVisitNo,curBollardCod,gpsXyz,curCyBlockNo,curCyBayNo,curCyRowNo");
								dg.datagrid("hdReload");
							}
						});
				// datagrid
				$("#MachPlacDatagrid1487043053991").datagrid({
        	striped:true,
					url : "../webresources/login/machPlac/find",
					queryParams : builder.build(),
					method : "POST",
					pagination : true,
					singleSelect :true,
					rownumbers : true,
					pageSize : 20,
					toolbar : "#MachPlacToolBar1487043053991",
					fit : true,
					sortOrder: 'desc',
			        sortName: 'updTimestamp',
					fitColumns : false,
					//autoLoad:false,
					columns : [ [
					{
						field : "companyCodNam",
						title : '<font color="red">公司名称</font>',
						multiSort : true,
						halign : "center",
						sortable : true
					}, 
					 {
						field : "machCod",
						title : '<font color="red">机械代码</font>',
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "machStat",
						title : '<font color="red">机械状态</font>',
						multiSort : true,
						halign : "center",
						sortable : true,
						formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'MACH_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }
					}, {
						field : "queueTyp",
						title : "作业类型",
						multiSort : true,
						halign : "center",
						sortable : true,
						formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'QUEUE_TYP', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }
					}, {
						field : "anchorMark",
						title : "锚定状态",
						multiSort : true,
						halign : "center",
						align: "center",
						sortable : true,
						formatter: $.hd.ezui.formatter.checkbox2
					}, {
						field : "machDriverCod",
						title : "机械司机代码",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "machBegTim",
						title : "机械登录时间",
						multiSort : true,
						halign : "center",
						formatter: function(value){
							return value ? new Date(value).format('yyyy-MM-dd hh:mm') : '';
						},
						sortable : true
					}, {
						field : "machEndTim",
						title : "机械注销时间",
						multiSort : true,
						halign : "center",
						formatter: function(value){
							return value ? new Date(value).format('yyyy-MM-dd hh:mm') : '';
						},
						sortable : true
					}, {
						field : "lastWorkTim",
						title : "上次作业时间",
						multiSort : true,
						halign : "center",
						formatter: function(value){
							return value ? new Date(value).format('yyyy-MM-dd hh:mm') : '';
						},
						sortable : true
					}, {
						field : "curShipVisitNo",
						title : "当前作业船舶航次",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "curShipBayNo",
						title : "当前作业船舶贝位",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "curBollardCod",
						title : '<font color="red">当前缆桩代码</font>',
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "gpsXyz",
						title : "GPS坐标",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "curCyBlockNo",
						title : "当前堆场编号",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "curCyBayNo",
						title : "当前堆场贝号",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "curCyRowNo",
						title : "当前堆场行号",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "description",
						title : "备注/描述",
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "insAccount",
						title : '创建人',
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "insTimestamp",
						title : '创建时间',
						multiSort : true,
						halign : "center",
						formatter: HdUtils.formatter.datetime,
						sortable : true
					}, {
						field : "updAccount",
						title : '更新人',
						multiSort : true,
						halign : "center",
						sortable : true
					}, {
						field : "updTimestamp",
						title : '更新时间',
						multiSort : true,
						halign : "center",
						formatter: HdUtils.formatter.datetime,
						sortable : true
					}, ] ]
				});
				$("#MachPlacDatagrid1487043053991")
						.datagrid("hdGetColumnNames");
			});
</script>

