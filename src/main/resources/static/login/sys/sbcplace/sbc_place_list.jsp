<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcPlaceToolBar1427420966140" style="padding-top: 0px;">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcPlace:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPlace:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPlace:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPlace:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcPlace:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>   
        &nbsp;           
    </div>    
    <input class="easyui-searchbox" id="SbcPlaceSearchbox1427420966140"/>        
</div>
<table id="SbcPlaceDatagrid1427420966140" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcPlaceDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SbcPlaceToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcPlaceToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'placeCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcPlaceToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcPlace/save"});
        });
        // 保存。
        $("#SbcPlaceToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcPlace/save"});
        });
        // 刷新。
        $("#SbcPlaceToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#SbcPlaceSearchbox1427420966140").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("placeCod","desc");
        // 返回后台参数。
        // searchbox
        $("#SbcPlaceSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "placeCod,enPlaceNam,cnPlaceNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcPlaceDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/SbcPlace/find",
            queryParams: builder.build(),
            method: "post",
            //autoLoad:false,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcPlaceToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "placeCod",
                        title: '<font color="red">地点代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcPlaceDatagrid1427420966140","SbcPlace","placeCod"]','length[1,10]']}},
                        //editor: {type: "uppercasebox", options: {required: true,validType: 'length[1,10]'}},
                        sortable: true
                    },
                    {
                        field: "enPlaceNam",
                        title: "英文地点名称",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "uppercasebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },

                    {
                        field: "cnPlaceNam",
                        title: "中文地点名称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter: $.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },  */                               
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter: $.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        width:80,
                        multiSort: true,
                        halign: "center",
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
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'placeCod'}).target.prop('disabled', true);
                } 
        });
    });
    
</script>