<meta charset="UTF-8">
<div id="SbcCountryToolBar1486799736989" style="padding-top: 0px;">
    <div style="float:left">
        <shiro:hasPermission name="webresources:sys:SbcCountry:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCountry:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCountry:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sysSbcCountry:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCountry:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="SbcCountrySearchbox1486799736989"/>
</div>
<table id="SbcCountryDatagrid1486799736989" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
    	var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCountryDialog1486799736989");
        var dg = $("#SbcCountryDatagrid1486799736989");
        // buttons
        // 增加。
        $("#SbcCountryToolBar1486799736989 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");         
        });
        // 编辑。
        $("#SbcCountryToolBar1486799736989 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'countryCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCountryToolBar1486799736989 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCountry/save"});
        });
        // 保存。
        $("#SbcCountryToolBar1486799736989 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCountry/save"});
        });
        // 刷新。
        $("#SbcCountryToolBar1486799736989 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCountrySearchbox1486799736989").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("countryCod","desc");
        // searchbox
        $("#SbcCountrySearchbox1486799736989").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "countryCod,cnCountryNam,enCountryNam,shortNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcCountryDatagrid1486799736989").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCountry/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            //autoLoad:false,
            pageSize: 20,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#SbcCountryToolBar1486799736989",
            fit: true,
            fitColumns: false,
            columns: [[
                    {
                       field: "ck",
   					   checkbox: true
                    },
                    {
                        field: "countryCod",
                        title: '<font color="red">国家代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type:"uppercasebox", options: {required:true,validType:['isCodeRepeat["SbcCountryDatagrid1486799736989","SbcCountry","countryCod"]','length[1,2]']}},
                        sortable: true
                    },
                    {
                        field: "shortNam",
                        title: "国家简称",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:false,validType:'length[0,20]'}},
                        sortable: true
                    },
                    {
                        field: "enCountryNam",
                        title: "国家英文名称",
                        multiSort: true,
                        halign: "center",
                        width:220,
                        editor: {type: "uppercasebox", options: {required:false,validType:'length[0,60]'}},
                        sortable: true
                    },
                    {
                        field: "cnCountryNam",
                        title: "国家中文名称",
                        multiSort: true,
                        halign: "center",
                        width:140,
                        editor: {type: "validatebox", options: {required:false,validType:'length[0,60]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox, 
                        sortable: true
                    }, */
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        halign: "center",
                        align: "center",
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
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: '创建人',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '创建时间',
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '更新人',
                        multiSort: true,
                        width:80,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '更新时间',
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'countryCod'}).target.prop('disabled', true);
                }  
        });
        $("#SbcCountryDatagrid1486799736989").datagrid("hdGetColumnNames");
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

