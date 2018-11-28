<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcCargoToolBar1486625782366" style="padding-top: 0px;">
     <div style="float:left;">
      <!-- 标准按钮 -->
      <shiro:hasPermission name="webresources:login:SbcCargo:add">
          <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
      </shiro:hasPermission>
      <shiro:hasPermission name="webresources:login:SbcCargo:update">
          <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
      </shiro:hasPermission>
      <shiro:hasPermission name="webresources:login:SbcCargo:delete">
          <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
      </shiro:hasPermission>
      <shiro:hasPermission name="webresources:login:SbcCargo:save">
          <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
      </shiro:hasPermission>
          <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
     </div>
     <input class="easyui-searchbox" id="SbcCargoSearchbox1486625782366"/>
</div>
<table id="SbcCargoDatagrid1486625782366" style="height:100%"></table>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCargoDialog1486625782366");
        var dg = $("#SbcCargoDatagrid1486625782366");
        // buttons
        // 增加。
        $("#SbcCargoToolBar1486625782366 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCargoToolBar1486625782366 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cargoCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCargoToolBar1486625782366 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/cargo/save"});
        });
        // 保存。
        $("#SbcCargoToolBar1486625782366 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/cargo/save"});
        });
        // 刷新。
        $("#SbcCargoToolBar1486625782366 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCargoSearchbox1486625782366").val();
        	builder.set("q", value);
        	dg.datagrid("hdReload");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cargoCodId","desc");
        // searchbox
        $("#SbcCargoSearchbox1486625782366").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cargoCod,cnCargoNam,enCargoNam,shortNam,cargoKindCod,dangClass,undgNo");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#SbcCargoDatagrid1486625782366").datagrid({
        	striped:true,
            url: "../webresources/login/cargo/find",
            queryParams: builder.build(),
            method: "POST",     
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            //autoLoad:false,
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcCargoToolBar1486625782366",
            fit: true,
            fitColumns: false,
            columns: [[
                       {
                           field: "ck",
      					    checkbox: true
                       },
                    {
                        field: "cargoCodId",
                        title: '<font color="red">货物代码ID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cargoCod",
                        title: '<font color="red">货物代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor: {type: "uppercasebox", options: {required:true, validType: ['isCodeRepeat["SbcCargoDatagrid1486625782366","SbcCargo","cargoCod"]','length[1,10]']}},
                        sortable: true
                    },

                    {
                        field: "shortNam",
                        title: "货物简称",
                        multiSort: true,
                        width:100,
                        halign: "center",
                        editor: {type: "uppercasebox", options: {required:false,validType:'length[0,40]'}},
                        sortable: true,
                        //hidden: true
                    },
                    {
                        field: "enCargoNam",
                        title: "货物英文名称",
                        multiSort: true,
                        width:100,
                        halign: "center",
                        editor: {type: "uppercasebox", options: {required:false,validType:'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "cnCargoNam",
                        title: '<font color="red">货物中文名称</font>',
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required:true,validType:'length[0,100]'}},
                        sortable: true
                    },
                   {
                        field: "cargoKindCod",
                        title: '<font color="red">货类</font>',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCargoKind({
                                parentId: '#SbcCargoDatagrid1486625782366',
                                fieldMapping: {
                                	cargoKindCod: 'cargoKindCod',
                                	cargoKindNam: 'cargoKindNam'
                                }
                            })
                        },
                        formatter:function(val,row,idx){
                        	if(row.cargoKindNam!=null){
                        		return row.cargoKindNam;
                        	}else{
                        		return row.cargoKindNam;
                        	}
                        }
                    }, 
                 
                    {
                        field: "dangMark",
                        title: "危险品标志",
                        multiSort: true,
                        width:70,
                        halign: "center",
                        align: "center",
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "dangClass",
                        title: '危险品等级',
                        multiSort: true,
                        width:100,
                        halign: "center",
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcDangClass({
                                parentId: '#SbcCargoDatagrid1486625782366',
                                fieldMapping: {
                                	dangClass: 'dangClass',
                                	dangClassNam: 'dangClassNam'
                                },
                                required: false,
                                panelWidth:260
                            })
                        }
                    },
                    {
                        field: "undgNo",
                        title: "国际危规号",
                        multiSort: true,
                        width:100,
                        halign: "center",
                        editor: {type: "numberbox", options: {required:false,validType:'length[0,4]'}},
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        width:60,
                        halign: "center",
                        align: "center",
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
                        width:60,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required:false,validType:'length[0,1000]'}},
                        sortable: true,
                        hidden: true
                       
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
                        formatter:HdUtils.formatter.datetime,
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
                        formatter: HdUtils.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'cargoCod'}).target.prop('disabled', true);
                }
        });
        $("#SbcCargoDatagrid1486625782366").datagrid("hdGetColumnNames");
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

