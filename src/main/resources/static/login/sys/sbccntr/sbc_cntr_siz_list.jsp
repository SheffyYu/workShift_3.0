<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCntrSizToolBar1486718041966" style="padding-top: 0px;">
    <div style="float:left"> 
        <shiro:hasPermission name="webresources:sys:SbcCntrSiz:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrSiz:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrSiz:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrSiz:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:sys:SbcCntrSiz:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>        
    </div>
    <input class="easyui-searchbox" id="SbcCntrSizSearchbox1486718041966"/>
</div>
<table id="SbcCntrSizDatagrid1486718041966" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCntrSizDialog1486718041966");
        var dg = $("#SbcCntrSizDatagrid1486718041966");
        // buttons
        // 增加。
        $("#SbcCntrSizToolBar1486718041966 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCntrSizToolBar1486718041966 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
      	    var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cntrSizCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCntrSizToolBar1486718041966 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCntrSiz/save"});
        });
        // 保存。
        $("#SbcCntrSizToolBar1486718041966 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCntrSiz/save"});
        });
        // 刷新。
        $("#SbcCntrSizToolBar1486718041966 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCntrSizSearchbox1486718041966").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cntrSizId","desc");
        $("#SbcCntrSizSearchbox1486718041966").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cntrSizCod,cntrSizNam,cntrTeu");
                dg.datagrid("load");
        }});
        // datagrid
        $("#SbcCntrSizDatagrid1486718041966").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCntrSiz/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            //autoLoad:false,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#SbcCntrSizToolBar1486718041966",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "cntrSizId",
                        title: '<font color="red">箱尺寸ID</font>',
                        multiSort: true,
                        halign: "center",                        
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cntrSizCod",
                        title: "<font color='red'>箱尺寸代码</font>",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,2]'}},
                        sortable: true
                    },
                    {
                        field: "cntrSizNam",
                        title: "箱尺寸名称",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,40]'}},
                        sortable: true
                    },
                    {
                        field: "cntrTeu",
                        title: "箱TEU",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "numberbox", options: {required:false,precision:2,max:99.99}},
                        formatter:$.hd.ezui.formatter.precision2,
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: "系统标识",
                        multiSort: true,
                        align: "center",
                        halign: "center",
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
                    }
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'cntrSizCod'}).target.prop('disabled', true);
                }
                });
        var pager = $('#SbcCntrSizDatagrid1486718041966').datagrid('getPager');    // get the pager of datagrid
    	pager.pagination({
    		showPageList:true,
    		layout:['list','sep','first','prev','next','last','refresh','manual','links'],
    		displayMsg:"",
    		onBeforeRefresh:function(){
    			alert('before refresh');
    			return true;
    		}
    	});
       
    });
</script>

