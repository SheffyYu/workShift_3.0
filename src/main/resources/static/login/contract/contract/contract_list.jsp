<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'center',split:true">
	<table id="ContractDatagrid1493016283337" style="height:90%"></table>
	<div style="padding-top:0px;" id="ContractToolBar1493016283337">
	    <div style="float:left;">
	       <input type="radio" id="yishengxiao1487062340496" name="HTleixing1474254766815" checked="true"> 已生效
	      
	       <input type="radio" id="yiqianshuweishengxiao1487062340496" name="HTleixing1474254766815"> 已签约未生效
	       
	       <input type="radio" id="yishixiao1487062340496" name="HTleixing1474254766815"> 已失效
	      
	       <input type="radio" id="hetongtixing1487062340496" name="HTleixing1474254766815"><font color="red">合同提醒</font>
	    </div>  
	    <input class="easyui-searchbox" id="Searchbox1487062340496"/>     
	</div> 
	</div>
	<div data-options="region:'east',split:true" style="width: 330px;">
		<table id="ContractFileDatagrid1487062340496"></table>
		<div id="ContractFileToolBar1487062340496">
	    	<div style="float:left;padding: 0px;margin: 0px;">
		        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
	    	</div>
	    	<input class="easyui-searchbox" id="ContractFileSearchbox1487062340496"/>
		</div>
	</div>
