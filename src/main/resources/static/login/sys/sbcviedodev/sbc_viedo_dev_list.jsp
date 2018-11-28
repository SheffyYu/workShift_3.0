<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="SbcViedoDevToolBar1486698273591" style="padding-top: 0px;">
    <div style="float:left">    
    <shiro:hasPermission name="webresources:login:SbcViedoDev:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcViedoDev:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcViedoDev:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcViedoDev:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            &nbsp;
    </div>
            <input class="easyui-searchbox" id="SbcViedoDevSearchbox1486698273591"/>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<div id="SbcViedoDevDialog1486698273591"   style="display:none"></div>
<table id="SbcViedoDevDatagrid1486698273591" style="height:100%"></table>
<!-- end Datagrid -->
<div id="chart-dlg">
    <div id="chart"></div>
</div>
<div id="chart-buttons">
    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
</div>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
    	var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcViedoDevDialog1486698273591");
        var dg = $("#SbcViedoDevDatagrid1486698273591");
        // buttons
        // 增加。
        $("#SbcViedoDevToolBar1486698273591 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");          
        });
        // 编辑。
        $("#SbcViedoDevToolBar1486698273591 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcViedoDevToolBar1486698273591 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcViedoDev/save"});
        });
        // 保存。
        $("#SbcViedoDevToolBar1486698273591 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcViedoDev/save"});
        });
        // 刷新。
        $("#SbcViedoDevToolBar1486698273591 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcViedoDevSearchbox1486698273591").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("devId","desc");
        // searchbox
        $("#SbcViedoDevSearchbox1486698273591").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "devCod,devNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcViedoDevDatagrid1486698273591").datagrid({
        	striped:true,
            url: "../webresources/login/SbcViedoDev/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            sortOrder: 'desc',
            //autoLoad:false,
            sortName: 'updTimestamp',
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcViedoDevToolBar1486698273591",
            fit: true,
            fitColumns: false,
            columns: [[
   					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "devId",
                        title: '<font color="red">视频监控设备ID，只用于唯一主键</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden:true
                    }, 
                    {
                        field: "companyCod",
                        title: '<font color="red">作业公司</font>',
                        multiSort: true,
                        width:100,
                        halign: "center",
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.companyId({
                                parentId: '#SbcViedoDevDatagrid1486698273591',
                                width: 80,
                                fieldMapping: {
                                	companyCod: 'companyCod',
                                	cnCompanyNam: 'cnCompanyNam'
                                },
                                required: true
                            })
                        },
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        },
                        sortable: true
                    },
                    {
                        field: "devCod",
                        title: '<font color="red">视频监控设备代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcViedoDevDatagrid1486698273591","SbcViedoDev","devCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "devNam",
                        title: "视频监控设备名称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[100]'}},
                        sortable: true
                    },
                    {
                        field: "ipAddress",
                        title: "IP地址",
                        multiSort: true,
                        width:180,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[20]'}},
                        sortable: true
                    },
                    {
                        field: "listenPort",
                        title: "监听端口",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor: {type: "numberbox", options: {required: false, validType: 'maxLength[7]'}},
                        sortable: true
                    },
                    {
                        field: "userCod",
                        title: "用户代码",
                        multiSort: true,
                        width:100,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[20]'}},
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "userPwd",
                        title: "用户密码",
                        multiSort: true,
                        width:100,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[20]'}},
                        sortable: true
                    },
                    {
                        field: "protocolClass",
                        title: "通信协议类别",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[20]'}},
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        width:180,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[1000]'}},
                        halign: "center",
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
                        formatter: $.hd.ezui.formatter.datetime,
                        halign: "center",
                        width:140,
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
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        halign: "center",
                        sortable: true
                    },
                ]],
                onDblClickRow: function (index, data) {
                	dg.datagrid("hdEdit"); 
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
	                dg.datagrid('getEditor', {index: selectIdx, field: 'devCod'}).target.prop('disabled', true);
                }  
        });
        $("#SbcViedoDevDatagrid1486698273591").datagrid("hdGetColumnNames");
    });
</script>

