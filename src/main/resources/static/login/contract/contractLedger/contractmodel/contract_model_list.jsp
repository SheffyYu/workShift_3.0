<meta charset="UTF-8">
<!-- 工具栏 -->
<!-- <script type="text/javascript" src="../../../js/hdEzuiEx_js/jquery.form.js"></script> -->
<style type="text/css">
    .tableform{
        margin: 16px auto;
    }
    .tableform tr{
        height: 20px; 
    } 
    .tableform th{
        text-align: right;
        white-space: nowrap;
    }
    .tableform td{
        text-align: left;
        width: 80px; 
    }
    .tableform input{ 
        text-align: left;
    }
</style>
<div id="ContractModelToolBar1493256102217" style="padding-top: 0px;">
    <div style="float: left">
        <shiro:hasPermission name="webresources:login:ContractModel:add">
            <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:ContractModel:update">
            <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:ContractModel:delete">
            <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:ContractModel:save">
            <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
            <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
            <a class="easyui-linkbutton" id="modelRead201704281516" plain="false">模板查看</a>
            <a class="easyui-linkbutton" id="modelDownLoad201704281516" plain="false">模板下载</a>
        &nbsp;
  <!--       <a class="easyui-linkbutton" id="creatWordModel20170610" plain="false">生成word测试</a> -->
    </div>
    <input class="easyui-searchbox" id="ContractModelSearchbox1493256102217"/>
</div>
<!-- Datagrid -->
<table id="ContractModelDatagrid1493256102217" style="height:100%"></table>
<div id="ContractModelDialog1493256102217" class="easyui-dialog" data-options="closed:true" >
	<div id="showPdf1493256102217" style="width:100%;height:100%;"></div>
