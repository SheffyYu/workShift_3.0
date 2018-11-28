<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="mainDiv1487906964309" class="easyui-layout" fit="true">
<div data-options="region:'center'" >
	<div id="SbcCourseToolBar1486860399659" style="padding-top: 0px;">
        <div style="float:left;">
        <shiro:hasPermission name="webresources:login:SbcCourse:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCourse:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCourse:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCourse:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:SbcCourse:refresh">
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
        &nbsp;
        </div>
        <input class="easyui-searchbox" id="SbcCourseSearchbox1486860399659"/>
    </div>
<table id="SbcCourseDatagrid1486860399659" style="height:100%"></table>
</div>
<div data-options="region:'south',split:true" style="height:340px;">
<div id="SbcShipServiceToolBar201705222101" style="padding-top: 0px;">
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
			 <a class="easyui-linkbutton" id='VesselScheduleGpg2324' plain="false">查看航线筛选</a>
			<!-- 标准按钮 结束-->
		</div>
		<input class="easyui-searchbox" id="SbcShipServiceSearchbox201705222101" />
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<table id="SbcShipServiceDatagrid111" style="height: 100%"></table>
<div id="VesselScheduleDialog4792111128"   style="display:none"></div>
</div>
</div>
<script type="text/javascript" src="/login/sys/shipSelected/ship_selected.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
    	
    	
    	var dg = $("#SbcCourseDatagrid1486860399659");
    	
        // buttons
        // 增加。
        $("#SbcCourseToolBar1486860399659 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");      
        });
        // 编辑。
        $("#SbcCourseToolBar1486860399659 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        	 var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
             dg.datagrid('getEditor', {index: selectIdx, field: 'courseCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCourseToolBar1486860399659 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove",{url : "../webresources/login/SbcCourse/save"});
        });
        // 保存。
        $("#SbcCourseToolBar1486860399659 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcCourse/save"});
            
        });
        // 刷新。
        $("#SbcCourseToolBar1486860399659 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCourseSearchbox1486860399659").val();
        	builder.set("q", value);
        	dg.datagrid("load");
        });
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("courseCod","desc");
        // searchbox
        $("#SbcCourseSearchbox1486860399659").searchbox({prompt: "请输入...", searcher: function (value, name) {
              builder.set("q", value);
              builder.set("queryColumns", "courseCod,cnCourseNam,enCourseNam");
              dg.datagrid("load");
            }
        });
        
    //航线
        var dgSbcShipService = $("#SbcShipServiceDatagrid111");
        var editflag=null;//编辑状态
		// 增加。
		$("#SbcShipServiceToolBar201705222101 a[iconCls='icon-add']").on("click", function() {
			var selectRow = $("#SbcCourseDatagrid1486860399659").datagrid("getSelected");
			editflag=false;//编辑状态为false
			if (selectRow == undefined) {
	            HdUtils.messager.info("请选择一条记录");
	        } else {
	        	$("#SbcShipServiceDatagrid111").datagrid("hdAdd",{"courseCod":selectRow.courseCod});
// 	              var selectIdx = $("#SbcShipServiceDatagrid111").datagrid("options").hdCurrentRowIndex;
// 	              $("#SbcShipServiceDatagrid111").datagrid('getEditor', {index: selectIdx, field: 'cnCarrier'}).target.prop('disabled', true);         
	        	  nams = [];
                  cods=[]; 
	        }
			
		});
		// 编辑。
		$("#SbcShipServiceToolBar201705222101 a[iconCls='icon-edit']").on("click",function() {
				dgSbcShipService.datagrid("hdEdit");
				editflag=true;
   		    	 var selectIdx = dgSbcShipService.datagrid("options").hdCurrentRowIndex;
// 				dgSbcShipService.datagrid('getEditor', {index: selectIdx, field: 'cnCarrier'}).target.prop('disabled', true);         
				dgSbcShipService.datagrid('getEditor', {index : selectIdx,field : 'shipServiceCod'}).target.prop('disabled', true);
 		});
		// 删除。
		$("#SbcShipServiceToolBar201705222101 a[iconCls='icon-remove']").on("click",
			function() {dgSbcShipService.datagrid("hdRealRemove",{url : "../webresources/login/SbcShipService/save"});
		});
		// 保存。
		$("#SbcShipServiceToolBar201705222101 a[iconCls='icon-save']").on("click",function() {
			dgSbcShipService.datagrid("hdSave",{url : "../webresources/login/SbcShipService/save"});
	
		});
		// 刷新。
		$("#SbcShipServiceToolBar201705222101 a[iconCls='icon-reload']").on("click",
			function() {
			var value=$("#SbcShipServiceSearchbox201705222101").val();
	    	builderSbcShipService.set("q", value);
	    	builderSbcShipService.set("queryColumns", "courseCod,cnCourseNam,enCourseNam");
	    	dgSbcShipService.datagrid("load");
		});
			
	    
		$("#VesselScheduleGpg2324").on("click",function() {
			var selectRow = $("#SbcShipServiceDatagrid111").datagrid("getSelected");
			var builder20151210=new HdEzuiQueryParamsBuilder();
             builder20151210.setAndClause("courseCod",selectRow.courseCod,"=","and");
             builder20151210.setAndClause("shipServiceCod",selectRow.shipServiceCod,"=","and");
            $.ajax({
                 type: "POST",
                 url: "../webresources/login/VesselSchedule/find",
                 contentType: "application/json",
                 data: $.toJSON(builder20151210.build()),
                 async:false,
                 success: function (data) {
	                if(data.rows.length==0){HdUtils.messager.info("无相应航线筛选");return;}
                	 $("#VesselScheduleDialog4792111128").show();
                	 var object=data.rows[0];
                     HdUtils.dialog3.setValue({data:object});
                     HdUtils.dialog3.show({height: 440,width:590,title: "航线筛选", href: "../login/sys/sbccourse/service_search_detail.jsp"});
          
                 }
             });
			        });
		
		// 条件类。
	     var builderSbcShipService = new HdEzuiQueryParamsBuilder();
