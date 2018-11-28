<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" style="width: 100%; height: 100%;" data-options="fit:true">
    <div data-options="region:'west',split:true" style="width:490px;">
	    <div id="SbcCntrCorpToolBar1487052014398" style="padding-top: 0px;">
		    <div style="float:left;">
		        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:add">
		            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:update">
		            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:delete">
		            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:save">
		            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
		        </shiro:hasPermission>
		        <shiro:hasPermission name="webresources:sys:SbcCntrCorp:refresh">
		            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
		        </shiro:hasPermission>
		             &nbsp;
		    </div>
		    <input class="easyui-searchbox" id="SbcCntrCorpSearchbox1487052014398"/>
	    </div>
        <table id="SbcCntrCorpDatagrid1487052014398" title="标准箱公司" style="height:100%"></table>
    </div>
    <div data-options="region:'center',split:true">
    
        <div id="SbcCntrCorpRelToolBar1487052014398" >
            <div style="float:left;">
                 <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
            </div>
        </div>
         <table id="MappCntrCorpDatagrid1487052014398" title="对应箱公司"  style="height:100%"></table>
     </div>
    <div data-options="region:'east',split:true"   style="width:500px;">
        <div id="SbcCntrCorpSubToolBar1487052014398" style="padding-top: 0px;">
                 <div style="float:left;">
                        <a class="easyui-linkbutton" iconCls="icon-rel" plain="false">关联</a>
                </div>
                <input class="easyui-searchbox" id="SbcCntrCorpSubSearchbox1487052014398"/>
        </div>
        <table id="SbcCntrCorpSubDatagrid1487052014398" title="来源箱公司" style="height:100%"></table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
    	var ccdg = $("#SbcCntrCorpDatagrid1487052014398");
        // buttons
        // 增加。
        $("#SbcCntrCorpToolBar1487052014398 a[iconCls='icon-add']").on("click", function () {
        	ccdg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SbcCntrCorpToolBar1487052014398 a[iconCls='icon-edit']").on("click", function () {
        	ccdg.datagrid("hdEdit");
        	var selectIdx = ccdg.datagrid("options").hdCurrentRowIndex;
        	ccdg.datagrid('getEditor', {index: selectIdx, field: 'cntrCorpCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcCntrCorpToolBar1487052014398 a[iconCls='icon-remove']").on("click", function () {
            ccdg.datagrid("hdRealRemove", {url: "../webresources/login/SbcCntrCorp/save"});
        });
        // 保存。
        $("#SbcCntrCorpToolBar1487052014398 a[iconCls='icon-save']").on("click", function () {
            ccdg.datagrid("hdSave", {url: "../webresources/login/SbcCntrCorp/save"});
        });
        // 刷新。
        $("#SbcCntrCorpToolBar1487052014398 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#SbcCntrCorpSearchbox1487052014398").val();
        	builder.set("q", value);
        	ccdg.datagrid("load");
        });
        // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("cntrCorpId","desc");
        // 返回后台参数。
        // searchbox
        $("#SbcCntrCorpSearchbox1487052014398").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "cntrCorpCod,cnCntrCorpNam,enCntrCorpNam");
                ccdg.datagrid("load");
            }});
        // datagrid
        $("#SbcCntrCorpDatagrid1487052014398").datagrid({
        	striped:true,
            url: "../webresources/login/SbcCntrCorp/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:true,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            //autoLoad:false,
            sortOrder: 'desc',//按更新时间倒序
            sortName: 'updTimestamp',
            rownumbers: true,
            pageSize: 100,
            toolbar: "#SbcCntrCorpToolBar1487052014398",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
                    {
                        field: "cntrCorpId",
                        title: '<font color="red">箱公司ID</font>',
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "cntrCorpCod",
                        title: '<font color="red">箱公司代码</font>',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true,validType:['isCodeRepeat["SbcCntrCorpDatagrid1487052014398","SbcCntrCorp","cntrCorpCod"]','length[1,10]']}},
                        sortable: true
                    },
                    {
                        field: "cnCntrCorpNam",
                        title: "中文名称",
                        multiSort: true,
                        halign: "center",
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,100]'}},
                        sortable: true,
                        width: 140,
                    },
                    {
                        field: "enCntrCorpNam",
                        title: "英文名称",
                        multiSort: true,
                        halign: "center",
                        editor:{type:"uppercasebox",options:{required:false,validType: 'length[0,100]'}},
                        sortable: true,
                        width: 180,
                    },
                    {
                        field: "tradeMark",
                        title: "贸易性质",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'TRADE_MARK', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({fieldCod: 'TRADE_MARK'}, {required: false})
                        },
                        sortable: true
                    },
                    /* {
                        field: "sysMark",
                        title: '系统标识',
                        multiSort: true,
                        align: "center",
                        width:80,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },  */
                    {
                        field: "abandonedMark",
                        title: "作废标志",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注/描述",
                        multiSort: true,
                        halign: "center",
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,1000]'}},
                        sortable: true,
                        width: 180,
                    },
                    {
                        field: "insAccount",
                        title: '创建人',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '创建时间',
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: '更新人',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: '更新时间',
                        multiSort: true,
                        halign: "center",
                        width:140,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                ]],
                onDblClickCell: function (index) {
                	ccdg.datagrid("hdEdit");
                	ccdg.datagrid('getEditor', {index: index, field: 'cntrCorpCod'}).target.prop('disabled', true);
                },
                onSelect:function(rowIndex,rowData){
    	            var builder = new HdEzuiQueryParamsBuilder(); 
    	            builder.setAndClause("cntrCorpCod",rowData.cntrCorpCod,"=","and");
    	             $("#MappCntrCorpDatagrid1487052014398").datagrid({  
    	                 url: "../webresources/login/MappCntrCorp/find", 
    	                 queryParams: builder.build()}
    	             );
    	             $("#SbcCntrCorpSubSearchbox1487052014398").searchbox('setValue',rowData.cnCntrCorpNam);
    	             subCntrCorpSearch(rowData.cntrCorpCod);
    	        }
        });
        $("#SbcCntrCorpDatagrid1487052014398").datagrid("hdGetColumnNames");
    	
        var dg = $("#MappCntrCorpDatagrid1487052014398");
        // buttons
       $("#SbcCntrCorpRelToolBar1487052014398 a[iconCls='icon-remove']").on("click", function () {
            var selectData = $("#MappCntrCorpDatagrid1487052014398").datagrid("getChecked");
            if(selectData&&selectData.length>0)
            {
                var pam={"mainRow":{},"subRow":selectData,'opt':'del'};
                 $.ajax({
                     url: "../webresources/login/SbcCntrCorp/saveMappCntrCorpRelSave",
                     type: "POST",
                     dataType: "json",
                     contentType: "application/json",
                     data: $.toJSON(pam),
                     success: function(data) {       
                         $("#MappCntrCorpDatagrid1487052014398").datagrid("load");
                         var ccdgSelected = ccdg.datagrid("getChecked");
                         subCntrCorpSearch(ccdgSelected[0].cntrCorpCod);
                        HdUtils.messager.bottomRight(data.message,'提示');
                     }
                 });
            }else{
                 $.messager.alert("提示", "请选择！", "info");
            }
        });
        // datagrid
        $("#MappCntrCorpDatagrid1487052014398").datagrid({
        	striped:true,
            //url: "../webresources/login/MappCntrCorp/find",
            queryParams: builder.build(),
            method: "POST",
            //pagination: true,
            sortOrder: 'desc',
            //autoLoad:false,
            sortName: 'updTimestamp',
            remoteSort:false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            pageList:[30,50,80,100,200],//当设置分页属性时，初始化页面的大小选择清单。默认
            pageSize: 100,
            rownumbers: true,
            //pageSize: 20,
            width:800,
            toolbar: "#SbcCntrCorpRelToolBar1487052014398",
            fit: true,
            fitColumns: false,
            columns: [[
					{
					    field: "ck",
					    checkbox: true
					},
					{
                        field: "cnCntrCorpNam",
                        title: "箱公司中文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,100]'}},
                        sortable: true
                    },
					 
                    {
                        field: "srcCntrCorpCod",
                        title: "原箱公司代码",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "uppercasebox", options: {required:true,validType: 'length[1,20]'}},
                        sortable: true
                    },
                    {
                        field: "cntrCorpCod",
                        title: "标准箱公司代码",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:'combogrid',
                        	options:HdUtils.code.sbcCntrCorp({
                        		required:true,
                        		parentId:"#MappCntrCorpDatagrid1487052014398",
                        		textField:'cntrCorpCod',
                        		fieldMapping: {
                        			cntrCorpCod : 'cntrCorpCod',
                        			cnCntrCorpNam : 'cnCntrCorpNam'
	                    		},
	                        	onSelect:function(index,record){
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'cnCntrCorpNam'
	                    			});
	                    			$(ed.target).val(record.cnCntrCorpNam);
	                    			var ed=dg.datagrid('getEditor', {
	                    				index : dg.datagrid("options").hdCurrentRowIndex,
	                    			    field : 'enCntrCorpNam'
	                    			});
	                    			$(ed.target).val(record.enCntrCorpNam);
	                    		}
                        	})
                        },
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: '作业公司',
                        multiSort: true,
                        halign: "center",                        
                        sortable: true,
                        width:120,
                        editor: {type: 'combogrid',
                        	options: HdUtils.code.sbcCompanyByCompanyCod({
                        		parentId: '#MappCntrCorpDatagrid1487052014398',
                        		textField:'COMPANY_COD',
                        		fieldMapping: {
                        			companyCod: 'COMPANY_COD',
                        			cnCompanyNam:'CN_COMPANY_NAM'
                        			},
                        			required: true                 
                            })
                        },
                        formatter: function (value, row, index) {
                            return row.cnCompanyNam;
                        },
                    },
                    {
                        field: "enCntrCorpNam",
                        title: "箱公司英文名称",
                        multiSort: true,
                        halign: "center",
                        width:160,
                        editor: {type: "uppercasebox", options: {required:false,validType: 'length[0,100]'}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        hidden:true,
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "创建时间",
                        multiSort: true,
                        halign: "center",
                        width:140,
                        hidden:true,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        hidden:true,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        width:140,
                        hidden:true,
                        formatter: $.hd.ezui.formatter.datetime,
                        sortable: true
                    }
                ]],
           });
        $("#MappCntrCorpDatagrid1487052014398").datagrid("hdGetColumnNames");
        var subbuilder = new HdEzuiQueryParamsBuilder();
        function subCntrCorpSearch(codValue)
        {
            var schvalue= $("#SbcCntrCorpSubSearchbox1487052014398").searchbox('getValue');
            subbuilder.set("q", schvalue);
            subbuilder.set("qValue",codValue);
            subbuilder.set("queryColumns", "CN_CNTR_CORP_NAM,CNTR_CORP_COD");
            $("#SbcCntrCorpSubDatagrid1487052014398").datagrid("load");
        }
        $("#SbcCntrCorpSubDatagrid1487052014398").datagrid({
            striped:true,
            url: "../webresources/login/SbcCntrCorp/findSrcCntrCorp",
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
            toolbar: "#SbcCntrCorpSubToolBar1487052014398",
            fit: true,
            fitColumns: false,
            columns: [[ 
                    {
    					field: "ck",
    					checkbox: true
					},
                    {
                        field: "CNTR_CORP_ID",
                        title: '<font color="red">guID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        hidden: true
                    },
                    {
                        field: "CN_CNTR_CORP_NAM",
                        title: "箱公司名称",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        editor:{type:"validatebox",options:{required:false,validType: 'length[0,60]'}},
                        sortable: true
                    },
                    
                    {
                        field: "CNTR_CORP_COD",
                        title: '箱公司代码',
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor:{type:"uppercasebox",options:{required:true,validType: 'length[1,40]'}},
                        sortable: true
                    },
                    {
                        field: "COMPANY_NAM",
                        title: '作业公司',
                        multiSort: true,
                        halign: "center",
                        sortable: true,
                        width:120,
                        /* editor: {type: 'combogrid',
                        	options: HdUtils.code.sbcCompanyByCompanyCod({
                        		parentId: '#SbcCustomerSubDatagrid1494818191170',
                        		textField:'COMPANY_COD',
                        		fieldMapping: {
                        			companyCod: 'COMPANY_COD',
                        			cnCompanyNam:'CN_COMPANY_NAM'
                        			},
                        			required: true                 
                            })
                        }, 
                        formatter: function (value, row, index) {
                            return row.company_nam;
                        }, */
                    }
              ]],
        });
       
        
        $("#SbcCntrCorpSubSearchbox1487052014398").searchbox({prompt: "请输入...", searcher: function(value, name) {
        	subCntrCorpSearch("");
        }});
        // 关联。
        $("#SbcCntrCorpSubToolBar1487052014398 a[iconCls='icon-rel']").on("click", function() {
            
            var selectRow =ccdg.datagrid("getSelected");
            if(selectRow){
                var selectData =$("#SbcCntrCorpSubDatagrid1487052014398").datagrid("getChecked");
                if(selectData&&selectData.length>0)
                {
                    var pam={"mainRow":selectRow,"subRow":selectData,'opt':'add'};
                    $.ajax({
                        url: "../webresources/login/SbcCntrCorp/saveMappCntrCorpRelSave",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        data: $.toJSON(pam),
                        success: function(data) {       
                             $("#MappCntrCorpDatagrid1487052014398").datagrid("load");
                             var ccdgSelected = ccdg.datagrid("getChecked");
                             subCntrCorpSearch(ccdgSelected[0].cntrCorpCod);
                            HdUtils.messager.bottomRight(data.message,'提示');
                        }
                    });
                }else{
                     $.messager.alert("提示", "请选择原箱公司！", "info");
                }
            }
            else{
                 $.messager.alert("提示", "请选择标准箱公司！", "info");
            }
            
        });
    });
</script>