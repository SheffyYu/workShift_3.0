<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCntrIsoToolBar1486628368990" style="padding-top: 0px;">
    <div style="float:left">     
        <shiro:hasPermission name="webresources:sys:SbcCntrIso:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrIso:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrIso:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrIso:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrIso:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="SbcCntrIsoSearchbox1486628368990"/>
</div>
<table id="SbcCntrIsoDatagrid1486628368990" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#SbcCntrIsoDatagrid1486628368990");
        // buttons
        // 增加。
        $("#SbcCntrIsoToolBar1486628368990 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
        });
        // 编辑。
        $("#SbcCntrIsoToolBar1486628368990 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex; 
        	dg.datagrid('getEditor', {index: selectIdx, field: 'cntrIso'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCntrIsoToolBar1486628368990 a[iconCls='icon-remove']").on("click", function () {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCntrIso/save"});
        });
        // 保存。
        $("#SbcCntrIsoToolBar1486628368990 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCntrIso/save"});
        });
        // 刷新。
        $("#SbcCntrIsoToolBar1486628368990 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCntrIsoSearchbox1486628368990").val();
        	builder.set("q", value);
        	dg.datagrid("hdReload");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cntrIsoId","desc");
        // searchbox
        $("#SbcCntrIsoSearchbox1486628368990").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cntrIso,cntrSizCod,cntrTypCod,isoVersion,cntrLength,cntrWidth,cntrHeight");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#SbcCntrIsoDatagrid1486628368990").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCntrIso/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            //autoLoad:false,
            pageSize: 20,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#SbcCntrIsoToolBar1486628368990",
            fit: true,
            fitColumns: false,
            columns: [[
                    {
                        field: "ck",
                        checkbox: true
                    },
                    {
                        field: "cntrIsoId",
                        title: '<font color="red">箱ISOID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cntrIso",
                        title: "<font color='red'>箱ISO代码</font>",
                        multiSort: true,
                        halign: "center",  
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcCntrIsoDatagrid1486628368990","SbcCntrIso","cntrIso"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "cntrTypCod",
                        title: "<font color='red'>箱类型代码</font>",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcCntrTyp({
                        		required:true,
                        		parentId:"#SbcCntrIsoDatagrid1486628368990",
                        		textField: 'cntrTypCod', 
                        		fieldMapping : {
                        			cntrTypCod : 'cntrTypCod',
                        			cntrTypNam : 'cntrTypNam'
                        		},
                        	})
                        }, 
                        sortable: true
                    },
                    {
                        field: "cntrSizCod",
                        title: "<font color='red'>箱尺寸代码</font>",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcCntrSiz({
                        		required:true,
                        		parentId:"#SbcCntrIsoDatagrid1486628368990",
                        		textField: 'cntrSizCod', 
                        		fieldMapping : {
                        			cntrSizCod : 'cntrSizCod',
                        			cntrSizNam : 'cntrSizNam'
                        		},
                        	})
                        }, 
                        sortable: true
                    },
                    {
                        field: "isoVersion",
                        title: "ISO版本",
                        multiSort: true,
                        halign: "center",
                        width:60,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,4]'}},
                        sortable: true
                    },
                    {
                        field: "cntrLength",
                        title: "箱长度",
                        multiSort: true,
                        halign: "center",
                        width:60,
                        editor: {type: "numberbox", options: {required:false,validType: 'length[0,10]'}},
                        sortable: true
                    },
                    {
                        field: "cntrWidth",
                        title: "箱宽度",
                        multiSort: true,
                        halign: "center",
                        width:60,
                        editor: {type: "numberbox", options: {required:false,validType: 'length[0,10]'}},
                        sortable: true
                    },
                    {
                        field: "cntrHeight",
                        title: "箱高",
                        multiSort: true,
                        halign: "center",
                        width:60,
                        editor: {type: "numberbox", options: {required:false,validType: 'length[0,10]'}},
                        sortable: true
                    },
                    /* {
                    	field: "sysMark",
                        title: "系统标识",
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
                        title: "作废标志",
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
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,1000]'}},
                        width: 180,
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
                	dg.datagrid('getEditor', {index: index, field: 'cntrIso'}).target.prop('disabled', true);
                }
        });
        $("#SbcCntrIsoDatagrid1486628368990").datagrid("hdGetColumnNames");
    });
</script>

