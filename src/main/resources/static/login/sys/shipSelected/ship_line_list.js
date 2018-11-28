function intiShipLine(selectedShipLineCod){	
		var sbcShipServiceBuilder=new HdEzuiQueryParamsBuilder();
		var sbcShipServiceSelectedBuilder=new HdEzuiQueryParamsBuilder();
		
		sbcShipServiceBuilder.setOtherskeyValue("lineCod",selectedShipLineCod);
		sbcShipServiceSelectedBuilder.setOtherskeyValue("selectedLineCod",selectedShipLineCod);
		$("#SbcShipServiceSearchbox").searchbox({prompt: "请输入...", searcher: function(value, name) {
			shipServiceSearch();
        }});
		
		function shipServiceSearch()
		{
			var selectedRows=$("#SbcShipServiceSelectedDatagrid").datagrid("getData");
        	if(selectedRows){
        		var valueCod="";
	        	for(var i=0;i<selectedRows.rows.length;i++){
	       			var rowData=selectedRows.rows[i];
	       			valueCod+=","+rowData.SHIP_SERVICE_COD;
	        	}
	        	sbcShipServiceBuilder.setOtherskeyValue("lineCod",valueCod.substring(1));
        	}
			sbcShipServiceBuilder.set("q", $("#SbcShipServiceSearchbox").searchbox('getValue'));
			$("#SbcShipServiceDatagrid").datagrid("load", sbcShipServiceBuilder.build());
		}
        // 主datagrid堆场
        $("#SbcShipServiceDatagrid").datagrid({
        	striped:true,
            url: "/webresources/login/SbcShipService/findShipLine",
            queryParams: sbcShipServiceBuilder.build(),
            method: "POST",
            pagination: false,
            singleSelect: true,
            selectOnCheck:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcShipServiceToolBar",
            fit: true,
            fitColumns: false,
            columns: [[
					{
						   field:'ck',
						   checkbox:"checkbox"
					},
                    {
                        field: "SHIP_SERVICE_COD",
                        title: '航线代码',
                        multiSort: true,
                        halign: "center",
                        width:70,
                        sortable: true
                    },
                    {
                        field: "CN_SHIP_SERVICE_NAM",
                        title: '航线名称',
                        multiSort: true,
                        halign: "center",
                        width:250,
                        sortable: true
                    }
                ]],
                onDblClickRow:function(rowIndex,rowData){
                	$("#SbcShipServiceDatagrid").datagrid('deleteRow', rowIndex);
                	$("#SbcShipServiceSelectedDatagrid").datagrid("hdAdd",rowData);
                }
            });
	            
	            $("#SbcShipServiceSelectedDatagrid").datagrid({
	            	striped:true,
	            	url: "/webresources/login/SbcShipService/findShipLine",
	                queryParams: sbcShipServiceSelectedBuilder.build(),
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
	                            field: "SHIP_SERVICE_COD",
	                            title: '航线代码',
	                            multiSort: true,
	                            halign: "center",
	                            width:70,
	                            sortable: true
	                        },
	                        {
	                            field: "CN_SHIP_SERVICE_NAM",
	                            title: '航线名称',//，正规堆场编号由3位字符组成，特殊堆场编号由8位字符组成，且前4位为0000
	                            multiSort: true,
	                            halign: "center",
	                            width:250,
	                            sortable: true
	                        },
	                    ]],
	                    onDblClickRow:function(rowIndex,rowData){
	                    	$("#SbcShipServiceSelectedDatagrid").datagrid('deleteRow', rowIndex);
	                    	$("#SbcShipServiceDatagrid").datagrid("hdAdd",rowData);
	                    } 
	            });
	        $("#add").on("click",function(){

	        	var rowDatas=$("#SbcShipServiceDatagrid").datagrid("getChecked");
	        	var selRowDatas=$("#SbcShipServiceSelectedDatagrid").datagrid("getRows");
	        	if(rowDatas){
	        		var binRowData=selRowDatas.concat(rowDatas);
	        		$("#SbcShipServiceSelectedDatagrid").datagrid("loadData",binRowData);
	        		shipServiceSearch();
	        	}
	        });
	        $("#return").on("click",function(){
	        	var rowDatas=$("#SbcShipServiceSelectedDatagrid").datagrid("getChecked");
	        	var gradRowDatas=$("#SbcShipServiceSelectedDatagrid").datagrid("getRows");
	        	var selRowDatas=$("#SbcShipServiceDatagrid").datagrid("getRows");
	        	if(rowDatas){
	        		for(var i=0;i<rowDatas.length;i++){
	        			gradRowDatas.removeByValue(rowDatas[i]);
	        		}
	        		$("#SbcShipServiceSelectedDatagrid").datagrid("loadData",gradRowDatas);
	        		var binRowData=selRowDatas.concat(rowDatas);
	        		$("#SbcShipServiceDatagrid").datagrid("loadData",binRowData);
	        	}
	       });
	      
}


