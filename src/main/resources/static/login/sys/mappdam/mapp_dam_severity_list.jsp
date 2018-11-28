<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappDamSeverityToolBar1487075179116" style="padding-top: 0px;">
    <div style="float:left;">      
        <shiro:hasPermission name="webresources:sys:MappDamSeverity:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamSeverity:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamSeverity:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamSeverity:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamSeverity:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="MappDamSeveritySearchbox1487075179116"/>
</div>
<table id="MappDamSeverityDatagrid1487075179116" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
    	var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappDamSeverityDialog1486628368990");
    	var dg = $("#MappDamSeverityDatagrid1487075179116");
    	function disableColumn(){
    		var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
			dg.datagrid('getEditor', {index: selectIdx, field: 'cnSeverityNam'}).target.prop('disabled', true);
			dg.datagrid('getEditor', {index: selectIdx, field: 'enSeverityNam'}).target.prop('disabled', true);							
         };
         // buttons
         // 增加。
         $("#MappDamSeverityToolBar1487075179116 a[iconCls='icon-add']").on("click", function() {
             dg.datagrid("hdAdd");
             disableColumn();			
         });
         // 编辑。
         $("#MappDamSeverityToolBar1487075179116 a[iconCls='icon-edit']").on("click", function() {
             dg.datagrid("hdEdit");
             disableColumn();
         });
         // 删除。
         $("#MappDamSeverityToolBar1487075179116 a[iconCls='icon-remove']").on("click", function() {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/MappDamSeverity/save"});
         });
         // 保存。
         $("#MappDamSeverityToolBar1487075179116 a[iconCls='icon-save']").on("click", function() {
             dg.datagrid("hdSave", {url: "../webresources/login/MappDamSeverity/save"});
         });
         // 刷新。
         $("#MappDamSeverityToolBar1487075179116 a[iconCls='icon-reload']").on("click", function() {
        	 var value=$("#MappDamSeveritySearchbox1487075179116").val();
         	 builder.set("q", value);
         	 dg.datagrid("load");
         });
         // 条件类。
         //var hdConditions = new HdConditions();
         var builder = new HdEzuiQueryParamsBuilder();
         builder.hdEzuiQueryParams.page = 1;
         builder.hdEzuiQueryParams.rows = 20;
         builder.setOrderByClause("guid","desc");
         $("#MappDamSeveritySearchbox1487075179116").searchbox({prompt: "请输入...", searcher: function(value, name) {
                 builder.set("q", value);
                 builder.set("queryColumns", "companyCod,damSeverityCod,srcDamSeverityCod,cnSeverityNam,enSeverityNam");
                 dg.datagrid("load");
             }});
         // datagrid
        $("#MappDamSeverityDatagrid1487075179116").datagrid({
        	striped:true,
            url: "../webresources/login/MappDamSeverity/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            //autoLoad:false,
            pageSize: 20,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#MappDamSeverityToolBar1487075179116",
            fit: true,
            fitColumns: false,
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
                        		parentId: '#MappDamSeverityDatagrid1487075179116',
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
                        field: "srcDamSeverityCod",
                        title: "来源残损程度",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["MappDamSeverityDatagrid1487075179116","MappDamSeverity","srcDamSeverityCod"]','length[1,20]']}},
                    },
                    {
                        field: "damSeverityCod",
                        title: '<font color="red">标准残损程度</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor : {
							type : 'combogrid',
							options : HdUtils.code.sbcDamSeverity({
								required : true,
								parentId : "#MappDamSeverityDatagrid1487075179116",
								textField: 'damSeverityCod',
								onSelect: function(index,record){    
									var ed = dg.datagrid('getEditor', {
										index : dg.datagrid("options").hdCurrentRowIndex,
										field : 'cnSeverityNam'
									});
									$(ed.target).val(record.cnSeverityNam);	
									var ed = dg.datagrid('getEditor', {
										index : dg.datagrid("options").hdCurrentRowIndex,
										field : 'enSeverityNam'
									});
									$(ed.target).val(record.enSeverityNam);	
								}
							})
						}
                    },
                    {
                        field: "cnSeverityNam",
                        title: "残损程度中文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:160,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,100]'}}
                    },
                    {
                        field: "enSeverityNam",
                        title: "残损程度英文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:160,
                        editor: {type: "uppercasebox", options: {required: false,validType: 'length[0,100]'}}
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
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	disableColumn();
                }  
        });
        $("#MappDamSeverityDatagrid1487075179116").datagrid("hdGetColumnNames");
    });
</script>