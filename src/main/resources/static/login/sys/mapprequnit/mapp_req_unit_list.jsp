<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappReqUnitToolBar1427420966140" style="padding-top: 0px;">
    <div style="float:left">
        <shiro:hasPermission name="webresources:sys:MappReqUnit:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappReqUnit:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappReqUnit:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappReqUnit:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappReqUnit:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
            &nbsp;
    </div>
    <input class="easyui-searchbox" id="MappReqUnitSearchbox1427420966140"/>
</div>
<table id="MappReqUnitDatagrid1427420966140" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {
    	var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappReqUnitDialog1427420966140");
        var dg = $("#MappReqUnitDatagrid1427420966140");
        // buttons
        // 增加。
        $("#MappReqUnitToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'reqUnitNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappReqUnitToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'reqUnitNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappReqUnitToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/MappReqUnit/save"});
        });
        // 保存。
        $("#MappReqUnitToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/MappReqUnit/save"});
        });
        // 刷新。
        $("#MappReqUnitToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#MappReqUnitSearchbox1427420966140").val();
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
        $("#MappReqUnitSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,reqUnitCod,srcReqUnitCod,reqUnitNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappReqUnitDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/MappReqUnit/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            //autoLoad:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#MappReqUnitToolBar1427420966140",
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
                        		parentId: '#MappReqUnitDatagrid1427420966140',
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
					    field: "srcReqUnitCod",
					    title: '<font color="red">来源申请方</font>',
					    multiSort: true,
					    halign: "center",
					    sortable: true,
					    width:120,
					    editor: {type: "uppercasebox", options: {required: true,validType: 'length[1,40]'}}
					},
					{
					    field: "reqUnitCod",
					    title: '<font color="red">标准申请方</font>',
					    multiSort: true,
					    halign: "center",
					    sortable: true,
					    width:120,
					    editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({
                            	fieldCod: 'REQ_UNIT_COD'},
                            	{required: true,
                            		textField:'code',
                            	  onSelect:function(record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'reqUnitNam'
	                    			});
	                    			$(ed.target).val(record.name);
	                    		}
                            })
                        }
					    //editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["MappReqUnitDatagrid1427420966140","MappReqUnit","reqUnitCod"]','length[1,36]']}}
					},
					{
					    field: "reqUnitNam",
					    title: "申请方名称",
					    multiSort: true,
					    halign: "center",
					    sortable: true,
					    width:160,
					    editor: {type: "validatebox", options: {required: false,validType: 'length[0,100]'}}
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
                	    field:"insTimestamp",
                	    title:"创建时间",
                	    multiSort:true,
                	    halign:"center",
                	    formatter: $.hd.ezui.formatter.datetime,
                	    width:140,
                	    sortable:true
               		},
               	    {
                	    
                	    field:"updAccount",
                	    title:"更新人",
                	    multiSort:true,
                	    halign:"center",
                	    width:80,
                	    sortable:true
               		},
               	    {
                	    
                	    field:"updTimestamp",
                	    title:"更新时间",
                	    multiSort:true,
                	    halign:"center",
                	    formatter: $.hd.ezui.formatter.datetime,
                	    width:140,
                	    sortable:true
                	}
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'reqUnitNam'}).target.prop('disabled', true);
                }             
        });
        $("#MappReqUnitDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
</script>