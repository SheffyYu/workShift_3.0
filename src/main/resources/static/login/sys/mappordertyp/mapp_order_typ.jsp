
<meta  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8">
<!-- 工具栏 -->
<div id="MappOrderTypToolBar1487041335167" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:sys:MappOrderTyp:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOrderTyp:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOrderTyp:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOrderTyp:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOrderTyp:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            </shiro:hasPermission>
        &nbsp;
    </div>
        <input class="easyui-searchbox" id="MappOrderTypSearchbox1487041335167"/>
</div>
<table id="MappOrderTypDatagrid1487041335167" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappOrderTypDialog1487041335167");
        var dg = $("#MappOrderTypDatagrid1487041335167");
        // buttons
        // 增加。
        $("#MappOrderTypToolBar1487041335167 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'orderTypNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappOrderTypToolBar1487041335167 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'orderTypNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappOrderTypToolBar1487041335167 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/MappOrderTyp/save"});
        });
        // 保存。
        $("#MappOrderTypToolBar1487041335167 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappOrderTyp/save"});
        });
        // 刷新。
        $("#MappOrderTypToolBar1487041335167 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappOrderTypSearchbox1487041335167").val();
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
        $("#MappOrderTypSearchbox1487041335167").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,orderTypCod,srcOrderTypCod,orderTypNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappOrderTypDatagrid1487041335167").datagrid({
        	striped:true,
            url: "../webresources/login/MappOrderTyp/find",
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
            toolbar: "#MappOrderTypToolBar1487041335167",
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
                        		parentId: '#MappOrderTypDatagrid1487041335167',
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
                        field: "srcOrderTypCod",
                        title: '<font color="red">来源委托类型</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "orderTypCod",
                        title: '<font color="red">标准委托类型</font>',
                        multiSort: true,
                        halign: "center",
                       /*  formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CURRENT_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }, */
                        width:120,
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({
                            	fieldCod: 'ORDER_TYP_COD'},
                            	{required: true,
                            		textField:'code',
                            	  onSelect:function(record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'orderTypNam'
	                    			});
	                    			$(ed.target).val(record.name);
	                    		}
                            })
                        }, 
                        sortable: true
                    },
                    {
                        field: "orderTypNam",
                        title: "委托类型名称",
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
            		dg.datagrid('getEditor', {index: index, field: 'orderTypNam'}).target.prop('disabled', true);
            	}});
        $("#MappOrderTypDatagrid1487041335167").datagrid("hdGetColumnNames");
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

