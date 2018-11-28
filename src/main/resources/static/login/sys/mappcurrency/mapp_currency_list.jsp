<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappCurrencyToolBar1488250662411" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:MappCurrency:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrency:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrency:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrency:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrency:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            </shiro:hasPermission>
        &nbsp;
    </div>
     <input class="easyui-searchbox" id="MappCurrencySearchbox1488250662411"/>
</div>
<table id="MappCurrencyDatagrid1488250662411" style="height:100%"></table>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#MappCurrencyDatagrid1488250662411");
        // buttons
        // 增加。
        $("#MappCurrencyToolBar1488250662411 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'currencyNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappCurrencyToolBar1488250662411 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'currencyNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappCurrencyToolBar1488250662411 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/MappCurrency/save"});
        });
        // 保存。
        $("#MappCurrencyToolBar1488250662411 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappCurrency/save"});
        });
        // 刷新。
        $("#MappCurrencyToolBar1488250662411 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappCurrencySearchbox1488250662411").val();
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
        $("#MappCurrencySearchbox1488250662411").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,currencyCod,srcCurrencyCod,currencyNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappCurrencyDatagrid1488250662411").datagrid({
        	striped:true,
            url: "../webresources/login/MappCurrency/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            //autoLoad:false,
            pageSize: 20,
            toolbar: "#MappCurrencyToolBar1488250662411",
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
                        hidden: true,
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
                        		parentId: '#MappCurrencyDatagrid1488250662411',
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
                        field: "srcCurrencyCod",
                        title: '<font color="red">来源币别</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "currencyCod",
                        title: '<font color="red">标准币别</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({
                            	fieldCod: 'CURRENCY_COD'},
                            	{required: true,
                            		textField:'code',
                            	onSelect:function(record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'currencyNam'
	                    			});
	                    			$(ed.target).val(record.name);
	                    		}
                            })
                        },
                        sortable: true
                    },
                    {
                        field: "currencyNam",
                        title: "币别名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,1000]'}},
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
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	dg.datagrid('getEditor', {index: index, field: 'currencyNam'}).target.prop('disabled', true);
                }});
        $("#MappCurrencyDatagrid1488250662411").datagrid("hdGetColumnNames");
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

