<meta charset="UTF-8"/>
<div class="easyui-layout" data-options="fit:true" style="width:100%;height:100%;">
    <!--<div data-options="region:'north',title:'North Title',split:true" style="height:100px;"></div>-->
    <div data-options="region:'west',title:'组织架构',split:true" style="width:230px;">
        <ul id="authUserTenantOrgnTree" class="easyui-tree" data-options="method:'get',loadFilter:AuthUserTreeLoadFilter"></ul>
        <!-- webresources/login/TenantOrgn/vj/myFindAllForTree -->
        <!-- webresources/login/VjUserTree/getUserTreeWithLevel -->
    </div>
    <div data-options="region:'center',title:''"><!-- style="padding:5px;"-->
        <div id="AuthUserToolBar">
        <div style="float:left;">
             <shiro:hasPermission name="webresources:login:AuthUser:add">
                <a class="easyui-linkbutton" iconCls="icon-add" plain="false"><label name="add">增加</label></a>
            </shiro:hasPermission>
            <shiro:hasPermission name="webresources:login:AuthUser:edit">
                <a class="easyui-linkbutton" iconCls="icon-edit" plain="false"><label name="edit">编辑</label></a>
            </shiro:hasPermission>
            <shiro:hasPermission name="webresources:login:AuthUser:remove">
                <a class="easyui-linkbutton" iconCls="icon-remove" plain="false"><label name="delete">删除</label></a>
            </shiro:hasPermission>
            <shiro:hasPermission name="webresources:login:AuthUser:save">
                <a class="easyui-linkbutton" iconCls="icon-save" plain="false"><label name="save">保存</label></a>
            </shiro:hasPermission>
            <shiro:hasPermission name="webresources:login:AuthUser:find">
                <a class="easyui-linkbutton" iconCls="icon-reload" plain="false"><label name="reload">刷新</label></a>
            </shiro:hasPermission>
            <shiro:hasPermission name="webresources:login:AuthUser:move">
                <a class="easyui-linkbutton" iconCls="icon-redo" plain="false"><label name="move">调动</label></a>
            </shiro:hasPermission>&nbsp;
        </div>
         <input class="easyui-searchbox" id="AuthUserSearchbox"/>
        </div>
        <table id="AuthUserDatagrid" style="height:100%"></table>
    </div>
    <!--<div data-options="region:'east',title:'East',split:true" style="width:100px;"></div>-->
    <!--<div data-options="region:'south',title:'South Title',split:true" style="height:100px;"></div>-->
