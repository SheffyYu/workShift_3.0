<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:470px;">
        <div id="MappCargoKindToolBar1487120113348" style="padding-top: 0px;">
                <div style="float:left;">
                    <shiro:hasPermission name="webresources:login:MappCargoKind:add">
                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:MappCargoKind:update">
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:MappCargoKind:delete">
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:MappCargoKind:save">
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="webresources:login:MappCargoKind:refresh">
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
                    </shiro:hasPermission>
                </div>
                <shiro:hasPermission name="webresources:login:MappCargoKind:searchbox">
                    <input class="easyui-searchbox" id="MappCargoKindSearchbox1487120113348"/>
                </shiro:hasPermission>
              
        </div>
          <table id="MappCargoKindDatagrid1487120113348" title="标准货类" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
        <div id="MappCargoKindRelToolBar1427420966140" style="padding-top: 0px;">
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>&nbsp;
            </div>
        </div>
         <table id="MappCargoKindRelDatagrid1427420966140" title="对应货类"  style="height:100%;"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:550px;">
        <div id="MappCargoKindSubToolBar1427420966140" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
<!--                        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> 
                        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a> -->
                </div>
                <input class="easyui-searchbox" id="MappCargoKindSubSearchbox1427420966140"/>
        </div>
        <table id="MappCargoKindSubDatagrid1427420966140" title="来源货类" style="height:100%"></table>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#MappCargoKindDatagrid1487120113348");
        // buttons
        // 增加。
        $("#MappCargoKindToolBar1487120113348 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd",{'abandonedMark':'1','sysMark':'1'}); 
        });
        // 编辑。
        $("#MappCargoKindToolBar1487120113348 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'cargoKindCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#MappCargoKindToolBar1487120113348 a[iconCls='icon-remove']").on("click", function() {
             dg.datagrid("hdRealRemove", {url: "../webresources/login/cargokind/save"});
        });
        // 保存。
        $("#MappCargoKindToolBar1487120113348 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/cargokind/save"});
        });
        // 刷新。
        $("#MappCargoKindToolBar1487120113348 a[iconCls='icon-reload']").on("click", function() {
            var value=$("#MappCargoKindSearchbox1487120113348").val();
            builder.set("q", value);
            builder.setOrderByClause("cargoKindCod","desc");
            dg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cargoKindCod","desc");
        $("#MappCargoKindSearchbox1487120113348").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cargoKindCod,cargoKindNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#MappCargoKindDatagrid1487120113348").datagrid({
            striped:true,
            url: "/webresources/login/cargokind/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            sortOrder: 'desc',
            sortName: 'cargoKindNam',//updTimestamp
            remoteSort:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:true,
            rownumbers: true,
            toolbar: "#MappCargoKindToolBar1487120113348",
            fit: true,
            fitColumns: false,
            columns: [[
				{
				    field: "ck",
					    checkbox: true
				},
				{
				    field: "cargoKindId",
				    title: '货类代码ID',
				    multiSort: true,
				    halign: "center",
				    sortable: true,
				    hidden: true
				},
				{
				    field: "cargoKindCod",
				    title: '<font color="red">货类代码</font>',
				    multiSort: true,
				    halign: "center",
				    width:80,
				    editor: {type: "uppercasebox", options: {required:true, validType: ['isCodeRepeat["MappCargoKindDatagrid1487120113348","SbcCargoKind","cargoKindCod"]','length[1,10]']}},
				    sortable: true
				},
				{
				    field: "cargoKindNam",
				    title: '<font color="red">货类名称</font>',
				    multiSort: true,
				    halign: "center",
				    width:140,
				    editor: {type: "validatebox", options: {required:true,validType:'length[1,100]'}},
				    sortable: true
				},
				{
				    field: "description",
				    title: "备注/描述",
				    multiSort: true,
				    halign: "center",
				    width:180,
				    editor: {type: "validatebox", options: {required:false,validType:'length[0,1000]'}},
				    sortable: true,
				    hidden: true
				   
				},
				{
				    field: "insAccount",
				    title: "创建人",
				    multiSort: true,
				    halign: "center",
				    width:80,
				    sortable: true
				},
				{
				    field: "insTimestamp",
				    title: "创建时间",
				    multiSort: true,
				    halign: "center",
				    width:140,
				    formatter: HdUtils.formatter.datetime,
				    sortable: true
				}
                ]],
                onDblClickRow: function (index, data) {
                    dg.datagrid("hdEdit");
                    dg.datagrid('getEditor', {index: index, field: 'cargoKindCod'}).target.prop('disabled', true);
                },
                onSelect:function(rowIndex,rowData){
                    var relbuilder = new HdEzuiQueryParamsBuilder(); 
                    relbuilder.setAndClause("cargoKindCod",rowData.cargoKindCod,"=","and");
                     $("#MappCargoKindRelDatagrid1427420966140").datagrid({  
                         url: "../webresources/login/mappCargoKind/find", 
                         queryParams: relbuilder.build()}
                     );
                     $("#MappCargoKindSubSearchbox1427420966140").searchbox('setValue',rowData.cargoKindNam);
                     subCargoSearch(rowData.cargoKindCod);
                }
        });
        
        $("#MappCargoKindDatagrid1487120113348").datagrid("hdGetColumnNames");
        // datagrid
        $("#MappCargoKindRelDatagrid1427420966140").datagrid({
            striped:true,
            method: "POST",
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pagination: true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            toolbar: "#MappCargoKindRelToolBar1427420966140", 
            remoteSort:false,
            fit: true,
            fitColumns: false,
            columns: [[ 
                    {field: "ck",checkbox: true},
                    {
                        field: "cargoKindNam",
                        title: "货类名称",
                        multiSort: true,
                        width:120,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "srcCargoKindCod",
                        title: '源港口货类',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "cargoKindCod",
                        title: '标准货类',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: '作业公司',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        }
                    }
             ]],
             onDblClickRow: function (index, data) {
             }
        });
        // 删除。
        $("#MappCargoKindRelToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {

                var selectData = $("#MappCargoKindRelDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                     $.ajax({
                         url: "../webresources/login/cargokind/saveSbrCargoKindRelSave",
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         data: $.toJSON(pam),
                         success: function(data) {       
                             $("#MappCargoKindRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subCargoSearch(dgSelected[0].cargoKindCod);
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
        function subCargoSearch(codValue)
        {
            var schvalue= $("#MappCargoKindSubSearchbox1427420966140").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "CARGO_KIND_NAM,CARGO_KIND_COD");
            $("#MappCargoKindSubDatagrid1427420966140").datagrid("load");
        }
        $("#MappCargoKindSubDatagrid1427420966140").datagrid({
            striped:true,
            url: "../webresources/login/cargokind/findSrcCargoKind",
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
            pageSize: 20,
            remoteSort:false,
            toolbar: "#MappCargoKindSubToolBar1427420966140",
            fit: true,
            fitColumns: false,
           
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "CARGO_KIND_NAM", title: "货类名称",  multiSort: true,  halign: "center", width:160,  sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {field: "CARGO_KIND_COD",title: '货类代码',multiSort: true, halign: "center",width:120,sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    { field: "COMPANY_COD", title:'作业公司', multiSort: true, halign: "center",width:120,
                        formatter: function (value, row, index) {
                            return row.COMPANY_NAM;
                        },
                        editor: {type: 'combogrid',
                            options: HdUtils.code.sbcCompanyByCompanyCod({
                                parentId: '#MappCargoKindSubDatagrid1427420966140',
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
        
        var dgSub = $("#MappCargoKindSubDatagrid1427420966140");
        
        $("#MappCargoKindSubSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
            subCargoSearch("");
        }});
        // buttons
/*         // 增加。
        $("#MappCargoKindSubToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dgSub.datagrid("hdAdd");
        });
        // 编辑。
        $("#MappCargoKindSubToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dgSub.datagrid("hdEdit");
        });
        // 删除。
        $("#MappCargoKindSubToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
            dgSub.datagrid("hdRealRemove", {url: "../webresources/login/SbcPort/saveSbrPort"});
        });
        // 保存。
        $("#MappCargoKindSubToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dgSub.datagrid("hdSave", {url: "../webresources/login/SbcPort/saveSbrPort"});
        });
        // 刷新。
        $("#MappCargoKindSubToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
            subCargoSearch();
        }); */
        // 关联。
        $("#MappCargoKindSubToolBar1427420966140 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =dg.datagrid("getSelected");
            if(selectRow){
                var selectData =dgSub.datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/SbcPort/saveSbrCargoKindRelSave",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#MappCargoKindRelDatagrid1427420966140").datagrid("load");
                             var dgSelected = dg.datagrid("getChecked");
                             subCargoSearch(dgSelected[0].cargoKindCod);
                            HdUtils.messager.bottomRight(data.message,'提示');
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择来源货类！", "info");
                }
            }
            else{
                 $.messager.alert("提示", "请选择标准货类！", "info");
            }
            
        });
    });
</script>