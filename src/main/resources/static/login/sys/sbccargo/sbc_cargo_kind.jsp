<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCargoKindToolBar1486693784384" style="padding-top: 0px;">
        <div style="float:left;">
	        <!-- 标准按钮 -->
	        <shiro:hasPermission name="webresources:login:SbcCargoKind:add">
	            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCargoKind:update">
	            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCargoKind:delete">
	            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCargoKind:save">
	            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCargoKind:refresh">
	            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	        </shiro:hasPermission>
        </div>
        <input class="easyui-searchbox" id="SbcCargoKindSearchbox1486693784384"/>
</div>
<table id="SbcCargoKindDatagrid1486693784384" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCargoKindDialog1486693784384");
        var dg = $("#SbcCargoKindDatagrid1486693784384");
        // buttons
        // 增加。
        $("#SbcCargoKindToolBar1486693784384 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCargoKindToolBar1486693784384 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
         	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cargoKindCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCargoKindToolBar1486693784384 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/cargokind/save"});
        });
        // 保存。
        $("#SbcCargoKindToolBar1486693784384 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/cargokind/save"});
        });
        // 刷新。
        $("#SbcCargoKindToolBar1486693784384 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCargoKindSearchbox1486693784384").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cargoKindId","desc");
        // searchbox
        $("#SbcCargoKindSearchbox1486693784384").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cargoKindCod,cargoKindNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcCargoKindDatagrid1486693784384").datagrid({
        	striped:true,
            url: "../webresources/login/cargokind/find",
            queryParams: builder.build(),
            method: "POST",
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            pagination: true,
            //autoLoad:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcCargoKindToolBar1486693784384",
            fit: true,
            fitColumns: false,
            columns: [[
                    {
                        field: "ck",
   					    checkbox: true
                    },
                    {
                        field: "cargoKindId",
                        title: '货类代码ID',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cargoKindCod",
                        title: '<font color="red">货类代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:true, validType: ['isCodeRepeat["SbcCargoKindDatagrid1486693784384","SbcCargoKind","cargoKindCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "cargoKindNam",
                        title: '<font color="red">货类名称</font>',
                        multiSort: true,
                        halign: "center",
                        width:140,
                        editor: {type: "validatebox", options: {required:true,validType:'length[1,100]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: "系统标识",
                        align: "center",
                        multiSort: true,
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    }, */
                    {
                        field: "abandonedMark",
                        title: "作废标志",
                        multiSort: true,
                        align: "center",
                        halign: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor: {type: "validatebox", options: {required:false,validType:'length[0,1000]'}},
                        sortable: true,
                        hidden: true
                       
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
                        formatter: HdUtils.formatter.datetime,
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
                        formatter: HdUtils.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'cargoKindCod'}).target.prop('disabled', true);
                }});
        $("#SbcCargoKindDatagrid1486693784384").datagrid("hdGetColumnNames");
    });
</script>

