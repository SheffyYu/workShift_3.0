
<meta charset="UTF-8">

<!--资源管理  ws-->
<!-- 工具栏 -->
<div id="AuthResourceToolBar1426483003737">
    <div style="float:left;">
        <!-- 查询 -->

        <!-- 查询结束 -->
        <!-- 标准按钮 -->
        <!-- 如果存在 查询条件，请开启-->
        <!--        <span style="float:right">-->
        <shiro:hasPermission name="webresources:login:AuthTenant:add">
                    <a class="easyui-linkbutton" iconCls="icon-add" plain="false"><label name="add">增加</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:update">
                    <a class="easyui-linkbutton" iconCls="icon-edit" plain="false"><label name="edit">编辑</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:delete">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="false"><label name="delete">删除</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:save">
                    <a class="easyui-linkbutton" iconCls="icon-save" plain="false"><label name="save">保存</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:refresh">
                    <a class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="reload">刷新</label></a>
        </shiro:hasPermission>
        &nbsp;
        <!-- 如果存在 查询条件，请开启-->
        <!--        </span>-->
        <!--请选择图表样式：<select id="chart-type" class="easyui-combobox">
                            <option value ="pie">饼图</option>
                            <option value ="column">柱状图</option>
                            <option value ="line">折线图</option>
                            <option value ="spline">曲线图</option>             
                     </select>
                <a class="easyui-linkbutton" iconCls="icon-tip" plain="false" href="javascript:createChart()">生成图表</a>-->

        <!-- 标准按钮 结束-->
    </div>
            <shiro:hasPermission name="webresources:login:AuthResource:find">
                <input class="easyui-searchbox" id="AuthResourceSearchbox1426483003737"/>
        </shiro:hasPermission>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="AuthResourceDatagrid1426483003737" style="height:100%"></table>
<!-- end Datagrid -->
<div id="chart-dlg">
    <div id="chart"></div>
</div>
<div id="chart-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {

        $.i18n.properties({
            name: 'resource', //资源文件名称
            path: '../i18n/project/', //资源文件路径
            mode: 'map', //用Map的方式使用资源文件中的值
            language: getBrowserLanguage(),
//            language: "en",
            callback: function () {//加载成功后设置显示内容
                $("label").each(function (i) {
                    $(this).html($.i18n.prop($(this).attr("name")));
                });
            }
        });
        

        var dg = $("#AuthResourceDatagrid1426483003737");
        // buttons
        // 增加。
        $("#AuthResourceToolBar1426483003737 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#AuthResourceToolBar1426483003737 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
        });
        // 删除。
        $("#AuthResourceToolBar1426483003737 a[iconCls='icon-remove']").on("click", function() {
            var row = $('#AuthResourceDatagrid1426483003737').datagrid('getSelected');
            if (row) {
                $.ajax({
                    type: 'post',
                    url: "../webresources/login/AuthResource/checkDelete",
                    contentType: "application/x-www-form-urlencoded",
                    data: {'resourceId': row.resourceId},
                    dataType: 'text',
                    success: function(data) {
                        if(data==""){
                        	
                            dg.datagrid("hdRemove");
                        }
                        else{
                            data = data.replace("000","权限与该资源已经关联");
                            data = data.replace("001","用户与该资源已经关联");
                            data = data.replace("002","角色与该资源已经关联");
                            HdUtils.messager.info(data+",不能进行删除操作，如要删除请先删除相关联的关系数据！");
                        } 
                    }
                });
            }
            else
            {
                HdUtils.messager.info("请选中一行数据！");
            }

        });
        // 保存。
        $("#AuthResourceToolBar1426483003737 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/AuthResource/save"});
        });
        // 刷新。
        $("#AuthResourceToolBar1426483003737 a[iconCls='icon-reload']").on("click", function() {
            dg.datagrid("hdReload");
        });

        // 返回后台参数。
        var builder = new HdEzuiQueryParamsBuilder();
        //builder.setOrderByClause("updTimestamp","desc");
        builder.set("sort", "insTimestamp");
        builder.set("order", "desc");
        // searchbox
        $("#AuthResourceSearchbox1426483003737").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "permissions,name,resource,description");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#AuthResourceDatagrid1426483003737").datagrid({
        	striped:true,
            url: "../webresources/login/AuthResource/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#AuthResourceToolBar1426483003737",
            fit: true,
            fitColumns: false,
            columns: [[
                    {
                        field: "permissions",
                        title: $.i18n.prop("pms"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "resourceId",
                        title: '<font color="red">'+$.i18n.prop("resourceId")+'</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        width: 80,
                        field: "dtype",
                        title: '<font color="red">'+$.i18n.prop("dtype")+'</font>',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        formatter: function(value) {
                            if ("0" == value) {
                                return "资源";
                            }
                            else if ("1" == value) {
                                return "按钮";
                            }
                            else if ("2" == value) {
                                return "元素";
                            }
                        },
                        editor: {type: 'combobox',
                            options: {
                                valueField: 'value',
                                textField: 'label',
                                data: [{
                                        label: '资源',
                                        value: '0'
                                    }, {
                                        label: '按钮',
                                        value: '1'
                                    }, {
                                        label: '元素',
                                        value: '2'
                                    }],
                                required: true
                            }},
                        sortable: true
                    },
                    {
                        field: "name",
                        title: $.i18n.prop("name"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "resource",
                        title: $.i18n.prop("resource"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "description",
                        title: $.i18n.prop("description"),
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    }
                ]]});
        $("#AuthResourceDatagrid1426483003737").datagrid("hdGetColumnNames");
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
