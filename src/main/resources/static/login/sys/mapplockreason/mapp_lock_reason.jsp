<meta charset="UTF-8">
<div id="MappLockReasonToolBar1487041335167" style="padding-top: 0px;"  >
	<div style="float:left;">
	        <shiro:hasPermission name="webresources:sys:MappLockReason:add">
	            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:sys:MappLockReason:update">
	            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:sys:MappLockReason:delete">
	            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:sys:MappLockReason:save">
	            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:sys:MappLockReason:refresh">
	            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	        </shiro:hasPermission>
	    </div>
    <input class="easyui-searchbox"  id="MappLockReasonSearchbox1487041335167"/>
</div>
<table id="MappLockReasonDatagrid1487041335167" style="height:100%" ></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappLockReasonDialog1487041335167");
        var dg = $("#MappLockReasonDatagrid1487041335167");
        // buttons
        // 增加。
        $("#MappLockReasonToolBar1487041335167 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'lockReasonNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappLockReasonToolBar1487041335167 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'lockReasonNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappLockReasonToolBar1487041335167 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/MappLockReason/save"});
        });
        // 保存。
        $("#MappLockReasonToolBar1487041335167 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappLockReason/save"});
        });
        // 刷新。
        $("#MappLockReasonToolBar1487041335167 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappLockReasonSearchbox1487041335167").val();
        	builder.set("q", value);
        	 dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("guid","desc");
        // searchbox
        $("#MappLockReasonSearchbox1487041335167").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,lockReasonCod,srcLockReasonCod,lockReasonNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappLockReasonDatagrid1487041335167").datagrid({
        	striped:true,
            url: "../webresources/login/MappLockReason/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            sortOrder: 'desc',
            //autoLoad:false,
            sortName: 'updTimestamp',
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            width:800,
            toolbar: "#MappLockReasonToolBar1487041335167",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "guid",
                        title: '<font color="red">guID</font>',
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
                        		parentId: '#MappLockReasonDatagrid1487041335167',
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
                        field: "srcLockReasonCod",
                        title: '<font color="red">来源锁扣原因</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "lockReasonCod",
                        title: '<font color="red">标准锁扣原因</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcLockReason({
                        		required:true,
                        		validType: 'length[1,60]',
                        		parentId:"#MappLockReasonDatagrid1487041335167",
                        		textField:'lockReasonCod',
                        		fieldMapping: {
                        			lockReasonCod : 'lockReasonCod',
                        			lockReasonNam : 'lockReasonNam'
	                    		},
	                        	onSelect:function(index,record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'lockReasonCod'
	                    			});
	                    			$(ed.target).val(record.lockReasonCod);
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'lockReasonNam'
	                    			});
	                    			$(ed.target).val(record.lockReasonNam);
	                    		}
                        	})
                        },                         
                        sortable: true
                    },
                    {
                        field: "lockReasonNam",
                        title: "锁扣原因名称",
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
            		dg.datagrid('getEditor', {index: index, field: 'lockReasonNam'}).target.prop('disabled', true);
            	}});
        $("#MappLockReasonDatagrid1487041335167").datagrid("hdGetColumnNames");
    });
</script>