</div>
<div id="AuthUserFormDialog" style="display:none"></div>
<div id="AuthUserMoveDialog" style="display:none"></div>
<script type="text/javascript">
    var authUserTenantId = '';
    var authUserOrgnId = '';
    function AuthUserTreeLoadFilter(data, parent) {
        var state = $.data(this, 'tree');
        function setData() {
            var serno = 1;
            var todo = [];
            for (var i = 0; i < data.length; i++) {
                todo.push(data[i]);
            }
            while (todo.length) {
                var node = todo.shift();
                if (node.type==='TENANT') {
                    node.iconCls = "hd-orgtree-folder";//hd-org
                } else if (node.type==='ORGN') {
                    node.iconCls = "hd-orgtree-file";
                } else if (node.type==='USER') {
                    node.iconCls = "icon-remove";
                }
                if (node.id === undefined) {
                    node.id = '_node_' + (serno++);
                }
                if(node.level<2){
                  if (node.children) {
                    node.children1 = node.children;
                    todo = todo.concat(node.children1);
                }   
                }else{
                    if (node.children) {
                    node.state = 'closed';
                    node.children1 = node.children;
                    node.children = undefined;
                    todo = todo.concat(node.children1);
                } 
                }
                   
            }
            state.tdata = data;
        }
        function find(id) {
            var data = state.tdata;

            var cc = [data];
            while (cc.length) {
                var c = cc.shift();
                for (var i = 0; i < c.length; i++) {
                    var node = c[i];
                    if (node.id === id) {
                        return node;
                    } else if (node.children1) {
                        cc.push(node.children1);
                    }
                }
            }
            return null;
        }
        setData();
        var t = $(this);
        var opts = t.tree('options');
        opts.onBeforeExpand = function (node) {
            var n = find(node.id);
            if (n.children && n.children.length) {
                return;
            }
            if (n.children1) {
                var filter = opts.loadFilter;
                opts.loadFilter = function (data) {
                    return data;
                };
                   t.tree('append', { 
                    parent: node.target,
                    data: n.children1
                }); 
                opts.loadFilter = filter;
                n.children = n.children1;
            }
        };
        
        
        $(this).tree('options').onClick = function (node) {
            //var hdConditions = new HdConditions();
            var hdConditions = new HdEzuiQueryParamsBuilder();
            if (node.type === 'TENANT') {
                $("#AuthUserToolBar a[iconCls='icon-add']").linkbutton('disable');
                hdConditions.setAndClause("tenantId_tenantId", node.tenantId, "=", "AND");
                authUserHideButton();
            } else if (node.type === 'ORGN') {
                $("#AuthUserToolBar a[iconCls='icon-add']").linkbutton('enable');
                hdConditions.setAndClause("tenantId_tenantId", node.tenantId, "=", "AND");
                hdConditions.setAndClause("orgnId_orgnId", node.orgnId, "=", "AND");
                authUserShowButton();
            } else {
                return;
            }
            //var queryParams = {
            //    hdConditions: hdConditions.getHdConditions(),
            //    queryColumns: {}
            //};
            var queryParams = hdConditions.build();
            $('#AuthUserDatagrid').datagrid({url: "../webresources/login/AuthUser/find?t="+Math.random(),
                queryParams: queryParams
            });
        };
        return data;
    }
    $(document).ready(function () {
        $.i18n.properties({
            name: 'user', //资源文件名称
            path: '../i18n/project/', //资源文件路径
            mode: 'map', //用Map的方式使用资源文件中的值
            language: getBrowserLanguage(),
//            language: "en",
            callback: function () {//加载成功后设置显示内容
                $("label").each(function (i) {
                    $(this).html($.i18n.prop($(this).attr("name")));
                });
            }
        });
        $('#authUserTenantOrgnTree').tree({
            url: "../webresources/login/TenantOrgn/vj/myFindAllForTree?s="+Math.random()
        }); 
        //列声明
        var columns = [];
        var column = [];
        column.push({
        	 field: "ck",
             checkbox: true
        });
        column.push({
            title: "用户id",
            field: "userId",
            hidden: true
        });
        column.push({
            field: "name",
            width: '110',
            title:  $.i18n.prop("name"),
            multiSort: true,
            align: "center",
            halign: "center",
            editor: {type: "validatebox", options: {required: false}},
            sortable: true
        });
        column.push({
            field: "account",
            width: '120',
            align: "center",
            title: $.i18n.prop("account"),
            multiSort: true,
            halign: "center",
            editor: {type: "validatebox", options: {required: false}},
            sortable: true
        });
        column.push({
            field: "companyCodNam",
            width: 90,
            align: "center",
            title: "所属单位",
            multiSort: true,
            halign: "center",
            editor: {type: "validatebox", options: {required: false}},

            sortable: true
        });
        /*
        column.push({
            field: "password",
            title: "密码",
            multiSort: true,
            halign: "center",
            editor: {type: "validatebox", options: {required: false}},
            sortable: true
        });
        */
        column.push({
            field: "tenantId",
            title: $.i18n.prop("tenantId"),
            hidden: true
        });
        column.push({
            field: "tenantName",//zuhu
            width: 85,
            title: "集团名称",
            align: "center",
            editor: {type: "text", options: {required: false}},
            formatter: function (val, row, idx) {
                return row.tenantId.text;
            },
            halign: "center"
        });
        column.push({
            field: "orgnId",
            title: $.i18n.prop("orgnId"),
            hidden: true
        });
        column.push({
            field: "orgnName",//zuzhi
            width: 95,
            title: $.i18n.prop("orgnName"),
            align: "center",
            halign: "center",
            editor: {type: "text", options: {required: false}},
            formatter: function (val, row, idx) {
                return row.orgnId.text;
            }
        });
        column.push({
            field: "status",
            width: 50,
            title: $.i18n.prop("status"),
            formatter: function (val, row, idx) {
                if (row.lockId==='1') {
                    return '锁定';
                }
                if (row.stopId==='2') {
                    return '停用';
                }
                return '正常';
            },
            halign: "center",
            align: "center"
        });
        column.push({
            field: "accountPassDate",
            width: 90,
            title: $.i18n.prop("accountPassDate"),
            align: "center",
            halign: "center",
            formatter: function (val, row, idx) {
                if (val===null||val===0||val==='0') {
                    return "";
                }
                //var date = new Date();
                //date.setTime(row.accountPassDate);
                //return date.getUTCFullYear()+"-"+date.getUTCMonth()+"-"+date.getUTCDate();
                return new Date(val).format("yyyy-MM-dd");
            }
        });
        column.push({
            field: "pwModifyTim",
            width: 90,
            title: $.i18n.prop("pwModifyTim"),
            align: "center",
            halign: "center",
            formatter: function (val, row, idx) {
                if (val===null||val===0||val==='0') {
                    return "";
                }
                return new Date(val).format("yyyy-MM-dd");
            }
        });
        column.push({
        	field: "sorter",
//          title: '排序',
            title: "排序",
            halign: "center",
            align: "center",
            multiSort: true,
            halign: "center",
            width:40,
        });
        column.push({
            field: 'opt',
            title: $.i18n.prop("opt"),
            width: 80,
            align: "center",
            halign: "center",
            formatter: function (val, row, idx) {
            	var userName=HdUtils.global.config.account();
            	if(userName=="admin"){//admin 账户可操作
                    return "<input type='button' value='修改密码' onclick='modifyPassword(\"" + row.userId + "\")'/>";
               }else{
            	   return ""; 
               }
            }
        });
        columns.push(column);
        
        //过滤条件
        //var hdConditions = new HdConditions();
        var hdConditions = new HdEzuiQueryParamsBuilder();
        hdConditions.setAndClause("tenantId_tenantId", "-1", "=", "AND");

        //列表定义
        var dataGrid = $("#AuthUserDatagrid");
        dataGrid.datagrid({
            url: "../webresources/login/AuthUser/find?t="+Math.random(),
            queryParams: hdConditions.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            sortName:'sorter',
            sortOrder:'asc',
            pageSize: 20,
            toolbar: "#AuthUserToolBar",
            fit: true,
            fitColumns: false,
            columns: columns,
            onDblClickCell: function (index) {
                var data = dataGrid.datagrid("getSelected");
                $("#AuthUserFormDialog").show();
                HdUtils.dialog.show({width:600,height:400,title:'修改用户',href:"system/user/userform.html",isSaveHandler:true});
                HdUtils.dialog.setValue({params:data, type:'EDIT', dataGrid:dataGrid});
            }
        });
       /*  dataGrid.datagrid({
            onDblClickCell: function (index) {
                var data = dataGrid.datagrid("getSelected");
                $("#AuthUserFormDialog").show();
                HdUtils.dialog.show({width:600,height:400,title:'修改用户',href:"system/user/userform.html",isSaveHandler:true});
                HdUtils.dialog.setValue({params:data, type:'EDIT', dataGrid:dataGrid});
            }
        }); */


        $("#AuthUserToolBar a[iconCls='icon-add']").on("click", function() {
            var sel = $('#authUserTenantOrgnTree').tree("getSelected");
            if (sel===null || sel.orgnId === undefined || sel.orgnId === '') {
            	HdUtils.messager.info('请先选择一个部门进行用户添加');
                return;
            }
            var defaultEntity = {
                tenantId: sel.tenantId,
                orgnId: sel.orgnId,
                tenantName: sel.tenantName,
                orgnName: sel.orgnName,
                password : '888888',//默认密码
                companyCod:sel.companyCod,
                pwNeverPassId: 1,
                lockId: 0,
                stopId: 0,
                nextChgId: 0,
                donotChgId: 0,
                skin: 'metro-blue'//皮肤默认蓝色
            };
            //dataGrid.datagrid("hdAdd", defaultEntity);//可编辑列表实现
            /*以下是弹窗表单编辑实现*/
            $("#AuthUserFormDialog").show();
            HdUtils.dialog.show({width:600,height:450,title:'增加用户',href:"system/user/userform.html",isSaveHandler:true});
            HdUtils.dialog.setValue({params:defaultEntity, type:'ADD', dataGrid:dataGrid});
        });
        $("#AuthUserToolBar a[iconCls='icon-edit']").on("click", function () {
            /*以下是弹窗表单编辑实现*/
            var data = dataGrid.datagrid("getSelected");
            if (data===null||data===undefined) {
                HdUtils.messager.info('请选择一个用户进行编辑！');
                return;
            }
            $("#AuthUserFormDialog").show();
            HdUtils.dialog.show({width:600,height:450,title:'修改用户',href:"system/user/userform.html",isSaveHandler:true});
            HdUtils.dialog.setValue({params:data, type:'EDIT', dataGrid:dataGrid});
        });
        $("#AuthUserToolBar a[iconCls='icon-remove']").on("click", function () {
            var data = dataGrid.datagrid("getSelected");
            if (data===null||data===undefined) {
                HdUtils.messager.info('请选择一个用户进行删除！');
                return;
            }
            $.ajax({
                type: "GET",
                url: "../webresources/login/AuthUser/validateDelete?t=" + Math.random(),
                contentType: "application/json",
                dataType: "json",
                data: {userId : data.userId},
                success: function(data) {
                     dataGrid.datagrid("hdRealRemove", {url:'../webresources/login/AuthUser/save'});
                     //dataGrid.datagrid("hdRemove");
                },
                error: function(data) {
                    HdUtils.messager.info('该用户存在以下关联：<br/><font color="red">'+data.responseText+'</font><br/>请解除关联后再进行删除操作！');
                }
            });
     
            
        });
//        $("#AuthUserToolBar a[iconCls='icon-save']").on("click", function () {
//            dataGrid.datagrid("hdSave", {url:'../webresources/login/AuthUser/save'});
//        });
        $("#AuthUserToolBar a[iconCls='icon-reload']").on("click", function () {
            dataGrid.datagrid("reload");
        });
        $("#AuthUserToolBar a[iconCls='icon-redo']").on("click", function () {
            var data = dataGrid.datagrid("getSelected");
            if (data===null||data===undefined) {
                HdUtils.messager.info('请选择一个用户进行操作！');
                return;
            }
            $("#AuthUserMoveDialog").show();
            HdUtils.dialog.show({width:300,height:400,title:'调动用户',href:"system/user/selectOrgn.html",isSaveHandler:true});
            HdUtils.dialog.setValue({params:data, dataGrid:dataGrid});
        });
        $("#AuthUserSearchbox").searchbox(
                {
                    prompt: "请输入...",
                    searcher: function (value, name) {
                        var sel = $('#authUserTenantOrgnTree').tree("getSelected");
                        if (sel===undefined) {
                            sel = {tenantId:'-1'};
                        }
                        var hdConditions = new HdEzuiQueryParamsBuilder();
                        hdConditions.setAndClause("tenantId_tenantId", sel.tenantId, "=", "AND");
                        if (sel.orgnId!==undefined&&sel.orgnId!=='') {
                            hdConditions.setAndClause("orgnId_orgnId", sel.orgnId, "=", "AND");
                        }
                        hdConditions.set("q",value);
                        hdConditions.set("queryColumns","account,name");
                        $('#AuthUserDatagrid').datagrid({
                            queryParams: hdConditions.build()
                        });
                        //dataGrid.datagrid("hdReload");
                    }
                }
        );
        authUserHideButton();
    });
    var modifyPasswordUserId = '';
    function modifyPassword(value) {
        modifyPasswordUserId = value;
        HdUtils.dialog.show({title:"密码修改",href:"../login/system/user/password0.html",width:370,height:200,isSaveHandler:true});
    }
    function authUserHideButton() {
        //$("#AuthUserToolBar a[iconCls='icon-add']").linkbutton('disable');
        /*
        $("#AuthUserToolBar a[iconCls='icon-add']").linkbutton("disable");
        $("#AuthUserToolBar a[iconCls='icon-add']").unbind("click");
        $("#AuthUserToolBar a[iconCls='icon-add']").hide();
        $("#AuthUserToolBar a[iconCls='icon-edit']").hide();
        $("#AuthUserToolBar a[iconCls='icon-remove']").hide();
        $("#AuthUserToolBar a[iconCls='icon-save']").hide();
        */
    }
    function authUserShowButton() {
        /*
        $("#AuthUserToolBar a[iconCls='icon-add']").linkbutton();
        $("#AuthUserToolBar a[iconCls='icon-add']").on("click", addAuthUser);
        $("#AuthUserToolBar a[iconCls='icon-add']").show();
        $("#AuthUserToolBar a[iconCls='icon-edit']").show();
        $("#AuthUserToolBar a[iconCls='icon-remove']").show();
        $("#AuthUserToolBar a[iconCls='icon-save']").show();
        */
    }
</script>
