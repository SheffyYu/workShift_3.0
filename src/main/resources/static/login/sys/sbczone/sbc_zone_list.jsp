<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcZoneToolBar1495334493663">
    <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcZone:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcZone:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcZone:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcZone:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        &nbsp;
    </div>
    <input class="easyui-searchbox" id="SbcZoneSearchbox1495334493663"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<div id="SbcZoneDialog1495334493663"   style="display:none"></div>
<table id="SbcZoneDatagrid1495334493663" style="height:100%"></table>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcZoneDialog1495334493663");
        var dg = $("#SbcZoneDatagrid1495334493663");
        // buttons
        // 增加。
        $("#SbcZoneToolBar1495334493663 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");        
        });
        // 编辑。
        $("#SbcZoneToolBar1495334493663 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'zoneCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcZoneToolBar1495334493663 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove",{url:"../webresources/login/SbcZone/save"});
        });
        // 保存。
        $("#SbcZoneToolBar1495334493663 a[iconCls='icon-save']").on("click", function () {
        	dg.datagrid("hdSave",{url:"../webresources/login/SbcZone/save"});  
        });
        // 刷新。
        $("#SbcZoneToolBar1495334493663 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcAreaSearchbox").val();
        	 builder.set("q", value);
        	 dg.datagrid("load");
        });
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("areaId","desc");
        // searchbox
        $("#SbcZoneSearchbox1495334493663").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "zoneId,zoneCod,insAccount,insTimestamp,updAccount,updTimestamp");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcZoneDatagrid1495334493663").datagrid({
            url: "../webresources/login/SbcZone/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcZoneToolBar1495334493663",
            fit: true,
            fitColumns: false,
            columns: [[
                
                    {
                        field: "zoneId",
                        title: '<font color="red">区域ID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "zoneCod",
                        title: '<font color="red">区域代码</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "cnZoneNam",
                        title: "中文区域名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "enZoneNam",
                        title: "英文区域名称",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: '<font color="red">创建人</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '<font color="red">创建时间</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '<font color="red">更新人</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '<font color="red">更新时间</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                ]],
                onDblClickRow: function (index, data) {
            		dg.datagrid("hdEdit"); 
            		dg.datagrid('getEditor', {index: index, field: 'zoneCod'}).target.prop('disabled', true);
            	}
        });
        });
</script>


