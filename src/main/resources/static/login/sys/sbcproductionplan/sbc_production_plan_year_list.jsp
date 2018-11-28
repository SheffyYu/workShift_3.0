<meta charset="UTF-8">
<div id="SbcProductionPlanYearToolBar" style="padding-top: 0px;">
    <div style="float:left;">
                     箱货类型：<input class="easyui-validatebox" id="SearchSbcProductionPlanYearbulkTyp" />
                     作业公司：<input class="easyui-validatebox" id="SearchSbcProductionPlanYearcompanyCod" />
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;              
       <a id="SearchSbcProductionPlanYear" class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>
       <!-- <shiro:hasPermission name="webresources:login:SbcProductionPlan:add"> -->
       <a class="easyui-linkbutton" id="SbcProductionPlanYearToolBarAdd" iconCls="icon-add" plain="false">增加</a>
       <!-- </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:update"> -->
       <a class="easyui-linkbutton" id="SbcProductionPlanYearToolBarEdit" iconCls="icon-edit" plain="false">编辑</a>
       <!-- </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:delete"> -->
       <a class="easyui-linkbutton" id="SbcProductionPlanYearToolBarRemove" iconCls="icon-remove" plain="false">删除</a>
      <!--  </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:save"> -->
       <a class="easyui-linkbutton" id="SbcProductionPlanYearToolBarSave" iconCls="icon-save" plain="false">保存</a>
       <!-- </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:refresh"> -->
       <a class="easyui-linkbutton" id="SbcProductionPlanYearToolBarReload" iconCls="icon-reload" plain="false">刷新</a>
       <!-- </shiro:hasPermission>  -->
    </div>
    <input class="easyui-searchbox" id="SbcProductionPlanYearSearchbox" type="text"/>