</div>
<!-- end Datagrid -->
<!-- 脚本控制 -->
<script type="text/javascript">
var CreateTable= function(tableData,tableId) {
	var table=$("<table border=\"1\" rules=\"all\">");
	table.appendTo($("#"+tableId));
	debugger
	var tableRows = parseInt(tableData[0].totalRows);
	for (var row=1;row<=tableRows;row++) {
		var tr=$("<tr></tr>");
	    tr.appendTo(table);
	    var lastTd = "";//textarea多行展示table
	    var cols = "100";//textarea展示的列数
	    var rows = "1";//textarea展示的行数
	    //var td = currentTd;
	    for(var i=0;i<tableData.length;i++) {
	    	if(parseInt(tableData[i].columnNam.split(",")[0])==row) {
	    		if(tableData[i].textTyp=="0") {//如果为input num类型
	    			var inputStr = "<input type=\"text\" value=\""+tableData[i].columnValue+"\" name=\""+tableId+tableData[i].columnNam+
	    			   "\" style=\"width:99%;border:0;text-align:center;\""+
	                   " onkeyup=\"(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)\""+
                  	   " onblur=\"this.v();\" class=\"textField\"/>";
	    			var td=$("<td align=\"center\" valign=\"middle\" colspan=\""+tableData[i].columnCols+"\" rowspan=\""+tableData[i].columnRows+"\">"
	 	    			   +inputStr+"</td>");
	    		} else if (tableData[i].textTyp=="1") {//如果为input string类型
	    			var inputStr = "<input type=\"text\" value=\""+tableData[i].columnValue+"\" name=\""+tableId+tableData[i].columnNam+
	    			   "\" style=\"width:99%;border:0;text-align:center;\""+
	                   " class=\"textField\"/>";
	    			var td=$("<td align=\"center\" valign=\"middle\" colspan=\""+tableData[i].columnCols+"\" rowspan=\""+tableData[i].columnRows+"\">"
	 	    			   +inputStr+"</td>");
	    		} else if (tableData[i].textTyp=="2") {//textarea 一个表格一个
	    		    if(tableData[i].columnRemark!=null&&tableData[i].columnRemark!="") {
	    		    	rows = tableData[i].columnRemark.split(",")[0];
	    		    	cols = tableData[i].columnRemark.split(",")[1];
	    		    } else {
	    		    	rows = "1";
	    		    	cols = "100";
	    		    } 
	    			var inputStr = "<textarea style=\"border-left:0px;border-top:0px;border-right:0px;border-bottom:1px \""+" rows=\""+rows+"\""+
	    			    " cols=\""+cols+"\" name=\""+tableId+tableData[i].columnNam+"\">"+tableData[i].columnValue+"</textarea>";
	    			var td=$("<td align=\"center\" valign=\"middle\" colspan=\""+tableData[i].columnCols+"\" rowspan=\""+tableData[i].columnRows+"\">"
	 	    			   +inputStr+"</td>");
	    		} else if (tableData[i].textTyp=="3"&&parseInt(tableData[i].columnNam.split(",")[2])=="1") {
	    			if(tableData[i].columnRemark!=null&&tableData[i].columnRemark!="") {
	    		    	rows = tableData[i].columnRemark.split(",")[0];
	    		    	cols = tableData[i].columnRemark.split(",")[1];
	    		    } else {
	    		    	rows = "1";
	    		    	cols = "100";
	    		    } 
	    			lastTd += "<table><tr><td>"+"<textarea style=\"border-left:0px;border-top:0px;border-right:0px;border-bottom:1px \""+" rows=\""+rows+"\""+
	    			" cols=\""+cols+"\" name=\""+tableId+tableData[i].columnNam+"\">"+tableData[i].columnValue+"</textarea></td></tr>";
	    		    continue;
	    		} else if (tableData[i].textTyp=="3"&&parseInt(tableData[i].columnNam.split(",")[2])!="1"&&parseInt(tableData[i].columnNam.split(",")[2])!="0") {
	    			if(tableData[i].columnRemark!=null&&tableData[i].columnRemark!="") {
	    		    	rows = tableData[i].columnRemark.split(",")[0];
	    		    	cols = tableData[i].columnRemark.split(",")[1];
	    		    } else {
	    		    	rows = "1";
	    		    	cols = "100";
	    		    } 
	    			lastTd += "<tr><td>"+"<textarea style=\"border-left:0px;border-top:0px;border-right:0px;border-bottom:1px \""+" rows=\""+rows+"\""+
	    			" cols=\""+cols+"\" name=\""+tableId+tableData[i].columnNam+"\">"+tableData[i].columnValue+"</textarea></td></tr>";
	    			continue;
	    		} else if (tableData[i].textTyp=="3"&&parseInt(tableData[i].columnNam.split(",")[2])!=="0") {
	    			if(tableData[i].columnRemark!=null&&tableData[i].columnRemark!="") {
	    		    	rows = tableData[i].columnRemark.split(",")[0];
	    		    	cols = tableData[i].columnRemark.split(",")[1];
	    		    } else {
	    		    	rows = "1";
	    		    	cols = "100";
	    		    } 
	    			lastTd += "<tr><td>"+"<textarea style=\"border-left:0px;border-top:0px;border-right:0px;border-bottom:1px \""+" rows=\""+rows+"\""+
	    			" cols=\""+cols+"\" name=\""+tableId+tableData[i].columnNam+"\">"+tableData[i].columnValue+"</textarea></td></tr></table>";
	    			var td=$("<td align=\"center\" valign=\"middle\" colspan=\""+tableData[i].columnCols+"\" rowspan=\""+tableData[i].columnRows+"\">"
	 	    			   +lastTd+"</td>");
	    		} 
	            td.appendTo(tr);
	    	}
	    }
	}
	//trend.appendTo(table);
	$("#"+tableId).append("</table>");
}
    var justEditIndex;
    var modelUrlVal;
    var currentEditIndex;
    //上传按钮点击事件
    var upload = function(value) {
    	$("#uploadForm201704271605").form("clear");
    	$("#EnclosureUploadFile201704271605").dialog({
			title:'模板上传',      			
			closed:false,
			width:300,
			height:130,
			buttons:[{
				text:'关闭',
				handler:function(){
				      $("#EnclosureUploadFile201704271605").dialog({closed:true});
			    }
			}]
		}); 
    };
    
    
    $(document).ready(function () {
        var diog = $("#ContractModelDialog1493256102217");
        var dg = $("#ContractModelDatagrid1493256102217");
        // buttons
        // 增加。
        $("#ContractModelToolBar1493256102217 a[iconCls='icon-add']").on("click", function () {
        	dg.datagrid("hdAdd");        
        });
        // 编辑。
        $("#ContractModelToolBar1493256102217 a[iconCls='icon-edit']").on("click", function () {
        	dg.datagrid("hdEdit");
        });
        // 删除。
        $("#ContractModelToolBar1493256102217 a[iconCls='icon-remove']").on("click", function () {
        	dg.datagrid("hdRealRemove", {url: "../webresources/login/ContractModel/save"});
        });
        // 保存。
        $("#ContractModelToolBar1493256102217 a[iconCls='icon-save']").on("click", function () {
            dg.datagrid("hdSave", {url: "../webresources/login/ContractModel/save"});
        });
        // 刷新。
        $("#ContractModelToolBar1493256102217 a[iconCls='icon-reload']").on("click", function () {
        	var value=$("#ContractModelSearchbox1493256102217").val();
        	builder.set("q", value);
            dg.datagrid("hdReload");
        });
        // 模板查看。
        $("#modelRead201704281516").on("click", function () {
        	var selectRow = dg.datagrid("getSelected");
        	if (selectRow == undefined) {
                HdUtils.messager.info("请选择一条记录");
                return;
            }else {
            	var url=selectRow.modelUrl;
            	var doc=url.substring(url.lastIndexOf("."));
            	if(doc==".doc"||doc==".docx"){
        		  	var src=url.substring(0,url.lastIndexOf("."))+".pdf";
        		   	var html="<embed id=\"pdfPlayer\" src=\""+src+"\" type=\"application/pdf\" width=\"100%\" height=\"99%\" >";
        		   	$("#showPdf1493256102217").html(html);
            	}else{
            		var src=url;
        		   	var html="<img id=\"pdfPlayer\" src=\""+src+"\" >";
        		   	$("#showPdf1493256102217").html(html);
            	}
    	      	$("#ContractModelDialog1493256102217").dialog({
    	      		title:'模板内容',
    	      		width:870,
    	      		height:620,
    	      		closed:false,
    	      		buttons:[{
    	      			text:'关闭',
    	      			handler:function(){
    	      				$("#ContractModelDialog1493256102217").dialog({closed:true});
    	      			}
    	      		}] 
    	      	});
            }
        });
        
        // word模板。
        $("#creatWordModel20170610").on("click", function () {
           $("#contractForm20170610").form("clear");
           var searchBuilder=new HdEzuiQueryParamsBuilder();
    	   searchBuilder.setAndClause("contractFormat","TRADE_BANLUN_PORT","=","and");
           var dataObject = {};
           $.ajax({
                type: "POST",
                url: "../webresources/login/ContractWord/find",
                contentType: "application/json",
                dataType: "json",
                async: false,
                data: JSON.stringify(searchBuilder.hdEzuiQueryParams),
                success: function (data) {
                    dataObject = {};
                    if(data!=null&&data.rows.length>0) {
                    	for(var i=0;i<data.rows.length;i++) {
							var key = data.rows[i].contentName;                    		
                    		dataObject[key] = data.rows[i].contentValue;
                    	}
                    }
                }
            });
            $("#contractForm20170610").form("loadData", dataObject);
            var searchTableBuilder=new HdEzuiQueryParamsBuilder();
           //searchTableBuilder.setAndClause("tableName","BANLUN_F_PORT_WORK_FEE","=","or");
            searchTableBuilder.setAndClause("tableName","空箱港口作业费","=","and");
            searchTableBuilder.setOrderByClause("columnSorter", "asc");//传入orderby
            $.ajax({
               type: "POST",
               url: "../webresources/login/ContractWordTable/find",
               contentType: "application/json",
               dataType: "json",
               async: false,
               data: JSON.stringify(searchTableBuilder.hdEzuiQueryParams),
               success: function (data) {
            	   debugger
                   if(data!=null&&data.rows.length>0) {
                	   CreateTable(data.rows,"fubiaoA2");
                   	 /* for(var i=0;i<data.rows.length;i++) {
						var key = data.rows[i].columnNam;                    		
                   		dataObject[key] = data.rows[i].columnValue;
                   	}  */
                   }
               }
            });
        	//
        	$("#contractDialog20170610").dialog({
    			title:'模板上传',      			
    			closed:false,
    			width:800,
    			height:630
    		}); 
        	
        });
        
        
        // 模板下载。
        $("#modelDownLoad201704281516").on("click", function () {
        	var selectRow =$("#ContractModelDatagrid1493256102217").datagrid("getSelected");
        	if(selectRow){
        		var url=selectRow.modelUrl;
        		window.location.href=url;
            } else {
            	HdUtils.messager.info("请选择一条记录");
            }
        });
        
     // 模板下载。
        $("#saveCurrentWord20170613").on("click", function () {
        	CreateTable(5,6);
        });
      //文件上传成功后的回掉函数
        $("#uploadForm201704271605").form({
 			success:function(data){
 				modelUrlVal = data;
            	$("#EnclosureUploadFile201704271605").dialog({closed:true});
	            $("#ContractModelDatagrid1493256102217").datagrid("endEdit",currentEditIndex);
	            $("#ContractModelDatagrid1493256102217").datagrid('updateRow',{
		    		index: justEditIndex,
		    		row: {
		    			modelUrl: data
		    		}
	            });
			 }
 		});
        var builder = new HdEzuiQueryParamsBuilder();
        builder.hdEzuiQueryParams.page = 1;
        builder.hdEzuiQueryParams.rows = 20;
        builder.setOrderByClause("updTimestamp","asc");
        // searchbox
        $("#ContractModelSearchbox1493256102217").searchbox({prompt: "请输入...", searcher: function (value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "contractTyp,modelNam,description,insAccount,insTimestamp");
                dg.datagrid("hdReload");
        }});
        // datagrid
        $("#ContractModelDatagrid1493256102217").datagrid({
        	striped:true,
            url: "../webresources/login/ContractModel/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#ContractModelToolBar1493256102217",
            fit: true,
            fitColumns: false,
            columns: [[
					{
						field: "ck",
						checkbox: true
					},
                    {
                        field: "id",
                        title: '<font color="red"></font>',
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        sortable: true
                    },
                    {
                        field: "contractTyp",
                        title: '<font color="red">合同类型</font>',
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:80,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_TYP', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        editor: {
                            type: "combobox",
                            options: HdUtils.code.scode({fieldCod: 'CONTRACT_TYP'},{required: true,textField:'name'})
                        }, 
                        sortable: true
                    },
                    {
                        field: "modelNam",
                        title: '<font color="red">模板名称</font>',
                        multiSort: true,
                        halign: "center",
                        width:100,
                        editor: {type: "validatebox", options: {required:true,validType: 'length[0,20]'}},
                        sortable: true
                    },
                    {
                        field: "modelState",
                        title: "激活",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width:60,
                        editor: $.hd.ezui.editor.checkbox,
                	    formatter: $.hd.ezui.formatter.checkbox2,
                        sortable: true
                    },
                    {
                        field: "modelUrl",
                        title: "模板上传",
                        multiSort: true,
                        halign: "center",
                        width:360,
                        align: "center",
                        formatter: function (value) {
                            if (value === null || value === ''||value===undefined)
                                return;
                            var names = value.split("/");
                            return names[names.length - 1];
                        },
                        editor: {type: "upload"},  
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "描述",
                        multiSort: true,
                        halign: "center",
                        width:120,
                        editor: {type: "validatebox", options: {required:false,validType: 'length[0,300]'}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: '创建人',
                        multiSort: true,
                        width:80,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: '创建时间',
                        multiSort: true,
                        halign: "center",
                        formatter:$.hd.ezui.formatter.datetime,
                        width:130,
                        sortable: true
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        width:80,
                        sortable: true
                    },
                    {
                        field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        formatter:$.hd.ezui.formatter.datetime,
                        width:130,
                        sortable: true
                    },
                    {
                        field: "pid",
                        title: "父节点",
                        multiSort: true,
                        halign: "center",
                        hidden:true,
                        sortable: true
                    },
                ]],
				onDblClickCell : function(index) {
					dg.datagrid("hdEdit");
				},
				onBeforeEdit : function(rowIndex, rowData) {
					modelUrlVal = rowData.modelUrl;
					currentEditIndex = rowIndex;
				},
				onAfterEdit : function(rowIndex, rowData, changes) {
					justEditIndex = rowIndex;
					currentEditIndex = "";
					$("#ContractModelDatagrid1493256102217").datagrid('updateRow',{
			    		index: rowIndex,
			    		row: {
			    			modelUrl: modelUrlVal
			    		}
		            });
				}
  });
        $("#ContractModelDatagrid1493256102217").datagrid("hdGetColumnNames");
    });
