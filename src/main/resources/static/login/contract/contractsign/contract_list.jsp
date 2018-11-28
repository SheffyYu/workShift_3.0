<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',split:true">
	<div id="ContractToolBarZhangdh201704241637" style="padding-top: 0px;">
	    <div style="float:left;">
	        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false" >刷新</a>
	        <input type="radio" id="radio201704241622fds" name="maintStat" checked ='checked'; value='RE' onclick="radio_click(this)"/>未签署
	        <input type="radio" id="radio201704241622" name="maintStat" value='ON' onclick="radio_click(this)"/>签署中
	        <input type="radio" id="radio201704241622" name="maintStat" value='ST' onclick="radio_click(this)"/>已终止签署 
	        &nbsp;
	    </div>
	    <input class="easyui-searchbox" id="ContractSearchBoxZhangdh201704241637"/>
	</div>
	<table id="ContractDatagridZhangdh201704241639" style="height:100%"></table>
	</div>
	<div data-options="region:'east',split:true" style="width: 330px;">
		<table id="ContractFileDatagrid201704241639"></table>
		<div id="ContractFileToolBar201704241639">
	    	<div style="float:left;padding: 0px;margin: 0px;">
		        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>、
		        <a class="easyui-linkbutton" id="download201704241639" plain="false">下载文件</a>
	    	</div>
	    	<input class="easyui-searchbox" id="ContractFileSearchbox201704241639"/>
		</div>
	</div>


<div id="ContractDialogZhangdh201704241637"   style="display:none"></div>
<div id="ContractFileDialog201704241639" class="easyui-dialog" data-options="closed:true" >
	<div id="showPdf201704241639" style="width:100%;height:100%;"></div>
