
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappMachineTypeToolBar1487041410297" style="padding-top: 0px;">
    <div style="float:left">      
        <shiro:hasPermission name="webresources:sys:MappMachineType:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappMachineType:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappMachineType:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappMachineType:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappMachineType:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>  
         &nbsp;
    </div>
    <input class="easyui-searchbox" id="MappMachineTypeSearchbox1487041410297"/>
</div>
<table id="MappMachineTypeDatagrid1487041410297" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {    
        var dg = $("#MappMachineTypeDatagrid1487041410297");
       
        // buttons
        // 增加。
        $("#MappMachineTypeToolBar1487041410297 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
			dg.datagrid('getEditor', {index: dg.datagrid("options").hdCurrentRowIndex, field: 'machTypNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappMachineTypeToolBar1487041410297 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
			dg.datagrid('getEditor', {index: dg.datagrid("options").hdCurrentRowIndex, field: 'machTypNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappMachineTypeToolBar1487041410297 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/MappMachineType/save"});
        });
        // 保存。
        $("#MappMachineTypeToolBar1487041410297 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappMachineType/save"});
        });
        // 刷新。
        $("#MappMachineTypeToolBar1487041410297 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappMachineTypeSearchbox1487041410297").val();
        	builder.set("q", value);
        	dg.datagrid("hdReload");
        });
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("guid","desc");
        // searchbox
        $("#MappMachineTypeSearchbox1487041410297").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,machTypCod,srcMachTypCod,machTypNam");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#MappMachineTypeDatagrid1487041410297").datagrid({
        	striped:true,
            url: "../webresources/login/MappMachineType/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#MappMachineTypeToolBar1487041410297",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "guid",
                        title: 'guID',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
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
                        		parentId: '#MappMachineTypeDatagrid1487041410297',
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
                        field: "srcMachTypCod",
                        title: '<font color="red">来源机械类型</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["MappMachineTypeDatagrid1487041410297","MappMachineType","srcMachTypCod"]','length[1,40]']}},
                        sortable: true
                    },
                    {
                        field: "machTypCod",
                        title: '<font color="red">标准机械类型</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor : {
							type : 'combogrid',
							options : HdUtils.code.sbcMachineType({
								required : true,
								parentId : "#MappMachineTypeDatagrid1487041410297",
								textField: 'machTypCod',
								fieldMapping : {
									machTypCod : 'machTypCod',
									machTypNam : 'machTypNam'
								},
								onSelect: function(index,record){    
									var ed = dg.datagrid('getEditor', {
										index : dg.datagrid("options").hdCurrentRowIndex,
										field : 'machTypNam'
									});
									$(ed.target).val(record.machTypNam);	
								}
							})
						},
                        sortable: true
                    },
                    {
                        field: "machTypNam",
                        title: "机械类型名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,100]'}},
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
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
					dg.datagrid('getEditor', {index: dg.datagrid("options").hdCurrentRowIndex, field: 'machTypNam'}).target.prop('disabled', true);
                }
        });
        $("#MappMachineTypeDatagrid1487041410297").datagrid("hdGetColumnNames");
    });
</script>

