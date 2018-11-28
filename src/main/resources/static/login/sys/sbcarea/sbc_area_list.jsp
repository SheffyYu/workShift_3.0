<meta charset="UTF-8">
<div id="SbcAreaToolBar" style="padding-top: 0px;">
    <div style="float:left;">
       <shiro:hasPermission name="webresources:login:SbcArea:add">
       <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcArea:update">
       <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcArea:delete">
       <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcArea:save">
       <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="webresources:login:SbcArea:refresh">
       <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
       </shiro:hasPermission> 
        &nbsp;
    </div>
    <input class="easyui-searchbox" id="SbcAreaSearchbox" type="text"/>
</div>
<table id="SbcAreaDatagrid" style="height:100%"></table>
<script type="text/javascript">
$(document).ready(function() { 
	var dg = $("#SbcAreaDatagrid");
    // buttons
    // 增加。
    $("#SbcAreaToolBar a[iconCls='icon-add']").on("click",function() {
        dg.datagrid("hdAdd");
    });
    // 编辑。
     $("#SbcAreaToolBar a[iconCls='icon-edit']").on("click",function() {
        dg.datagrid("hdEdit");
        var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
        dg.datagrid('getEditor', {index: selectIdx, field: 'areaCod'}).target.prop('disabled', true);
     });
    // 删除。
     $("#SbcAreaToolBar a[iconCls='icon-remove']").on("click",function() {
    	dg.datagrid("hdRealRemove",{url:"../webresources/login/SbcArea/save"});
     });
    // 保存。
     $("#SbcAreaToolBar a[iconCls='icon-save']").on("click",function() {
        dg.datagrid("hdSave",{url:"../webresources/login/SbcArea/save"});   
     });
    // 刷新。
     $("#SbcAreaToolBar a[iconCls='icon-reload']").on("click",function() {
    	 var value=$("#SbcAreaSearchbox").val();
     	 builder.set("q", value);
     	 dg.datagrid("load");
     });
    // 条件类。
     var builder = new HdEzuiQueryParamsBuilder();
     builder.hdEzuiQueryParams.page = 1;
     builder.hdEzuiQueryParams.rows = 20;
     builder.setOrderByClause("areaId","desc");
    // searchbox
    $("#SbcAreaSearchbox").searchbox({prompt:"请输入...",searcher:function(value,name) {
         builder.set("q",value);
         builder.set("queryColumns","areaCod,cnAreaNam,enAreaNam");
         dg.datagrid("load");
     }});
	$("#SbcAreaDatagrid").datagrid({
        	striped:true,
	    url:"../webresources/login/SbcArea/find",
	    queryParams:builder.build(),
	    method:"post", 
	    pagination:true,
        singleSelect: true,
        selectOnCheck:false,
        checkOnSelect:false,
	    //autoLoad:false,
	    sortOrder: 'desc',//按更新时间倒序
        sortName: 'updTimestamp',
	    rownumbers:true,
	    pageSize:20,
	    toolbar:"#SbcAreaToolBar",
	    fit:true,
	    fitColumns:false,
	    columns:[[
		{
		    field: "ck",
		    checkbox: true
		},
	    {
	    
	    field:"areaId",
	    title:'<font color="red">GUID</font>',
	    multiSort:true,
	    hidden:true,
	    halign:"center",
	    sortable:true
		}
	    ,
	    {
	    
	    field:"areaCod",
	    title:'<font color="red">地区代码</font>',
	    multiSort:true,
	    halign:"center",
	    editor:{type:"uppercasebox",options:{required:true,validType:['isCodeRepeat["SbcAreaDatagrid","SbcArea","areaCod"]','length[1,10]']}},
	    width:80,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"enAreaNam",
	    title:'英文地区名称',
	    multiSort:true,
	    halign:"center",
	    editor:{type:"uppercasebox",options:{required:false,validType: 'length[0,60]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    {	    
	    field:"cnAreaNam",
	    title:'中文地区名称',
	    multiSort:true,
	    halign:"center",
	    editor:{type:"validatebox",options:{required:false,validType: 'length[0,60]'}},
	    width:100,
	    sortable:true
		}
	    ,
	    /* {
	    
	    field:"sysMark",
	    title:'系统标识',
	    multiSort:true,
	    halign:"center",
	    align:"center",
	    width:80,
	    editor: $.hd.ezui.editor.checkbox,
	    formatter: $.hd.ezui.formatter.checkbox2,
	    sortable:true
		}
	    , */
	    {
	    
	    field:"abandonedMark",
	    title:'废弃标识',
	    multiSort:true,
	    halign:"center",
	    align:"center",
	    width:80,
	    editor: $.hd.ezui.editor.checkbox,
	    formatter: $.hd.ezui.formatter.checkbox2,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"description",
	    title:"备注",
	    multiSort:true,
	    halign:"center",
	    editor:{type:"validatebox",options:{required:false,validType: 'length[0,1000]'}},
	    sortable:true,
	    width:180
		}
	    ,
	    {
	    
	    field:"insAccount",
	    title:'录入人',
	    multiSort:true,
	    halign:"center",
	    width:80,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"insTimestamp",
	    title:"录入时间",
	    multiSort:true,
	    halign:"center",
	    width:140,
	    formatter: $.hd.ezui.formatter.datetime,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"updAccount",
	    title:"更新人",
	    multiSort:true,
	    halign:"center",
	    width:80,
	    sortable:true
		}
	    ,
	    {
	    
	    field:"updTimestamp",
	    title:"更新时间",
	    multiSort:true,
	    halign:"center",
	    width:140,
	    formatter: $.hd.ezui.formatter.datetime,
	    sortable:true
		}
	]],
	onDblClickRow: function (index, data) {
		dg.datagrid("hdEdit"); 
		dg.datagrid('getEditor', {index: index, field: 'areaCod'}).target.prop('disabled', true);
	}
	});
});
</script>
