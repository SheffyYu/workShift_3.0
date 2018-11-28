<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappTransportModToolBar1487058394570" style="padding-top: 0px;">
    <div style="float:left">
        <shiro:hasPermission name="webresources:login:MappTransportMod:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappTransportMod:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappTransportMod:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappTransportMod:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappTransportMod:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            </shiro:hasPermission>
    </div>
     <input class="easyui-searchbox" id="MappTransportModSearchbox1487058394570"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="MappTransportModDatagrid1487058394570" style="height:100%"></table>
<!-- end Datagrid -->
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#MappTransportModDatagrid1487058394570");
       // buttons
        // 增加。
        $("#MappTransportModToolBar1487058394570 a[iconCls='icon-add']").on("click", function () {
        	 dg.datagrid("hdAdd");  
        	 var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
             dg.datagrid('getEditor', {index: selectIdx, field: 'transportNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappTransportModToolBar1487058394570 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'transportNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappTransportModToolBar1487058394570 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/MappTransportMod/save"});
        });
        // 保存。
        $("#MappTransportModToolBar1487058394570 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappTransportMod/save"});
        });
        // 刷新。
        $("#MappTransportModToolBar1487058394570 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappTransportModSearchbox1487058394570").val();
        	builder.set("q", value);
        	 dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("guid","desc");
        // searchbox
        $("#MappTransportModSearchbox1487058394570").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns","companyCod,transportMod,transportNam,srcTransportMod");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappTransportModDatagrid1487058394570").datagrid({
        	striped:true,
            url: "../webresources/login/MappTransportMod/find",
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
            toolbar: "#MappTransportModToolBar1487058394570",
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
                        		parentId: '#MappTransportModDatagrid1487058394570',
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
                        field: "srcTransportMod",
                        title: '<font color="red">来源进出港类别</font>',
                        multiSort: true,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,40]'}},
                        halign: "center",
                        width:120,
                        sortable: true
                    },
                    {
                        field: "transportMod",
                        title: '<font color="red">标准进出港类别</font>',
                        multiSort: true,
/*                         formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'TRANSPORT_MOD', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }, */
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({
                            	fieldCod: 'TRANSPORT_MOD'},
                            	{
	                            	required: true,
	                            	textField:'code',
	                            	onSelect:function(record){
		                    			var ed=dg.datagrid('getEditor', {
		                    				index : dg.datagrid("options").hdCurrentRowIndex,
		                    			    field : 'transportNam'
		                    			});
		                    			$(ed.target).val(record.name);
		                    		}
                            	})
                        }, 
                        //editor:{type:"uppercasebox",options:{required:true,validType:['isCodeRepeat["MappTransportModDatagrid1487058394570","MappTransportMod","transportMod"]', 'length[1,36]']}},
                        halign: "center",
                        width:120,
                        sortable: true
                    },
                    {
                        field: "transportNam",
                        title: "进出港类别名称",
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
                        formatter: $.hd.ezui.formatter.datetime,
                        halign: "center",
                        width:140,
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
                        formatter: $.hd.ezui.formatter.datetime,
                        halign: "center",
                        width:140,
                        sortable: true
                    },
                ]],
        onDblClickRow: function (index, data) {
    		dg.datagrid("hdEdit"); 
    		dg.datagrid('getEditor', {index: index, field: 'transportNam'}).target.prop('disabled', true);
    	}});
        $("#MappTransportModDatagrid1487058394570").datagrid("hdGetColumnNames");
    });
</script>

