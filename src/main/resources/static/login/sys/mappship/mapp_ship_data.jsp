<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:470px;">
        <div id="SbcShipDataToolBar1427420966140" style="padding-top: 0px;">
                <div style="float:left;">
                    <!-- <shiro:hasPermission name="webresources:login:SbcShipData:add">
                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcShipData:update">
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcShipData:delete">
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcShipData:save">
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
                    </shiro:hasPermission> -->
                    <shiro:hasPermission name="webresources:login:SbcShipData:refresh">
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
                    </shiro:hasPermission>
                </div>
                <shiro:hasPermission name="webresources:login:SbcShipData:searchbox">
                    <input class="easyui-searchbox" id="SbcShipDataSearchbox1427420966140"/>
                </shiro:hasPermission>
              
        </div>
          <table id="SbcShipDataDatagrid1427420966140" title="标准船舶代码" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcShipDataRelToolBar1427420966140" style="padding-top: 0px;">
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
        </div>
         <table id="SbcShipDataRelDatagrid1427420966140" title="对应船舶代码"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:550px;">
        <div id="SbcShipDataSubToolBar1427420966140" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
<!--                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> 
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> -->
                </div>
                <input class="easyui-searchbox" id="SbcShipDataSubSearchbox1427420966140"/>
        </div>
        <table id="SbcShipDataSubDatagrid1427420966140" title="来源船舶代码" style="height:100%"></table>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcShipDataDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SbcShipDataToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd",{'abandonedMark':'1','sysMark':'1'}); 
        });
        // 编辑。
        $("#SbcShipDataToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'shipCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcShipDataToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
             dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcShipData/save"});
        });
        // 保存。
        $("#SbcShipDataToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcShipData/save"});
        });
        // 刷新。
        $("#SbcShipDataToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
            var value=$("#SbcShipDataSearchbox1427420966140").val();
            builder.set("q", value);
            builder.setOrderByClause("shipCod","desc");
            dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("shipCod","desc");
        $("#SbcShipDataSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "shipCod,enShipNam,cnShipNam,shortNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcShipDataDatagrid1427420966140").datagrid({
            striped:true,
            url: "/webresources/login/SbcShipData/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            sortOrder: 'desc',
            sortName: 'cnShipNam',//updTimestamp
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            rownumbers: true,
            pageSize: 100,
            toolbar: "#SbcShipDataToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
                    { field: "ck", checkbox: true},
                    { field: "shipCod",  title: '船舶代码',  multiSort: true, halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcShipDataDatagrid1427420966140","SbcShipData","shipCod"]','length[1,5]']}},
                        sortable: true
                    },   
                    { field: "cnShipNam", title: "船舶名称",multiSort: true,  width:120,halign: "center",
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    {field: "shortNam",title: "船舶简称", multiSort: true, halign: "center",  width:80,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,20]'}},
                        sortable: true
                    },
                    {field: "enShipNam", title: "船舶英文名称",multiSort: true, width:120,  halign: "center",
                        editor: {type: "uppercasebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },                                          
                    {field: "description", title: "备注", multiSort: true, halign: "center",   width:100,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}},
                        sortable: true
                    },
                    { field: "insAccount", title: "创建人",multiSort: true, halign: "center", width:80,sortable: true},
                    { field:"insTimestamp", title:"创建时间", multiSort:true, halign:"center", formatter: $.hd.ezui.formatter.datetime, width:140,sortable:true}
                ]],
               /*  onDblClickRow: function (index, data) {
                    dg.datagrid("hdEdit");
                    dg.datagrid('getEditor', {index: selectIdx, field: 'shipCod'}).target.prop('disabled', true);
                }, */
                onSelect:function(rowIndex,rowData){
                    var relbuilder = new HdEzuiQueryParamsBuilder(); 
                    relbuilder.setAndClause("shipCod",rowData.shipCod,"=","and");
                     $("#SbcShipDataRelDatagrid1427420966140").datagrid({  
                         url: "../webresources/login/MappShipData/find", 
                         queryParams: relbuilder.build()}
                     );
                     $("#SbcShipDataSubSearchbox1427420966140").searchbox('setValue',rowData.cnShipNam);
                     subShipDataSearch(rowData.shipCod);
                }
        });
        
        $("#SbcShipDataDatagrid1427420966140").datagrid("hdGetColumnNames");
        // datagrid
        $("#SbcShipDataRelDatagrid1427420966140").datagrid({
            striped:true,
            method: "POST",
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 50,
            rownumbers: true,
            toolbar: "#SbcShipDataRelToolBar1427420966140", 
            remoteSort:false,
            fit: true,
            fitColumns: false,
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "cnShipNam", title: "船舶名称",  multiSort: true,  halign: "center", width:120,  sortable: true },
                    {field: "srcShipCod",title: '原船舶代码',multiSort: true, halign: "center",width:100,sortable: true },
                    {field: "shipCod", title: '标准船舶代码', multiSort: true, halign: "center",width:120,sortable: true },
                    { field: "companyCod", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        },
                        sortable: true
                    },
                    {field: "enShipNam", title: "船舶英文名称", multiSort: true,halign: "center",width:160,sortable: true }
                ]],
             onDblClickRow: function (index, data) {
             }
        });
        // 删除。
        $("#SbcShipDataRelToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {

                var selectData = $("#SbcShipDataRelDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                     $.ajax({
                         url: "../webresources/login/MappShipData/saveSbrShipDataRelSave",
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         data: $.toJSON(pam),
                         success: function(data) {       
                             $("#SbcShipDataRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subShipDataSearch(dgSelected[0].shipCod);
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
        function subShipDataSearch(codValue)
        {
            var schvalue= $("#SbcShipDataSubSearchbox1427420966140").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "CN_SHIP_NAM,SHIP_COD");
            $("#SbcShipDataSubDatagrid1427420966140").datagrid("load");
        }
        $("#SbcShipDataSubDatagrid1427420966140").datagrid({
            striped:true,
            url: "../webresources/login/SbcShipData/findSrcShipData",
            queryParams: subbuilder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            autoLoad:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            remoteSort:false,
            toolbar: "#SbcShipDataSubToolBar1427420966140",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "CN_SHIP_NAM", title: "船舶名称",  multiSort: true,  halign: "center", width:160,  sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {field: "SHIP_COD",title: '船舶代码',multiSort: true, halign: "center",width:120,sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    { field: "COMPANY_COD", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.COMPANY_NAM;
                        },
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCompanyByCompanyCod({
                                parentId: '#SbcShipDataSubDatagrid1427420966140',
                                textField:'COMPANY_COD',
                                fieldMapping: {companyCod: 'COMPANY_COD',cnCompanyNam:'CN_COMPANY_NAM'},
                                required: true                 
                            })
                        }, 
                        sortable: true
                    }
                ]],
             onDblClickRow: function (index, data) {
             }
        });
        
        var dgSub = $("#SbcShipDataSubDatagrid1427420966140");
        
        $("#SbcShipDataSubSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
            subShipDataSearch("");
        }});
        // 关联。
        $("#SbcShipDataSubToolBar1427420966140 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =dg.datagrid("getSelected");
            if(selectRow){
                var selectData =dgSub.datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/MappShipData/saveSbrShipDataRelSave",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#SbcShipDataRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subShipDataSearch(dgSelected[0].shipCod);
                            HdUtils.messager.bottomRight(data.message,'提示');
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择原港口！", "info");
                }
            }
            else{
                 $.messager.alert("提示", "请选择标准港口！", "info");
            }
            
        });
    });
</script>