<meta charset="UTF-8">
<!-- 工具栏 -->
	<div id="MappCountryToolBar1488247714414" style="padding-top: 0px;">
	    <div style="float:left;">
	        <shiro:hasPermission name="webresources:login:MappCountry:add">
	            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappCountry:update">
	            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappCountry:delete">
	            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappCountry:save">
	            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:MappCountry:refresh">
	            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	        </shiro:hasPermission>
	    </div>
	    <input class="easyui-searchbox" id="MappCountrySearchbox1488247714414"/>
	</div>
	<table id="MappCountryDatagrid1488247714414" style="height:100%"></table>
<!-- 工具栏 结束 -->
<!-- Datagrid -->

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#MappCountryDatagrid1488247714414");
        // buttons
        // 增加。
        $("#MappCountryToolBar1488247714414 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnCountryNam'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'enCountryNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappCountryToolBar1488247714414 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cnCountryNam'}).target.prop('disabled', true);
            dg.datagrid('getEditor', {index: selectIdx, field: 'enCountryNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappCountryToolBar1488247714414 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/MappCountry/save"});
        });
        // 保存。
        $("#MappCountryToolBar1488247714414 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappCountry/save"});
        });
        // 刷新。
        $("#MappCountryToolBar1488247714414 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappCountrySearchbox1488247714414").val();
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
        $("#MappCountrySearchbox1488247714414").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,countryCod,srcCountryCod,cnCountryNam,enCountryNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappCountryDatagrid1488247714414").datagrid({
        	striped:true,
            url: "../webresources/login/MappCountry/find",
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
            toolbar: "#MappCountryToolBar1488247714414",
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
                        		parentId: '#MappCountryDatagrid1488247714414',
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
                        field: "srcCountryCod",
                        title: '<font color="red">来源国家</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "countryCod",
                        title: '<font color="red">标准国家</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcCountry({
                        		required:true,
                        		parentId:"#MappCountryDatagrid1488247714414",
                        		textField:'countryCod',
                        		fieldMapping: {
                        			countryCod : 'countryCod',
                        			cnCountryNam : 'cnCountryNam'
	                    		},
	                        	onSelect:function(index,record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'cnCountryNam'
	                    			});
	                    			$(ed.target).val(record.cnCountryNam);
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
                        field: "cnCountryNam",
                        title: "国家中文名称",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    {
                        field: "enCountryNam",
                        title: "国家英文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor:{type:"uppercasebox",options:{required:false,validType: 'length[0,60]'}},
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
                	dg.datagrid('getEditor', {index: index, field: 'cnCountryNam'}).target.prop('disabled', true);
                	dg.datagrid('getEditor', {index: index, field: 'enCountryNam'}).target.prop('disabled', true);
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

