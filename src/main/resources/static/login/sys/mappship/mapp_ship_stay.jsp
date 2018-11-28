<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappShipStayToolBar1487072258264" style="padding-top: 0px;">
		<div style="float:left;">
	        <!-- 标准按钮 -->
	        <shiro:hasPermission name="webresources:login:MappShipStay:add">
	            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappShipStay:update">
	            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappShipStay:delete">
	            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappShipStay:save">
	            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappShipStay:refresh">
	            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	        </shiro:hasPermission>
        </div>
        <input class="easyui-searchbox" id="MappShipStaySearchbox1487072258264" />
</div>
<table id="MappShipStayDatagrid1487072258264" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappShipStayDialog1487072258264");
        var dg = $("#MappShipStayDatagrid1487072258264");
       
        // buttons
        // 增加。
        $("#MappShipStayToolBar1487072258264 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            //dg.datagrid('getEditor', {index: selectIdx, field: 'srcShipStayCod'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnShipStayNam'}).target.prop('disabled', true);
			dg.datagrid('getEditor', {index: selectIdx, field: 'enShipStayNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappShipStayToolBar1487072258264 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            //dg.datagrid('getEditor', {index: selectIdx, field: 'srcShipStayCod'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnShipStayNam'}).target.prop('disabled', true);
			dg.datagrid('getEditor', {index: selectIdx, field: 'enShipStayNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappShipStayToolBar1487072258264 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/MappShipStay/save"});
        });
        // 保存。
        $("#MappShipStayToolBar1487072258264 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappShipStay/save"});
        });
        // 刷新。
        $("#MappShipStayToolBar1487072258264 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappShipStaySearchbox1487072258264").val();
        	builder.set("q", value);
        	 dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("guid","desc");
        // searchbox
        $("#MappShipStaySearchbox1487072258264").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,shipStayCod,srcShipStayCod,cnShipStayNam,enShipStayNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappShipStayDatagrid1487072258264").datagrid({
        	striped:true,
            url: "../webresources/login/MappShipStay/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            //autoLoad:false,
            pageSize: 20,
            toolbar: "#MappShipStayToolBar1487072258264",
            fit: true,
            fitColumns: false,
            sortOrder: 'desc',
	        sortName: 'updTimestamp',
            columns: [[
					{
					    field: "ck",
						   checkbox: true
					 },
                    {
                        field: "companyCod",
                        title: '<font color="red">作业公司</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor: {type: 'combogrid',
                        	options: HdUtils.code.sbcCompanyByCompanyCod({
                        		parentId: '#MappShipStayDatagrid1487072258264',
                        		textField:'COMPANY_COD',
                        		fieldMapping: {
                        			companyCod: 'COMPANY_COD',
                        			cnCompanyNam:'CN_COMPANY_NAM'
                        			},
                        			required: true                 
                            })
                        }, 
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        },
                    }, 
                    {
                        field: "srcShipStayCod",
                        title: '<font color="red">来源船舶停留</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "uppercasebox", options: {required:true, validType: ['isCodeRepeat["MappShipStayDatagrid1487072258264","MappShipStay","srcShipStayCod"]','length[1,40]']}},
                        sortable: true
                    },
                    {
                        field: "shipStayCod",
                        title: '<font color="red">标准船舶停留</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcShipStay({
                        		required:true,
                        		parentId:"#MappShipStayDatagrid1487072258264",
                        		textField: 'shipStayCod', 
                        		fieldMapping : {
                        			shipStayCod : 'shipStayCod',
                        			cnShipStayNam : 'cnShipStayNam'
                        		},
                        		onSelect: function(index,record){    
									var ed = dg.datagrid('getEditor', {
										index : dg.datagrid("options").hdCurrentRowIndex,
										field : 'cnShipStayNam'
									});
									$(ed.target).val(record.cnShipStayNam);
									var ed = dg.datagrid('getEditor', {
										index : dg.datagrid("options").hdCurrentRowIndex,
										field : 'enShipStayNam'
									});
									$(ed.target).val(record.enShipStayNam);
						        }
                        	})
                        },
                        sortable: true
                    },
                    {
                        field: "cnShipStayNam",
                        title: "中文船舶停留名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required:false, validType: 'length[0,60]'}},
                        sortable: true
                    },
                    {
                        field: "enShipStayNam",
                        title: "英文船舶停留名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "uppercasebox", options: {required:false, validType: 'length[0,60]'}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "创建时间",
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: HdUtils.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        width:80,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: HdUtils.formatter.datetime,
                        sortable: true
                    }
                ]],
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'cnShipStayNam'}).target.prop('disabled', true);
        			dg.datagrid('getEditor', {index: selectIdx, field: 'enShipStayNam'}).target.prop('disabled', true);
                }
        });
        $("#MappShipStayDatagrid1487072258264").datagrid("hdGetColumnNames");
    });
    function createChart() {
        $("#chart-dlg").dialog({
            title: '生成图表',
            width: 800,
            height: 500,
            padding: 10,
            iconCls: 'icon-save',
            buttons: '#chart-buttons',
            maximizable: true
        });
        var divId = 'chart';
        var type = $("#chart-type").combobox("getValue");
        var s = new ShapeBase();
        s.show("xxx", divId, type);//XXX是查询数据的方法路径
    }
</script>