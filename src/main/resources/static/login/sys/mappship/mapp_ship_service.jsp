<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:490px;">
		<div id="SbcShipServiceToolBar1487072258264" style="padding-top: 0px;">
				<div style="float:left">
					<!-- 标准按钮 -->
					<shiro:hasPermission name="webresources:sys:SbcShipService:add">
						<a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="webresources:sys:SbcShipService:update">
						<a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="webresources:sys:SbcShipService:delete">
						<a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="webresources:sys:SbcShipService:save">
						<a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="webresources:sys:SbcShipService:refresh">
						<a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
					</shiro:hasPermission>
					<!-- 标准按钮 结束-->
				</div>
				<input class="easyui-searchbox" id="SbcShipServiceSearchbox1487072258264" />
		</div>
        <table id="SbcShipServiceDatagrid1487072258264" title="标准航线" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcShipServiceRelToolBar1487072258264" >
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
           <!--  <input class="easyui-searchbox" id="mappServiceSearchbox122"/> -->
        </div>
         <table id="MappShipServiceDatagrid1487072258264" title="对应航线"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:500px;">
        <div id="SbcShipServiceSubToolBar1487072258264" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
                </div>
                <input class="easyui-searchbox" id="SbcShipServiceSubSearchbox1487072258264"/>
        </div>
        <table id="SbcShipServiceSubDatagrid1487072258264" title="来源航线" style="height:100%"></table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
    	var ssdg = $("#SbcShipServiceDatagrid1487072258264");
    	// buttons
    	// 增加。
    	$("#SbcShipServiceToolBar1487072258264 a[iconCls='icon-add']").on("click", function() {
    		ssdg.datagrid("hdAdd");
    	});
    	// 编辑。
    	$("#SbcShipServiceToolBar1487072258264 a[iconCls='icon-edit']").on("click",
    		function() {
    			ssdg.datagrid("hdEdit");
    			var selectIdx = ssdg.datagrid("options").hdCurrentRowIndex;
    			ssdg.datagrid('getEditor', {index : selectIdx,field : 'shipServiceCod'}).target.prop('disabled', true);
    	});
    	// 删除。
    	$("#SbcShipServiceToolBar1487072258264 a[iconCls='icon-remove']").on("click",
    		function() {ssdg.datagrid("hdRealRemove",{url : "../webresources/login/SbcShipService/save"});
    	});
    	
    	// 保存。
        $("#SbcShipServiceToolBar1487072258264 a[iconCls='icon-save']").on("click", function () {
        	ssdg.datagrid("hdSave", {url: "../webresources/login/SbcShipService/save"});
        });

    	// 刷新。
    	$("#SbcShipServiceToolBar1487072258264 a[iconCls='icon-reload']").on("click",
    		function() {
    		var value=$("#SbcShipServiceSearchbox1487072258264").val();
        	builder.set("q", value);
        	ssdg.datagrid("load");
    	});
    	// 条件类。
    	var builder = new HdEzuiQueryParamsBuilder();
    	 builder.hdEzuiQueryParams.page = 1;
         builder.hdEzuiQueryParams.rows = 100;
         builder.setOrderByClause("shipServiceId","desc");
    	// searchbox
    	$("#SbcShipServiceSearchbox1487072258264").searchbox({prompt : "请输入...",
    		searcher : function(value, name) {
    			builder.set("q", value);
    			builder.set("queryColumns","shipServiceCod,cnShipServiceNam,enShipServiceNam,courseCod");
    			ssdg.datagrid("load");
    			}
    	});
    	// datagrid
    	$("#SbcShipServiceDatagrid1487072258264").datagrid({
	               striped:true,
				url : "../webresources/login/SbcShipService/find",
				queryParams : builder.build(),
				method : "post",
				pagination : true,
				singleSelect: true,
	            selectOnCheck:false,
	            checkOnSelect:true,
	            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
	            sortOrder: 'desc',//按更新时间倒序
	            sortName: 'updTimestamp',
				//autoLoad:false,
				rownumbers : true,
				pageSize : 100,
				toolbar : "#SbcShipServiceToolBar1487072258264",
				fit : true,
				fitColumns : false,
				columns : [ [
						{
							field : "ck",
							checkbox : true
						},
						{
							field : "shipServiceId",
							title : '<font color="red">航线代码ID</font>',
							multiSort : true,
							halign : "center",
							sortable : true,
							hidden : true
						},
						{
							field : "shipServiceCod",
							title : '航线代码',
							multiSort : true,
							width:100,
							halign : "center",
							editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcShipServiceDatagrid1487072258264","SbcShipService","shipServiceCod"]','length[1,20]']}},
							sortable : true
						},
						{
                            field : "cnShipServiceNam",
                            title : '航线中文名称',
                            multiSort : true,
                            width:200,
                            halign : "center",
                            editor: {type: "validatebox", options: {required:false,validType: 'length[0,60]'}},
                            sortable : true
                        },
                        {
                            field : "enShipServiceNam",
                            title : "航线英文名称",
                            multiSort : true,
                            width:100,
                            halign : "center",
                            editor : {
                                type : "uppercasebox",
                                options : {
                                    required : false,
                                    validType : 'length[0,60]'
                                }
                            },
                            sortable : true
                        },
                        {
                            field: "courseCod",
                            title: '航向代码',
                            multiSort: true,
                            width:100,
                            halign: "center",
                            sortable : true,
                            editor: {type: 'combogrid',
                                options: HdUtils.code.sbcCourse({
                                	parentId: '#SbcShipServiceDatagrid1487072258264',
                                    fieldMapping: {
                                    	courseCod: 'courseCod',
                                        cnCourseNam:'cnCourseNam'
                                    },
                                    required: false,
                                    panelWidth:260
                                })
                            },
                            formatter: function (value, row, index) {
                                return row.cnCourseNam;
                            },
                        },
						{
							field : "serviceTyp",
							title : '航线类别',
							multiSort : true,
							halign : "center",
							editor: {
	                            type: "combobox",
	                            options: HdUtils.code.scode({fieldCod: 'SERVICE_TYP'}, {required: true})
	                        },
	                        formatter: function (value) {
	                            if (value === null || value === '')
	                                return;
	                            var list = HdUtils.global.scode.query({fieldCod: 'SERVICE_TYP', code: value});
	                            return list.length > 0 ? list[0].name : "";
	                        },
							sortable : true,
							width:80
						},
						{
                            field : "tradeMark",
                            title : '贸易性质',
                            multiSort : true,
                            halign : "center",
                            width:80,
                            editor: {
                                type: "combobox",
                                options: HdUtils.code.scode({fieldCod: 'TRADE_MARK'}, {required: true})
                            },
                            formatter: function (value) {
                                if (value === null || value === '')
                                    return;
                                var list = HdUtils.global.scode.query({fieldCod: 'TRADE_MARK', code: value});
                                return list.length > 0 ? list[0].name : "";
                            },
                            sortable : true
                        },
						{
							field : "mainMark",
							title : "干支线标志",
							multiSort : true,
							halign : "center",
							width:80,
							formatter : function(value) {
								if ("0" == value) {
									return "支线";
								} else if ("1" == value) {
									return "干线";
								}
							},
							editor : {
								type : 'combobox',
								options : {
									valueField : 'value',
									textField : 'label',
									width:100,
									data : [
											{
												label : '支线',
												value : '0'
											},
											{
												label : '干线',
												value : '1'
											} ],
									panelHeight : "auto"
								}
							},
							sortable : true
						},
						{
							field : "oceanMark",
							title : "近远洋标志",
							multiSort : true,
							width:80,
							halign : "center",
							formatter : function(value) {
								if ("1" == value) {
									return "远洋";
								} else if ("0" == value) {
									return "近洋";
								}
							},
							editor : {
								type : 'combobox',
								options : {
									valueField : 'value',
									textField : 'label',
									width:100,
									data : [
											{
												label : '远洋',
												value : '1'
											},
											{
												label : '近洋',
												value : '0'
											} ],
									panelHeight : "auto"
								}
							},
							sortable : true
						},
						{
							field : "abandonedMark",
							title : '作废标志',
							multiSort : true,
							halign : "center",
							align : "center",
							width:80,
						    editor: $.hd.ezui.editor.checkbox,
		                	formatter: $.hd.ezui.formatter.checkbox2,
							sortable : true
						},
						{
	
							field : "description",
							title : "备注",
							multiSort : true,
							halign : "center",
							width:180,
							editor : {
								type : "validatebox",
								options : {
									required : false,
									validType : 'length[0,1000]'
								}
							},
							sortable : true,
							width:90
						},
						{
	
							field : "insAccount",
							title : '创建人',
							multiSort : true,
							halign : "center",
							required : true,
							width:80,
							sortable : true
						},
						{
	
							field : "insTimestamp",
							title : '创建时间',
							multiSort : true,
							halign : "center",
							required : true,
							width:140,
							formatter : HdUtils.formatter.datetime,
							sortable : true
						},
						{
	
							field : "updAccount",
							title : "更新人",
							multiSort : true,
							halign : "center",
							required : false,
							width:80,
							sortable : true
						},
						{
	
							field : "updTimestamp",
							title : "更新时间",
							multiSort : true,
							halign : "center",
							required : true,
							width:140,
							formatter : HdUtils.formatter.datetime,
							sortable : true
						}
	
				] ],
				onDblClickCell : function(index) {
					ssdg.datagrid("hdEdit");
					ssdg.datagrid('getEditor', {index : index,field : 'shipServiceCod'
					}).target.prop('disabled', true);
				},
				onSelect:function(rowIndex,rowData){
	   	            var builder = new HdEzuiQueryParamsBuilder(); 
	   	            builder.setAndClause("shipServiceCod",rowData.shipServiceCod,"=","and");
	   	             $("#MappShipServiceDatagrid1487072258264").datagrid({  
	   	                 url: "../webresources/login/MappShipService/find", 
	   	                 queryParams: builder.build()}
	   	             );
	   	             $("#SbcShipServiceSubSearchbox1487072258264").searchbox('setValue',rowData.cnShipServiceNam);
	   	             subShipServiceSearch(rowData.shipServiceCod);
	   	        }
			});

        var dg = $("#MappShipServiceDatagrid1487072258264");
        $("#SbcShipServiceRelToolBar1487072258264 a[iconCls='icon-remove']").on("click", function () {
            var selectData = $("#MappShipServiceDatagrid1487072258264").datagrid("getChecked");
            if(selectData&&selectData.length>0)
            {
                var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                 $.ajax({
                     url: "../webresources/login/SbcShipService/saveMappShipServiceRelSave",
                     type: "POST",
                     dataType: "json",
                     contentType: "application/json",
                     data: $.toJSON(pam),
                     success: function(data) {       
                         $("#MappShipServiceDatagrid1487072258264").datagrid("load");
                         var ssdgSelected = ssdg.datagrid("getChecked");
                         subShipServiceSearch(ssdgSelected[0].shipServiceCod);
                        HdUtils.messager.bottomRight(data.message,'提示');
                     }
                 });
            }else{
                 $.messager.alert("提示", "请选择！", "info");
            }
        });
        $("#mappServiceSearchbox122").searchbox({prompt: "请输入...", searcher: function(value, name) {
            var selectRow = $("#SbcShipServiceDatagrid1487072258264").datagrid("getSelected");
            var relbuilder = new HdEzuiQueryParamsBuilder();
            if(selectRow!=null){
                relbuilder.setAndClause("shipServiceCod",selectRow.shipServiceCod,"=","and");
            } 
            relbuilder.set("q", value);
            relbuilder.set("queryColumns", "cnShipServiceNam,srcShipServiceCod,shipServiceCod，companyCod")
            $("#MappShipServiceDatagrid1487072258264").datagrid({  
                url: "../webresources/login/MappShipService/find", 
                queryParams: relbuilder.build()}
            );
      }});
        // datagrid
        $("#MappShipServiceDatagrid1487072258264").datagrid({
           // queryParams: builder.build(),
            striped:true,
            method: "POST",
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            remoteSort:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            fit: true,
            fitColumns: false,
            toolbar: "#SbcShipServiceRelToolBar1487072258264",
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "cnShipServiceNam",
                        title: "航线中文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        sortable: true
                    },
                    {
                        field: "enShipServiceNam",
                        title: "航线英文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        sortable: true
                    },
                    {
                        field: "srcShipServiceCod",
                        title: '源航线代码',
                        multiSort: true,
                        halign: "center",
                        width:120,
                      //  editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "shipServiceCod",
                        title: '标准航线代码',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: '作业公司',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        },
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        width:80,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "创建时间",
                        multiSort: true,
                        halign: "center",
                        formatter: HdUtils.formatter.datetime,
                        width: 140,
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
                        formatter: HdUtils.formatter.datetime,
                        width: 140,
                        hidden:true,
                        sortable: true
                    },
                ]],
        });
        
        var subbuilder = new HdEzuiQueryParamsBuilder();
        function subShipServiceSearch(codValue)
        {
            var schvalue= $("#SbcShipServiceSubSearchbox1487072258264").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "SHIP_SERVICE_NAM,SHIP_SERVICE_COD");
            $("#SbcShipServiceSubDatagrid1487072258264").datagrid("load");
        }
        $("#SbcShipServiceSubDatagrid1487072258264").datagrid({
            striped:true,
            url: "../webresources/login/SbcShipService/findSrcShipService",
            queryParams: subbuilder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            selectOnCheck:false,
            checkOnSelect:false, 
            rownumbers: true,
            autoLoad:false,
            pageSize: 100,
            remoteSort:false,
            toolbar: "#SbcShipServiceSubToolBar1487072258264",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {
    					field: "ck",
    					checkbox: true
					},
                    {
                        field: "SHIP_SERVICE_ID",
                        title: '<font color="red">guID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "SHIP_SERVICE_NAM",
                        title: "航线名称",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    
                    {
                        field: "SHIP_SERVICE_COD",
                        title: '航线代码',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "COMPANY_NAM",
                        title: '作业公司',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        /* editor: {type: 'combogrid',
                        	options: HdUtils.code.sbcCompanyByCompanyCod({
                        		parentId: '#SbcCustomerSubDatagrid1494818191170',
                        		textField:'COMPANY_COD',
                        		fieldMapping: {
                        			companyCod: 'COMPANY_COD',
                        			cnCompanyNam:'CN_COMPANY_NAM'
                        			},
                        			required: true                 
                            })
                        }, 
                        formatter: function (value, row, index) {
                            return row.company_nam;
                        }, */
                    }
              ]],
        });
       
        
        $("#SbcShipServiceSubSearchbox1487072258264").searchbox({prompt: "请输入...", searcher: function(value, name) {
        	subShipServiceSearch("");
        }});
        // 关联。
        $("#SbcShipServiceSubToolBar1487072258264 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =ssdg.datagrid("getSelected");
            if(selectRow){
                var selectData =$("#SbcShipServiceSubDatagrid1487072258264").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/SbcShipService/saveMappShipServiceRelSave",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#MappShipServiceDatagrid1487072258264").datagrid("load");
                             var ssdgSelected = ssdg.datagrid("getChecked");
                             subShipServiceSearch(ssdgSelected[0].shipServiceCod);
                            HdUtils.messager.bottomRight(data.message,'提示');
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择原航线！", "info");
                }
            }
            else{
                 $.messager.alert("提示", "请选择标准航线！", "info");
            }
            
        });
    });
</script>