<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCntrCorpToolBar1488243989759" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
             &nbsp;
    </div>
    <input class="easyui-searchbox" id="SbcCntrCorpSearchbox1488243989759"/>
</div>
<table id="SbcCntrCorpDatagrid1488243989759" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#SbcCntrCorpDatagrid1488243989759");
        // buttons
        // 增加。
        $("#SbcCntrCorpToolBar1488243989759 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCntrCorpToolBar1488243989759 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
        	dg.datagrid('getEditor', {index: selectIdx, field: 'cntrCorpCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCntrCorpToolBar1488243989759 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCntrCorp/save"});
        });
        // 保存。
        $("#SbcCntrCorpToolBar1488243989759 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCntrCorp/save"});
        });
        // 刷新。
        $("#SbcCntrCorpToolBar1488243989759 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCntrCorpSearchbox1488243989759").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cntrCorpId","desc");
        // 返回后台参数。
        // searchbox
        $("#SbcCntrCorpSearchbox1488243989759").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cntrCorpCod,cnCntrCorpNam,enCntrCorpNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcCntrCorpDatagrid1488243989759").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCntrCorp/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcCntrCorpToolBar1488243989759",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "cntrCorpId",
                        title: '<font color="red">箱公司ID</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "cntrCorpCod",
                        title: '<font color="red">箱公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true,validType:['isCodeRepeat["SbcCntrCorpDatagrid1488243989759","SbcCntrCorp","cntrCorpCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "cnCntrCorpNam",
                        title: "中文名称",
                        multiSort: true,
                        halign: "center",
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,100]'}},
                        sortable: true,
                        width: 140,
                    },
                    {
                        field: "enCntrCorpNam",
                        title: "英文名称",
                        multiSort: true,
                        halign: "center",
                        editor:{type:"uppercasebox",options:{required:false,validType: 'length[0,100]'}},
                        sortable: true,
                        width: 180,
                    },
                    {
                        field: "tradeMark",
                        title: "贸易性质",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'TRADE_MARK', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({fieldCod: 'TRADE_MARK'}, {required: false})
                        },
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
                        title: "作废标志",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,1000]'}},
                        sortable: true,
                        width: 180,
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
                        halign: "center",
                        width:80,
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
                onDblClickCell: function (index) {
                    dg.datagrid("hdEdit");
                    dg.datagrid('getEditor', {index: index, field: 'cntrCorpCod'}).target.prop('disabled', true);
                }});
        $("#SbcCntrCorpDatagrid1488243989759").datagrid("hdGetColumnNames");
    });
</script>