// 	     builderSbcShipService.hdEzuiQueryParams.page = 3;
// 	     builderSbcShipService.hdEzuiQueryParams.rows = 20;
	     builderSbcShipService.setOrderByClause("shipServiceId","desc");
		// searchbox
		$("#SbcShipServiceSearchbox201705222101").searchbox({prompt : "请输入...",
			searcher : function(value, name) {
				builderSbcShipService.set("q", value);
				builderSbcShipService.set("queryColumns","shipServiceCod,cnShipServiceNam,enShipServiceNam");
				dgSbcShipService.datagrid("load",builderSbcShipService.build());
			}
		});
        // datagrid
        $("#SbcCourseDatagrid1486860399659").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCourse/find",
            queryParams: builder.build(),
            method: "POST",
            //pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            //autoLoad:false,        
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            //pageSize: 20,
            toolbar: "#SbcCourseToolBar1486860399659",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "courseCod",
                        title: '<font color="red">航向代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcCourseDatagrid1486860399659","SbcCourse","courseCod"]','maxLength[10]']}},
                        sortable: true
                    },
                    {
                        field: "enCourseNam",
                        title: "航向英文名称",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "uppercasebox", options: {required: false, validType: 'maxLength[60]'}},
                        sortable: true
                    },
                    {
                        field: "cnCourseNam",
                        title: "中文航向名称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[60]'}},
                        sortable: true
                    },
                    {
                        field: "courseZone",
                        title: "所属区域",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[60]'}},
                        sortable: true
                    },
                    {
                        field: "abandonedMark",
                        title: '作废标志',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        formatter: $.hd.ezui.formatter.checkbox2,
                	    editor: $.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false, validType: 'maxLength[1000]'}},
                        sortable: true,
                        width:180
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
                        formatter: $.hd.ezui.formatter.datetime,
                        width: 140,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '更新人',
                        multiSort: true,
                        width:80,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '更新时间',
                        multiSort: true,
                        halign: "center",
                        formatter: $.hd.ezui.formatter.datetime,
                        width: 140,
                        sortable: true
                    },
                ]],onDblClickCell: function (index) {
                	dg.datagrid("hdEdit");
                	var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
                    dg.datagrid('getEditor', {index: selectIdx, field: 'courseCod'}).target.prop('disabled', true);
                },
                onSelect:function(rowIndex,rowData){
              	  builderJoin=new HdEzuiQueryParamsBuilder();
              	  builderJoin.setAndClause("courseCod",rowData.courseCod,"=","and");
              	  $("#SbcShipServiceDatagrid111").datagrid("load",builderJoin.build());
                }
        });
        var  nams = [];
        var cods=[]; 
        var builderJoinNam = new HdEzuiQueryParamsBuilder();
        builderJoinNam.setAndClause("customerTyp","SL","=","and"); //船公司
     // 航线datagrid
    	$("#SbcShipServiceDatagrid111").datagrid({
        striped:true,
        url : "../webresources/login/SbcShipService/find",
		queryParams : builderSbcShipService.build(),
		method : "post",
		//pagination : true,
		singleSelect: true,
        selectOnCheck:false,
        checkOnSelect:false,
           //sortOrder: 'desc',//按更新时间倒序
           //sortName: 'updTimestamp',
		autoLoad:false,
		rownumbers : true,
		//pageSize : 20,
		toolbar : "#SbcShipServiceToolBar201705222101",
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
					title : '<font color="red">航线代码</font>',
					multiSort : true,
					width:100,
					halign : "center",
					editor : {
						type : "uppercasebox",
						options : {
							required : true,
							validType : [
									'isCodeRepeat["SbcShipServiceDatagrid111","SbcShipService","shipServiceCod"]',
									'length[1,20]' ]
						}
					},
					sortable : true
				},
				{
					field : "courseCod",
					title : "航向代码",
					multiSort : true,
					halign : "center",
					width:100,
				    hidden:true,
					sortable : true
				},
				{
					field : "cnShipServiceNam",
					title : '航线中文名称',
					multiSort : true,
					width:100,
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
					field : "serviceTyp",
					title : '<font color="red">航线类别</font>',
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
					field : "tradeMark",
					title : '<font color="red">贸易性质</font>',
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
                    field: "maidenTim",
                    title: '首航时间',
                    multiSort: true,
                    halign: "center",
                    formatter: $.hd.ezui.formatter.date,
                    editor: {type: "datebox"},

                    width: 140,
                    sortable: true
                },
                /* {
                    field: "ignoenCarrier",
                    title: '船公司代码选项',
                    multiSort: true,
                    width:100,
                    halign: "center",
                    editor:{type:'combogrid',
                        options:HdUtils.code.sbcCustomer3({
                            required:false,
                            parentId:"#SbcShipServiceDatagrid111",
                            textField:'customerCod',
                            //multiple:true,
                            fieldMapping: {
                            	customerCod : 'customerCod',
                            	cnCustomerNam : 'cnCustomerNam'
                            },
                            onSelect:function(index,record){
                            	var selectIdx = $("#SbcShipServiceDatagrid111").datagrid("options").hdCurrentRowIndex;
                            	var enCarrier22=$("#SbcShipServiceDatagrid111").datagrid('getEditor', {
                                      index:selectIdx ,
                                      field :'enCarrier'
                                  });
                            	 var cnCarrier1=$("#SbcShipServiceDatagrid111").datagrid('getEditor', {
                                     index:selectIdx ,
                                     field :'cnCarrier'
                                 });
                            	 if(editflag){//编辑
		                           	var v=$(enCarrier22.target).val();
                            		 if($(enCarrier22.target).val()==""||$(enCarrier22.target).val()==null){//增加或编辑的清除状态
		                           		 cods=[]; 
		                           	 }else{
	                                    cods.push($(enCarrier22.target).val()); 
	                                    // nams.push($(cnCarrier1.target).val()); 
		                           	 }
                            	 }
                   		   //nams.push(record.cnCustomerNam);
                            cods.push(record.customerCod);
                           $(enCarrier22.target).val(cods.join()); 
                          // $(cnCarrier1.target).val(nams.join()); 
                           cods=[]; 
                            }
                        })
                    },
                    sortable: true
                }, */
                {
                    field: "enCarrier",
                    title: '船公司代码',
                    multiSort: true,
                    width:130,
                    halign: "center",
                    editor:{type:"validatebox"},
//                    editor : {
//                         type : "uppercasebox",
//                     },
                    sortable: true
                },
                {	field: "id",
                    title: '',
                    multiSort: true,
                    width:40,
                    halign: "center",
                    align: "center",
                	formatter:function(value,row){
                        return  "<button onclick=\"show('"+row+"')\" >...</button>";
                     }
                },
                {
                    field: "cnCarrier",
                    title: '船公司名称',
                    multiSort: true,
                    halign: "center",
                    width:180,
                    editor:{type:"validatebox"},
                    sortable: true
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
			dgSbcShipService.datagrid("hdEdit");
            var selectIdx = dgSbcShipService.datagrid("options").hdCurrentRowIndex;

// 			dgSbcShipService.datagrid('getEditor', {index : selectIdx,field : 'shipServiceCod'
// 			}).target.prop('disabled', true);
// 			dgSbcShipService.datagrid('getEditor', {index : selectIdx,field : 'cnCarrier'
//             }).target.prop('disabled', true);
		}
	});
    
});
    function show(row){
    	var selectRow = $("#SbcShipServiceDatagrid111").datagrid("getSelected");
		if(selectRow.enCarrier ==null){
			selectRow.enCarrier='';
		}
		if(selectRow.cnCarrier ==null){
			selectRow.cnCarrier='';
		}
		openSelectShipCompanyDialog1('enCarrier','cnCarrier',selectRow.enCarrier,selectRow.cnCarrier,checkField);
  	}
    function checkField(shipCod,shipNam){
    	$("#SbcShipServiceDatagrid111").datagrid("hdEdit");
    	var selectIdx = $("#SbcShipServiceDatagrid111").datagrid("options").hdCurrentRowIndex;
		var ed1 = $('#SbcShipServiceDatagrid111').datagrid('getEditor', {index:selectIdx,field:'enCarrier'});
		$(ed1.target).val(shipCod);
		var ed2 = $('#SbcShipServiceDatagrid111').datagrid('getEditor', {index:selectIdx,field:'cnCarrier'});
		$(ed2.target).val(shipNam);
		
   	 	var aaa = $('#SbcShipServiceDatagrid111').datagrid('getEditor', {index:selectIdx,field:'shipServiceCod'});
   	    aaa.target.prop('disabled', true);
    } 
</script>

