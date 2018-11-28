<meta charset="UTF-8">
<!-- 	<div data-options="region:'west',split:true" style="width:100%;"> -->
		<div id="SbcPortToolBar14274111140" style="padding-top: 0px;">
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
		        	<input class="easyui-searchbox" id="SbcPortSearchbox14271110"/>
		        </shiro:hasPermission>
		      
		</div>
		  <table id="SbcPortDatagrid1411114"  style="height:100%"></table>
<!-- 	</div> -->

<script type="text/javascript">
    $(document).ready(function() {
        var dg = $("#SbcPortDatagrid1411114");
        // buttons
        // 增加。
        $("#SbcPortToolBar14274111140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd",{'abandonedMark':'1','sysMark':'1'}); 
        });
        // 编辑。
        $("#SbcPortToolBar14274111140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
            var selectIdx = dg.datagrid("options").hdCurrentRowIndex;
            dg.datagrid('getEditor', {index: selectIdx, field: 'portCod'}).target.prop('disabled', true);
        });
        // 删除。
        $("#SbcPortToolBar14274111140 a[iconCls='icon-remove']").on("click", function() {
        	 dg.datagrid("hdRealRemove", {url: "../webresources/login/SbcPort/save"});
        });
        // 保存。
        $("#SbcPortToolBar14274111140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SbcPort/save"});
        });
        // 刷新。
        $("#SbcPortToolBar14274111140 a[iconCls='icon-reload']").on("click", function() {
        	var value=$("#SbcPortSearchbox14271110").val();
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
        $("#SbcPortSearchbox14271110").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "portCod,enPortNam,cnPortNam,shortNam");
                dg.datagrid("load");
            }});
        // datagrid
        $("#SbcPortDatagrid1411114").datagrid({
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
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SbcPortToolBar14274111140",
            fit: true,
            fitColumns: false,
            columns: [[
					{ field: "ck", checkbox: true},
                    { field: "portCod",  title: '代码',  multiSort: true, halign: "center",
                        width:80,
                        editor:{type:"uppercasebox",options:{required:true, validType: ['isCodeRepeat["SbcPortDatagrid1411114","SbcPort","portCod"]','length[1,5]']}},
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
                    { field: "countryCod",title: "国家", multiSort: true, width:80,halign: "center",
                        editor: {
                            type: 'combogrid',
                            options: HdUtils.code.sbcCountry({
                                parentId: '#SbcPortDatagrid1411114',width: 80,
                                fieldMapping: {countryCod: 'countryCod',cnCountryNam: 'cnCountryNam'},
                                required: false
                            })
                        },
                        formatter:function(val,row,idx){
                        	if(row.cnCountryNam!=null){
                        		return row.cnCountryNam;
                        	}else{
                        		return row.cnCountryNam;
                        	}
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
        });

    });
</script>