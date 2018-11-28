<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcDamAreaToolBar1486629478618" style="padding-top: 0px;">
    	<div style="float:left;">
	        <!-- 标准按钮 -->
	        <shiro:hasPermission name="webresources:login:SbcDamArea:add">
	            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcDamArea:update">
	            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcDamArea:delete">
	            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcDamArea:save">
	            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
	        </shiro:hasPermission>
	        <shiro:hasPermission name="webresources:login:SbcDamArea:refresh">
	            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	        </shiro:hasPermission>
	        <!-- 标准按钮 结束-->
        </div>
        <input class="easyui-searchbox" id="SbcDamAreaSearchbox1486629478618"/>
</div>
<table id="SbcDamAreaDatagrid1486629478618" style="height:100%"></table>
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcDamAreaDialog1486629478618");
        var dg = $("#SbcDamAreaDatagrid1486629478618");
        // buttons
        // 增加。
        $("#SbcDamAreaToolBar1486629478618 a[iconCls='icon-add']").on("click", function () {
         	dg.datagrid("hdAdd");     
        });
        // 编辑。
        $("#SbcDamAreaToolBar1486629478618 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'damAreaCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcDamAreaToolBar1486629478618 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcDamArea/save"});
        });
        // 保存。
        $("#SbcDamAreaToolBar1486629478618 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcDamArea/save"});
        });
        // 刷新。
        $("#SbcDamAreaToolBar1486629478618 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcDamAreaSearchbox1486629478618").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("damAreaCod","desc");
        // 返回后台参数。
        // searchbox
        $("#SbcDamAreaSearchbox1486629478618").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "damAreaCod,cnDamAreaNam,enDamAreaNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcDamAreaDatagrid1486629478618").datagrid({
        	striped:true,
            url: "../webresources/login/SbcDamArea/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            //autoLoad:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcDamAreaToolBar1486629478618",
            fit: true,
            fitColumns: false,
            sortOrder: 'desc',
	        sortName: 'updTimestamp',
            columns: [[        
					{
					    field: "ck",
						checkbox: true
					},
                    {
                        field: "damAreaCod",
                        title: '<font color="red">残损范围代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:true, validType: ['isCodeRepeat["SbcDamAreaDatagrid1486629478618","SbcDamArea","damAreaCod"]','length[1,10]']}},
                        sortable: true
                    },
                   /*  {
                        field: "cnDamAreaNam",
                        title: '<font color="red">残损范围中文名称</font>',
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required:true,validType: 'length[0,100]'}},
                        sortable: true
                    }, */
                    {
                        field: "enDamAreaNam",
                        title: "残损范围英文名称",
                        multiSort: true,
                        halign: "center",
                        width:110,
                        editor: {type: "uppercasebox", options: {validType: 'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "cnDamAreaNam",
                        title: '<font color="red">残损范围中文名称</font>',
                        multiSort: true,
                        halign: "center",
                        width:110,
                        editor: {type: "validatebox", options: {required:true,validType: 'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "sorter",
                        title: "排序编号",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "numberbox", options: {required: false,validType: 'length[0,5]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    },   */                              
                    {
                        field: "abandonedMark",
                        title: '作废标志',
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
                        editor: {type: "validatebox", options: {validType: 'length[0,1000]'}},
                        sortable: true,
                        width: 180
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
                        formatter: HdUtils.formatter.datetime,
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
                        formatter: HdUtils.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'damAreaCod'}).target.prop('disabled', true);
                }
        });
        $("#SbcDamAreaDatagrid1486629478618").datagrid("hdGetColumnNames");
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