</script>
<div id="EnclosureUploadFile201704271605" class="easyui-dialog" data-options="closed:true">
	<form id="uploadForm201704271605" name="fileForm" method="POST" enctype="multipart/form-data"  action="/webresources/login/ContractModel/impWord" target="message">
	    <table align="center">
	       <tr>
	         	<td colspan="2"> 
	               <input type="file" name="file" id="enclosureNam1493012840094" style="width:210px;" />
	           </td>
	           <td> 
	               <input type="hidden" id="contractId1493012840095" name="id"/>
	           </td>
	         </tr>
	         <tr>
        	 	<td> 
	               <input type="submit" value="上传"/>
	           </td>
        	 </tr>
	       <iframe name="message" style="display: none"></iframe>
	    </table>
    </form>
</div>
<script>

</script>
<div id="contractDialog20170610" class="easyui-dialog" data-options="closed:true">
<form id="contractForm20170610" name="fileForm" method="POST" enctype="multipart/form-data"  action="/webresources/login/ContractModel/creatWord" target="message">
<div id="file" align="center">  
            <h6>合同名称:<input type="text" name="title" class="textField"/></h6>
            <h6>子标题:<input type="text" name="subtitle" class="textField"/></h6>
    <hr/>  
    <table> 
        <tr><td style="font-weight:bold;" >甲方信息：</td></tr>
        <tr>  
            <td align="center"><label>公司名称：</label></td>  
            <td><input type="text" name="firstParty" style="width:90%;" class="textField"/></td> 
            <td align="center">代表：</td>  
            <td ><input type="text" name="firstPartyRepresent" style="width:90%;" class="textField"/></td>
        </tr>  
        <tr> 
            <td align="center">电话：</td>  
            <td ><input type="text" name="firstPartyTel" style="width:90%;" class="textField"/></td>
        	<td align="center">传真：</td>  
            <td ><input type="text" name="firstPartyEmail" style="width:90%;" class="textField"/></td>
        </tr>  
        <tr>  
            <td align="center">地址：</td>  
            <td colspan="3"><input colspan="5" type="text" style="width:95.6%;" name="firstPartyAddress"  class="textField"/></td>
        </tr> 
        <tr><td style="font-weight:bold;">乙方信息： </td></tr> 
        <tr> 
            <td  align="center">公司名称：</td>  
            <td><input type="text" name="secondParty" style="width:90%;" class="textField"/></td> 
            <td  align="center">代表：</td>  
            <td><input type="text" name="secondPartyRepresent" style="width:90%;" class="textField"/></td>
        </tr>  
        <tr> 
            <td  align="center">电话：</td>  
            <td ><input type="text" name="secondPartyTel" style="width:90%;" class="textField"/></td>
        	<td  align="center">传真：</td>  
            <td ><input type="text" name="secondPartyEmail" style="width:90%;" class="textField"/></td>
        </tr>  
        <tr>  
            <td align="center">联系人：</td>  
            <td><input type="text" name="secondPartyContactPerson" style="width:90%;" class="textField"/></td>
            <td align="center">地址：</td>  
            <td><input type="text" style="width:90%;" name="secondPartyAddress"  class="textField"/></td>
        </tr>  
        <tr><td style="font-weight:bold;">丙方信息：</td></tr>                    
        <tr>  
            <td align="center">公司名称：</td>  
            <td><input type="text" name="thirdParty" style="width:90%;" class="textField"/></td> 
            <td align="center">代表：</td>  
            <td><input type="text" name="thirdPartyRepresent" style="width:90%;" class="textField"/></td>
        </tr>  
        <tr> 
            <td align="center">电话：</td>  
            <td><input type="text" name="thirdPartyTel" style="width:90%;" class="textField"/></td>
        	<td align="center">传真：</td>  
            <td><input type="text" name="thirdPartyEmail" style="width:90%;" class="textField"/></td>
        </tr>  
        <tr>  
            <td align="center">联系人：</td>  
            <td><input type="text" name="thirdPartyContactPerson" style="width:90%;" class="textField"/></td>
            <td align="center">地址：</td>  
            <td><input colspan="3" type="text" style="width:90%;" name="thirdPartyAddress"  class="textField"/></td>
        </tr> 
        <tr>  
            <td style="font-weight:bold;" class="key">合同内容：</td>  
        </tr>  
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content1"></textarea>  
            </td>  
        </tr>  
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content2"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content3"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="5" cols="100" name="content4"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content5"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content6"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content7"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content8"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="4" cols="100" name="content9"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content10"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content11"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content12"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content13"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content14"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="7" cols="100" name="content15"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content16"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="8" cols="100" name="content17"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content18"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content19"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content20"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content21"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content22"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content24"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content25"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content26"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content27"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content28"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="6" cols="100" name="content29"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content30"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content31"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content32"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content33"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="4" cols="100" name="content34"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="5" cols="100" name="content35"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="content36"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content37"></textarea>  
            </td>  
        </tr> 
        <tr>  
            <td align="center">逾期天数：</td>  
            <td ><input type="text" name="delayDay1" style="width:90%;" class="textField"/></td> 
            <td >滞纳金：</td>  
            <td ><input type="text" name="payFee1" style="width:90%;" class="textField"/></td> 
        </tr> 
        <tr>  
            <td align="center">逾期天数：</td>  
            <td ><input type="text" name="delayDay2" style="width:90%;" class="textField"/></td>
            <td>滞纳金：</td>  
            <td ><input type="text" name="payFee2" style="width:90%;" class="textField"/></td>
        </tr> 
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content38"></textarea>  
            </td>  
        </tr>  
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content39"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content40"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content41"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content42"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content43"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content44"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content45"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="content46"></textarea>  
            </td>  
        </tr>
        <tr>  
            <td colspan="4">  
                <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="content47"></textarea>  
            </td>  
        </tr>   
        <tr><td style="font-weight:bold;">附表一：</td></tr>
        <tr><td>A）班轮重箱港口作业费</td><td>单位：元</td></tr>
        <tr><td colspan="4"><div id="fubiaoA1"></div></td> </tr>
		<tr><td>B）空箱港口作业费（班轮/驳船）</td><td>单位：元</td></tr>
		<tr><td colspan="4"><div id="fubiaoA2"></div></td> </tr>
        <tr><td>附表二：    港口使费率表</td><td>单位：元</td></tr>
		<tr><td colspan="4"><div id="fubiaoB"></div></td> </tr>
		<tr><td style="font-weight:bold;">附表三：</td></tr>
        <tr><td>A）重、空堆存费率表</td><td>单位：元/箱天</td></tr>
        <tr><td colspan="4"><div id="fubiaoC1"></div></td> </tr>
        <tr><td>B）重箱免堆期</td><td>单位：元/箱天</td></tr>
        <tr><td colspan="4"><div id="fubiaoC2"></div></td> </tr>
        <tr><td>C）重箱超期堆存费率</td><td>单位：元/箱天</td></tr>
        <tr><td colspan="4"><div id="fubiaoC3"></div></td> </tr>
        </table>  
