<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:470px;">
			<div id="SbcCargoToolBar201707201713" style="padding-top: 0px;">
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
			     <input class="easyui-searchbox" id="SbcCargoSearchbox201707201714"/>
			</div>
			<table id="SbcCargoDatagrid201707201714" style="height:100%"  title="标准货代码"></table>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcCargoRelToolBar1427420966140" style="padding-top: 0px;">
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
        </div>
         <table id="SbcCargoRelDatagrid1427420966140" title="对应货代码"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:550px;">
        <div id="SbcCargoSubToolBar1427420966140" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
                </div>
                <input class="easyui-searchbox" id="SbcCargoSubSearchbox1427420966140"/>
        </div>
        <table id="SbcCargoSubDatagrid1427420966140" title="来源货代码" style="height:100%"></table>
    </div>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function () {
        var diog = $("#SbcCargoDialog1486625782366");
        var dg = $("#SbcCargoDatagrid201707201714");
        // buttons
        // 增加。
        $("#SbcCargoToolBar201707201713 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCargoToolBar201707201713 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cargoCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCargoToolBar201707201713 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/cargo/save"});
        });
        // 保存。
        $("#SbcCargoToolBar201707201713 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/cargo/save"});
        });
        // 刷新。
        $("#SbcCargoToolBar201707201713 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCargoSearchbox201707201714").val();
        	builder.set("q", value);
        	dg.datagrid("hdReload");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cargoCod","desc");
        // searchbox
        $("#SbcCargoSearchbox201707201714").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cargoCod,cnCargoNam,enCargoNam,shortNam,cargoKindCod,dangClass,undgNo");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#SbcCargoDatagrid201707201714").datagrid({
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
            checkOnSelect:true,
            rownumbers: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            toolbar: "#SbcCargoToolBar201707201713",
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
                        editor: {type: "uppercasebox", options: {required:true, validType: ['isCodeRepeat["SbcCargoDatagrid201707201714","SbcCargo","cargoCod"]','length[1,10]']}},
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
                        field: "cargoKindCod",
                        title: '<font color="red">货类代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCargoKind({
                                parentId: '#SbcCargoDatagrid201707201714',
                                fieldMapping: {
                                	cargoKindCod: 'cargoKindCod',
                                	cargoKindNam: 'cargoKindNam'
                                }
                            })
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
                        title: '<font color="red">危险品等级</font>',
                        multiSort: true,
                        width:100,
                        halign: "center",
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcDangClass({
                                parentId: '#SbcCargoDatagrid201707201714',
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
                },
                onSelect:function(rowIndex,rowData){
                    var relbuilder = new HdEzuiQueryParamsBuilder(); 
                    relbuilder.setAndClause("cargoCod",rowData.cargoCod,"=","and");
                     $("#SbcCargoRelDatagrid1427420966140").datagrid({  
                         url: "../webresources/login/mappCargo/find", 
                         queryParams: relbuilder.build()}
                     );
                     $("#SbcCargoSubSearchbox1427420966140").searchbox('setValue',rowData.cnCargoNam);
                     subSbcCargo(rowData.cargoCod);
                }
        });
        
        $("#SbcCargoRelDatagrid1427420966140").datagrid({
            striped:true,
            method: "POST",
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            toolbar: "#SbcCargoRelToolBar1427420966140", 
            remoteSort:false,
            fit: true,
            fitColumns: false,
            columns: [[ 
				{
					field : "ck",
					checkbox : true
				}, {
					field : "companyCod",
					title : '<font color="red">作业公司</font>',
					multiSort : true,
					halign : "center",
					sortable : true,
					width:120,
					editor: {type: 'combogrid',
				    	options: HdUtils.code.sbcCompanyByCompanyCod({
				    		parentId: '#MappCargoDatagrid1487120113348',
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
				}, {
					field : "srcCargoCod",
					title : '<font color="red">原货代码</font>',
					multiSort : true,
					halign : "center",
					width:120,
					editor : {
						type : "uppercasebox",
						options : {
							required : true,
							validType : ['isCodeRepeat["MappCargoDatagrid1487120113348","MappCargo","srcCargoCod"]','length[1,40]']
						}
					},
					sortable : true
				},{
					field : "cargoCod",
					title : '<font color="red">标准货代码</font>',
					multiSort : true,
					halign : "center",
					width:120,
					/* editor : {
						type : 'combogrid',
						options : HdUtils.code.sbcCargo({
							required : true,
							parentId : "#MappCargoDatagrid1487120113348",
							textField: 'cargoCod', 
							fieldMapping : {
								cargoKindCod : 'cargoCod',
								cnCargoKindNam : 'cnCargoNam'
							},
							panelWidth:430,
							onSelect: function(index,record){    
								var ed = dg.datagrid('getEditor', {
									index : dg.datagrid("options").hdCurrentRowIndex,
									field : 'cnCargoNam'
								});
								$(ed.target).val(record.cnCargoNam);
								var ed = dg.datagrid('getEditor', {
									index : dg.datagrid("options").hdCurrentRowIndex,
									field : 'enCargoNam'
								});
								$(ed.target).val(record.enCargoNam);
					        }
						})
					}, */
					sortable : true
				}, {
					field : "cnCargoNam",
					title : "货中文名称",
					multiSort : true,
					halign : "center",
					width:160,
					editor : {
						type : "validatebox",
						options : {
							required : false,
							validType : 'length[0,100]'
						}
					},
					sortable : true
				}, {
					field : "enCargoNam",
					title : "货英文名称",
					multiSort : true,
					halign : "center",
					width:160,
					editor : {
						type : "uppercasebox",
						options : {
							required : false,
							validType : 'length[0,100]'
						}
					},
					sortable : true
				},  {
					field : "insAccount",
					title : "创建人",
					multiSort : true,
					halign : "center",
					width:80,
					hidden:true,
					sortable : true
				}, {
					field : "insTimestamp",
					title : "创建时间",
					multiSort : true,
					halign : "center",
					width:140,
					hidden:true,
					formatter: $.hd.ezui.formatter.datetime,
					sortable : true
				}, {
					field : "updAccount",
					title : "更新人",
					multiSort : true,
					halign : "center",
					width:80,
					hidden:true,
					sortable : true
				}, {
					field : "updTimestamp",
					title : "更新时间",
					multiSort : true,
					halign : "center",
					width:140,
					formatter: $.hd.ezui.formatter.datetime,
					hidden:true,
					sortable : true
				}, 
				] ],
             onDblClickRow: function (index, data) {
             }
        });
        // 删除。
        $("#SbcCargoRelToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {

                var selectData = $("#SbcCargoRelDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                     $.ajax({
                         url: "../webresources/login/mappCargo/saveMappCargo",
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         data: $.toJSON(pam),
                         success: function(data) {       
                             $("#SbcCargoRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subSbcCargo(dgSelected[0].cargoCod);
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
        function subSbcCargo(codValue)
        {
            var schvalue= $("#SbcCargoSubSearchbox1427420966140").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "CN_CARGO_NAM,CARGO_COD");
            $("#SbcCargoSubDatagrid1427420966140").datagrid("load");
        }
        $("#SbcCargoSubDatagrid1427420966140").datagrid({
            striped:true,
            url: "../webresources/login/cargo/findSrcCargo",
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
            toolbar: "#SbcCargoSubToolBar1427420966140",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "CN_CARGO_NAM", title: "货名称",  multiSort: true,  halign: "center", width:160,  sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {field: "CARGO_COD",title: '货代码',multiSort: true, halign: "center",width:120,sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    { field: "COMPANY_COD", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.COMPANY_NAM;
                        },
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCompanyByCompanyCod({
                                parentId: '#SbcCargoSubDatagrid1427420966140',
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
        
        var dgSub = $("#SbcCargoSubDatagrid1427420966140");
        
        $("#SbcCargoSubSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
            subSbcCargo("");
        }});
        // 关联。
        $("#SbcCargoSubToolBar1427420966140 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =dg.datagrid("getSelected");
            if(selectRow){
                var selectData =dgSub.datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/mappCargo/saveMappCargo",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#SbcCargoRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subSbcCargo(dgSelected[0].cargoCod);
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

