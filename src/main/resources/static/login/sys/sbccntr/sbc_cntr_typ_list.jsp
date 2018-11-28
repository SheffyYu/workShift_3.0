<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCntrTypToolBar1486718205885" style="padding-top: 0px;">
    <div style="float:left">
        <shiro:hasPermission name="webresources:sys:SbcCntrTyp:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrTyp:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrTyp:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrTyp:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrTyp:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
    </div>
    <input class="easyui-searchbox" id="SbcCntrTypSearchbox1486718205885"/>
</div>
<div id="SbcCntrTypDialog1486718205885"   style="display:none"></div>
<table id="SbcCntrTypDatagrid1486718205885" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCntrTypDialog1486718205885");
        var dg = $("#SbcCntrTypDatagrid1486718205885");
        // buttons
        // 增加。
        $("#SbcCntrTypToolBar1486718205885 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCntrTypToolBar1486718205885 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	  var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
              dg.datagrid('getEditor', {index: selectIdx, field: 'cntrTypCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCntrTypToolBar1486718205885 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCntrTyp/save"});
        }); 
        // 保存。
        $("#SbcCntrTypToolBar1486718205885 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCntrTyp/save"});
        });
        // 刷新。
        $("#SbcCntrTypToolBar1486718205885 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCntrTypSearchbox1486718205885").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cntrTypId","desc");
        // 返回后台参数。
//        var queryParams = {
//            builder: builder.build(),
//            queryColumns: {}
//        };
        // searchbox
        $("#SbcCntrTypSearchbox1486718205885").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns","cntrTypCod,cntrTypNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcCntrTypDatagrid1486718205885").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCntrTyp/find",
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
            toolbar: "#SbcCntrTypToolBar1486718205885",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "cntrTypId",
                        title: '<font color="red">箱类型ID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cntrTypCod",
                        title: "<font color='red'>箱类型代码</font>",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,2]'}},
                        sortable: true
                    },
                    {
                        field: "cntrTypNam",
                        title: "箱类型名称",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,40]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: "系统标识",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width: 80,
                        formatter: $.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    }, */
                    {
                        field: "abandonedMark",
                        title: "作废标志",
                        align: "center",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        formatter: $.hd.ezui.formatter.checkbox2,
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
                    }                    
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'cntrTypCod'}).target.prop('disabled', true);
                }
        });
        $("#SbcCntrTypDatagrid1486718205885").datagrid("hdGetColumnNames");
    });

</script>

