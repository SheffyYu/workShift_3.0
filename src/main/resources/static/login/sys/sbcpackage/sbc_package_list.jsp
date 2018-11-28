<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcPackageToolBar1427420966140" style="padding-top: 0px;">
    <div>
        <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcPackage:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPackage:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPackage:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPackage:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPackage:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
        &nbsp;
        </div>
        <input class="easyui-searchbox" id="SbcPackageSearchbox1427420966140"/>
    </div>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="SbcPackageDatagrid1427420966140" style="height:100%"></table>
<!-- end Datagrid -->
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcPackageDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SbcPackageToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcPackageToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'packageCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcPackageToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcPackage/save"});
        });
        // 保存。
        $("#SbcPackageToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcPackage/save"});
        });
        // 刷新。
        $("#SbcPackageToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#SbcPackageSearchbox1427420966140").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("packageCod","desc");
        // searchbox
        $("#SbcPackageSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "packageCod,cnPackageNam,enPackageNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcPackageDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/SbcPackage/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcPackageToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "packageCod",
                        title: '<font color="red">包装代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcPackageDatagrid1427420966140","SbcPackage","packageCod"]','length[1,10]']}},
                        sortable: true
                    }, 
                    {
                        field: "enPackageNam",
                        title: "包装英文名称",
                        multiSort: true,
                        halign: "center",
                        width:230,
                        editor: {type: "uppercasebox", options: {required: false,validType: 'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "cnPackageNam",
                        title: '<font color="red">包装中文</font>',
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required: true,validType: 'length[1,100]'}},
                        sortable: true
                    },
                    {
                        field: "shortNam",
                        title: "包装简称",
                        multiSort: true,
                        halign: "center",
                        width:90,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,40]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },  */                               
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}},
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
                	    field:"insTimestamp",
                	    title:"创建时间",
                	    multiSort:true,
                	    halign:"center",
                	    formatter: $.hd.ezui.formatter.datetime,
                	    width:140,
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
                	}
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'packageCod'}).target.prop('disabled', true);
                } 
        });
        $("#SbcPackageDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
</script>