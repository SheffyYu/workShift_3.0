<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappDamCodToolBar1487075179116" style="padding-top: 0px;">
    <div  style="float:left;">      
        <shiro:hasPermission name="webresources:login:MappDamCod:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappDamCod:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappDamCod:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappDamCod:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappDamCod:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="MappDamCodSearchbox1487075179116"/>
</div>
<table id="MappDamCodDatagrid1487075179116" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
			var dialogTitleAddF = "增加";
			var dialogTitleEditF = "编辑";
			var diog = $("#MappDamCodDialog1487075179116");
			var dg = $("#MappDamCodDatagrid1487075179116");
         function disableColumn(){
        	 var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
			 dg.datagrid('getEditor', {index: selectIdx, field: 'cnDamNam'}).target.prop('disabled', true);
			 dg.datagrid('getEditor', {index: selectIdx, field: 'enDamNam'}).target.prop('disabled', true);	
         }
         // 增加。
         $("#MappDamCodToolBar1487075179116 a[iconCls='icon-add']").on("click", function() {
             dg.datagrid("hdAdd");
             disableColumn();			
         });
         // 编辑。
         $("#MappDamCodToolBar1487075179116 a[iconCls='icon-edit']").on("click", function() {
             dg.datagrid("hdEdit");
             disableColumn();	
				
         });
         // 删除。
         $("#MappDamCodToolBar1487075179116 a[iconCls='icon-remove']").on("click", function() {
             dg.datagrid("hdRealRemove",{url:"../webresources/login/MappDamCod/save"});
         });
         // 保存。
         $("#MappDamCodToolBar1487075179116 a[iconCls='icon-save']").on("click", function() {
             dg.datagrid("hdSave", {url: "../webresources/login/MappDamCod/save"});
         });
         // 刷新。
         $("#MappDamCodToolBar1487075179116 a[iconCls='icon-reload']").on("click", function() {
        	 var value=$("#MappDamCodSearchbox1487075179116").val();
         	 builder.set("q", value);
         	 dg.datagrid("load");
         });
         // 条件类。
         //var hdConditions = new HdConditions();
         var builder = new HdEzuiQueryParamsBuilder();
         builder.hdEzuiQueryParams.page = 1;
         builder.hdEzuiQueryParams.rows = 20;
         builder.setOrderByClause("guid","desc");
         // searchbox
         $("#MappDamCodSearchbox1487075179116").searchbox({prompt: "请输入...", searcher: function(value, name) {
                 builder.set("q", value);
                 builder.set("queryColumns", "companyCod,damCod,srcDamCod,cnDamNam,enDamNam");
                 dg.datagrid("load");
             }});
         // datagrid
        $("#MappDamCodDatagrid1487075179116").datagrid({
        	striped:true,
            url: "../webresources/login/MappDamCod/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            //autoLoad:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#MappDamCodToolBar1487075179116",
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
                        		parentId: '#MappDamCodDatagrid1487075179116',
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
                        field: "srcDamCod",
                        title: '<font color="red">来源残损</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["MappDamCodDatagrid1487075179116","MappDamCod","srcDamCod"]','length[1,20]']}},
                    },
                    {
                        field: "damCod",
                        title: '<font color="red">标准残损</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor : {
							type : 'combogrid',
							options : HdUtils.code.sbcDamCod({
								required : true,
								parentId : "#MappDamCodDatagrid1487075179116",
								textField: 'damCod', 
								onSelect: function(index,record){    
									var ed = dg.datagrid('getEditor', {
										index : dg.datagrid("options").hdCurrentRowIndex,
										field : 'cnDamNam'
									});
									$(ed.target).val(record.cnDamNam);	
									var ed = dg.datagrid('getEditor', {
										index : dg.datagrid("options").hdCurrentRowIndex,
										field : 'enDamNam'
									});
									$(ed.target).val(record.enDamNam);	
								}
							})
						}
                    },
                    {
                        field: "cnDamNam",
                        title: "残损中文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:160,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,100]'}}
                    },
                    {
                        field: "enDamNam",
                        title: "残损英文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:160,
                        editor: {type: "uppercasebox", options: {required: false,validType: 'length[0,100]'}}
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
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '更新人',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '更新时间',
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        width: 140,
                        sortable: true
                    },
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit");
                	disableColumn();	
                }  
        });
        $("#MappDamCodDatagrid1487075179116").datagrid("hdGetColumnNames");
    });
</script>

