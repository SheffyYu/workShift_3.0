<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:470px;">
        <div id="SbcCustomerToolBar1494818191170" style="padding-top: 0px;">
                <div style="float:left;">
                    <shiro:hasPermission name="webresources:login:SbcCustomer:add">
                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcCustomer:update">
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcCustomer:delete">
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                    </shiro:hasPermission>
                    
                    <shiro:hasPermission name="webresources:login:SbcCustomer:refresh">
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
                    </shiro:hasPermission>
                </div>
                <shiro:hasPermission name="webresources:login:SbcCustomer:searchbox">
                    <input class="easyui-searchbox" id="SbcCustomerSearchbox1494818191170"/>
                </shiro:hasPermission>
              
        </div>
          <table id="SbcCustomerDatagrid1494818191170" title="标准客户" style="height:100%"></table>
          <div id="SbcCustomerDialog1494818191170"   style="display:none"></div>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcCustomerRelToolBar1494818191170" >
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
<!--             <input class="easyui-searchbox" id="SbcPortRelSearchbox1411140"/> -->
        </div>
         <table id="MappCustomerDatagrid1494818191170" title="对应客户"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:500px;">
        <div id="SbcCustomerSubToolBar1494818191170" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
                </div>
                <input class="easyui-searchbox" id="SbcCustomerSubSearchbox1494818191170"/>
        </div>
        <table id="SbcCustomerSubDatagrid1494818191170" title="来源客户" style="height:100%"></table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
    	var customerTypeListAll=[];
    	var dialogTitleAddF = "增加";
		var dialogTitleEditF = "编辑";
		$.ajax({
            type: "POST",
            url: "../webresources/login/SbcCustomer/findCustomerType",
            contentType: "application/json",
            success: function (data) {
            	console.log(data);
            	customerTypeListAll=data;
            },
            error: function (data) {
                HdUtils.messager.info("数据加载失败，请刷新页面");
            }
        });
    	var scdg=$("#SbcCustomerDatagrid1494818191170");
    	$("#SbcCustomerToolBar1494818191170 a[iconCls='icon-add']").on("click", function() {
    		/*********勿删，测试文景接口数据************/
    		/*  var dataJason = {};
    		dataJason.id="3008";
    		var entityData={};
    		entityData.TEXT="船舶规范审核管理";
    		entityData.OPERATION="UPDATE";
    		var privilegeData = {};
    		privilegeData.NEW_TEXT="船舶规范审核管理1";
    		privilegeData.NEW_URL="";
    		privilegeData.NEW_SORTER=0;
    		privilegeData.NEW_STATE="open";
    		entityData.DATA=privilegeData;
    		
    		dataJason.data=entityData;
    		
    		dataJason.coId="";
    		dataJason.coKey="";
    		debugger
    		$.ajax({
	            type: "POST",
	            url: "../webresources/partnerService/accpteCommand",
	            contentType: "application/json",
	            dataType: "json",
	            data: $.toJSON(dataJason),
	            success: function (data) {
	            	debugger
	            },
	            error: function (data) {
	                HdUtils.messager.info(data.responseText);
	            }	
	    	});  */
    	    $("#SbcCustomerDialog1494818191170").show();
            HdUtils.dialog.show({height: 510,width:730,resizable:false, title: dialogTitleAddF, href: "../login/customer/sbccustomer/sbc_customer_detail.html", isSaveHandler: true});
           	var data={};
           	data.type="ADD";
           	data.customerTypeListAll=customerTypeListAll;
            HdUtils.dialog.setValue({data:data,dataGrid:scdg});
        });
    
        // 编辑。
        $("#SbcCustomerToolBar1494818191170 a[iconCls='icon-edit']").on("click", function() {
        	 $("SbcCustomerDialog1494818191170").show();
             var selectRow = scdg.datagrid("getSelected");
             if (selectRow == undefined) {
                 HdUtils.messager.info("请选择一条记录");
             } else {
                var builder111=new HdEzuiQueryParamsBuilder();
             	builder111.setAndClause("customerId",selectRow.customerId,"=","and");
             	builder111.hdEzuiQueryParams.page = 1;
             	builder111.hdEzuiQueryParams.rows = 1;
 	           $.ajax({
 	           		type: "POST",
 	                url: "../webresources/login/SbcCustomer/findVSbcCustomerById",
 	                contentType: "application/json",
 	                data: $.toJSON(builder111.build()),
 	                async:false,
 	                success: function (data) {
 	                	console.log(data);
 	                	if(data.rows){
 	                		if(customerTypeListAll){
 	                			data.rows[0].customerTypeListAll=customerTypeListAll;
 	                		}
 	                		HdUtils.dialog.setValue({data:data.rows[0],dataGrid:scdg});
 	   	                    HdUtils.dialog.show({height: 510,width:730,resizable:false,title: dialogTitleEditF, href: "../login/customer/sbccustomer/sbc_customer_detail.html", isSaveHandler: true});
 	                	}
 	                 }
 	           	});
              }
        });
        // 删除。
        $("#SbcCustomerToolBar1494818191170 a[iconCls='icon-remove']").on("click", function() {
        	var selects=scdg.datagrid("getChecked");
            if(selects==undefined||selects==null||selects.length<=0){
            	HdUtils.messager.info('请选择要删除的数据.');
            	return;
            }
            $.messager.confirm("提示","是否确认删除.", function(r){
		        if (r){
		        	var dataJason=null;
			    	var customerList=[];
		        	for (var i = 0; i < selects.length; i++) {
		        		var customer={};
		        		customer.customerId=selects[i].customerId;
		        		customer.customerCod=selects[i].customerCod;
			            customerList.push(customer);
			            dataJason={deletedRows:customerList,insertedRows:[],updatedRows:[]};
		        	}
		            $.ajax({
			            type: "POST",
			            url: "../webresources/login/SbcCustomer/deleteCustomer",
			            contentType: "application/json",
			            dataType: "json",
			            data: $.toJSON(dataJason),
			            success: function (data) {
			            	scdg.datagrid("hdReload");
			            },
			            error: function (data) {
			                HdUtils.messager.info(data.responseText);
			            }	
			    	});
		        }
            });
        });
        // 保存。
        $("#SbcCustomerToolBar1494818191170 a[iconCls='icon-save']").on("click", function() {
        	 dg.datagrid("hdSave", {url: "../webresources/login/SbcCustomer/save"});
        });
        // 刷新。
        $("#SbcCustomerToolBar1494818191170 a[iconCls='icon-reload']").on("click", function() {
            var value=$("#SbcCustomerSearchbox1494818191170").val();
            SbcCustomerbuilder.set("q", value);
            //builder.setOrderByClause("customerCod","desc");
            scdg.datagrid("load");
        });
        // 条件类。
        var SbcCustomerbuilder = new HdEzuiQueryParamsBuilder();
        //builder.setOrderByClause("customerCod","desc");
        $("#SbcCustomerSearchbox1494818191170").searchbox({prompt: "请输入...", searcher: function(value, name) {
        	SbcCustomerbuilder.set("q", value);
        	SbcCustomerbuilder.set("queryColumns", "cnCustomerNam,customerCod,shortNam,customerTypDesc");
            scdg.datagrid("load");
            }});
        //中间searchbox