</div>
<div id="SbcProductionPlanYearDialog" style="display:none"></div>
<table id="SbcProductionPlanYearDatagrid" style="height:100%"></table>
<script type="text/javascript">
$(document).ready(function() { 
	var dialogTitleAddF = "增加";
    var dialogTitleEditF = "编辑";
    var diog = $("#SbcProductionPlanYearDialog");
	var dg = $("#SbcProductionPlanYearDatagrid");
// 	$("#SearchSbcProductionPlanYearcompanyCod").combogrid(HdUtils.code.sbcCompany({required:false,textField: 'cnCompanyNam'}));
    $("#SearchSbcProductionPlanYearcompanyCod").combogrid(HdUtils.code.findVwGroupOrgn({required:false, textField: 'companyNam', width:150}));

	$("#SearchSbcProductionPlanYearbulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:false, width:124}));
    // buttons
    //查询
     $("#SearchSbcProductionPlanYear").on("click",function() {
    	var SearchSbcProductionPlanYearBuilder=new HdEzuiQueryParamsBuilder();
     	if($("#SearchSbcProductionPlanYearbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionPlanYearbulkTyp").combobox("getValue")!=null){
     		SearchSbcProductionPlanYearBuilder.setAndClause("bulkTyp",$("#SearchSbcProductionPlanYearbulkTyp").combobox("getValue"),"=","and");
        }
        if($("#SearchSbcProductionPlanYearcompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionPlanYearcompanyCod").combogrid("getValue")!=null){
        	SearchSbcProductionPlanYearBuilder.setAndClause("companyCod", $("#SearchSbcProductionPlanYearcompanyCod").combogrid("getValue"), "=", "and");
      	}
        SearchSbcProductionPlanYearBuilder.setAndClause("prodPlanTyp","Y","=","and"); 
        SearchSbcProductionPlanYearBuilder.setOrderByClause("updTimestamp", "desc");
        builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionPlanYearBuilder.hdEzuiQueryParams.hdConditions;
     	dg.datagrid("hdReload");
    });
    // 增加。
    $("#SbcProductionPlanYearToolBar a[iconCls='icon-add']").on("click",function() {
    	//dg.datagrid("hdAdd");
    	 $("#SbcProductionPlanYearDialog").show();
         HdUtils.dialog.show({height: 360,width:745, title: dialogTitleAddF, href: "../login/sys/sbcproductionplan/sbc_production_plan_year_detail.jsp", isSaveHandler: true});
         HdUtils.dialog.setValue({data: {type: "ADD"},dataGrid:dg});  
    });
    // 编辑。
     $("#SbcProductionPlanYearToolBar a[iconCls='icon-edit']").on("click",function() {
    	 dg.datagrid("hdEdit");
//      	 $("SbcProductionPlanYearDialog").show();
//          var selectRow = dg.datagrid("getSelected");
//          if (selectRow == undefined) {
//              HdUtils.messager.info("请选择一条记录");
//          } else {
//              HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
//              HdUtils.dialog.show({height: 320,width:260, title: dialogTitleEditF, href: "../login/sys/sbcproductionplan/sbc_production_plan_year_detail.jsp", isSaveHandler: true});
//          }
     });
    // 删除。
     $("#SbcProductionPlanYearToolBar a[iconCls='icon-remove']").on("click",function() {
    	dg.datagrid("hdRealRemove",{url:"../webresources/login/SbcProductionPlan/save"});
     });
    // 保存。
     $("#SbcProductionPlanYearToolBar a[iconCls='icon-save']").on("click",function() {
        dg.datagrid("hdSave",{url:"../webresources/login/SbcProductionPlan/save"});   
     });
    // 刷新。
     $("#SbcProductionPlanYearToolBar a[iconCls='icon-reload']").on("click",function() {
    	 var SearchSbcProductionPlanYearBuilder1=new HdEzuiQueryParamsBuilder();
      	if($("#SearchSbcProductionPlanYearbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionPlanYearbulkTyp").combobox("getValue")!=null){
      		SearchSbcProductionPlanYearBuilder1.setAndClause("bulkTyp",$("#SearchSbcProductionPlanYearbulkTyp").combobox("getValue"),"=","and");
         }
         if($("#SearchSbcProductionPlanYearcompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionPlanYearcompanyCod").combogrid("getValue")!=null){
         	SearchSbcProductionPlanBuilder1.setAndClause("companyCod", $("#SearchSbcProductionPlanYearcompanyCod").combogrid("getValue"), "=", "and");
       	}
         SearchSbcProductionPlanYearBuilder1.setAndClause("prodPlanTyp","Y","=","and"); 
         SearchSbcProductionPlanYearBuilder1.setOrderByClause("updTimestamp", "desc");
         builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionPlanYearBuilder1.hdEzuiQueryParams.hdConditions;
      	dg.datagrid("hdReload");
     });
    // 条件类。
     var builder = new HdEzuiQueryParamsBuilder();
     builder.setAndClause("prodPlanTyp","Y","=","and"); 
     builder.setOrderByClause("updTimestamp", "desc");
    // searchbox
    $("#SbcProductionPlanYearSearchbox").searchbox({prompt:"请输入...",searcher:function(value,name) {
         builder.set("q",value);
         builder.set("queryColumns","prodPlanTyp,prodPlanYmd");
         dg.datagrid("load");
     }});
	$("#SbcProductionPlanYearDatagrid").datagrid({
        	striped:true,
	    url:"../webresources/login/SbcProductionPlan/find",
	    queryParams:builder.build(),
	    method:"post", 
	    pagination:true,
	    singleSelect: true,
        selectOnCheck:false,
        checkOnSelect:false,
        sortOrder: 'desc',
        sortName: 'updTimestamp',
        remoteSort:false,
	    //autoLoad:false,
	    rownumbers:true,
	    pageSize:20,
	    toolbar:"#SbcProductionPlanYearToolBar",
	    fit:true,
	    fitColumns:false,
	    columns:[[
		{
		    field: "ck",
		    checkbox: true
		},
	    {
	    
	    field:"planId",
	    title:'planId',
	    multiSort:true,
	    hidden:true,
	    halign:"center",
	    sortable:true
		}
		,
	    {
	    
	    field:"companyCod",
	    title:'作业公司',
	    multiSort:true,
	    halign:"center",
        formatter: function (value, row, index) {
            return row.cnCompanyNam;
        },
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"bulkTyp",
	    title:'箱货类型',
	    multiSort:true,
	    halign:"center",
	    align:"center",
	    formatter: function (value) {
            if (value === null || value === '')
                return;
            var list = HdUtils.global.scode.query({fieldCod: 'BULK_TYP', code: value});
            return list.length > 0 ? list[0].name : "";
        },
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"prodPlanTyp",
	    title:'计划类别',
	    multiSort:true,
	    halign:"center",
	    align:"center",
	    formatter: function (value) {
            if (value === null || value === '')
                return;
            var list = HdUtils.global.scode.query({fieldCod: 'PROD_PLAN_TYP', code: value});
            return list.length > 0 ? list[0].name : "";
        },
	    width:100,
	    sortable:true
		}
	    ,
	    {	    
	    field:"prodPlanYmd",
	    title:'计划年月',
	    multiSort:true,
	    halign:"center",
	   // editor:{type:"validatebox",options:{required:true,validType: 'length[1,10]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"planNum",
	    title:'计划量(万TEU/万吨)',
	    multiSort:true,
	    halign:"center",
	    width:130,
	    editor:{type:"numberbox",options:{required:false,validType: 'length[0,12]'}},
	    sortable:true
		}
	   ,
	    {
	    
	    field:"description",
	    title:"备注",
	    multiSort:true,
	    width:130,
	    halign:"center",
	    editor:{type:"validatebox",options:{required:false,validType: 'length[0,1000]'}},
	    sortable:true
		}
	    ,
	    {
	    
	    field:"insAccount",
	    title:'创建人',
	    multiSort:true,
	    halign:"center",
	    sortable:true
		}
	    ,
	    {
	    
	    field:"insTimestamp",
	    title:"创建时间",
	    multiSort:true,
	    halign:"center",
	    formatter: $.hd.ezui.formatter.datetime,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"updAccount",
	    title:"修改人",
	    multiSort:true,
	    halign:"center",
	    sortable:true
		}
	    ,
	    {
	    
	    field:"updTimestamp",
	    title:"修改时间",
	    multiSort:true,
	    halign:"center",
	    formatter: $.hd.ezui.formatter.datetime,
	    sortable:true
		}
	]],
    onDblClickCell: function (index) {
    	dg.datagrid("hdEdit");
//     	dg.datagrid('selectRow',index);
//         var selectRow = $("#SbcProductionPlanYearDatagrid").datagrid("getSelected");
//         HdUtils.dialog.setValue({data: selectRow,type:"EDIT",dataGrid:dg});
//         HdUtils.dialog.show({height: 320,width:260, title: dialogTitleAddF, href: "../login/sys/sbcproductionplan/sbc_production_plan_year_detail.jsp", isSaveHandler: true}); 
    }
	});
});
</script>
