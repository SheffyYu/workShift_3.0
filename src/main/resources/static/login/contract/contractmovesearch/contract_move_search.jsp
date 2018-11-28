<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',split:true">
		<table id="ContractDatagrid20174271641" style="height:90%"></table>
		<div  id="ContractToolBar20174271641">
	        <div style="float:left;">
	                                   合同编号：<input id="contractNo20174271641" data-options="required:false" style="width:100px" class="easyui-validatebox"/>
			            转出时间：<input id="outDate20174271641" data-options="required:false" style="width:100px" class="easyui-datebox"/>
			            转入时间：<input id="inDate20174271641" data-options="required:false" style="width:100px" class="easyui-datebox"/>
			    <a class="easyui-linkbutton"  id="search20174271641" style="width:55px">查询</a>
	        </div> 
	       <input class="easyui-searchbox" id="ContractMoveSearchbox20174271641"/>
		</div> 
	</div>
	<div data-options="region:'east',split:true" style="width: 330px;">
		<table id="ContractFileDatagrid20174271641"></table>
		<div id="ContractFileToolBar20174271641">
	    	<div style="float:left;padding: 0px;margin: 0px;">
		        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	    	</div>
	    	<input class="easyui-searchbox" id="ContractFileSearchbox20174271641"/>
		</div>
<!-- 		<div data-options="region:'center',split:true,collapsible:false,border:true">
			<table id="ContractDatagrid20174271641" style="height:80%"></table>
	    </div>
	    <div data-options="region:'east',split:true,border:true" style="width: 330px;">
	
		    <table id="ContractFileDatagrid20174271641"></table>
		</div> -->
	</div>
</div>
<div id="ContractDialog20174271641"   style="display:none"></div>
<div id="ContractFileDialog20174271641" class="easyui-dialog" data-options="closed:true" >
	<div id="showPdf20174271641" style="width:100%;height:100%;"></div>
