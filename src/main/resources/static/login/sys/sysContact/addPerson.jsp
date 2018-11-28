<meta charset="UTF-8">
<div id="sbcContactPersonToolBar6767" style="padding-top: 0px;">
     <div style="float:left;">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
<!--             <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> -->
    </div>
    <input class="easyui-searchbox" id="sbcContactPersonSearchbox17777"/>
</div>
<table id="sysContactPersonDatagrid2565" title="用户" style="height:100%"></table>

<script type="text/javascript">
    $(document).ready(function () {
    	userdgg=$("#sysContactPersonDatagrid2565"); 
    	//user 按钮
        $("#sbcContactPersonToolBar6767  a[iconCls='icon-add']").on("click", function() {
            addflag=false;  
            userdgg.datagrid("hdAdd");
       });
       // 编辑。
       $("#sbcContactPersonToolBar6767  a[iconCls='icon-edit']").on("click",function() {
           addflag=false;    
           userdgg.datagrid("hdEdit");
       });
       // 删除。
       $("#sbcContactPersonToolBar6767  a[iconCls='icon-remove']").on("click",function() {
    	   userdgg.datagrid("hdRemove",{url : "../webresources/login/SysContact/saveSysContactPerson"});
       });
       // 保存。
       $("#sbcContactPersonToolBar6767  a[iconCls='icon-save']").on("click", function () {
           addflag=false;  
           userdgg.datagrid("hdSave", {url: "../webresources/login/SysContact/saveSysContactPerson", callback: function() {
        	   var rowData=$("#sysContactGroupDatagrid1487072258264").datagrid("getSelected");
               var builder222 = new HdEzuiQueryParamsBuilder();
               builder222.set("q", rowData.groupId);
               builder222.set("queryColumns","");
               $("#sysContactPersonDatagrid233").datagrid("reload", builder222.build());
           }});
       });

       // 刷新。
//        $("#sbcContactPersonToolBar6767  a[iconCls='icon-reload']").on("click",
//            function() {
//            addflag=false;  
//            var value=$("#sbcContactPersonSearchbox1487").val();
//            subbuilder11.set("q", value);
//            userdgg.datagrid("load");
//        });
       
       $("#sbcContactPersonSearchbox17777").searchbox({prompt: "请输入...", searcher: function(value, name) {
    	   subbuilder11.set("q", value);
    	   subbuilder11.set("queryColumns","PERSON_NAME");
    	   userdgg.datagrid("load");
       }});
       var subbuilder11 = new HdEzuiQueryParamsBuilder();
       subbuilder11.set("q", "");
       subbuilder11.set("queryColumns","");
       $("#sysContactPersonDatagrid2565").datagrid({
           striped:true,
           url: "../webresources/login/SysContact/findSysContactPerson",
           queryParams: subbuilder11.build(),
           method: "POST",
           pagination: true,
           singleSelect: true,
           pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
           selectOnCheck:false,
           checkOnSelect:false, 
           rownumbers: true,
           pageSize: 50,
           remoteSort:false,
           toolbar: "#sbcContactPersonToolBar6767",
           fit: true,
           fitColumns: false,
           columns: [[ 
                   
                   {
                       field: "PERSON_ID",
                       title: '',
                       multiSort: true,
                       halign: "center",
                       hidden:true,
                       sortable: true
                   },
                   {
                       field: "PERSON_CODE",
                       title: '<font color="red">用户代码</font>',
                       multiSort: true,
                       width:100,
                       editor: {type: "uppercasebox", options: {required:true,validType: 'length[0,36]'}},
                       halign: "center",
                       sortable: true
                   },
                   {
                       field: "PERSON_NAME",
                       title: '<font color="red">用户姓名</font>',
                       multiSort: true,
                       halign: "center",
                       editor: {type: "validatebox", options: {required:true,validType: 'length[0,36]'}},
                       width:100,
                       sortable: true
                   },
                   {
                       field: "PERSON_PHONE",
                       title: '<font color="red">用户手机</font>',
                       multiSort: true,
                       halign: "center",
                       editor: {type: "numberbox", options: {required: true,validType: 'length[0,12]'}},
                       align: "center",
                       width:100,
                       sortable: true
                   },
                  
                   {
                       field: "PERSON_POSITION",
                       title: "用户称谓",
                       multiSort: true,
                       align: "center",
                       width:100,
                       editor: {type: "validatebox", options: {required:true,validType: 'length[0,12]'}},
                       halign: "center",
                       sortable: true
                   }
             ]],
       });
    	
    })
</script>