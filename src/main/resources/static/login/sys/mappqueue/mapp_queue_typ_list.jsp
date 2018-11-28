
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="MappQueueTypToolBar1487038873248" style="padding-top: 0px;">
    <div style="float:left">          
        <shiro:hasPermission name="webresources:sys:MappQueueTyp:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappQueueTyp:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappQueueTyp:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappQueueTyp:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:MappQueueTyp:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission> 
        &nbsp; 
    </div>
    <input class="easyui-searchbox" id="MappQueueTypSearchbox1427420966140"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="MappQueueTypDatagrid1427420966140" style="height:100%"></table>
              
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#MappQueueTypDialog1486627282418");
        var dg = $("#MappQueueTypDatagrid1427420966140");
        
        // buttons
        // 增加。
        $("#MappQueueTypToolBar1487038873248 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'queueTypNam'}).target.prop('disabled', true);
        });
        // 编辑。
        $("#MappQueueTypToolBar1487038873248 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'queueTypNam'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappQueueTypToolBar1487038873248 a[iconCls='icon-remove']").on("click", function() {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/MappQueueTyp/save"});
        });
        // 保存。
        $("#MappQueueTypToolBar1487038873248 a[iconCls='icon-save']").on("click", function() {
        	dg.datagrid("hdSave", {url: "../webresources/login/MappQueueTyp/save"});
        });
        // 刷新。
        $("#MappQueueTypToolBar1487038873248 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#MappQueueTypSearchbox1427420966140").val();
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
//        var queryParams = {
//            builder: builder.build(),
//            queryColumns: {}
//        };
        // searchbox
        $("#MappQueueTypSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,queueTyp,srcQueueTyp,queueTypNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappQueueTypDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/MappQueueTyp/find",
            queryParams: builder.build(),
            method: "post",
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
            toolbar: "#MappQueueTypToolBar1487038873248",
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
					    sortable: true,
					    width:120,
					    editor: {type: 'combogrid',
                        	options: HdUtils.code.sbcCompanyByCompanyCod({
                        		parentId: '#MappQueueTypDatagrid1427420966140',
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
					    field: "srcQueueTyp",
					    title: '<font color="red">来源队列类型</font>',
					    multiSort: true,
					    halign: "center",
					    sortable: true,
					    width:120,
					    editor: {type: "uppercasebox", options: {required: true,validType: 'length[1,40]'}}
					},
					{
					    field: "queueTyp",
					    title: '<font color="red">标准队列类型</font>',
					    multiSort: true,
					    halign: "center",
					    sortable: true,
					    width:120,
					    editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({ fieldCod: 'QUEUE_TYP'},
                                {required: true,
                                    textField:'code',
                                    onSelect:function(record){
                                    var ed=dg.datagrid('getEditor', {
                                        index : dg.datagrid("options").hdCurrentRowIndex,
                                        field : 'queueTypNam'
                                    });
                                    $(ed.target).val(record.name);
                                }
                                })
                        }
// 					    editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["MappQueueTypDatagrid1427420966140","MappQueueTyp","queueTyp"]','length[1,36]']}}					
					},
					{
					    field: "queueTypNam",
					    title: "队列类型名称",
					    multiSort: true,
					    halign: "center",
					    sortable: true,
					    width:160,
					    editor: {type: "validatebox", options: {required: false,validType: 'length[0,100]'}},
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
                	    field:"insTimestamp",
                	    title:"创建时间",
                	    multiSort:true,
                	    halign:"center",
                	    width:140,
                	    formatter: $.hd.ezui.formatter.datetime,
                	    sortable:true
               		},
               	    {
                	    
                	    field:"updAccount",
                	    title:"更新人",
                	    multiSort:true,
                	    halign:"center",
                	    width:80,
                	    sortable:true
               		},
               	    {
                	    
                	    field:"updTimestamp",
                	    title:"更新时间",
                	    multiSort:true,
                	    halign:"center",
                	    formatter: $.hd.ezui.formatter.datetime,
                	    width:140,
                	    sortable:true
                	},
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'queueTypNam'}).target.prop('disabled', true);
                }
        });
        $("#MappQueueTypDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
</script>