<meta charset="UTF-8">
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:480px;">
        <div id="SbcPlanPortSubToolBar1427420966140" style="padding-top: 0px;">
             <div style="float:left;">
                     <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                     <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                     <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                     <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a> 
                     <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
             </div>
             <input class="easyui-searchbox" id="SbcPlanPortSubSearchbox1427420966140"/>
        </div>
        <table id="SbcPlanPortSubDatagrid1427420966140" title="流向" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcPlanPortRelToolBar1427420966140" style="padding-top: 0px;">
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
        </div>
         <table id="SbcPlanPortRelDatagrid1427420966140" title="对应港口"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:500px;">
        <div id="SbcBasePortToolBar1427420966140" style="padding-top: 0px;">
             <div style="float:left;">
				  <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
                  <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
             </div>
			<input class="easyui-searchbox" id="SbcPlanPortSearchbox1427420966140"/>
        </div>
        <table id="SbcPlanPortDatagrid1427420966140" title="标准港口" style="height:100%"></table>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        
       
        // buttons

        // 刷新。
        $("#SbcBasePortToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
            var value=$("#SbcPlanPortSearchbox1427420966140").val();
            builder.set("q", value);
            builder.setOrderByClause("portCod","desc");
            $("#SbcPlanPortDatagrid1427420966140").datagrid("load");
        });
        
        // 关联。
        $("#SbcBasePortToolBar1427420966140 a[iconCls='icon-rel']").on("click", function() {
        	var dg = $("#SbcPlanPortSubDatagrid1427420966140");
            var selectRow =dg.datagrid("getSelected");
            if(selectRow){
                var selectData =$("#SbcPlanPortDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/mappPlanPort/saveMappPlanPort",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                            $("#SbcPlanPortRelDatagrid1427420966140").datagrid("load");
                            HdUtils.messager.bottomRight(data.message,'提示');
                            $("#SbcPlanPortDatagrid1427420966140").datagrid("load");
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择原港口！", "info");
                }
            }
            else{
                 $.messager.alert("提示", "请选择流向！", "info");
            }
            
        });
        
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("portCod","desc");
        $("#SbcPlanPortSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "PORT_COD,EN_PORT_NAM,CN_PORT_NAM,SHORT_NAM");
                $("#SbcPlanPortDatagrid1427420966140").datagrid("load");
                
            }});
        // datagrid
        $("#SbcPlanPortDatagrid1427420966140").datagrid({
            striped:true,
            url: "/webresources/login/SbcPort/findMapPort",
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
            toolbar: "#SbcBasePortToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[
                    { field: "ck", checkbox: true},
                    { field: "PORT_COD",  title: '代码',  multiSort: true, halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcPlanPortDatagrid1427420966140","SbcPort","PortCod"]','length[1,5]']}},
                        sortable: true
                    },   
                    { field: "CN_PORT_NAM", title: "名称",multiSort: true,  width:120,halign: "center",
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    {field: "SHORT_NAM",title: "港口简称", multiSort: true, halign: "center",  width:80,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,20]'}},
                        sortable: true
                    },
                    {field: "EN_PORT_NAM", title: "英文名称",multiSort: true, width:120,  halign: "center",
                        editor: {type: "uppercasebox", options: {required: false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    { field: "COUNTRY_COD",title: "国家代码", multiSort: true, width:80,halign: "center",
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.sbcCountry({
                                parentId: '#SbcPlanPortDatagrid1427420966140',width: 80,
                                fieldMapping: {countryCod: 'countryCod',cnCountryNam: 'cnCountryNam'},
                                required: false
                            })
                        },
                        sortable: true
                    },                                            
                    {field: "DESCRIPTION", title: "备注", multiSort: true, halign: "center",   width:100,
                        editor: {type: "validatebox", options: {required: false,validType: 'length[0,1000]'}},
                        sortable: true
                    }
                ]],
                onDblClickRow: function (index, data) {
                },
                onSelect:function(rowIndex,rowData){
    
                }
        });

        var relPam={};
        relPam.planPort="";
        // datagrid
        $("#SbcPlanPortRelDatagrid1427420966140").datagrid({
            striped:true,
            method: "POST",
            url: "../webresources/login/mappPlanPort/findMappPlanPort", 
            queryParams: relPam,
            //pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            autoLoad:false,
            rownumbers: true,
            toolbar: "#SbcPlanPortRelToolBar1427420966140", 
            remoteSort:false,
            fit: true,
            fitColumns: false,
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "PORT_COD", title: "港口名称",  multiSort: true,  halign: "center", width:120,  sortable: true },
                    {field: "PORT_NAM",title: '原港口代码',multiSort: true, halign: "center",width:100,sortable: true },
                    {field: "PLAN_PORT_COD", title: '流向代码', multiSort: true, halign: "center",width:120,sortable: true }
                ]],
             onDblClickRow: function (index, data) {
             }
        });
        // 删除。
        $("#SbcPlanPortRelToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {

                var selectData = $("#SbcPlanPortRelDatagrid1427420966140").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                     $.ajax({
                         url: "../webresources/login/mappPlanPort/saveMappPlanPort",
                         type: "POST",
                         dataType: "json",
                         contentType: "application/json",
                         data: $.toJSON(pam),
                         success: function(data) {       
                             $("#SbcPlanPortRelDatagrid1427420966140").datagrid("load");
                             HdUtils.messager.bottomRight(data.message,'提示');
                         }
                     });
                }else{
                     $.messager.alert("提示", "请选择！", "info");
                }
        });
       
        // 条件类。
        //var hdConditions = new HdConditions();
       
        var mainPam={};
        mainPam.port="";
        function subPlanPortSearch(codValue)
        {    
	        mainPam.port=codValue;
            $("#SbcPlanPortSubDatagrid1427420966140").datagrid("load");
        }
        $("#SbcPlanPortSubDatagrid1427420966140").datagrid({
            striped:true,
            url: "../webresources/login/SbcPlanPort/findPlanPort",
            queryParams:mainPam,
            method: "POST",
            pagination: false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            autoLoad:true,
            remoteSort:false,
            toolbar: "#SbcPlanPortSubToolBar1427420966140",
            fit: true,
            fitColumns: false,
            columns: [[ 
                    {field: "ck",checkbox: true},
                    { field: "PLAN_PORT_NAM", title: "流向名称",  multiSort: true,  halign: "center", width:120,  sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {field: "PLAN_PORT_COD",title: '代码',multiSort: true, halign: "center",width:80,sortable: true,
                         editor: {type: "validatebox", options: {required: false,validType: 'length[0,60]'}}
                    },
                    {
                    	field: "SHORT_NAM",title: '简称',multiSort: true, halign: "center",width:120,sortable: true,
                    	editor: {type: "validatebox", options: {required: false,validType: 'length[0,20]'}}
                    },
                    {field: "DESCRIPTION",title: '描述',multiSort: true, halign: "center",width:200,sortable: true,
                    	editor: {type: "validatebox", options: {required: false,validType: 'length[0,20]'}}
                    }
                   
                    
                ]],
             onDblClickRow: function (index, data) {
             },
             onSelect:function(rowIndex,rowData){
            	 relPam.planPort=rowData.PLAN_PORT_COD;
            	 $("#SbcPlanPortRelDatagrid1427420966140").datagrid("load");
             }
        });
        

        
        $("#SbcPlanPortSubSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
        	var schvalue= $("#SbcPlanPortSubSearchbox1427420966140").searchbox('getValue');
            subPlanPortSearch(schvalue);
        }});
     
        var dgSub = $("#SbcPlanPortSubDatagrid1427420966140");
        // buttons
         // 增加。
          $("#SbcPlanPortSubToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
              dgSub.datagrid("hdAdd");
          });
          // 编辑。
          $("#SbcPlanPortSubToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
              dgSub.datagrid("hdEdit");
          });
          // 删除。
          $("#SbcPlanPortSubToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
              dgSub.datagrid("hdRealRemove", {url: "../webresources/login/SbcPlanPort/savePlanPort"});
          });
          // 保存。
          $("#SbcPlanPortSubToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
              dgSub.datagrid("hdSave", {url: "../webresources/login/SbcPlanPort/savePlanPort"});
          });
          // 刷新。
          $("#SbcPlanPortSubToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
        	  subPlanPortSearch("");
          }); 
    });
</script>