<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:460px;">
        <div id="SysContactGroupToolBar1500342967682" style="padding-top: 0px;">
                <div style="float:left">
                    <shiro:hasPermission name="webresources:login:SysContactGroup:add">
			            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
			        </shiro:hasPermission>
			        <shiro:hasPermission name="webresources:login:SysContactGroup:update">
			            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
			        </shiro:hasPermission>
			        <shiro:hasPermission name="webresources:login:SysContactGroup:delete">
			            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
			        </shiro:hasPermission>
			        <shiro:hasPermission name="webresources:login:SysContactGroup:save">
			            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
			        </shiro:hasPermission>
			            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
                </div>
                <input class="easyui-searchbox" id="sbcContactGroupSearchbox1487" />
        </div>
        <table id="sysContactGroupDatagrid1487072258264" title="用户组" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
        <div id="sbcContactRelToolBar1487072258264" >
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
        </div>
         <table id="sysContactRelDatagrid14870" title="对应关系 "  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:520px;">
        <div id="sbcContactPersonToolBar14866" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
                        <a class="easyui-linkbutton" id='addPerson1212' plain="false">维护联系人</a> 
                        
<!--                         <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a> -->
<!--                         <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a> -->
<!--                         <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a> -->
<!--                         <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> -->
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
                </div>
