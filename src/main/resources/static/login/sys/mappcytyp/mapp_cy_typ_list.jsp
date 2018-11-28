<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappCyTypToolBar1488244147298" style="padding-top: 0px;">
    <div style="float:left;">
    <shiro:hasPermission name="webresources:login:MappCyTyp:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCyTyp:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCyTyp:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCyTyp:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCyTyp:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            </shiro:hasPermission>
            </div>
            <input class="easyui-searchbox" id="MappCyTypSearchbox1488244147298"/>
</div>
<table id="MappCyTypDatagrid1488244147298" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappCyTypDialog1488244147298");
        var dg = $("#MappCyTypDatagrid1488244147298");
        // buttons
        // 增加。
        $("#MappCyTypToolBar1488244147298 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");     
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cyTypNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappCyTypToolBar1488244147298 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cyTypNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappCyTypToolBar1488244147298 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/MappCyTyp/save"});
        });
        // 保存。
        $("#MappCyTypToolBar1488244147298 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappCyTyp/save"});
        });
        // 刷新。
        $("#MappCyTypToolBar1488244147298 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappCyTypSearchbox1488244147298").val();
        	builder.set("q", value);
        	dg.datagrid("hdReload");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("guid","desc");
        // searchbox
        $("#MappCyTypSearchbox1488244147298").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,cyTypCod,srcCyTypCod,cyTypNam");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#MappCyTypDatagrid1488244147298").datagrid({
        	striped:true,
            url: "../webresources/login/MappCyTyp/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            //autoLoad:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#MappCyTypToolBar1488244147298",
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
                        		parentId: '#MappCyTypDatagrid1488244147298',
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
                        field: "srcCyTypCod",
                        title: '<font color="red">来源堆场类型</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type:"uppercasebox", options: {required:true,validType:['isCodeRepeat["MappCyTypDatagrid1488244147298","MappCyTyp","srcCyTypCod"]','length[1,20]']}},
                        sortable: true
                    },
                    {
                        field: "cyTypCod",
                        title: '<font color="red">标准堆场类型</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        //editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,10]'}},
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({
                            	fieldCod: 'CY_TYP_COD'},
                            	{required: true,
                            		textField:'code',
                            	  onSelect:function(record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'cyTypNam'
	                    			});
	                    			$(ed.target).val(record.name);
	                    		}
                            })
                        },  
                        sortable: true
                        /*, formatter:function(value){
                        	if(value===null || value==='')
                        		return;
                        	var list=HdUtils.global.query({fieldCod:'CY_TYP_COD',code:value});
                        	return list.length>0?list[0].name:"";
                        } */
                    },
                    {
                        field: "cyTypNam",
                        title: "堆场类型名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,60]'}},
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
            		//dg.datagrid('getEditor', {index: index, field: 'srcCyTypCod'}).target.prop('disabled', true);
            		dg.datagrid('getEditor', {index: index, field: 'cyTypNam'}).target.prop('disabled', true);
            	}});
        $("#MappCyTypDatagrid1488244147298").datagrid("hdGetColumnNames");
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

