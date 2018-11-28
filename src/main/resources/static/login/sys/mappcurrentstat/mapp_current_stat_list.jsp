<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappCurrentStatToolBar1488244147298" style="padding-top: 0px;">
    <div style="float:left">
        <shiro:hasPermission name="webresources:login:MappCurrentStat:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrentStat:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrentStat:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrentStat:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:MappCurrentStat:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            </shiro:hasPermission>
    </div>
            <input class="easyui-searchbox" id="MappCurrentStatSearchbox1488244147298"/>
            
</div>
<table id="MappCurrentStatDatagrid1488244147298" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappCurrentStatDialog1488244147298");
        var dg = $("#MappCurrentStatDatagrid1488244147298");
        // buttons
        // 增加。
        $("#MappCurrentStatToolBar1488244147298 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
			dg.datagrid('getEditor', {index: selectIdx, field: 'currentStatNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappCurrentStatToolBar1488244147298 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'srcCurrentStat'}).target.prop('disabled', true);
			dg.datagrid('getEditor', {index: selectIdx, field: 'currentStatNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappCurrentStatToolBar1488244147298 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/MappCurrentStat/save"});
        });
        // 保存。
        $("#MappCurrentStatToolBar1488244147298 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/MappCurrentStat/save"});
        });
        // 刷新。
        $("#MappCurrentStatToolBar1488244147298 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#MappCurrentStatSearchbox1488244147298").val();
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
        $("#MappCurrentStatSearchbox1488244147298").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,currentStat,srcCurrentStat,currentStatNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappCurrentStatDatagrid1488244147298").datagrid({
        	striped:true,
            url: "../webresources/login/MappCurrentStat/find",
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
            toolbar: "#MappCurrentStatToolBar1488244147298",
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
                        		parentId: '#MappCurrentStatDatagrid1488244147298',
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
                        field: "srcCurrentStat",
                        title: '<font color="red">来源箱状态</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        //editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,40]'}},
                        editor: {type:"uppercasebox", options: {required:true,validType:['isCodeRepeat["MappCurrentStatDatagrid1488244147298","MappCurrentStat","srcCurrentStat"]','length[1,40]']}},
                        sortable: true
                    },
                    {
                        field: "currentStat",
                        title: '<font color="red">标准箱状态</font>',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        //editor: {type: "uppercasebox", options: {required:false,validType: 'length[1,36]'}},
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({
                            	fieldCod: 'CURRENT_STAT'},
                            	{required: true,
                            		textField:'code',
                            	  onSelect:function(record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'currentStatNam'
	                    			});
	                    			$(ed.target).val(record.name);
	                    		}
                            })
                        },  
                        sortable: true
                    },
                    {
                        field: "currentStatNam",
                        title: "箱状态名称",
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
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                	dg.datagrid('getEditor', {index: selectIdx, field: 'srcCurrentStat'}).target.prop('disabled', true);
        			dg.datagrid('getEditor', {index: selectIdx, field: 'currentStatNam'}).target.prop('disabled', true);
                }
        });
        $("#MappCurrentStatDatagrid1488244147298").datagrid("hdGetColumnNames");
    });
</script>