<!--                 <input class="easyui-searchbox" id="sbcContactPersonSearchbox1487"/> -->
        </div>
        <table id="sysContactPersonDatagrid233" title="用户" style="height:100%"></table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var ssdg = $("#sysContactGroupDatagrid1487072258264");
        var userdg=$("#sysContactPersonDatagrid233");
        // buttons
        // 增加。
        var addflag=false;
        $("#SysContactGroupToolBar1500342967682  a[iconCls='icon-add']").on("click", function() {
           addflag=true;
        	ssdg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SysContactGroupToolBar1500342967682  a[iconCls='icon-edit']").on("click",
            function() {
        	addflag=false;   
        	ssdg.datagrid("hdEdit");
                var selectIdx = ssdg.datagrid("options").hdCurrentRowIndex;
                ssdg.datagrid('getEditor', {index : selectIdx,field : 'groupCode'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SysContactGroupToolBar1500342967682  a[iconCls='icon-remove']").on("click",
            function() {ssdg.datagrid("hdRealRemove",{url : "../webresources/login/SysContact/saveSysContactGroup"});
        });
        
        // 保存。
        $("#SysContactGroupToolBar1500342967682  a[iconCls='icon-save']").on("click", function () {
        	addflag=false;  
        	ssdg.datagrid("hdSave", {url: "../webresources/login/SysContact/saveSysContactGroup"});
        });

        // 刷新。
        $("#SysContactGroupToolBar1500342967682  a[iconCls='icon-reload']").on("click",
            function() {
        	addflag=false;  
        	var value=$("#sbcContactGroupSearchbox1487").val();
            builder.set("q", value);
            ssdg.datagrid("load");
        });
        //user 按钮
         $("#addPerson1212").on("click", function() {
             HdUtils.dialog.show({height: 565,width:750, title: "维护联系人", href: "../login/sys/sysContact/addPerson.jsp", isSaveHandler: false
             })
        });
        // 刷新。
        $("#sbcContactPersonToolBar14866  a[iconCls='icon-reload']").on("click",
            function() {
        	addflag=false;  
        	var value=$("#sbcContactPersonSearchbox1487").val();
            subbuilder.set("q", value);
            subbuilder.set("queryColumns","");
            userdg.datagrid("load");
        });
        
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
         builder.hdEzuiQueryParams.page = 1;
         builder.hdEzuiQueryParams.rows = 50;
         builder.setOrderByClause("groupCode","asc");
        // searchbox
        $("#sbcContactGroupSearchbox1487").searchbox({prompt : "请输入...",
            searcher : function(value, name) {
            	addflag=false;  
            	builder.set("q", value);
                builder.set("queryColumns","groupCode,groupName");
                ssdg.datagrid("load");
                }
        });
        // datagrid
        $("#sysContactGroupDatagrid1487072258264").datagrid({
                striped:true,
                url : "../webresources/login/SysContact/findSysContactGroup",
                queryParams : builder.build(),
                method : "post",
                pagination : true,
                singleSelect: true,
                selectOnCheck:false,
                checkOnSelect:true,
                pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
                sortOrder: 'desc',//按更新时间倒序
                rownumbers : true,
                pageSize : 50,
                toolbar : "#SysContactGroupToolBar1500342967682",
                fit : true,
                fitColumns : false,
                onLoadSuccess: function(data){
                    //默认选中第一行
                $(this).datagrid('selectRow', 0);
                },
                columns : [[
                        {
                            field : "ck", checkbox : true
                        },
                        {
                            field: "groupId", title: "",multiSort: true,halign: "center", hidden:true,sortable: true
                        },
                        {
                            field: "groupCode", title: '<font color="red">组代码</font>', multiSort: true, halign: "center",
                            editor: {type: "uppercasebox", options: {required:true,validType: 'length[0,24]'}},
                            width:100,sortable: true
                        },
                        {
                            field: "groupName", title: '<font color="red">组名称</font>',multiSort: true,width:100, 
                            editor: {type: "validatebox", options: {required:true,validType: 'length[0,64]'}},
                            halign: "center",sortable: true
                        }
                ]],
                onDblClickCell : function(index) {
                    ssdg.datagrid("hdEdit");
                    ssdg.datagrid('getEditor', {index : index,field : 'groupCode'
                    }).target.prop('disabled', true);
                },
                onSelect:function(rowIndex,rowData){
                    if(!addflag){
                    	var builder = new HdEzuiQueryParamsBuilder(); 
                        builder.setAndClause("groupId",rowData.groupId,"=","and");
                         $("#sysContactRelDatagrid14870").datagrid({  
                             url: "../webresources/login/SysContact/findSysContactRel", 
                             queryParams: builder.build()});
                         
                         var builder22 = new HdEzuiQueryParamsBuilder(); 
                         builder22.set("q", rowData.groupId);
                         builder22.set("queryColumns","");
                         $("#sysContactPersonDatagrid233").datagrid({
                             url: "../webresources/login/SysContact/findSysContactPerson",
                             queryParams: builder22.build()});
                         addflag=false;
                    }
                	
                }
            });

        var dg = $("#sysContactRelDatagrid14870");
        $("#sbcContactRelToolBar1487072258264 a[iconCls='icon-remove']").on("click", function () {
            dg.datagrid("hdRealRemove", {url: "../webresources/login/SysContact/saveSysContactRel"});
        });
    
        $("#sysContactRelDatagrid14870").datagrid({
           // queryParams: builder.build(),
            striped:true,
            method: "POST",
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            remoteSort:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 50,
            fit: true,
            fitColumns: false,
            toolbar: "#sbcContactRelToolBar1487072258264",
            columns: [[
                    {
                        field: "ck",
                        checkbox: true
                    },
                    {
                        field: "relId",
                        title: '<font color="red"></font>',
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        sortable: true
                    },
                    {
                        field: "groupId",
                        title: "groupId",
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        sortable: true
                    },
                    {
                        field: "personId",
                        title: "personId",
                        multiSort: true,
                        hidden:true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "groupName",
                        title: "组名称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "personName",
                        title: "用户名",
                        multiSort: true,
                        width:100,
                        halign: "center",
                        sortable: true
                    },
                ]],
        });
        
        var subbuilder = new HdEzuiQueryParamsBuilder();
        subbuilder.set("q", "");
        subbuilder.set("queryColumns","");
        $("#sysContactPersonDatagrid233").datagrid({
            striped:true,
            url: "../webresources/login/SysContact/findSysContactPerson",
            queryParams: subbuilder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            selectOnCheck:false,
            checkOnSelect:false, 
            rownumbers: true,
            pageSize: 50,
            remoteSort:false,
            toolbar: "#sbcContactPersonToolBar14866",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {
                        field: "ck",
                        checkbox: true
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
                   
                    
              ]],
        });
       
        $("#sbcContactPersonSearchbox1487").searchbox({prompt: "请输入...", searcher: function(value, name) {
        	debugger
        	subbuilder.set("q", value);
        	subbuilder.set("queryColumns","PERSON_NAME");
             $("#sysContactPersonDatagrid233").datagrid("load");
        }});
        // 关联。
        $("#sbcContactPersonToolBar14866 a[iconCls='icon-rel']").on("click", function() {
            var selectRow =ssdg.datagrid("getSelected");
            if(selectRow){
                var selectData =$("#sysContactPersonDatagrid233").datagrid("getChecked");
                if(selectData&&selectData.length>0){ 
                	var insertList=[];
                    var dataJason = null;
                    var pam=null;
                	for(var i=0;i<selectData.length;i++){
                		pam={"groupId":selectRow.groupId,"personId":selectData[i].PERSON_ID};
                		insertList.push(pam);
                	}
                    dataJason = {deletedRows: [], insertedRows: insertList, updatedRows: []};
                    $.ajax({
                        url: "../webresources/login/SysContact/saveSysContactRel",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(dataJason),
                        success: function(data) {       
                             $("#sysContactRelDatagrid14870").datagrid("load");
                            HdUtils.messager.bottomRight(data.message,'提示');
                            
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择用户！", "info");
                }
            } else{
                 $.messager.alert("提示", "请选择用户组！", "info");
            }
            
        });
    });
</script>