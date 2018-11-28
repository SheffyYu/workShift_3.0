<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappFeeItemToolBar1427420966140" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:MappFeeItem:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappFeeItem:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappFeeItem:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappFeeItem:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappFeeItem:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="MappFeeItemSearchbox1427420966140"/>
</div>       
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="MappFeeItemDatagrid1427420966140" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#MappFeeItemDatagrid1427420966140");
        // buttons
        // 增加。
        $("#MappFeeItemToolBar1427420966140 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnFeeItemNam'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'enFeeItemNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappFeeItemToolBar1427420966140 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnFeeItemNam'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'enFeeItemNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappFeeItemToolBar1427420966140 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/MappFeeItem/save"});
        });
        // 保存。
        $("#MappFeeItemToolBar1427420966140 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappFeeItem/save"});
        });
        // 刷新。
        $("#MappFeeItemToolBar1427420966140 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappFeeItemSearchbox1427420966140").val();
        	builder.set("q", value);
        	 dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("guid","desc");
        // 返回后台参数。
        // searchbox
        $("#MappFeeItemSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,srcFeeItemCod,feeItemCod,cnFeeItemNam,enFeeItemNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappFeeItemDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/MappFeeItem/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            //autoLoad:false,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#MappFeeItemToolBar1427420966140",
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
                        hidden:true,
                        sortable: true
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
                        		parentId: '#MappFeeItemDatagrid1427420966140',
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
                        field: "srcFeeItemCod",
                        title: '<font color="red">来源费用条目</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,20]'}},
                        sortable: true
                    },
                    {
                        field: "feeItemCod",
                        title: '<font color="red">标准费用条目</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcFeeItme({
                        		required:true,
                        		parentId:"#MappFeeItemDatagrid1427420966140",
                        		textField:'feeItemCod',
                        		fieldMapping: {
                        			feeItemCod : 'feeItemCod',
                        			cnFeeItemNam : 'cnFeeItemNam'
	                    		},
	                        	onSelect:function(index,record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'cnFeeItemNam'
	                    			});
	                    			$(ed.target).val(record.cnFeeItemNam);
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'enFeeItemNam'
	                    			});
	                    			$(ed.target).val(record.enFeeItemNam);
	                    		}
                        	})
                        },
                        sortable: true
                    },
                    {
                        field: "cnFeeItemNam",
                        title: "费用条目中文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:100,
					    editor: {type: "validatebox", options: {required: false,validType: 'length[0,100]'}}
                    },
                    {
                        field: "enFeeItemNam",
                        title: "费用条目英文名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:100,
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
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'cnFeeItemNam'}).target.prop('disabled', true);
                	dg.datagrid('getEditor', {index: index, field: 'enFeeItemNam'}).target.prop('disabled', true);
                }});
        $("#MappCountryDatagrid1488247714414").datagrid("hdGetColumnNames");
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