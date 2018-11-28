<meta charset="UTF-8">
<script src="../../js/hdEzuiEx_js/ezui.ex.datagrid.js"></script>
<!-- 工具栏 -->
<div id="SbcCompanyToolBar1486628216599" style="padding-top: 0px;">
        <div style="float: left">
	        <shiro:hasPermission name="webresources:login:SbcCompany:add">
	            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCompany:update">
	            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCompany:delete">
	            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCompany:save">
	            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcCompany:find">
	            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	        </shiro:hasPermission>
	        &nbsp;
        </div>
        <input class="easyui-searchbox" id="SbcCompanySearchbox1486628216599"/>
    </div>
<table id="SbcCompanyDatagrid1486628216599" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
    	var dg = $("#SbcCompanyDatagrid1486628216599");
        // buttons
        // 增加。
        $("#SbcCompanyToolBar1486628216599 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");          
        });
        // 编辑。
        $("#SbcCompanyToolBar1486628216599 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'companyCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCompanyToolBar1486628216599 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCompany/save"});
        });
        // 保存。
        $("#SbcCompanyToolBar1486628216599 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCompany/save"});
        });
        // 刷新。
        $("#SbcCompanyToolBar1486628216599 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCompanySearchbox1486628216599").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        dg.datagrid({
        	onDblClickCell: function (index) {
            	dg.datagrid("hdEdit");
            	dg.datagrid('getEditor', {index: index, field: 'companyCod'}).target.prop('disabled', true);
            }
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("companyCod","desc");
        // searchbox
        $("#SbcCompanySearchbox1486628216599").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "companyCod,cnCompanyNam,shortNam,portZoneCod");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcCompanyDatagrid1486628216599").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCompany/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcCompanyToolBar1486628216599",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "companyCod",
                        title: '<font color="red">公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox",options:{required:true,validType:['isCodeRepeat["SbcCompanyDatagrid1486628216599","SbcCompany","companyCod"]', 'length[1,20]']}},
                        sortable: true
                    },
                    {
                        field: "portZoneCod",
                        title: "所属港区代码",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required: false, validType: 'maxLength[20]'}},
                        sortable: true
                    },
                    {
                        field: "enCompanyNam",
                        title: "公司英文名称",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required: false, validType: 'maxLength[100]'}},
                        sortable: true
                    },
                    {
                        field: "cnCompanyNam",
                        title: '<font color="red">公司中文名称</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required: true, validType: 'maxLength[100]'}},
                        sortable: true
                    },
                    {
                        field: "shortNam",
                        title: "公司简称",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[40]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        formatter: $.hd.ezui.formatter.checkbox2,
                	    editor: $.hd.ezui.editor.checkbox, 
                        sortable: true
                    }, */
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        hidden:true,
                        formatter: $.hd.ezui.formatter.checkbox2,
                	    editor: $.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        hidden:true,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[1000]'}},
                        sortable: true
                    },
                    {
                        field: "lastSynTime",
                        title: "上次数据同步时间",
                        multiSort: true,
                        halign: "center",
                        width:130,
                        formatter:$.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "timeLimit",
                        title: "超时时间间隔",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "numberbox", options: {required: false, max:9999999999,precision:0}},
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
                        formatter: $.hd.ezui.formatter.datetime,
                        width: 140,
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
                        formatter:$.hd.ezui.formatter.datetime,
                        width: 140,
                        sortable: true
                    },
                ]]});
        $("#SbcCompanyDatagrid1486628216599").datagrid("hdGetColumnNames");
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