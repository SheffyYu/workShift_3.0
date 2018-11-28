<meta charset="UTF-8">
<div id="SbcProductionGoalYearToolBar" style="padding-top: 0px;">
    <div style="float:left;">
                     箱货类型：<input class="easyui-validatebox" id="SearchSbcProductionGoalYearbulkTyp" />
                     作业公司：<input class="easyui-validatebox" id="SearchSbcProductionGoalYearcompanyCod" />
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;              
       <a id="SearchSbcProductionGoalYear" class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>
       <!-- <shiro:hasPermission name="webresources:login:SbcProductionGoal:add"> -->
       <a class="easyui-linkbutton" id="SbcProductionGoalYearToolBarAdd" iconCls="icon-add" plain="false">增加</a>
       <!-- </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:update"> -->
       <a class="easyui-linkbutton" id="SbcProductionGoalYearToolBarEdit" iconCls="icon-edit" plain="false">编辑</a>
       <!-- </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:delete"> -->
       <a class="easyui-linkbutton" id="SbcProductionGoalYearToolBarRemove" iconCls="icon-remove" plain="false">删除</a>
      <!--  </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:save"> -->
       <a class="easyui-linkbutton" id="SbcProductionGoalYearToolBarSave" iconCls="icon-save" plain="false">保存</a>
       <!-- </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:refresh"> -->
       <a class="easyui-linkbutton" id="SbcProductionGoalYearToolBarReload" iconCls="icon-reload" plain="false">刷新</a>
       <!-- </shiro:hasPermission>  -->
    </div>
    <input class="easyui-searchbox" id="SbcProductionGoalYearSearchbox" type="text"/>
