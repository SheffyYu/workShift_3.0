<script type='text/javascript' src='../login/system/role/allotRoleAndPrivilege.js'></script>
<script>
    var tools = [{
            iconCls: 'icon-save',
            handler: function() {
            	if (userId == '') {
                    HdUtils.messager.info("请选择一个用户!");
                    return;
                }
//                 var nodes = $('#resoursePTree').tree('getChecked', ['checked', 'indeterminate']);
//                 var json = "[";
//                 for (var i = 0; i < nodes.length; i++) {
//                     if (i == 0) {
//                         json = json + "{";
//                     } else {
//                         json = json + ",{";
//                     }
//                     json = json + '"tid":"' + nodes[i].tid + '"';
//                     json = json + ',"id":"' + nodes[i].id + '"';
//                     json = json + ',"pid":"' + nodes[i].pid + '"}';
//                 }
//                 json = json + "]";


//                 HdUtils.ajax.post({url: "../webresources/login/AuthRole/updateUserPermission/" + userId, data: json, success: function(data) {
//                         HdUtils.messager.bottomRight("保存成功!", "权限分配管理");
//                     }, error: function(data) {
//                         HdUtils.messager.bottomRight("保存成功!", "权限分配管理");
//                     }});
       var dgSelected = $("#usrTree").tree('getSelected');
       var qqq=$("#RoleDatagrid").datagrid('getSelected');
            if (dgSelected == null)
            {
                return;
            }
            if (dgSelected.type != "USER")
            {
                HdUtils.messager.info("请选择一个员工！");
                return;
            }
            saveGroupRoleUser(true, qqq.roleId, userId);//保存用户角色

            }

        }];

</script>
<div class="easyui-layout" data-options="fit:true" style="height:100%;width:100%;">
    <div data-options="region:'west',split:true" title="集团组织用户树" style="width: 230px;height:100%;">
        <!-- 这里显示流程列表 -->
        <ul id="usrTree" class="easyui-tree" 
            ></ul>
    </div>
    <div  data-options="region:'center',split:true" title="角色列表" style="height: 100%;">
        <!-- 这里显示流程列表 -->
        <table id ="RoleDatagrid"></table>
    </div>
    <!--  该功能因为插入auth_user_privilege,auth_user_resource，菜单查询从auth_role_privilege取 -->
<!--     <div data-options="region:'east',tools:tools,split:true" title="功能资源分配列表"  style="width: 200px;height: 100%;"> -->
<!--         <ul id="resoursePTree" class="easyui-tree"   -->
<!--             data-options="checkbox:true">      -->
<!--         </ul> -->
<!--     </div> -->
    
</div>