</div>
<div id="ContractDialog1487062340496"   style="display:none"></div>
<div id="ContractFileDialog1487062340496" class="easyui-dialog" data-options="closed:true" >
	<div id="showPdf1487062340496" style="width:100%;height:100%;"></div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
    	var dg = $("#ContractDatagrid1493016283337");
    	function loadFile(){//重置文件页面
        	$("#ContractFileDatagrid1487062340496").datagrid("loadData",{total: 0, rows: []});
        }
    	$("#yishengxiao1487062340496").on("click",function() {
        	var yishengxiaoBuilder=new HdEzuiQueryParamsBuilder();
        	yishengxiaoBuilder.setOtherskeyValue("contractSatwo","WO");
            dg.datagrid("load", yishengxiaoBuilder.build());
            loadFile();
        });
    	$("#yiqianshuweishengxiao1487062340496").on("click",function() {
        	var yiqianshuweishengxiaoBuilder=new HdEzuiQueryParamsBuilder();
        	yiqianshuweishengxiaoBuilder.setOtherskeyValue("contractSatonw","ONW");
        	dg.datagrid("load", yiqianshuweishengxiaoBuilder.build());
        	loadFile();
    	});
    	$("#yishixiao1487062340496").on("click",function() {
        	var yishixiao1487062340496=new HdEzuiQueryParamsBuilder();
        	yishixiao1487062340496.setOtherskeyValue("contractSatuw","UW");
            dg.datagrid("load", yishixiao1487062340496.build());
            loadFile();
        });
    	$("#hetongtixing1487062340496").on("click",function() {
    		var hetongtixing1487062340496=new HdEzuiQueryParamsBuilder();
    		hetongtixing1487062340496.setOtherskeyValue("contractSattixing","TIXING");
            dg.datagrid("load", hetongtixing1487062340496.build());
            loadFile();
        });
    	var builder = new HdEzuiQueryParamsBuilder();
    	$("#Searchbox1487062340496").searchbox({prompt: "请输入...", searcher: function (value, name) {
        	if($("#Searchbox1487062340496").searchbox("getValue")!=""){
	        	if($("#yishengxiao1487062340496").get(0).checked){
	        		var WOSearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		WOSearchboxBuilder.setOtherskeyValue("searchWO",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", WOSearchboxBuilder.build()); 
	                loadFile();
	        	} 
	        	if($("#yiqianshuweishengxiao1487062340496").get(0).checked){
	        		var ONWSearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		ONWSearchboxBuilder.setOtherskeyValue("searchONW",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", ONWSearchboxBuilder.build()); 
	                loadFile();
	        	}
	        	if($("#yishixiao1487062340496").get(0).checked){
	        		var UWSearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		UWSearchboxBuilder.setOtherskeyValue("searchUW",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", UWSearchboxBuilder.build()); 
	                loadFile();
	        	}
	        	if($("#hetongtixing1487062340496").get(0).checked){
	        		var TIXINGSearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		TIXINGSearchboxBuilder.setOtherskeyValue("searchTIXING",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", TIXINGSearchboxBuilder.build()); 
	                loadFile();
	        	}
        	}else{
        		if($("#yishengxiao1487062340496").get(0).checked){
	        		var WO1SearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		WO1SearchboxBuilder.setOtherskeyValue("searchWO0",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", WO1SearchboxBuilder.build()); 
	                loadFile();
	        	} 
	        	if($("#yiqianshuweishengxiao1487062340496").get(0).checked){
	        		var ONW1SearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		ONW1SearchboxBuilder.setOtherskeyValue("searchONW0",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", ONW1SearchboxBuilder.build()); 
	                loadFile();
	        	}
	        	if($("#yishixiao1487062340496").get(0).checked){
	        		var UW1SearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		UW1SearchboxBuilder.setOtherskeyValue("searchUW0",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", UW1SearchboxBuilder.build()); 
	                loadFile();
	        	}
	        	if($("#hetongtixing1487062340496").get(0).checked){
	        		var TIXING1SearchboxBuilder=new HdEzuiQueryParamsBuilder();
	        		TIXING1SearchboxBuilder.setOtherskeyValue("searchTIXING0",$("#Searchbox1487062340496").searchbox("getValue"));
	                dg.datagrid("load", TIXING1SearchboxBuilder.build()); 
	                loadFile();
	        	}
        	}
        }});
        $("#ContractDatagrid1493016283337").datagrid({
        	striped:true,
            url: "../webresources/login/Contract/findtixingContract",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            sortOrder: 'desc',
            sortName: 'UPD_TIMESTAMP',
            remoteSort:false,
            pageSize: 20,
            toolbar: "#ContractToolBar1493016283337",
            fit: true,
            fitColumns: false,
            frozenColumns:[[ {
                field: "CONTRACT_ID",
                title: '<font color="red"></font>',
                multiSort: true,
                halign: "center",
                hidden:true,
                sortable: true
            },
            {
                field: "CONTRACT_NO",
                title: "合同编号",
                multiSort: true,
                halign: "center",
                width: 100,
                sortable: true
            },
            {
                field: "CONTRACT_NAM",
                title: "合同名称",
                multiSort: true,
                halign: "center",
                width: 180,
                sortable: true
            }]],
            columns: [[
                
                    
                    {
                        field: "CONTRACT_TYP",
                        title: "合同类型",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        sortable: true,
                        width: 80,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_TYP', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }
                    },
                    {
                        field: "CONTRACT_SAT",
                        title: "合同状态",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        sortable: true,
                        width: 80,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        }
                    },
                    {
                        field: "PAREN_CONTRACT",
                        title: "主合同",
                        multiSort: true,
                        halign: "center",
                        width: 120,
                        sortable: true
                    },
                    {
                        field: "SIGNATORY",
                        title: "经办人",
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        hidden: true,
                        sortable: true
                    },
                    {
                        field: "SIGNATORY_NAME",
                        title: "经办人",
                        multiSort: true,
                        halign: "center",
                        width: 90,
                        sortable: true
                    },
                    {
                        field: "SIGN_DEPARTMENT",
                        title: "签约部门",
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        sortable: true
                    },
                    {
                        field: "SIGN_DAT",
                        title: "签署日期",
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "REMIND_DAY",
                        title: "超期提醒",
                        multiSort: true,
                        halign: "center",
                        width: 60,
                        sortable: true
                    },
                    {
                        field: "CUSTOM",
                        title: "客户名称",
                        multiSort: true,
                        halign: "center",
                        width: 140,
                        sortable: true
                    },
                    {
                        field: "COMPANY_COD",
                        title: "公司名称",
                        multiSort: true,
                        halign: "center",
                        width: 140,
                        sortable: true
                    },
                    {
                        field: "BEG_DTE",
                        title: "有效开始期",
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "END_DTE",
                        title: "有效截至期",
                        multiSort: true,
                        styler: function(value,row,index){
                       	 var date=new Date(value).format("yyyy-MM-dd"); 
                       	 var month=date.substring(5,7);
                            var day=date.substring(8,10);
                            var nowdate= Date.prototype.dateAdd(0, "yyyy-MM-dd ");
                            var nowmonth=nowdate.substring(5,7);
                            var nowday=nowdate.substring(8,10); 
           				   if (month==nowmonth&&day<nowday+8){//生日前七天提醒
           					  return 'background-color:#ffee00;color:red;';
           				   }
           			    },

                        halign: "center",
                        width: 80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "IS_ARCHIVE",
                        title: "是否归档",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width: 60,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "DESCRIPTION",
                        title: "描述",
                        multiSort: true,
                        halign: "center",
                        width: 180,
                        sortable: true
                    },
                ]],
                onSelect:function(rowIndex, rowData){
                	builderFile=new HdEzuiQueryParamsBuilder();
                	builderFile.setAndClause("contractNo",rowData.CONTRACT_NO,"=","and");//签署日期非空
                	$("#ContractFileDatagrid1487062340496").datagrid("load",builderFile.build());
                },
          });
        var builderFile= new HdEzuiQueryParamsBuilder();
        $("#ContractFileToolBar1487062340496 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#ContractFileSearchbox1487062340496").val();
        	builderFile.set("q", value);
        	$("#ContractFileDatagrid1487062340496").datagrid("load");
        });
        $("#ContractFileSearchbox1487062340496").searchbox({prompt: "请输入...", searcher: function (value, name) {
        	builderFile.set("q", value);
        	builderFile.set("queryColumns", "enclosureNam,version");
        	$("#ContractFileDatagrid1487062340496").datagrid("load");
        }});
        $("#ContractFileDatagrid1487062340496").datagrid({
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
            toolbar: "#ContractFileToolBar1487062340496",
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
                onSelect: function (rowIndex, rowData) {
                	var url=rowData.enclosureUrl;
            		  var src=url.substring(0,url.lastIndexOf("."))+".pdf";
            		   var html="<embed id=\"pdfPlayer\" src=\""+src+"\" type=\"application/pdf\" width=\"100%\" height=\"99%\" >";
            		   $("#showPdf1487062340496").html(html);
                	$("#ContractFileDialog1487062340496").dialog({
                		title:'文件内容显示',
                		width:870,
                		height:620,
                		closed:false,
                		buttons:[{
                			text:'关闭',
                			handler:function(){
                				$("#ContractFileDialog1487062340496").dialog({closed:true});
                			}
                		}] 
                	});
                	
                }
        });
    });
</script>


    