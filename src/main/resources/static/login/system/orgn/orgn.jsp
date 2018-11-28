
<meta charset="UTF-8">
<script src='../login/system/orgn/orgn.js'></script>
<script >
</script>

<div class="easyui-layout" data-options="fit:true" style="height:100%;width:100%">
    <div data-options="region:'west',split:true,title:'部门结构',tools:[
                {
                    iconCls:'icon-reload',
                    handler:function(){$('#orgnTree').tree('reload');}
                }]"
         style="width:230px;padding:10px;">
        <ul  id="orgnTree" class="easyui-tree"></ul>
    </div>
    <div  data-options="region:'center',title:'部门列表'" style="height:100%;width:100%">
        <div id="AuthOrgnToolBar1421220911777">
            <div style="float:left;">
                <!-- 查询条件 结束-->
                <!-- 查询 -->
                    
                <!-- 查询结束 -->
                <!-- 标准按钮 -->
                <!-- 如果存在 查询条件，请开启-->
                <!--        <span style="float:right">-->
                <shiro:hasPermission name="webresources:login:AuthOrgn:add">
                    <a class="easyui-linkbutton" iconCls="icon-add" plain="false"><label name="add">增加</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthOrgn:update">
                    <a class="easyui-linkbutton" iconCls="icon-edit" plain="false"><label name="edit">编辑</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthOrgn:delete">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="false"><label name="delete">删除</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthOrgn:save">
                    <a class="easyui-linkbutton" iconCls="icon-save" plain="false"><label name="save">保存</label></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:AuthOrgn:refresh">
                    <a class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="reload">刷新</label></a>
                </shiro:hasPermission>&nbsp;
            </div>
            <input class="easyui-searchbox" id="AuthOrgnSearchbox1421220911777"/>
        </div>
        <table id="AuthOrgnDatagrid1421220911777" style="height:100%;width:100%"></table>
    </div>
</div>