</div>  
<div align="center" style="margin-top:15px;">  
    <input type="button" id="saveCurrentWord20170613" value="保存当前模板" />  
    <input type="submit" value="保存Word文档" />  
</div>  
</form> 
</div>




<!-- <tr><td colspan="4">
        <table border="1" rules="all">
                <tr>
                    <td colspan="2" align="center">箱型</td>
                    <td align="center">汽车集疏运港口作业费</td>
                    <td align="center">驳船集疏运港口作业费</td>
                    <td align="center">沿海中转港口作业费</td>
                </tr>
			    <tr>
			        <td align="center" valign="middle" rowspan="3">20'</td>
			        <td align="center">一般货物</td>
			        <td><input type="text" name="20normalcar" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="20normalboat" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="20normaltrans" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			    </tr>
			    <tr>
			        <td align="center">普通危险货物</td>
			        <td><input type="text" name="20dangercar" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="20dangerboat" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="20dangertrans" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			    </tr>
			    <tr>
			        <td align="center">冷藏重箱</td>
			        <td><input type="text" name="20reefcar" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="20reefboat" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="20reeftrans" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			    </tr>
			    <tr>
			        <td align="center" valign="middle" rowspan="3">40'</td>
			        <td align="center">一般货物</td>
			        <td><input type="text" name="40normalcar" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="40normalboat" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="40normaltrans" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			    </tr>
			    <tr>
			        <td align="center">普通危险货物</td>
			        <td><input type="text" name="40dangercar" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="40dangerboat" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="40dangertrans" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			    </tr>
			    <tr>
			        <td align="center">冷藏重箱</td>
			        <td><input type="text" name="40reefcar" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="40reefboat" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			        <td><input type="text" name="40reeftrans" style="width:99%;border:0;text-align:center;"
			                   onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" 
	                  		   onblur="this.v();" class="textField"/></td>
			    </tr>
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="fubiao1A1content1"></textarea> 
			        </td>
			    </tr>
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="4" cols="100" name="fubiao1A2"></textarea>  
			        </td>
			    </tr> 
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="fubiao1A3"></textarea>  
			        </td>
			    </tr> 
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="fubiao1A4"></textarea>  
			        </td>
			    </tr> 
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="3" cols="100" name="fubiao1A5"></textarea>  
			        </td>
			    </tr> 
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="2" cols="100" name="fubiao1A6"></textarea>  
			        </td>
			    </tr> 
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="fubiao1A7"></textarea>  
			        </td>
			    </tr> 
			    <tr>
			        <td align="center" colspan="5">
                		 <textarea style="border-left:0px;border-top:0px;border-right:0px;border-bottom:1px " rows="1" cols="100" name="fubiao1A8"></textarea>  
			        </td>
			    </tr>
		 </table>
		</td></tr> -->