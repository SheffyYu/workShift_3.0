<meta charset="UTF-8">
<div id="SbcBollardToolBar" style="padding-top: 0px;">
    <div style="float:left;">
    <shiro:hasPermission name="webresources:login:SbcBollard:add">
       <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcBollard:update">
       <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcBollard:delete">
       <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcBollard:save">
       <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcBollard:refresh">
       <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
       </shiro:hasPermission> 
    </div>
    <input class="easyui-searchbox" id="SbcBollardSearchbox" type="text"/>
</div>
<table id="SbcBollardDatagrid" style="height:100%"></table>
<script type="text/javascript">
$(document).ready(function() { 
	var dg = $("#SbcBollardDatagrid");
    // buttons
    // 增加。
    $("#SbcBollardToolBar a[iconCls='icon-add']").on("click",function() {
        dg.datagrid("hdAdd");
    });
    // 编辑。
     $("#SbcBollardToolBar a[iconCls='icon-edit']").on("click",function() {
        dg.datagrid("hdEdit");
        var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
        dg.datagrid('getEditor', {index: selectIdx, field: 'bollardCod'}).target.prop('disabled', true);
     });
    // 删除。
     $("#SbcBollardToolBar a[iconCls='icon-remove']").on("click",function() {
    	 dg.datagrid("hdRealRemove",{url:"../webresources/login/SbcBollard/save"});
     });
    // 保存。
     $("#SbcBollardToolBar a[iconCls='icon-save']").on("click",function() {
    	 dg.datagrid("hdSave",{url:"../webresources/login/SbcBollard/save"}); 
     });
    // 刷新。
     $("#SbcBollardToolBar a[iconCls='icon-reload']").on("click",function() {
    	 var value=$("#SbcBollardSearchbox").val();
     	 builder.set("q", value);
     	 dg.datagrid("load");
     });
    // 条件类。
     var builder = new HdEzuiQueryParamsBuilder();
     builder.setOrderByClause("bollardId","desc");
    // searchbox
    $("#SbcBollardSearchbox").searchbox({prompt:"请输入...",searcher:function(value,name) {
         builder.set("q",value);
         builder.set("queryColumns","bollardCod,bollardNam,berthCod,distance");
         dg.datagrid("load");
     }});
	$("#SbcBollardDatagrid").datagrid({
        	striped:true,
	    url:"../webresources/login/SbcBollard/find",
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
	    toolbar:"#SbcBollardToolBar",
	    fit:true,
	    fitColumns:false,
	    columns:[[
		{
		    field: "ck",
		    checkbox: true
		},          
	    {
	    
	    field:"bollardId",
	    title:'<font color="red">GUID</font>',
	    multiSort:true,
	    hidden:true,
	    halign:"center",
	    sortable:true
		}
	    ,
	    {
	    
	    field:"bollardCod",
	    title:'<font color="red">缆桩代码</font>',
	    multiSort:true,
	    halign:"center",
	    editor:{type:"uppercasebox",options:{required:true,validType:['isCodeRepeat["SbcBollardDatagrid","SbcBollard","bollardCod"]', 'length[1,10]']}},
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"bollardNam",
	    title:'<font color="red">缆桩名称</font>',
	    multiSort:true,
	    halign:"center",
	    editor:{type:"validatebox",options:{required:true,validType: 'length[1,40]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"berthCod",
	    title:'<font color="red">泊位代码</font>',
	    multiSort:true,
	    halign:"center",
	    editor: {
	        type: 'combogrid',
	        options: HdUtils.code.sbcBerth({
	            parentId: '#SbcBollardDatagrid',
	            width: 80,
	            fieldMapping: {
	            	berthCod: 'berthCod',
	            	berthNam: 'berthNam'
	            },
	            required:true
	        })
	    },
	    //editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,10]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"distance",
	    title:'<font color="red">离原地距离</font>',
	    multiSort:true,
	    halign:"center",
	    editor:{type:"numberbox",options:{required:true,validType: 'length[1,60]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"sorter",
	    title:'排序编号',
	    multiSort:true,
	    halign:"center",
	    editor:{type:"numberbox",options:{required:false,validType: 'length[0,60]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"description",
	    title:"备注",
	    multiSort:true,
	    width:100,
	    halign:"center",
	    editor:{type:"validatebox",options:{required:false,validType: 'length[0,1000]'}},
	    sortable:true
		}
	    ,
	    {
	    
	    field:"insAccount",
	    title:'录入人',
	    multiSort:true,
	    halign:"center",
	    sortable:true
		}
	    ,
	    {
	    
	    field:"insTimestamp",
	    title:"录入时间",
	    multiSort:true,
	    halign:"center",
	    formatter: $.hd.ezui.formatter.datetime,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"updAccount",
	    title:"更新人",
	    multiSort:true,
	    halign:"center",
	    sortable:true
		}
	    ,
	    {
	    
	    field:"updTimestamp",
	    title:"更新时间",
	    multiSort:true,
	    halign:"center",
	    formatter: $.hd.ezui.formatter.datetime,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"companyCod",
	    title:"公司代码",
	    multiSort:true,
	    hidden:true,
	    halign:"center",
	    width:160,
	    sortable:true
		}
	]],
    onDblClickRow: function (index, data) {
    	dg.datagrid("hdEdit"); 
    	dg.datagrid('getEditor', {index: index, field: 'bollardCod'}).target.prop('disabled', true);
    } 
	});
});
</script>
