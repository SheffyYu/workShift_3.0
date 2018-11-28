<meta charset="UTF-8">
<div id="SbcProductionGoalToolBar" style="padding-top: 0px;">
    <div style="float:left;">
                     箱货类型：<input class="easyui-validatebox" id="SearchSbcProductionGoalbulkTyp" />
                     作业公司：<input class="easyui-validatebox" id="SearchSbcProductionGoalcompanyCod" />
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;              
       <a id="SearchSbcProductionGoal" class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:add">
       <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>  
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:update">
       <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:delete">
       <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:save">
       <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcProductionGoal:refresh">
       <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
       </shiro:hasPermission> 
    </div>
    <input class="easyui-searchbox" id="SbcProductionGoalSearchbox" type="text"/>
</div>
<table id="SbcProductionGoalDatagrid" style="height:100%"></table>
<div id="SbcProductionGoalDialog" style="display:none"></div>
<script type="text/javascript">
$(document).ready(function() { 
	var dialogTitleAddF = "增加";
    var dialogTitleEditF = "编辑";
    var diog = $("#SbcProductionGoalDialog");
	var dg = $("#SbcProductionGoalDatagrid");
// 	$("#SearchSbcProductionGoalcompanyCod").combogrid(HdUtils.code.sbcCompany({required:false,textField: 'cnCompanyNam'}));
    $("#SearchSbcProductionGoalcompanyCod").combogrid(HdUtils.code.findVwGroupOrgn({required:false, textField: 'companyNam', width:150}));

	$("#SearchSbcProductionGoalbulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:false, width:124}));
    // buttons
    //查询
     $("#SearchSbcProductionGoal").on("click",function() {
    	var SearchSbcProductionGoalBuilder=new HdEzuiQueryParamsBuilder();
     	if($("#SearchSbcProductionGoalbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionGoalbulkTyp").combobox("getValue")!=null){
     		SearchSbcProductionGoalBuilder.setAndClause("bulkTyp",$("#SearchSbcProductionGoalbulkTyp").combobox("getValue"),"=","and");
        }
        if($("#SearchSbcProductionGoalcompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionGoalcompanyCod").combogrid("getValue")!=null){
        	SearchSbcProductionGoalBuilder.setAndClause("companyCod", $("#SearchSbcProductionGoalcompanyCod").combogrid("getValue"), "=", "and");
      	}
        SearchSbcProductionGoalBuilder.setAndClause("prodPlanTyp","M","=","and"); 
        SearchSbcProductionGoalBuilder.setOrderByClause("updTimestamp", "desc");
        builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionGoalBuilder.hdEzuiQueryParams.hdConditions;
     	dg.datagrid("hdReload");
    });
    // 增加。
    $("#SbcProductionGoalToolBar a[iconCls='icon-add']").on("click",function() {
    	//dg.datagrid("hdAdd");
    	 $("#SbcProductionGoalDialog").show();
         HdUtils.dialog.show({height: 360,width:820, title: dialogTitleAddF, href: "../login/sys/sbcproductiongoal/sbc_production_goal_detail.jsp", isSaveHandler: true});
         HdUtils.dialog.setValue({data: {type: "ADD"},dataGrid:dg});  
    });
    // 编辑。
     $("#SbcProductionGoalToolBar a[iconCls='icon-edit']").on("click",function() {
    	 dg.datagrid("hdEdit");
     	 /* $("SbcProductionGoalDialog").show();
         var selectRow = dg.datagrid("getSelected");
         if (selectRow == undefined) {
             HdUtils.messager.info("请选择一条记录");
         } else {
             HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
             HdUtils.dialog.show({height: 320,width:260, title: dialogTitleEditF, href: "../login/sys/sbcproductiongoal/sbc_production_goal_detail.jsp", isSaveHandler: true});
         } */
     });
    // 删除。
     $("#SbcProductionGoalToolBar a[iconCls='icon-remove']").on("click",function() {
    	dg.datagrid("hdRealRemove",{url:"../webresources/login/SbcProductionGoal/save"});
     });
    // 保存。
     $("#SbcProductionGoalToolBar a[iconCls='icon-save']").on("click",function() {
        dg.datagrid("hdSave",{url:"../webresources/login/SbcProductionGoal/save"});   
     });
    // 刷新。
     $("#SbcProductionGoalToolBar a[iconCls='icon-reload']").on("click",function() {
    	 var SearchSbcProductionGoalBuilder1=new HdEzuiQueryParamsBuilder();
      	if($("#SearchSbcProductionGoalbulkTyp").combobox("getValue")!=""&&$("#SearchSbcProductionGoalbulkTyp").combobox("getValue")!=null){
      		SearchSbcProductionGoalBuilder1.setAndClause("prodPlanTyp",$("#SearchSbcProductionGoalbulkTyp").combobox("getValue"),"=","and");
         }
         if($("#SearchSbcProductionGoalcompanyCod").combogrid("getValue")!=""&&$("#SearchSbcProductionGoalcompanyCod").combogrid("getValue")!=null){
         	SearchSbcProductionGoalBuilder1.setAndClause("companyCod", $("#SearchSbcProductionGoalcompanyCod").combogrid("getValue"), "=", "and");
       	}
         SearchSbcProductionGoalBuilder1.setAndClause("prodPlanTyp","M","=","and"); 
         SearchSbcProductionGoalBuilder1.setOrderByClause("updTimestamp", "desc");
         builder.hdEzuiQueryParams.hdConditions=SearchSbcProductionGoalBuilder1.hdEzuiQueryParams.hdConditions;
      	dg.datagrid("hdReload");
     });
    // 条件类。
     var builder = new HdEzuiQueryParamsBuilder();
     builder.setAndClause("prodPlanTyp","M","=","and"); 
     builder.setOrderByClause("updTimestamp", "desc");
    // searchbox
    $("#SbcProductionGoalSearchbox").searchbox({prompt:"请输入...",searcher:function(value,name) {
         builder.set("q",value);
         builder.set("queryColumns","companyCod,bulkTyp,prodPlanTyp,prodPlanYmd,planNum");
         dg.datagrid("load");
     }});
	$("#SbcProductionGoalDatagrid").datagrid({
        	striped:true,
	    url:"../webresources/login/SbcProductionGoal/find",
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
	    toolbar:"#SbcProductionGoalToolBar",
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
                parentId: '#SbcProductionGoalDatagrid',
                textField:'cnCompanyNam',
                required: true,
                fieldMapping: {
        	    	companyCod: 'companyCod',
        	    	cnCompanyNam:'cnCompanyNam'
        		}
            })
        }, */
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
	    width:130,
	    multiSort:true,
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
    	/* dg.datagrid('selectRow',index);
        var selectRow = $("#SbcProductionGoalDatagrid").datagrid("getSelected");
        HdUtils.dialog.setValue({data: selectRow,type:"EDIT",dataGrid:dg});
        HdUtils.dialog.show({height: 320,width:260, title: dialogTitleAddF, href: "../login/sys/sbcproductiongoal/sbc_production_goal_detail.jsp", isSaveHandler: true});  */
    }
	});
});
</script>
