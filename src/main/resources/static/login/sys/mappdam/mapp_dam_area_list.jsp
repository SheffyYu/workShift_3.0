<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappDamAreaToolBar1487052014398" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:sys:MappDamArea:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamArea:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamArea:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamArea:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappDamArea:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
   </div>
   <input class="easyui-searchbox" id="MappDamAreaSearchbox1487052014398"/>
</div>
<table id="MappDamAreaDatagrid1487052014398" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappDamAreaDialog1487052014398");
        var dg = $("#MappDamAreaDatagrid1487052014398");
        // buttons
        // 增加。
        $("#MappDamAreaToolBar1487052014398 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");  
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
			dg.datagrid('getEditor', {index: selectIdx, field: 'cnDamAreaNam'}).target.prop('disabled', true);
			dg.datagrid('getEditor', {index: selectIdx, field: 'enDamAreaNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappDamAreaToolBar1487052014398 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	 var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
        	 //dg.datagrid('getEditor', {index: selectIdx, field: 'srcDamAreaCod'}).target.prop('disabled', true);
	         dg.datagrid('getEditor', {index: selectIdx, field: 'cnDamAreaNam'}).target.prop('disabled', true);
	         dg.datagrid('getEditor', {index: selectIdx, field: 'enDamAreaNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappDamAreaToolBar1487052014398 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/MappDamArea/save"});
        });
        // 保存。
        $("#MappDamAreaToolBar1487052014398 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappDamArea/save"});
        });
        // 刷新。
        $("#MappDamAreaToolBar1487052014398 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappDamAreaSearchbox1487052014398").val();
        	builder.set("q", value);
        	 dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("guid","desc");
        // searchbox
        $("#MappDamAreaSearchbox1487052014398").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,damAreaCod,srcDamAreaCod,cnDamAreaNam,enDamAreaNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappDamAreaDatagrid1487052014398").datagrid({
        	striped:true,
            url: "../webresources/login/MappDamArea/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#MappDamAreaToolBar1487052014398",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "guid",
                        title: '<font color="red"></font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden:true
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
                        		parentId: '#MappDamAreaDatagrid1487052014398',
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
                        field: "srcDamAreaCod",
                        title: '<font color="red">来源残损区域</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor : {
							type : "uppercasebox",
							options : {
								required : true,
								validType : ['isCodeRepeat["MappDamAreaDatagrid1487052014398","MappDamArea","srcDamAreaCod"]','length[1,40]']
							}
						},
                        sortable: true
                    },
                    {
                        field: "damAreaCod",
                        title: '<font color="red">标准残损区域</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcDamArea({
                        		required:true,
                        		parentId:"#MappDamAreaDatagrid1487052014398",
                        		textField:'damAreaCod',
                        		fieldMapping: {
                        			damAreaCod : 'damAreaCod',
                        			cnDamAreaNam : 'cnDamAreaNam'
	                    		},
	                        	onSelect:function(index,record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'cnDamAreaNam'
	                    			});
	                    			$(ed.target).val(record.cnDamAreaNam);
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'enCountryNam'
	                    			});
	                    			$(ed.target).val(record.enCountryNam);
	                    		}
                        	})
                        },
                        sortable: true
                    },
                    {
                        field: "cnDamAreaNam",
                        title: "残损范围中文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "enDamAreaNam",
                        title: "残损范围英文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[0,100]'}},
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
                    }
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
   		            dg.datagrid('getEditor', {index: selectIdx, field: 'cnDamAreaNam'}).target.prop('disabled', true);
   		            dg.datagrid('getEditor', {index: selectIdx, field: 'enDamAreaNam'}).target.prop('disabled', true);
                }});
        $("#MappDamAreaDatagrid1487052014398").datagrid("hdGetColumnNames");
    });
</script>

