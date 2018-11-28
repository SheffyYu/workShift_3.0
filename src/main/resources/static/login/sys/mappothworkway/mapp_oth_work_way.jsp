<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:470px;">
        <div id="SysCodeToolBar1427420966140" style="padding-top: 0px;">
                <div style="float:left;">
                    <shiro:hasPermission name="webresources:login:SysCode:add">
                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SysCode:update">
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SysCode:delete">
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SysCode:save">
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SysCode:refresh">
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
                    </shiro:hasPermission>
                </div>
                <shiro:hasPermission name="webresources:login:SysCode:searchbox">
                    <input class="easyui-searchbox" id="SysCodeSearchbox1427420966140"/>
                </shiro:hasPermission>
              
        </div>
          <table id="SysCodeDatagrid1427420966140" title="标准杂作业方式" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="MapOtherWorkToolBar1427420966140" style="padding-top: 0px;">
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
        </div>
         <table id="MapOtherWorkDatagrid1427420966140" title="对应杂作业方式"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:550px;">
        <div id="SrcOtherWorkToolBar1427420966140" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
<!--                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> 
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> -->
                </div>
                <input class="easyui-searchbox" id="SrcOtherWorkSearchbox1427420966140"/>
        </div>
        <table id="SrcOtherWorkDatagrid1427420966140" title="来源杂作业方式" style="height:100%"></table>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SysCodeDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SysCodeToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd",{'abandonedMark':'1','sysMark':'1','fieldCod':'OTH_WORK_WAY','fieldNam':'杂作业方式'}); 
        });
        // 编辑。
        $("#SysCodeToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'code'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SysCodeToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
             dg.datagrid("hdRealRemove", {url: "../webresources/login/SysCode/save"});
        });
        // 保存。
        $("#SysCodeToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SysCode/save"});
        });
        // 刷新。
        $("#SysCodeToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
            var value=$("#SysCodeSearchbox1427420966140").val();
            builder.set("q", value);
            builder.setOrderByClause("code","desc");
            dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setAndClause("fieldCod","OTH_WORK_WAY","=","and");
        builder.setOrderByClause("code","desc");
        $("#SysCodeSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "code,name");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SysCodeDatagrid1427420966140").datagrid({
            striped:true,
            url: "/webresources/login/SysCode/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            sortOrder: 'desc',
            sortName: 'code',//updTimestamp
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            toolbar: "#SysCodeToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
                    { field: "ck", checkbox: true},
                    { field: "code",  title: '<font color="red">杂作业代码</font>',  multiSort: true, halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isSysCodeRepeat["SysCodeDatagrid1427420966140","code","OTH_WORK_WAY"]','length[1,36]']}},
                        sortable: true
                    },   
                    { field: "name", title: '<font color="red">杂作业名称</font>',multiSort: true,  width:120,halign: "center",
                        editor: {type: "validatebox", options: {required: true,validType: 'length[0,100]'}},
                        sortable: true
                    },                                            
                    { field: "insAccount", title: "创建人",multiSort: true, halign: "center", width:80,sortable: true},
                    { field:"insTimestamp", title:"创建时间", multiSort:true, halign:"center", formatter: $.hd.ezui.formatter.datetime, width:140,sortable:true}
                ]],
                onDblClickRow: function (index, data) {
                    dg.datagrid("hdEdit");
                    dg.datagrid('getEditor', {index: index, field: 'code'}).target.prop('disabled', true);
                },
                onSelect:function(rowIndex,rowData){
                    var relbuilder = new HdEzuiQueryParamsBuilder(); 
                    relbuilder.setAndClause("othWorkWay",rowData.code,"=","and");
                     $("#MapOtherWorkDatagrid1427420966140").datagrid({  
                         url: "../webresources/login/mappothworkway/find", 
                         queryParams: relbuilder.build()}
                     );
                     $("#SrcOtherWorkSearchbox1427420966140").searchbox('setValue',rowData.name);
                     subOthWorkSearch(rowData.code);
                }
        });
        
        $("#SysCodeDatagrid1427420966140").datagrid("hdGetColumnNames");
        // datagrid
        $("#MapOtherWorkDatagrid1427420966140").datagrid({
            striped:true,
            method: "POST",
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            toolbar: "#MapOtherWorkToolBar1427420966140", 
            remoteSort:false,
            fit: true,
            fitColumns: false,
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "othWorkWayNam", title: "杂作业名称",  multiSort: true,  halign: "center", width:120,  sortable: true },
                    {field: "srcOthWorkWay",title: '原杂作业代码',multiSort: true, halign: "center",width:100,sortable: true },
                    {field: "othWorkWay", title: '标准杂作业代码', multiSort: true, halign: "center",width:120,sortable: true }
                    /* { field: "companyCod", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        },
                        sortable: true
                    } */
                ]],
             onDblClickRow: function (index, data) {
             }
        });
        // 删除。
        $("#MapOtherWorkToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {

                var selectData = $("#MapOtherWorkDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                     $.ajax({
                         url: "../webresources/login/SysCode/saveSbrOtherWorkRelSave",
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         data: $.toJSON(pam),
                         success: function(data) {       
                             $("#MapOtherWorkDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subOthWorkSearch(dgSelected[0].code);
                            HdUtils.messager.bottomRight(data.message,'提示');
                         }
                     });
                }else{
                     $.messager.alert("提示", "请选择！", "info");
                }
        });
        
        // 条件类。
        //var hdConditions = new HdConditions();
       
        var subbuilder = new HdEzuiQueryParamsBuilder();
        function subOthWorkSearch(codValue)
        {
            var schvalue= $("#SrcOtherWorkSearchbox1427420966140").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "NAME,CODE");
            $("#SrcOtherWorkDatagrid1427420966140").datagrid("load");
        }
        $("#SrcOtherWorkDatagrid1427420966140").datagrid({
            striped:true,
            url: "../webresources/login/SysCode/findSrcOtherWorkWay",
            queryParams: subbuilder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            autoLoad:false,
            remoteSort:false,
            toolbar: "#SrcOtherWorkToolBar1427420966140",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "NAME", title: "杂作业名称",  multiSort: true,  halign: "center", width:160,  sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {field: "CODE",title: '杂作业代码',multiSort: true, halign: "center",width:120,sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    }/* ,
                    { field: "COMPANY_COD", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.COMPANY_NAM;
                        },
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCompanyByCompanyCod({
                                parentId: '#SrcOtherWorkDatagrid1427420966140',
                                textField:'COMPANY_COD',
                                fieldMapping: {companyCod: 'COMPANY_COD',cnCompanyNam:'CN_COMPANY_NAM'},
                                required: true                 
                            })
                        }, 
                        sortable: true
                    } */
                ]],
             onDblClickRow: function (index, data) {
             }
        });
        
        var dgSub = $("#SrcOtherWorkDatagrid1427420966140");
        
        $("#SrcOtherWorkSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
            subOthWorkSearch("");
        }});

        // 关联。
        $("#SrcOtherWorkToolBar1427420966140 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =dg.datagrid("getSelected");
            if(selectRow){
                var selectData =dgSub.datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/SysCode/saveSbrOtherWorkRelSave",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#MapOtherWorkDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subOthWorkSearch(dgSelected[0].code);
                            HdUtils.messager.bottomRight(data.message,'提示');
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择来源杂作业方式！", "info");
                }
            }
            else{
                 $.messager.alert("提示", "请选择标准杂作业方式！", "info");
            }
            
        });
    });
</script>