function initShipCompny(selectedShipCompanyCod){	
		var ShipCompanyBuilder=new HdEzuiQueryParamsBuilder();
		var ShipCompanySelectedBuilder=new HdEzuiQueryParamsBuilder();
		
		ShipCompanyBuilder.setOtherskeyValue("companyCod",selectedShipCompanyCod);
		ShipCompanySelectedBuilder.setOtherskeyValue("selectedCompanyCod",selectedShipCompanyCod);
		$("#ShipCompanySearchbox").searchbox({prompt: "请输入...", searcher: function(value, name) {
			shipCompanySearch();
        }});

		function shipCompanySearch(){
			var selectedRows=$("#ShipCompanySelectedDatagrid").datagrid("getData");
        	if(selectedRows){
        		var valueCod="";
	        	for(var i=0;i<selectedRows.rows.length;i++){
	       			var rowData=selectedRows.rows[i];
	       			valueCod+=","+rowData.CUSTOMER_COD;
	        	}
	        	ShipCompanyBuilder.setOtherskeyValue("companyCod",valueCod.substring(1));
        	}
			ShipCompanyBuilder.set("q", $("#ShipCompanySearchbox").searchbox('getValue'));
			$("#ShipCompanyDatagrid").datagrid("load",ShipCompanyBuilder.build());
		}

        // 主datagrid堆场
        $("#ShipCompanyDatagrid").datagrid({
        	striped:true,
            url: "/webresources/login/SbcCustomer/findShipCompany",
            queryParams: ShipCompanyBuilder.build(),
            method: "POST",
            pagination: false,
            singleSelect: true,
            selectOnCheck:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#ShipCompanyToolBar",
            fit: true,
            fitColumns: false,
            columns: [[
                       {
                    	   field:'ck',
                    	   checkbox:"checkbox"
                       },
                    {
                        field: "CUSTOMER_COD",
                        title: '公司代码',
                        multiSort: true,
                        halign: "center",
                        width:70,
                        sortable: true
                    },
                    {
                        field: "CUSTOMER_NAM",
                        title: '公司名称',
                        multiSort: true,
                        halign: "center",
                        width:200,
                        sortable: true
                    }
                ]],
                onDblClickRow:function(rowIndex,rowData){
                	$("#ShipCompanyDatagrid").datagrid('deleteRow', rowIndex);
                	$("#ShipCompanySelectedDatagrid").datagrid("hdAdd",{"CUSTOMER_COD":rowData.CUSTOMER_COD,"CUSTOMER_NAM":rowData.CUSTOMER_NAM});
                }
            });
	            
	            $("#ShipCompanySelectedDatagrid").datagrid({
	            	striped:true,
	            	url: "/webresources/login/SbcCustomer/findShipCompany",
	                queryParams: ShipCompanySelectedBuilder.build(),
	                method: "POST",
	                singleSelect: true,
	                selectOnCheck:false,
	                rownumbers: true,
	                fit: true,
	                fitColumns: false,
	                columns: [[
							{
								   field:'ck',
								   checkbox:"checkbox"
							},
	                        {
	                            field: "CUSTOMER_COD",
	                            title: '公司代码',
	                            multiSort: true,
	                            halign: "center",
	                            width:70,
	                            sortable: true
	                        },
	                        {
	                            field: "CUSTOMER_NAM",
	                            title: '公司名称',//，正规堆场编号由3位字符组成，特殊堆场编号由8位字符组成，且前4位为0000
	                            multiSort: true,
	                            halign: "center",
	                            width:200,
	                            sortable: true
	                        },
	                    ]],
	                    onDblClickRow:function(rowIndex,rowData){
	                    	$("#ShipCompanySelectedDatagrid").datagrid('deleteRow', rowIndex);
	                    	$("#ShipCompanyDatagrid").datagrid("hdAdd",{"CUSTOMER_COD":rowData.CUSTOMER_COD,"CUSTOMER_NAM":rowData.CUSTOMER_NAM});
	                    } 
	            });
	        $("#add").on("click",function(){
	        	
	        	var rowDatas=$("#ShipCompanyDatagrid").datagrid("getChecked");
	        	var selRowDatas=$("#ShipCompanySelectedDatagrid").datagrid("getRows");
	        	if(rowDatas){
	        		var binRowData=selRowDatas.concat(rowDatas);
	        		$("#ShipCompanySelectedDatagrid").datagrid("loadData",binRowData);
	        		shipCompanySearch();
	        	}
	        });
	        $("#return").on("click",function(){
	        	var rowDatas=$("#ShipCompanySelectedDatagrid").datagrid("getChecked");
	        	var gradRowDatas=$("#ShipCompanySelectedDatagrid").datagrid("getRows");
	        	var selRowDatas=$("#ShipCompanyDatagrid").datagrid("getRows");
	        	if(rowDatas){
	        		for(var i=0;i<rowDatas.length;i++){
	        			gradRowDatas.removeByValue(rowDatas[i]);
	        		}
	        		$("#ShipCompanySelectedDatagrid").datagrid("loadData",gradRowDatas);
	        		var binRowData=selRowDatas.concat(rowDatas);
	        		$("#ShipCompanyDatagrid").datagrid("loadData",binRowData);
	        	}
	        	
	        	
	        });
	      
}


