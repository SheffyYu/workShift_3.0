<meta charset="UTF-8">
<div id="MappOthWorkWayToolBar1487053926981" style="padding-top: 0px;" >
    <div style="float:left">
        <shiro:hasPermission name="webresources:login:MappOthWorkWay:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOthWorkWay:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOthWorkWay:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOthWorkWay:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappOthWorkWay:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="MappOthWorkWaySearchbox1487053926981"/>
</div>
<table id="MappOthWorkWayDatagrid1487053926981" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappOthWorkWayDialog1487053926981");
        var dg = $("#MappOthWorkWayDatagrid1487053926981");
        // buttons
        // 增加。
        $("#MappOthWorkWayToolBar1487053926981 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'othWorkWayNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappOthWorkWayToolBar1487053926981 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'othWorkWayNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappOthWorkWayToolBar1487053926981 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/mappothworkway/save"});
        });
        // 保存。
        $("#MappOthWorkWayToolBar1487053926981 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/mappothworkway/save"});
        });
        // 刷新。
        $("#MappOthWorkWayToolBar1487053926981 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappOthWorkWaySearchbox1487053926981").val();
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
        $("#MappOthWorkWaySearchbox1487053926981").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,srcOthWorkWay,othWorkWay,othWorkWayNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappOthWorkWayDatagrid1487053926981").datagrid({
        	striped:true,
            url: "../webresources/login/mappothworkway/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            rownumbers: true,
            pageSize: 20,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#MappOthWorkWayToolBar1487053926981",
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
                        width:120,
                        editor: {type: 'combogrid',
                        	options: HdUtils.code.sbcCompanyByCompanyCod({
                        		parentId: '#MappOthWorkWayDatagrid1487053926981',
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
                        field: "srcOthWorkWay",
                        title: '<font color="red">来源杂作业方式</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "uppercasebox", options: {required:true,validType:'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "othWorkWay",
                        title: '<font color="red">标准杂作业方式</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "combobox", 
                        	options: HdUtils.code.scode({
                            	fieldCod: 'CURRENT_STAT'},
                            	{	
                            		required: true,
                            		textField:'code',
                            		onSelect:function(record){
                            			var ed = dg.datagrid('getEditor', {
    										index : dg.datagrid("options").hdCurrentRowIndex,
    										field : 'othWorkWayNam'
    									});
    									$(ed.target).val(record.name);
                            		}
                            	})
                        },
                        sortable: true
                    },
                    {
                        field: "othWorkWayNam",
                        title: "杂作业名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required:false,validType:'length[0,100]'}},
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
            		dg.datagrid('getEditor', {index: index, field: 'othWorkWayNam'}).target.prop('disabled', true);
            	}});
        $("#MappOthWorkWayDatagrid1487053926981").datagrid("hdGetColumnNames");
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