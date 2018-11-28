<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:470px;">
        <div id="SbcPortToolBar1427420966140" style="padding-top: 0px;">
                <div style="float:left;">
                    <shiro:hasPermission name="webresources:login:SbcPort:add">
                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcPort:update">
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcPort:delete">
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcPort:save">
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:SbcPort:refresh">
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
                    </shiro:hasPermission>
                </div>
                <shiro:hasPermission name="webresources:login:SbcPort:searchbox">
                    <input class="easyui-searchbox" id="SbcPortSearchbox1427420966140"/>
                </shiro:hasPermission>
              
        </div>
          <table id="SbcPortDatagrid1427420966140" title="标准港口" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcPortRelToolBar1427420966140" style="padding-top: 0px;">
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
          <!--   <input class="easyui-searchbox" id="SbcPortRelSearchbox1427420966140"/> -->
        </div>
         <table id="SbcPortRelDatagrid1427420966140" title="对应港口"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:500px;">
        <div id="SbcPortSubToolBar1427420966140" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
<!--                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> 
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> -->
                </div>
                <input class="easyui-searchbox" id="SbcPortSubSearchbox1427420966140"/>
        </div>
        <table id="SbcPortSubDatagrid1427420966140" title="来源港口" style="height:100%"></table>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcPortDatagrid1427420966140");
        var dgSbcPortRel= $("#SbcPortRelDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SbcPortToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd",{'abandonedMark':'1','sysMark':'1'}); 
        });
        // 编辑。
        $("#SbcPortToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'portCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcPortToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
             dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcPort/save"});
        });
        // 保存。
        $("#SbcPortToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcPort/save"});
        });
        // 刷新。
        $("#SbcPortToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
            var value=$("#SbcPortSearchbox1427420966140").val();
            builder.set("q", value);
            builder.setOrderByClause("portCod","desc");
            dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("portCod","desc");
        $("#SbcPortSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "portCod,enPortNam,cnPortNam,shortNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcPortDatagrid1427420966140").datagrid({
            striped:true,
            url: "/webresources/login/SbcPort/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            sortOrder: 'desc',
            sortName: 'cnPortNam',//updTimestamp
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:true,
            rownumbers: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            toolbar: "#SbcPortToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
                    { field: "ck", checkbox: true},
                    { field: "portCod",  title: '代码',  multiSort: true, halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcPortDatagrid1427420966140","SbcPort","portCod"]','length[1,5]']}},
                        sortable: true
                    },   
                    { field: "cnPortNam", title: "名称",multiSort: true,  width:120,halign: "center",
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    {field: "shortNam",title: "港口简称", multiSort: true, halign: "center",  width:80,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,20]'}},
                        sortable: true
                    },
                    {field: "enPortNam", title: "英文名称",multiSort: true, width:120,  halign: "center",
                        editor: {type: "uppercasebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    { field: "countryCod",title: "国家代码", multiSort: true, width:80,halign: "center",
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.sbcCountry({
                                parentId: '#SbcPortDatagrid1427420966140',width: 80,
                                fieldMapping: {countryCod: 'countryCod',cnCountryNam: 'cnCountryNam'},
                                required: false
                            })
                        },
                        sortable: true
                    },                                            
                    {field: "description", title: "备注", multiSort: true, halign: "center",   width:100,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}},
                        sortable: true
                    },
                    { field: "insAccount", title: "创建人",multiSort: true, halign: "center", width:80,sortable: true},
                    { field:"insTimestamp", title:"创建时间", multiSort:true, halign:"center", formatter: $.hd.ezui.formatter.datetime, width:140,sortable:true}
                ]],
                onDblClickRow: function (index, data) {
                    dg.datagrid("hdEdit");
                    dg.datagrid('getEditor', {index: index, field: 'portCod'}).target.prop('disabled', true);
                },
                onSelect:function(rowIndex,rowData){
                    var relbuilder = new HdEzuiQueryParamsBuilder(); 
                    relbuilder.setAndClause("portCod",rowData.portCod,"=","and");
                     $("#SbcPortRelDatagrid1427420966140").datagrid({  
                         url: "../webresources/login/mappport/find", 
                         queryParams: relbuilder.build()}
                     );
                     $("#SbcPortSubSearchbox1427420966140").searchbox('setValue',rowData.cnPortNam);
                     subPortSearch(rowData.portCod);
                }
        });
        var relbuilder = new HdEzuiQueryParamsBuilder();
      
        	$("#SbcPortRelSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
        		  var selectRow = $("#SbcPortDatagrid1427420966140").datagrid("getSelected");
        		  var relbuilder = new HdEzuiQueryParamsBuilder();
        		  if( selectRow!=null){
        			  relbuilder.setAndClause("portCod",selectRow.portCod,"=","and");
        	      } 
        		  relbuilder.set("q", value);
        	      relbuilder.set("queryColumns", "cnPortNam,srcPortCod,portCod,enPortNam")
        	      $("#SbcPortRelDatagrid1427420966140").datagrid({  
                      url: "../webresources/login/mappport/find", 
                      queryParams: relbuilder.build()}
                  );
            }});
        
        
        $("#SbcPortDatagrid1427420966140").datagrid("hdGetColumnNames");
        // datagrid
        $("#SbcPortRelDatagrid1427420966140").datagrid({
            striped:true,
            method: "POST",
            url: "../webresources/login/mappport/find", 
            queryParams: relbuilder.build(),
            //pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            autoLoad:false,
            rownumbers: true,
            toolbar: "#SbcPortRelToolBar1427420966140", 
            remoteSort:false,
            fit: true,
//             pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
//             pageSize: 100,
            fitColumns: false,
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "cnPortNam", title: "港口名称",  multiSort: true,  halign: "center", width:120,  sortable: true },
                    {field: "srcPortCod",title: '原港口代码',multiSort: true, halign: "center",width:100,sortable: true },
                    {field: "portCod", title: '标准港口代码', multiSort: true, halign: "center",width:120,sortable: true },
                    { field: "companyCod", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        },
                        sortable: true
                    },
                    {field: "enPortNam", title: "港口英文名称", multiSort: true,halign: "center",width:160,sortable: true }
                ]],
             onDblClickRow: function (index, data) {
             }
        });
        // 删除。
        $("#SbcPortRelToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {

                var selectData = $("#SbcPortRelDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                     $.ajax({
                         url: "../webresources/login/SbcPort/saveSbrPortRelSave",
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         data: $.toJSON(pam),
                         success: function(data) {       
                             $("#SbcPortRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subPortSearch(dgSelected[0].portCod);
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
        function subPortSearch(codValue)
        {
            var schvalue= $("#SbcPortSubSearchbox1427420966140").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "C_PORT_NAM,PORT_COD");
            $("#SbcPortSubDatagrid1427420966140").datagrid("load");
        }
        $("#SbcPortSubDatagrid1427420966140").datagrid({
            striped:true,
            url: "../webresources/login/SbcPort/findSrcPort",
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
            toolbar: "#SbcPortSubToolBar1427420966140",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "C_PORT_NAM", title: "港口名称",  multiSort: true,  halign: "center", width:160,  sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {field: "PORT_COD",title: '港口代码',multiSort: true, halign: "center",width:120,sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    { field: "COMPANY_COD", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.COMPANY_NAM;
                        },
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCompanyByCompanyCod({
                                parentId: '#SbcPortSubDatagrid1427420966140',
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
        
        var dgSub = $("#SbcPortSubDatagrid1427420966140");
        
        $("#SbcPortSubSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
            subPortSearch("");
        }});
        // buttons
/*         // 增加。
        $("#SbcPortSubToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dgSub.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcPortSubToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dgSub.datagrid("hdEdit");
        });
        // 删除。
        $("#SbcPortSubToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
            dgSub.datagrid("hdRealRemove", {url: "../webresources/login/SbcPort/saveSbrPort"});
        });
        // 保存。
        $("#SbcPortSubToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dgSub.datagrid("hdSave", {url: "../webresources/login/SbcPort/saveSbrPort"});
        });
        // 刷新。
        $("#SbcPortSubToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
            subPortSearch();
        }); */
        // 关联。
        $("#SbcPortSubToolBar1427420966140 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =dg.datagrid("getSelected");
            if(selectRow){
                var selectData =dgSub.datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/SbcPort/saveSbrPortRelSave",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#SbcPortRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subPortSearch(dgSelected[0].portCod);
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