<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:470px;">
		<div id="SbcCntrTypToolBar201707201712" style="padding-top: 0px;">
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
		<!-- 工具栏 结束 -->
		<!-- Datagrid -->
		<table id="SbcCntrTypDatagrid201707201712" style="height:100%"  title="标准箱类型代码" ></table>
		<!-- end Datagrid -->
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcCntrTypRelToolBar1427420966140" style="padding-top: 0px;">
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
        </div>
         <table id="SbcCntrTypRelDatagrid1427420966140" title="对应箱类型代码"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:550px;">
        <div id="SbcCntrTypSubToolBar1427420966140" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
                </div>
                <input class="easyui-searchbox" id="SbcCntrTypSubSearchbox1427420966140"/>
        </div>
        <table id="SbcCntrTypSubDatagrid1427420966140" title="来源箱类型代码" style="height:100%"></table>
    </div>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var dialogTitleAddF = "增加";
        var dialogTitleEditF = "编辑";
        var diog = $("#SbcCntrTypDialog1486718205885");
        var dg = $("#SbcCntrTypDatagrid201707201712");
        // buttons
        // 增加。
        $("#SbcCntrTypToolBar201707201712 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCntrTypToolBar201707201712 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	  var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
              dg.datagrid('getEditor', {index: selectIdx, field: 'cntrTypCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCntrTypToolBar201707201712 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCntrTyp/save"});
        }); 
        // 保存。
        $("#SbcCntrTypToolBar201707201712 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCntrTyp/save"});
        });
        // 刷新。
        $("#SbcCntrTypToolBar201707201712 a[iconCls='icon-reload']").on("click", function () {
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
        $("#SbcCntrTypDatagrid201707201712").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCntrTyp/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:true,
            rownumbers: true,
            //autoLoad:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            remoteSort:false,
            toolbar: "#SbcCntrTypToolBar201707201712",
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
                },
                onSelect:function(rowIndex,rowData){
                    var relbuilder = new HdEzuiQueryParamsBuilder(); 
                    relbuilder.setAndClause("cntrTypCod",rowData.cntrTypCod,"=","and");
                     $("#SbcCntrTypRelDatagrid1427420966140").datagrid({  
                         url: "../webresources/login/MappCntrTyp/find", 
                         queryParams: relbuilder.build()}
                     );
                     $("#SbcCntrTypSubSearchbox1427420966140").searchbox('setValue',rowData.cntrTypNam);
                     subSbcCntrTyp(rowData.cntrTypCod);
                }
        });
        $("#SbcCntrTypDatagrid201707201712").datagrid("hdGetColumnNames");
        
        $("#SbcCntrTypRelDatagrid1427420966140").datagrid({
            striped:true,
            method: "POST",
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            toolbar: "#SbcCntrTypRelToolBar1427420966140", 
            remoteSort:false,
            fit: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            fitColumns: false,
            columns: [[ 
				{field: "ck",checkbox: true},
				{
				    field: "guid",
				    title: '<font color="red"></font>',
				    multiSort: true,
				    halign: "center",
				    sortable: true,
				    hidden:true
				},
				{
				    field: "companyCod",
				    title: '<font color="red">作业公司</font>',
				    multiSort: true,
				    halign: "center",
				    width:120,
				    editor: {type: 'combogrid',
				    	options: HdUtils.code.sbcCompanyByCompanyCod({
				    		parentId: '#MappCntrTypDatagrid1487052108880',
				    		textField:'COMPANY_COD',
				    		fieldMapping: {
				    			companyCod: 'COMPANY_COD',
				    			cnCompanyNam:'CN_COMPANY_NAM'
				    			},
				    			required: true                 
				        })
				    }, 
				    formatter: function (value, row, index) {
				        return row.cnCompanyNam;
				    },
				},
				{
				    field: "srcCntrTypCod",
				    title: "<font color='red'>原箱类型代码</font>",
				    multiSort: true,
				    halign: "center",
				    width:120,
				    editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,10]'}},
				    sortable: true
				},
				{
				    field: "cntrTypCod",
				    title: "<font color='red'>标准箱类型代码</font>",
				    multiSort: true,
				    halign: "center",
				    width:120,
/* 				    editor:{type:'combogrid',
				    	options:HdUtils.code.sbcCntrTyp({
				    		required:true,
				    		parentId:"#MappCntrTypDatagrid1487052108880",
				    		textField: 'cntrTypCod', 
				    		fieldMapping : {
				    			cntrTypCod : 'cntrTypCod',
				    			cntrTypNam : 'cntrTypNam'
				    		},
				    		onSelect: function(index,record){    
								var ed = dg.datagrid('getEditor', {
									index : dg.datagrid("options").hdCurrentRowIndex,
									field : 'cntrTypNam'
								});
								$(ed.target).val(record.cntrTypNam);
					        }
				    	})
				    },
 */				    sortable: true
				},
				{
				    field: "cntrTypNam",
				    title: "箱类型名称",
				    multiSort: true,
				    halign: "center",
				    width:160,
				    editor: {type: "validatebox", options: {required:false,validType: 'length[0,20]'}},
				    sortable: true
				},
				{
				    field: "insAccount",
				    title: "创建人",
				    multiSort: true,
				    width:80,
				    halign: "center",
				    hidden:true,
				    sortable: true
				},
				{
				    field: "insTimestamp",
				    title: "创建时间",
				    multiSort: true,
				    halign: "center",
				    width:140,
				    formatter: $.hd.ezui.formatter.datetime,
				    hidden:true,
				    sortable: true
				},
				{
				    field: "updAccount",
				    title: "更新人",
				    multiSort: true,
				    halign: "center",
				    width:80,
				    hidden:true,
				    sortable: true
				},
				{
				    field: "updTimestamp",
				    title: "更新时间",
				    multiSort: true,
				    halign: "center",
				    width:140,
				    formatter: $.hd.ezui.formatter.datetime,
				    hidden:true,
				    sortable: true
				}
				]],
             onDblClickRow: function (index, data) {
             }
        });
        // 删除。
        $("#SbcCntrTypRelToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {

                var selectData = $("#SbcCntrTypRelDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                     $.ajax({
                         url: "../webresources/login/MappCntrTyp/saveMappCntrTyp",
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         data: $.toJSON(pam),
                         success: function(data) {       
                             $("#SbcCntrTypRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subSbcCntrTyp(dgSelected[0].cntrTypCod);
                            HdUtils.messager.bottomRight(data.message,'提示');
                         }
                     });
                }else{
                     $.messager.alert("提示", "请选择！", "info");
                }
        });
        
        // 条件类。
        //var hdConditions = new HdConditions();
       
        var subbuilder = new HdEzuiQueryParamsBuilder();
        function subSbcCntrTyp(codValue)
        {
            var schvalue= $("#SbcCntrTypSubSearchbox1427420966140").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "CNTR_TYP_NAM,CNTR_TYP_COD");
            $("#SbcCntrTypSubDatagrid1427420966140").datagrid("load");
        }
        $("#SbcCntrTypSubDatagrid1427420966140").datagrid({
            striped:true,
            url: "../webresources/login/SbcCntrTyp/findSrcCntrTyp",
            queryParams: subbuilder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            autoLoad:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            remoteSort:false,
            toolbar: "#SbcCntrTypSubToolBar1427420966140",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "CNTR_TYP_NAM", title: "箱类型名称",  multiSort: true,  halign: "center", width:160,  sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {field: "CNTR_TYP_COD",title: '箱类型代码',multiSort: true, halign: "center",width:120,sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    { field: "COMPANY_COD", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.COMPANY_NAM;
                        },
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCompanyByCompanyCod({
                                parentId: '#SbcCntrTypSubDatagrid1427420966140',
                                textField:'COMPANY_COD',
                                fieldMapping: {companyCod: 'COMPANY_COD',cnCompanyNam:'CN_COMPANY_NAM'},
                                required: true                 
                            })
                        }, 
                        sortable: true
                    }
                ]],
             onDblClickRow: function (index, data) {
             }
        });
        
        var dgSub = $("#SbcCntrTypSubDatagrid1427420966140");
        
        $("#SbcCntrTypSubSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
            subSbcCntrTyp("");
        }});
        // 关联。
        $("#SbcCntrTypSubToolBar1427420966140 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =dg.datagrid("getSelected");
            if(selectRow){
                var selectData =dgSub.datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/MappCntrTyp/saveMappCntrTyp",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#SbcCntrTypRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subSbcCntrTyp(dgSelected[0].cntrTypCod);
                            HdUtils.messager.bottomRight(data.message,'提示');
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择原港口！", "info");
                }
            }
            else{
                 $.messager.alert("提示", "请选择标准港口！", "info");
            }
            
        });
    });
</script>

