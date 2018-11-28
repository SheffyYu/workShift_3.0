<meta charset="UTF-8">
<div id="SbcProductionPlanToolBar" style="padding-top: 0px;">
    <div style="float:left;">
                     箱货类型：<input class="easyui-validatebox" id="SearchSbcProductionPlanbulkTyp" />
                     作业公司：<input class="easyui-validatebox" id="SearchSbcProductionPlancompanyCod" />
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;              
       <a id="SearchSbcProductionPlan" class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:add">
       <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:update">
       <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:delete">
       <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:save">
       <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionPlan:refresh">
       <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
       </shiro:hasPermission> 
    </div>
    <input class="easyui-searchbox" id="SbcProductionPlanSearchbox" type="text"/>
</div>
<table id="SbcProductionPlanDatagrid" style="height:100%"></table>
<div id="SbcProductionPlanDialog" style="display:none"></div>
<script type="text/javascript">
$(document).ready(function() { 
	var dialogTitleAddF = "增加";
    var dialogTitleEditF = "编辑";
    var diog = $("#SbcProductionPlanDialog");
	var dg = $("#SbcProductionPlanDatagrid");
	$("#SearchSbcProductionPlancompanyCod").combogrid(HdUtils.code.findVwGroupOrgn({required:false,textField: 'companyNam'}));
	$("#SearchSbcProductionPlanbulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:false, width:124}));
    // buttons
    //查询
     $("#SearchSbcProductionPlan").on("click",function() {
    	var SearchSbcProductionPlanBuilder=new HdEzuiQueryParamsBuilder();
     	if($("#SearchSbcProductionPlanbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionPlanbulkTyp").combobox("getValue")!=null){
     		SearchSbcProductionPlanBuilder.setAndClause("bulkTyp",$("#SearchSbcProductionPlanbulkTyp").combobox("getValue"),"=","and");
        }
        if($("#SearchSbcProductionPlancompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionPlancompanyCod").combogrid("getValue")!=null){
        	SearchSbcProductionPlanBuilder.setAndClause("companyCod", $("#SearchSbcProductionPlancompanyCod").combogrid("getValue"), "=", "and");
      	}
        SearchSbcProductionPlanBuilder.setAndClause("prodPlanTyp","M","=","and"); 
        SearchSbcProductionPlanBuilder.setOrderByClause("updTimestamp", "desc");
        builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionPlanBuilder.hdEzuiQueryParams.hdConditions;
     	dg.datagrid("hdReload");
    });
    // 增加。
    $("#SbcProductionPlanToolBar a[iconCls='icon-add']").on("click",function() {
    	//dg.datagrid("hdAdd");
    	 $("#SbcProductionPlanDialog").show();
         HdUtils.dialog.show({height: 360,width:820, title: dialogTitleAddF, href: "../login/sys/sbcproductionplan/sbc_production_plan_detial.jsp", isSaveHandler: true});
         HdUtils.dialog.setValue({data: {type: "ADD"},dataGrid:dg});  
    });
    // 编辑。
     $("#SbcProductionPlanToolBar a[iconCls='icon-edit']").on("click",function() {
    	 dg.datagrid("hdEdit");
//      	 $("SbcProductionPlanDialog").show();
//          var selectRow = dg.datagrid("getSelected");
//          if (selectRow == undefined) {
//              HdUtils.messager.info("请选择一条记录");
//          } else {
//              HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
//              HdUtils.dialog.show({height: 320,width:260, title: dialogTitleEditF, href: "../login/sys/sbcproductionplan/sbc_production_plan_detial.jsp", isSaveHandler: true});
//          }
     });
    // 删除。
     $("#SbcProductionPlanToolBar a[iconCls='icon-remove']").on("click",function() {
    	dg.datagrid("hdRealRemove",{url:"../webresources/login/SbcProductionPlan/save"});
     });
    // 保存。
     $("#SbcProductionPlanToolBar a[iconCls='icon-save']").on("click",function() {
        dg.datagrid("hdSave",{url:"../webresources/login/SbcProductionPlan/save"});   
     });
    // 刷新。
     $("#SbcProductionPlanToolBar a[iconCls='icon-reload']").on("click",function() {
    	 var SearchSbcProductionPlanBuilder1=new HdEzuiQueryParamsBuilder();
      	if($("#SearchSbcProductionPlanbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionPlanbulkTyp").combobox("getValue")!=null){
      		SearchSbcProductionPlanBuilder1.setAndClause("prodPlanTyp",$("#SearchSbcProductionPlanbulkTyp").combobox("getValue"),"=","and");
         }
         if($("#SearchSbcProductionPlancompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionPlancompanyCod").combogrid("getValue")!=null){
         	SearchSbcProductionPlanBuilder1.setAndClause("companyCod", $("#SearchSbcProductionPlancompanyCod").combogrid("getValue"), "=", "and");
       	}
         SearchSbcProductionPlanBuilder1.setAndClause("prodPlanTyp","M","=","and"); 
         SearchSbcProductionPlanBuilder1.setOrderByClause("updTimestamp", "desc");
         builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionPlanBuilder1.hdEzuiQueryParams.hdConditions;
      	dg.datagrid("hdReload");
     });
    // 条件类。
     var builder = new HdEzuiQueryParamsBuilder();
     builder.setAndClause("prodPlanTyp","M","=","and"); 
     builder.setOrderByClause("updTimestamp", "desc");
    // searchbox
    $("#SbcProductionPlanSearchbox").searchbox({prompt:"请输入...",searcher:function(value,name) {
         builder.set("q",value);
         builder.set("queryColumns","prodPlanTyp,prodPlanYmd");
         dg.datagrid("load");
     }});
	$("#SbcProductionPlanDatagrid").datagrid({
        	striped:true,
	    url:"../webresources/login/SbcProductionPlan/find",
	    queryParams:builder.build(),
	    method:"post", 
	    pagination:true,
	    singleSelect: true,
        selectOnCheck:false,
        checkOnSelect:false,
	    //autoLoad:false,
	    sortOrder: 'desc',
        sortName: 'updTimestamp',
        remoteSort:false,
	    rownumbers:true,
	    pageSize:20,
	    toolbar:"#SbcProductionPlanToolBar",
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
	    //editor:{type:"validatebox",options:{required:true,validType: 'length[1,10]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"planNum",
	    title:'计划量(万吨/TEU)',
	    multiSort:true,
	    halign:"center",
	    width:130,
	    editor:{type:"numberbox",options:{required:false,precision: 0, max: 999999999999999999,validType: 'length[0,12]'}},
	    
	    sortable:true
		}
	   ,
	    {
	    
	    field:"description",
	    title:"备注",
	    multiSort:true,
	    halign:"center",
	    width:130,
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
//         var selectRow = $("#SbcProductionPlanDatagrid").datagrid("getSelected");
//         HdUtils.dialog.setValue({data: selectRow,type:"EDIT",dataGrid:dg});
//         HdUtils.dialog.show({height: 320,width:260, title: dialogTitleAddF, href: "../login/sys/sbcproductionplan/sbc_production_plan_detial.jsp", isSaveHandler: true}); 
    }
	});
});
</script>
