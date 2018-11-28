<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappPackageToolBar1487062340496" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:MappPackage:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappPackage:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappPackage:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappPackage:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappPackage:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="MappPackageSearchbox1487062340496"/>
</div>
<table id="MappPackageDatagrid1487062340496" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappPackageDialog1487062340496");
        var dg = $("#MappPackageDatagrid1487062340496");
        // buttons
        // 增加。
        $("#MappPackageToolBar1487062340496 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnPackageNam'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'enPackageNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappPackageToolBar1487062340496 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnPackageNam'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'enPackageNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappPackageToolBar1487062340496 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/mapppackage/save"});
        });
        // 保存。
        $("#MappPackageToolBar1487062340496 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/mapppackage/save"});
        });
        // 刷新。
        $("#MappPackageToolBar1487062340496 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappPackageSearchbox1487062340496").val();
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
        $("#MappPackageSearchbox1487062340496").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,srcPackageCod,packageCod,cnPackageNam,enPackageNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappPackageDatagrid1487062340496").datagrid({
        	striped:true,
            url: "../webresources/login/mapppackage/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            //autoLoad:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#MappPackageToolBar1487062340496",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "guid",
                        title: "主键",
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
                        		parentId: '#MappPackageDatagrid1487062340496',
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
                        field: "srcPackageCod",
                        title: '<font color="red">来源包装</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "validatebox", options: {required:true,validType: 'length[1,20]'}},
                        sortable: true
                    },
                    {
                        field: "packageCod",
                        title: '<font color="red">标准包装</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcPackage({
                        		required:true,
                        		parentId:"#MappPackageDatagrid1487062340496",
                        		textField:'packageCod',
                        		fieldMapping: {
                        			packageCod : 'packageCod',
                        			cnPackageNam : 'cnPackageNam'
	                    		},
	                        	onSelect:function(index,record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'cnPackageNam'
	                    			});
	                    			$(ed.target).val(record.cnPackageNam);
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'enPackageNam'
	                    			});
	                    			$(ed.target).val(record.enPackageNam);
	                    		}
                        	})
                        },
                        sortable: true
                    },
                    {
                        field: "cnPackageNam",
                        title: "包装中文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {validType: 'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "enPackageNam",
                        title: "包装英文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "uppercasebox", options: {validType: 'length[0,100]'}},
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
                	dg.datagrid('getEditor', {index: index, field: 'cnPackageNam'}).target.prop('disabled', true);
                    dg.datagrid('getEditor', {index: index, field: 'enPackageNam'}).target.prop('disabled', true);
                }
        });
        $("#MappPackageDatagrid1487062340496").datagrid("hdGetColumnNames");
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

