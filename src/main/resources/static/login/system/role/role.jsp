
<meta charset="UTF-8">
<script language="JavaScript" src='../login/system/role/role.js'></script>
<style type="text/css">
    #bgMask20170811zhangdh { 
        display: none;
        position: absolute; 
        left: 0%;  
        width: 100%;  
        height: 100%;  
        background-color: #F0F0F0;  
        z-index:1001;  
        -moz-opacity: 0.7;  
        opacity:.70;  
        filter: alpha(opacity=70);
    }
    #showMask20170811zhangdh {
        display: none;  
        position: absolute;  
        top: 45%;
        bottom:45%;  
        left: 15%;
        right:15%;  
        width: 60%;  
        height: 4%;  
        padding: 8px;  
        border: 2px solid #D3D3D3;  
        background-color: white;  
        z-index:1002;  
        overflow: auto;
    }
</style>
<script>
var userName=HdUtils.global.config.account();
if(userName=="admin"){
	var tools=[
           {
               iconCls:'',
            }
           ]
} else{
	var tools = [{
        iconCls: 'icon-save',
        handler: function() {
            var userName=HdUtils.global.config.account();
            if (roleId == '') {
                HdUtils.messager.info("请选择一个角色!");
                return;
            }
            var nodes = $('#resourseTree').tree('getChecked', ['checked', 'indeterminate']);
            var json = "[";
            for (var i = 0; i < nodes.length; i++) {
                if (i == 0) {
                    json = json + "{";
                } else {
                    json = json + ",{";
                }
                json = json + '"tid":"' + nodes[i].tid + '"';
                json = json + ',"id":"' + nodes[i].id + '"';
                json = json + ',"pid":"' + nodes[i].pid + '"}';
            }
            json = json + "]";
            HdUtils.ajax.post({
                url: "../webresources/login/AuthRole/updatePermission/" + roleId, 
                data:json, 
                success: function(data) {
                    HdUtils.messager.bottomRight("保存成功!", "角色管理");
                }, error: function(data) {
                    HdUtils.messager.bottomRight("保存成功!", "角色管理");
            }}); 
            /* $.ajax({
                type: "POST",
                url: "../webresources/login/AuthRole/updatePermission/" + roleId, 
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(json),
                async: false,
                success: function(data) {
                    HdUtils.messager.bottomRight("保存成功!", "角色管理");
                }
            }); */
        }

    }];	
} 

</script>
<div class="easyui-layout" data-options="fit:true"  style="height:100%;width:100%">
    <div data-options="region:'west',split:true,title:'集团'" style="width:200px;">
        <ul  id="tenantRoleTree" ></ul>
    </div>
    <div  data-options="region:'center',title:'角色'" style="width:660;" >
        <div id="AuthRoleToolBar1420351793293">
           <div style="float:left;">
               
                    
                <shiro:hasPermission name="webresources:login:AuthTenant:add">
                    <a class="easyui-linkbutton" iconCls="icon-add" plain="false"><label name="add">增加</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:update">
                    <a class="easyui-linkbutton" iconCls="icon-edit" plain="false"><label name="edit">编辑</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:delete">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="false"><label name="delete">删除</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:save">
                    <a class="easyui-linkbutton" iconCls="icon-save" plain="false"><label name="save">保存</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthTenant:refresh">
                    <a class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="reload">刷新</label></a>
                </shiro:hasPermission>&nbsp;
            </div>
            <input class="easyui-searchbox" id="AuthRoleSearchbox1420351793293"/>
        </div>
        <table id="AuthRoleDatagrid1420351793293" style="height:100%"></table>
    </div>
    <div   id='index_layout 'data-options="region:'east',title:'功能资源分配',tools:tools"  style="width:200px;">
        <div data-options="region:'center',split:true,title:'资源'">
            <div id="bgMask20170811zhangdh"></div>
            <div id="showMask20170811zhangdh"><img src="../../../images/loading.gif"/>&nbsp;&nbsp;正在加载。。。</div>
            <ul id="resourseTree" > </ul>
        </div>
    </div>
</div>