</div>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(function () {
    	function loadFile(){//重置文件页面
        	$("#ContractFileDatagrid20174271641").datagrid("loadData",{total: 0, rows: []});
        }
        $("#search20174271641").on("click", function () {
        	var builder20174271641 = new HdEzuiQueryParamsBuilder();
        	if($("#contractNo20174271641").val() != ""){
        		builder20174271641.setAndClause("contractNo", "%"+$("#contractNo20174271641").val()+"%", "like", "and");
            }
        	if($("#outDate20174271641").datebox("getValue") != ""){
        		builder20174271641.setAndClause("outDate",$("#outDate20174271641").datebox("getValue")+" 00:00:00", ">=","and");
     	    }
        	if($("#outDate20174271641").datebox("getValue") != ""){
        		builder20174271641.setAndClause("outDate",$("#outDate20174271641").datebox("getValue")+" 23:59:59", "<=","and");
     	    }
        	if($("#inDate20174271641").datebox("getValue") != ""){
        		builder20174271641.setAndClause("inDate",$("#inDate20174271641").datebox("getValue")+" 00:00:00", ">=","and");
     	    }
        	if($("#inDate20174271641").datebox("getValue") != ""){
        		builder20174271641.setAndClause("inDate",$("#inDate20174271641").datebox("getValue")+" 23:59:59", "<=","and");
     	    }
        	builder.hdEzuiQueryParams.hdConditions=builder20174271641.hdEzuiQueryParams.hdConditions;
        	$("#ContractDatagrid20174271641").datagrid("hdReload");
        	loadFile();
        });
        // datagrid
        var builder = new HdEzuiQueryParamsBuilder();
        $("#ContractMoveSearchbox20174271641").searchbox({prompt: "请输入...", searcher: function(value, name) {
            builder.set("q", value);
            builder.set("queryColumns", "contractNo,contractNam");
            $("#ContractDatagrid20174271641").datagrid("load");
            loadFile();
        }});
        $("#ContractDatagrid20174271641").datagrid({
        	striped:true,
        	url: "../webresources/login/ContractMove/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            pageSize: 20,
            toolbar: "#ContractToolBar20174271641",
            fit: true,
            fitColumns: false,
            frozenColumns:[[
				{
				    field: "moveId",
				    title: '<font color="red">转移ID</font>',
				    multiSort: true,
				    halign: "center",
				    hidden:true,
				    sortable: true
				},
				{
				    field: "contractNo",
				    title: '合同编号',
				    multiSort: true,
				    halign: "center",
				    width:100,
				    sortable: true
				},
				{
				    field: "contractNam",
				    title: '合同名称',
				    multiSort: true,
				    halign: "center",
				    width:180,
				    sortable: true
				}          
            ]],
            columns: [[
                    {
                        field: "contractStat",
                        title: '合同状态',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        width:80,
                        sortable: true
                    },
                    {
                        field: "outDate",
                        title: '转出时间',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "outAccount",
                        title: '转出账户',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "outDepartment",
                        title: '转出部门',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "inDate",
                        title: "转入时间",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "inAccount",
                        title: '转入账户',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "inDepartment",
                        title: '转入部门',
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "转移说明",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        sortable: true
                    },
                ]],
                onSelect:function(rowIndex, rowData){
                	builderFile=new HdEzuiQueryParamsBuilder();
                	builderFile.setAndClause("contractNo",rowData.contractNo,"=","and");//签署日期非空
                	$("#ContractFileDatagrid20174271641").datagrid("load",builderFile.build());
                }
  	});
        var builderFile = new HdEzuiQueryParamsBuilder();
        $("#ContractFileToolBar20174271641 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#ContractFileSearchbox20174271641").val();
        	builderFile.set("q", value);
        	$("#ContractFileDatagrid20174271641").datagrid("load");
        });
        $("#ContractFileSearchbox20174271641").searchbox({prompt: "请输入...", searcher: function (value, name) {
        	builderFile.set("q", value);
        	builderFile.set("queryColumns", "enclosureNam,version");
        	$("#ContractFileDatagrid20174271641").datagrid("load");
        }});
        $("#ContractFileDatagrid20174271641").datagrid({
        	striped:true,
        	url: "/webresources/login/ContractFile/find",
            queryParams: builderFile.build(),
            method: "POST",
            pagination: false,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            autoLoad:false,
            pageSize: 20,
            toolbar: "#ContractFileToolBar20174271641",
            fit: true,
            fitColumns: true,
            columns: [[
					{
					    field: "enclosureUrl",
					    title: "文件url",
					    multiSort: true,
					    halign: "center",
					    hidden:true,
					    width:80,
					    sortable: true
					},
                    {
                        field: "enclosureNam",
                        title: "文件名称",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        sortable: true
                    },
                    {
                        field: "version",
                        title: "版本",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:40,
                        sortable: true
                    },
                    {
                        field: "fileSource",
                        title: "文件来源",
                        multiSort: true,
                        halign: "center",
                        width:60,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'FILE_SOURCE', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }, 
                        sortable: true
                    },
                    {
                        field: "fileState",
                        title: "最新",
                        multiSort: true,
                        halign: "center",
                        width:40,
                        align:"center",
                        formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    },
                ]],
                onSelect: function (rowIndex, rowData) {
                	var url=rowData.enclosureUrl;
                	var doc=url.substring(url.lastIndexOf("."));
                	if(doc==".doc"||doc==".docx"){
            		  	var src=url.substring(0,url.lastIndexOf("."))+".pdf";
            		   	var html="<embed id=\"pdfPlayer\" src=\""+src+"\" type=\"application/pdf\" width=\"100%\" height=\"99%\" >";
            		   	$("#showPdf20174271641").html(html);
                	}else{
                		var src=url;
            		   	var html="<img id=\"pdfPlayer\" src=\""+src+"\" >";
            		   	$("#showPdf20174271641").html(html);
                	}
                	$("#ContractFileDialog20174271641").dialog({
                		title:'文件内容显示',
                		width:870,
                		height:620,
                		closed:false,
                		buttons:[{
                			text:'关闭',
                			handler:function(){
                				$("#ContractFileDialog20174271641").dialog({closed:true});
                			}
                		}] 
                	});
                	
                }
        });
});
</script>