</div>
<!-- end Datagrid -->
<!-- 脚本控制 -->
<script type="text/javascript">
	//获取登录的用户
	var oper=$.main.loginOper;
    var radioValue = "RE";
    var builder = new HdEzuiQueryParamsBuilder();

    var dg = $("#ContractDatagridZhangdh201704241639");
    var radio_click = function(obj) {
		radioValue = obj.value;
		var searchBuilder=new HdEzuiQueryParamsBuilder();
	    searchBuilder.setAndClause("contractSat",radioValue,"=","and");
	    if(oper.account != 'admin'){
		    searchBuilder.setAndClause("signatory",oper.account,"=","and");
	    }
 	    builder.hdEzuiQueryParams.hdConditions=searchBuilder.hdEzuiQueryParams.hdConditions;
    	dg.datagrid("hdReload");
    	loadFile();
	};
	function loadFile(){//重置文件页面
    	$("#ContractFileDatagrid201704241639").datagrid("loadData",{total: 0, rows: []});
    }
    $(document).ready(function () {
        var diog = $("#ContractDialogZhangdh201704241637");
        var dgContract = $("#ContractDatagridZhangdh201704241639");
        var searchBuilder=new HdEzuiQueryParamsBuilder();
        if(oper.account != 'admin'){
    	    searchBuilder.setAndClause("signatory",oper.account,"=","and");
        }
        var builderFile= new HdEzuiQueryParamsBuilder();//文件
	    searchBuilder.setAndClause("contractSat","RE","=","and");
 	    builder.hdEzuiQueryParams.hdConditions=searchBuilder.hdEzuiQueryParams.hdConditions;
        // buttons
        // 刷新。
        $("#ContractToolBarZhangdh201704241637 a[iconCls='icon-reload']").on("click", function () {
        	if(radioValue==null||radioValue=="") {
        		radioValue = "RE";
        	}
    		var searchBuilder=new HdEzuiQueryParamsBuilder();
  	    	searchBuilder.setAndClause("contractSat",radioValue,"=","and");
     	    builder.hdEzuiQueryParams.hdConditions=searchBuilder.hdEzuiQueryParams.hdConditions;
        	dg.datagrid("hdReload");
        	loadFile();
        });
        
        $("#ContractSearchBoxZhangdh201704241637").searchbox({prompt: "请输入...", searcher: function (value, name) {
            builder.set("q", value);
            builder.set("queryColumns", "contractNo,contractNam,signatory,signDepartment,signDat,remindDay,custom,companyCod,begDte,endDte,description");
            dg.datagrid("hdReload");
            loadFile();
        }});
        // datagrid
        $("#ContractDatagridZhangdh201704241639").datagrid({
        	striped:true,
            url: "../webresources/login/Contract/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            rownumbers: true,
            pageSize: 20,
            toolbar: "#ContractToolBarZhangdh201704241637",
            fit: true,
            fitColumns: false,
            frozenColumns:[[{
        		field: "ck",
        		checkbox: true
        	},
            {
                field: "contractId",
                title: '<font color="red"></font>',
                multiSort: true,
                hidden: true,
                halign: "center",
                sortable: true
            },
            {
                field: "contractNo",
                title: "合同编号",
                multiSort: true,
                halign: "center",
                width:80,
                sortable: true
            },
            {
                field: "contractNam",
                title: "名称",
                multiSort: true,
                halign: "center",
                width:180,
                sortable: true
            }]],
            columns: [[
                	
                    {
                        field: "contractTyp",
                        title: "合同类型",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:100,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_TYP', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "contractSat",
                        title: "合同状态",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:100,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "parenContract",
                        title: "主合同",
                        multiSort: true,
                        halign: "center",
                        width: 120,
                        sortable: true
                    },
                    {
                        field: "signatory",
                        title: "经办人",
                        multiSort: true,
                        halign: "center",
                        width:100,
                        formatter: function (value, row, index) {
                            return row.signatoryNam;
                        }, 
                        sortable: true
                    },
                    {
                        field: "signDepartment",
                        title: "签约部门",
                        multiSort: true,
                        width:100,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "signDat",
                        title: "签署日期",
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        width:100,
                        formatter:$.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "remindDay",
                        title: "超期提醒",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "custom",
                        title: "客户名称",
                        multiSort: true,
                        halign: "center",
                        width:180,
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: "公司名称",
                        multiSort: true,
                        halign: "center",
                        width:103,
                        sortable: true
                    },
                    {
                        field: "begDte",
                        title: "开始日期",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:100,
                        formatter:$.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "endDte",
                        title: "截止日期",
                        multiSort: true,
                        width:100,
                        align: "center",
                        formatter:$.hd.ezui.formatter.date,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "isArchive",
                        title: "是否归档",
                        multiSort: true,
                        hidden: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "内容描述",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: "记录人",
                        multiSort: true,
                        hidden: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "记录时间",
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        formatter:$.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        hidden: true,
                        formatter:$.hd.ezui.formatter.date,
                        sortable: true
                    }
                ]],
                onDblClickRow: function (rowIndex, rowData) {
					var dialogTitle;                	
                	if(radioValue == 'RE') {
                		dialogTitle = "未签署";
                	} else if(radioValue=="ON") {
                		dialogTitle = "签署中";
                	} else if(radioValue=="ST") {
                		dialogTitle = "已终止签署 ";
                	}
                    HdUtils.dialog3.show({height: 350,width:720, title: dialogTitle, href: "../login/contract/contractsign/contract_form_st.jsp"});
                    HdUtils.dialog3.setValue({data: rowData,dataGrid:dg});
                },
                onSelect:function(rowIndex,rowData){
                	builderFile=new HdEzuiQueryParamsBuilder();
                	builderFile.setAndClause("contractNo",rowData.contractNo,"=","and");//签署日期非空
                	$("#ContractFileDatagrid201704241639").datagrid("load",builderFile.build());
                }
                
  });
 		$("#ContractFileToolBar201704241639 a[iconCls='icon-reload']").on("click",function(){
 			var value=$("#ContractFileSearchbox201704241639").val();
        	builderFile.set("q", value);
        	$("#ContractFileDatagrid201704241639").datagrid("load");
        });
        $("#ContractFileSearchbox201704241639").searchbox({prompt: "请输入...", searcher: function (value, name) {
        	builderFile.set("q", value);
        	builderFile.set("queryColumns", "enclosureNam,version");
        	$("#ContractFileDatagrid201704241639").datagrid("load");
        }});
        //下载文件
        $("#download201704241639").on("click",function(){
        	var selectRow=$("#ContractFileDatagrid201704241639").datagrid("getSelected");
        	if(selectRow){
        		var url=selectRow.enclosureUrl;
        		window.location.href=url;
        	}else{
        		$.messager.alert("提示","请先选择一个文件再进行下载！");
        	}
        });
        $("#ContractFileDatagrid201704241639").datagrid({
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
            toolbar: "#ContractFileToolBar201704241639",
            fit: true,
            fitColumns: true,
            columns: [[
					{
					    field: "enclosureUrl",
					    title: "文件url",
					    multiSort: true,
					    halign: "center",
					    hidden:true,
					    width:100,
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
                onDblClickRow: function (rowIndex, rowData) {
                	var url=rowData.enclosureUrl;
            		var doc=url.substring(url.lastIndexOf("."));
           		   	if(doc==".doc"||doc==".docx"){
               		  	var src=url.substring(0,url.lastIndexOf("."))+".pdf";
               		   	var html="<embed id=\"pdfPlayer\" src=\""+src+"\" type=\"application/pdf\" width=\"100%\" height=\"99%\" >";
               		   	$("#showPdf201704241639").html(html);
                   	}else{
                   		var src=url;
               		   	var html="<img id=\"pdfPlayer\" src=\""+src+"\" >";
               		   	$("#showPdf201704241639").html(html);
                   	}
                	$("#ContractFileDialog201704241639").dialog({
                		title:'文件内容显示',
                		width:870,
                		height:620,
                		closed:false,
                		buttons:[{
                			text:'关闭',
                			handler:function(){
                				$("#ContractFileDialog201704241639").dialog({closed:true});
                			}
                		}] 
                	});
                	
                }
        });
});
</script>


