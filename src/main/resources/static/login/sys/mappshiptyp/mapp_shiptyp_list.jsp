<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappShipTypToolBar1487049309549" style="padding-top: 0px;">
    <div style="float:left">
        <shiro:hasPermission name="webresources:login:MappShipTyp:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappShipTyp:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappShipTyp:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappShipTyp:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappShipTyp:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            </shiro:hasPermission>
    </div>
     <input class="easyui-searchbox" id="MappShipTypSearchbox1487049309549"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="MappShipTypDatagrid1487049309549" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#MappShipTypDatagrid1487049309549");
        // buttons
        // 增加。
        $("#MappShipTypToolBar1487049309549 a[iconCls='icon-add']").on("click", function () {
            dg.datagrid("hdAdd");    
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'shipTypNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappShipTypToolBar1487049309549 a[iconCls='icon-edit']").on("click", function () {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'shipTypNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappShipTypToolBar1487049309549 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove",{url:"../webresources/login/MappShipTyp/save"});
        });
        // 保存。
        $("#MappShipTypToolBar1487049309549 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappShipTyp/save"});
        });
        // 刷新。
        $("#MappShipTypToolBar1487049309549 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappShipTypSearchbox1487049309549").val();
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
        $("#MappShipTypSearchbox1487049309549").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns","companyCod,shipTypCod,srcShipTypCod,shipTypNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappShipTypDatagrid1487049309549").datagrid({
        	striped:true,
            url: "../webresources/login/MappShipTyp/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            //autoLoad:false,
            remoteSort:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#MappShipTypToolBar1487049309549",
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
                        hidden:true,
                        halign: "center",
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
                        		parentId: '#MappShipTypDatagrid1487049309549',
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
                        field: "srcShipTypCod",
                        title: '<font color="red">来源船舶类型</font>',
                        multiSort: true,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,40]'}},
                        halign: "center",
                        width:120,
                        sortable: true
                    },
                    {
                        field: "shipTypCod",
                        title: '<font color="red">标准船舶类型</font>',
                        multiSort: true,
                        /* formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'SHIP_TYP_COD', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }, */
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({
                            	fieldCod: 'SHIP_TYP_COD'},
                            	{required: true,
                            		textField:'code',
                            	onSelect:function(record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'shipTypNam'
	                    			});
	                    			$(ed.target).val(record.name);
	                    		}
                            })
                        }, 
                        //editor:{type:"uppercasebox",options:{required:true,validType:['isCodeRepeat["MappShipTypDatagrid1487049309549","MappShipTyp","shipTypCod"]', 'length[1,36]']}},
                        halign: "center",
                        width:120,
                        sortable: true
                    },
                    {
                        field: "shipTypNam",
                        title: "船舶类型名称",
                        multiSort: true,
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,100]'}},
                        halign: "center",
                        width:160,
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
                        formatter: $.hd.ezui.formatter.datetime,
                        width:140,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        width:80,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        width:140,
                        sortable: true
                    },
                ]],
        onDblClickRow: function (index, data) {
    		dg.datagrid("hdEdit"); 
    		dg.datagrid('getEditor', {index: index, field: 'shipTypNam'}).target.prop('disabled', true);
    	}});
    });
</script>