</div>
<div id="SbcProductionGoalYearDialog" style="display:none"></div>
<table id="SbcProductionGoalYearDatagrid" style="height:100%"></table>
<script type="text/javascript">
$(document).ready(function() { 
	var dialogTitleAddF = "增加";
    var dialogTitleEditF = "编辑";
    var diog = $("#SbcProductionGoalYearDialog");
	var dg = $("#SbcProductionGoalYearDatagrid");
	//$("#SearchSbcProductionGoalYearcompanyCod").combogrid(HdUtils.code.sbcCompany({required:false,textField: 'cnCompanyNam'}));
	    $("#SearchSbcProductionGoalYearcompanyCod").combogrid(HdUtils.code.findVwGroupOrgn({required:false, textField: 'companyNam', width:150}));

	$("#SearchSbcProductionGoalYearbulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:false, width:124}));
    // buttons
    //查询
     $("#SearchSbcProductionGoalYear").on("click",function() {
    	var SearchSbcProductionGoalYearBuilder=new HdEzuiQueryParamsBuilder();
     	if($("#SearchSbcProductionGoalYearbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionGoalYearbulkTyp").combobox("getValue")!=null){
     		SearchSbcProductionGoalYearBuilder.setAndClause("bulkTyp",$("#SearchSbcProductionGoalYearbulkTyp").combobox("getValue"),"=","and");
        }
        if($("#SearchSbcProductionGoalYearcompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionGoalYearcompanyCod").combogrid("getValue")!=null){
        	SearchSbcProductionGoalYearBuilder.setAndClause("companyCod", $("#SearchSbcProductionGoalYearcompanyCod").combogrid("getValue"), "=", "and");
      	}
        SearchSbcProductionGoalYearBuilder.setAndClause("prodPlanTyp","Y","=","and"); 
        SearchSbcProductionGoalYearBuilder.setOrderByClause("updTimestamp", "desc");
        builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionGoalYearBuilder.hdEzuiQueryParams.hdConditions;
     	dg.datagrid("hdReload");
    });
    // 增加。
    $("#SbcProductionGoalYearToolBar a[iconCls='icon-add']").on("click",function() {
    	//dg.datagrid("hdAdd");
    	 $("#SbcProductionGoalYearDialog").show();
         HdUtils.dialog.show({height: 360,width:745, title: dialogTitleAddF, href: "../login/sys/sbcproductiongoal/sbc_production_goal_year_detail.jsp", isSaveHandler: true});
         HdUtils.dialog.setValue({data: {type: "ADD"},dataGrid:dg});  
    });
    // 编辑。
     $("#SbcProductionGoalYearToolBar a[iconCls='icon-edit']").on("click",function() {
    	dg.datagrid("hdEdit");
     	 /* $("SbcProductionGoalYearDialog").show();
         var selectRow = dg.datagrid("getSelected");
         if (selectRow == undefined) {
             HdUtils.messager.info("请选择一条记录");
         } else {
             HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
             HdUtils.dialog.show({height: 320,width:260, title: dialogTitleEditF, href: "../login/sys/sbcproductiongoal/sbc_production_goal_year_detail.jsp", isSaveHandler: true});
         } */
     });
    // 删除。
     $("#SbcProductionGoalYearToolBar a[iconCls='icon-remove']").on("click",function() {
    	dg.datagrid("hdRealRemove",{url:"../webresources/login/SbcProductionGoal/save"});
     });
    // 保存。
     $("#SbcProductionGoalYearToolBar a[iconCls='icon-save']").on("click",function() {
        dg.datagrid("hdSave",{url:"../webresources/login/SbcProductionGoal/save"});   
     });
    // 刷新。
     $("#SbcProductionGoalYearToolBar a[iconCls='icon-reload']").on("click",function() {
    	 var SearchSbcProductionGoalYearBuilder1=new HdEzuiQueryParamsBuilder();
      	 if($("#SearchSbcProductionGoalYearbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionGoalYearbulkTyp").combobox("getValue")!=null){
      		SearchSbcProductionGoalYearBuilder1.setAndClause("bulkTyp",$("#SearchSbcProductionGoalYearbulkTyp").combobox("getValue"),"=","and");
         }
         if($("#SearchSbcProductionGoalYearcompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionGoalYearcompanyCod").combogrid("getValue")!=null){
         	SearchSbcProductionGoalBuilder1.setAndClause("companyCod", $("#SearchSbcProductionGoalYearcompanyCod").combogrid("getValue"), "=", "and");
       	 }
         SearchSbcProductionGoalYearBuilder1.setAndClause("prodPlanTyp","Y","=","and"); 
         SearchSbcProductionGoalYearBuilder1.setOrderByClause("updTimestamp", "desc");
         builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionGoalYearBuilder1.hdEzuiQueryParams.hdConditions;
      	 dg.datagrid("hdReload");
     });
    // 条件类。
     var builder = new HdEzuiQueryParamsBuilder();
     builder.setAndClause("prodPlanTyp","Y","=","and"); 
     builder.setOrderByClause("updTimestamp", "desc");
    // searchbox
    $("#SbcProductionGoalYearSearchbox").searchbox({prompt:"请输入...",searcher:function(value,name) {
         builder.set("q",value);
         builder.set("queryColumns","companyCod,prodPlanTyp,prodPlanYmd,planNum");
         dg.datagrid("load");
     }});
	$("#SbcProductionGoalYearDatagrid").datagrid({
        	striped:true,
	    url:"../webresources/login/SbcProductionGoal/find",
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
	    toolbar:"#SbcProductionGoalYearToolBar",
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
	    /* editor: {
            type: 'combogrid',
            options: HdUtils.code.sbcCompany({
                parentId: '#SbcProductionGoalYearDatagrid',
                textField:'cnCompanyNam',
                required: true,
                fieldMapping: {
        	    	companyCod: 'companyCod',
        	    	cnCompanyNam:'cnCompanyNam'
        		}
            })
        },  */
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
	    /* editor: {
            type: "combobox",
            options: HdUtils.code.scode({
            	fieldCod: 'BULK_TYP'},
            	{required: true})
        }, */
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
	    /* editor: {
            type: "combobox",
            options: HdUtils.code.scode({
            	fieldCod: 'PROD_PLAN_TYP'},
            	{required: true})
        }, */
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
		dg.datagrid('hdEdit');
    	/* dg.datagrid('selectRow',index);
        var selectRow = $("#SbcProductionGoalYearDatagrid").datagrid("getSelected");
        HdUtils.dialog.setValue({data: selectRow,type:"EDIT",dataGrid:dg});
        HdUtils.dialog.show({height: 320,width:260, title: dialogTitleAddF, href: "../login/sys/sbcproductiongoal/sbc_production_goal_year_detail.jsp", isSaveHandler: true});  */
    }
	});
});
</script>
