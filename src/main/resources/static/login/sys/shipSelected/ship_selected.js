var selectedShipLineCod="";//已选航线
var selectedShipCompanyCod="";//已选船公司
/**
 * 
 * @param  //
 * @returns
 */
var modDolage=null;
/**
 * 打开选择航线代码
 * @param jqObjShipCod 航线代码对象
 * @param jqObjShipNam 航线名称对象
 * @param shipCod 航线代码
 * @param shipNam 航线名称
 * @returns
 */
function  openSelectShipLineDialog(jqObjShipCod,jqObjShipNam,shipCod,shipNam)
{	
	selectedShipLineCod=shipCod;
	var bUrl='/login/sys/shipSelected/ship_line_list.html';
				  
	//参数为选中的贝箱  因为版本问题 是传不进去 但是已经放到全局变量 selectedFeatures
	modDolage=$("<div></div>").dialog({
		id:'openShipSelectDiloge',
		width:920,    
		height:440,
		modal:true,
		cache: true,
		resizable:true,
		collapsible:true,
		onClose:function(){
			$(this).dialog('destroy');
			modDolage=null;
		},
		title:"航线信息",
		href: bUrl,
		buttons:[{
			text:'确定',
			handler:function(){
         	   	var selected=$("#SbcShipServiceSelectedDatagrid").datagrid("getData");
	        	var valueCod="";
	        	var valueNam="";
	        	for(var i=0;i<selected.rows.length;i++){
	       			var rowData=selected.rows[i];
	       			valueCod+=","+rowData.SHIP_SERVICE_COD;
	       			valueNam+=","+rowData.CN_SHIP_SERVICE_NAM;
	        	}
	        	$("#openShipSelectDiloge").dialog('destroy');
				modDolage=null;
				jqObjShipCod.val(valueCod.substring(1));
				jqObjShipNam.val(valueNam.substring(1));
			}
		},{
			text:'取消',
			handler:function(){
				$("#openShipSelectDiloge").dialog('destroy');
				modDolage=null;
			}
		}]
	});      
}
/**
 * 打开选择船公司代码
 * @param jqObjShipCompany 船公司代码对象
 * @param jqObjShipCompanyNam 船公司名称对象
 * @param shipCompany 船公司代码
 * @param shipCompanyNam 船公司名称
 * @returns
 */
function  openSelectShipCompanyDialog(jqObjShipCompany,jqObjShipCompanyNam,shipCompany,shipCompanyNam)
{	
	selectedShipCompanyCod=shipCompany;
	var bUrl='/login/sys/shipSelected/ship_company_list.html';
	//参数为选中的贝箱  因为版本问题 是传不进去 但是已经放到全局变量 selectedFeatures
	modDolage=$("<div></div>").dialog({
		id:'openShipCompanyDiloge',
		width:820,       
		height:440,
		modal:true,
		cache: true,
		resizable:true,
		collapsible:true,
		onClose:function(){
			$(this).dialog('destroy');
			modDolage=null;
		},
		title:"船公司信息",
		href: bUrl,
		buttons:[{
			text:'确定',
			handler:function(){
         	   	var selected=$("#ShipCompanySelectedDatagrid").datagrid("getData");
	        	var valueCod="";
	        	var valueNam="";
	        	for(var i=0;i<selected.rows.length;i++){
	       			var rowData=selected.rows[i];
	       			valueCod+=","+rowData.CUSTOMER_COD;
	       			valueNam+=","+rowData.CUSTOMER_NAM;
	        	}
	        	$("#openShipCompanyDiloge").dialog('destroy');
				modDolage=null;
				jqObjShipCompany.val(valueCod.substring(1));
				jqObjShipCompanyNam.val(valueNam.substring(1));
			}
		},{
			text:'取消',
			handler:function(){
				$("#openShipCompanyDiloge").dialog('destroy');
				modDolage=null;
			}
		}]
	});      
}


function  openSelectShipCompanyDialog1(jqObjShipCompany,jqObjShipCompanyNam,shipCompany,shipCompanyNam,selectRow)
{	
	selectedShipCompanyCod=shipCompany;
	var bUrl='/login/sys/shipSelected/ship_company_list.html';
	//参数为选中的贝箱  因为版本问题 是传不进去 但是已经放到全局变量 selectedFeatures
	modDolage=$("<div></div>").dialog({
		id:'openShipCompanyDiloge',
		width:820,       
		height:440,
		modal:true,
		cache: true,
		resizable:true,
		collapsible:true,
		onClose:function(){
			$(this).dialog('destroy');
			modDolage=null;
		},
		title:"船公司信息",
		href: bUrl,
		buttons:[{
			text:'确定',
			handler:function(){
         	   	var selected=$("#ShipCompanySelectedDatagrid").datagrid("getData");
	        	var valueCod="";
	        	var valueNam="";
	        	for(var i=0;i<selected.rows.length;i++){
	       			var rowData=selected.rows[i];
	       			valueCod+=","+rowData.CUSTOMER_COD;
	       			valueNam+=","+rowData.CUSTOMER_NAM;
	        	}
	        	$("#openShipCompanyDiloge").dialog('destroy');				
				selectRow(valueCod.substring(1),valueNam.substring(1));
				//jqObjShipCompany.val(valueCod.substring(1));
				//jqObjShipCompanyNam.val(valueNam.substring(1));
				/*var ed1 = $('#SbcShipServiceDatagrid111').datagrid('getEditor', {index:selectRow,field:jqObjShipCompany});
				$(ed1.target).datebox('setValue',valueCod.substring(1) );*/
			}
		},{
			text:'取消',
			handler:function(){
				$("#openShipCompanyDiloge").dialog('destroy');
				modDolage=null;
			}
		}]
	});      
}