//          var mapbuilder = new HdEzuiQueryParamsBuilder();
//          //mapbuilder.setOrderByClause("portCod","desc");
//         $("#SbcPortRelSearchbox1411140").searchbox({prompt: "请输入...", searcher: function(value, name) {
//         	mapbuilder.set("q", value);
//         	mapbuilder.set("queryColumns", "customerCod,cnCustomerNam,srcCustomerCod");
//             $("#MappCustomerDatagrid1494818191170").datagrid("load");
//         }});
        scdg.datagrid({
        	striped:true,
            url: "../webresources/login/ViSbcCustomer/find",
            queryParams: SbcCustomerbuilder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            checkOnSelect:true,
            rownumbers: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
        	sortOrder: 'desc',
	        sortName: 'updTimestamp',
            toolbar: "#SbcCustomerToolBar1494818191170",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
					{
                        field: "cnCustomerNam",
                        title: '客户名称',
                        multiSort: true,
                        width:180,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "customerCod",
                        title: '客户代码',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                   /*  {
                        field: "enCustomerNam",
                        title: "客户英文名称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    }, */
                    {
                        field: "shortNam",
                        title: "客户简称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "customerTypDesc",
                        title: "客户类型",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "bizTypDesc",
                        title: "经营类型",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "cargoTypDesc",
                        title: "主要货类",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "mainBusiness",
                        title: "主要业务",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "businessNatureNam",
                        title: "公司性质",
                        multiSort: true,
                        halign: "center",
                        width:100,
                       /*  formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'BUSINESS_NATURE', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }, */
                        sortable: true
                    },
                    {
                        field: "classificationNam",
                        title: "公司级别",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        /* formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CUSTOMER_CLASSIFICATION', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }, */
                        sortable: true
                    },
                    {
                        field: "parentFirmCompanyNam",
                        title: "上级公司",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                   /*  {
                        field: "parentFirm",
                        title: "上级公司",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        formatter: function (value, row, index) {
                            return row.parentFirmCompanyNam;
                        },    
                        sortable: true
                    }, */
                    { 
                        field: "chiefNam",
                        title: "法人代表",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    { 
                        field: "qualification",
                        title: "公司资质",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        sortable: true
                    },
                    {
                        field: "areaNam",
                        title: '所属区域',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                   /*  {
                        field: "areaCod",
                        title: '所属区域',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        formatter: function (value, row, index) {
                     	   if(row.entitySbcArea!=null){
                     		   return row.entitySbcArea.cnAreaNam;
                     	   } else {
                     		   return value;
                     	   }
                        },
                        sortable: true
                    }, */
                    {
                        field: "province",
                        title: "省",
                        multiSort: true,
                        width:40,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "city",
                        title: "市",
                        multiSort: true,
                        width:40,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "addressTxt",
                        title: "地址",
                        multiSort: true,
                        width:180,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "webSite",
                        title: "公司网站",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: '创建人',
                        multiSort: true,
                        halign: "center",
                        width:60,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '创建时间',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:100,
                        formatter: $.hd.ezui.formatter.datetime
                    },
                    {
                        field: "updAccount",
                        title: '更新人',
                        multiSort: true,
                        halign: "center",
                        width:60,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '更新时间',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:100,
                        formatter: $.hd.ezui.formatter.datetime
                    }
                ]],
                onDblClickRow: function (rowIndex, rowData) {
                	HdUtils.dialog3.setValue({customerId:rowData.customerId,customerCod:rowData.customerCod,addressTxt:rowData.addressTxt});
            	    HdUtils.dialog3.show({height: 530,width:900,resizable:false,title: dialogTitleEditF, href: "../login/customer/sbccustomer/sbc_customer_organ_list.jsp"});
                },
	        onSelect:function(rowIndex,rowData){
	            var builder22 = new HdEzuiQueryParamsBuilder(); 
	            builder22.setAndClause("customerCod",rowData.customerCod,"=","and");
	             $("#MappCustomerDatagrid1494818191170").datagrid({  
	                 url: "../webresources/login/MappCustomer/find", 
	                 queryParams: builder22.build()}
	             );
	             $("#SbcCustomerSubSearchbox1494818191170").searchbox('setValue',rowData.cnCustomerNam,rowData.customerCod);
	             subCustomerSearch(rowData.customerCod);
	        }
        });
    	
        $("#SbcCustomerRelToolBar1494818191170 a[iconCls='icon-remove']").on("click", function () {
            var selectData = $("#MappCustomerDatagrid1494818191170").datagrid("getChecked");
            if(selectData&&selectData.length>0)
            {
                var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                 $.ajax({
                     url: "../webresources/login/MappCustomer/saveSbcCustomerRelSave",
                     type: "POST",
                     dataType: "json",
                     contentType: "application/json",
                     data: $.toJSON(pam),
                     success: function(data) {       
                         $("#MappCustomerDatagrid1494818191170").datagrid("load");
                         var scdgSelected = scdg.datagrid("getChecked");
                         subCustomerSearch(scdgSelected[0].customerCod);
                        HdUtils.messager.bottomRight(data.message,'提示');
                     }
                 });
            }else{
                 $.messager.alert("提示", "请选择！", "info");
            }
        });
        // datagrid
        $("#MappCustomerDatagrid1494818191170").datagrid({
        	 striped:true,
            //queryParams: builder.build(),
            method: "POST",
            //pagination: true,
            sortName: 'updTimestamp',
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            width:500,
            rownumbers: true,
            toolbar: "#SbcCustomerRelToolBar1494818191170",
            fit: true,
            fitColumns: false,
            columns: [[
					{
    					field: "ck",
    					checkbox: true
					},
                    {
                        field: "guid",
                        title: '<font color="red">guID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "cnCustomerNam",
                        title: "客户名称",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    
                    {
                        field: "srcCustomerCod",
                        title: '原客户代码',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "customerCod",
                        title: '标准客户代码',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcCustomer({
                        		required:true,
                        		parentId:"#MappCustomerDatagrid1494818191170",
                        		textField:'customerCod',
                        		fieldMapping: {
                        			countryCod : 'customerCod',
                        			cnCountryNam : 'cnCustomerNam'
	                    		},
	                        	onSelect:function(index,record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'cnCustomerNam'
	                    			});
	                    			$(ed.target).val(record.cnCustomerNam);
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'enCustomerNam'
	                    			});
	                    			$(ed.target).val(record.enCustomerNam);
	                    		}
                        	})
                        },
                    },
                    {
                        field: "companyCod",
                        title: '作业公司',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        editor: {type: 'combogrid',
                        	options: HdUtils.code.sbcCompanyByCompanyCod({
                        		parentId: '#MappCustomerDatagrid1494818191170',
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
                        field: "enCustomerNam",
                        title: "客户英文名字",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor:{type:"uppercasebox",options:{required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        hidden:true,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "创建时间",
                        multiSort: true,
                        halign: "center",
                        width:140,
                        hidden:true,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        width:80,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                /* onDblClickCell: function (index) {
                	dg.datagrid("hdEdit"); 
                	dg.datagrid('getEditor', {index: index, field: 'cnCustomerNam'}).target.prop('disabled', true);
                	dg.datagrid('getEditor', {index: index, field: 'enCustomerNam'}).target.prop('disabled', true);
                } */
                });
        		$("#MappCustomerDatagrid1494818191170").datagrid("hdGetColumnNames");
        		 var subbuilder = new HdEzuiQueryParamsBuilder();
        	        function subCustomerSearch(codValue)
        	        {
        	            var schvalue= $("#SbcCustomerSubSearchbox1494818191170").searchbox('getValue');
        	            subbuilder.set("q", schvalue);
        	            subbuilder.set("qValue",codValue);
        	            subbuilder.set("queryColumns", "CUSTOMER_COD,CN_CUSTOMER_NAM");
        	            $("#SbcCustomerSubDatagrid1494818191170").datagrid("load");
        	        }
        	        $("#SbcCustomerSubDatagrid1494818191170").datagrid({
        	            striped:true,
        	            url: "../webresources/login/MappCustomer/findSrcCustomer",
        	            queryParams: subbuilder.build(),
        	            method: "POST",
        	            pagination: true,
        	            singleSelect: true,
        	            selectOnCheck:false,
        	            checkOnSelect:false,
        	            rownumbers: true,
        	            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
        	            pageSize: 100,
        	            autoLoad:false,
        	            remoteSort:false,
        	            toolbar: "#SbcCustomerSubToolBar1494818191170",
        	            fit: true,
        	            fitColumns: false,
        	           
        	            columns: [[ 
        	                    {
        	    					field: "ck",
        	    					checkbox: true
        						},
        	                    {
        	                        field: "CUSTOMER_ID",
        	                        title: '<font color="red">guID</font>',
        	                        multiSort: true,
        	                        halign: "center",
        	                        sortable: true,
        	                        hidden: true
        	                    },
        	                    {
        	                        field: "CN_CUSTOMER_NAM",
        	                        title: "客户名称",
        	                        multiSort: true,
        	                        halign: "center",
        	                        width:180,
        	                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,60]'}},
        	                        sortable: true
        	                    },
        	                    
        	                    {
        	                        field: "CUSTOMER_COD",
        	                        title: '客户代码',
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
        	        
        	       
        	        
        	        $("#SbcCustomerSubSearchbox1494818191170").searchbox({prompt: "请输入...", searcher: function(value, name) {
        	        	subCustomerSearch("");
        	        }});
        	        // 关联。
        	        $("#SbcCustomerSubToolBar1494818191170 a[iconCls='icon-rel']").on("click", function() {
        	            
        	            var selectRow =scdg.datagrid("getSelected");
        	            if(selectRow){
        	                var selectData =$("#SbcCustomerSubDatagrid1494818191170").datagrid("getChecked");
        	                if(selectData&&selectData.length>0)
        	                {
        	                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
        	                    $.ajax({
        	                        url: "../webresources/login/MappCustomer/saveSbcCustomerRelSave",
        	                        type: "POST",
        	                        dataType: "json",
        	                        contentType: "application/json",
        	                        data: $.toJSON(pam),
        	                        success: function(data) {       
        	                             $("#MappCustomerDatagrid1494818191170").datagrid("load");
        	                             var scdgSelected = scdg.datagrid("getChecked");
        	                             subCustomerSearch(scdgSelected[0].customerCod);
        	                             HdUtils.messager.bottomRight(data.message,'提示');
        	                        }
        	                    });
        	                }else{
        	                     $.messager.alert("提示", "请选择原客户！", "info");
        	                }
        	            }
        	            else{
        	                 $.messager.alert("提示", "请选择标准客户！", "info");
        	            }
        	            
        	        });
            });
</script>


