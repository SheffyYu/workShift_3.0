<meta charset="UTF-8">
<style type="text/css">
    .tableform{
        margin: 16px auto;
    }
    .tableform tr{
        height: 30px; 
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
<script>
    $(document).ready(function () {
    	$("#parenContract201704250900").combogrid(HdUtils.code.contract({
    		width:150,
    		editable:true,
    		required:false
    	}));
    	$("#contractTyp201704250900").combobox(HdUtils.code.scode({fieldCod: 'CONTRACT_TYP'},{required:false}));
    	$("#contractSat201704250900").combobox(HdUtils.code.scode({fieldCod: 'CONTRACT_STAT'},{required:false}));
    	var formObject = $("#ContractFormZhangdh20170425");
        var dataObject = HdUtils.dialog3.getValue("data");
        var dg = HdUtils.dialog3.getValue("dataGrid");
        formObject.form("loadData", dataObject);
        //控制按钮的隐藏与显示
        if(dataObject.contractSat=="RE") {
        	document.getElementById("recover201704251005").style.display = "none";
        	$("#signDat201704250900").datebox({value: new Date().format("yyyy-MM-dd")});
        } else if(dataObject.contractSat=="ON") {
        	document.getElementById("sign201704251005").style.display = "none";
        	document.getElementById("recover201704251005").style.display = "none";
        } else if(dataObject.contractSat=="ST") {
        	document.getElementById("sign201704251005").style.display = "none";
        	document.getElementById("stopSign201704251005").style.display = "none";
        }
        $("#signatory201704250900").val(dataObject.signatoryNam);
        //关闭按钮事件
        $("#close201704251005").on("click", function () {
        	HdUtils.dialog3.close();
        });
        //签署按钮事件
        $("#sign201704251005").on("click", function () {
        	$.ajax({
                url:"../webresources/login/Contract/modifyContractStat?contractId="+$("#contractId201704250900").val()+"&contractStat=ON",
                type: 'POST',//请求方式
                contentType: 'application/json',
                dataType: 'text',//响应信息格式
                success: function (data) {
                	$("#ContractDatagridZhangdh201704241639").datagrid("hdReload");
                    HdUtils.messager.bottomRight('签署中！','提示');
                    HdUtils.dialog3.close();
                    $("#ContractFileDatagrid201704241639").datagrid("loadData",{total: 0, rows: []});
                }
            });
        });
        //终止签署按钮事件
        $("#stopSign201704251005").on("click", function () {
        	$.ajax({
                url:"../webresources/login/Contract/modifyContractStat?contractId="+$("#contractId201704250900").val()+"&contractStat=ST",
                type: 'POST',//请求方式
                contentType: 'application/json',
                dataType: 'text',//响应信息格式
                success: function (data) {
                	$("#ContractDatagridZhangdh201704241639").datagrid("hdReload");
                    HdUtils.messager.bottomRight('已终止签署！','提示');
                    HdUtils.dialog3.close();
                    $("#ContractFileDatagrid201704241639").datagrid("loadData",{total: 0, rows: []});
                }
            });
        });
        //恢复按钮事件
        $("#recover201704251005").on("click", function () {
        	$.ajax({
                url:"../webresources/login/Contract/modifyContractStat?contractId="+$("#contractId201704250900").val()+"&contractStat=RE",
                type: 'POST',//请求方式
                contentType: 'application/json',
                dataType: 'text',//响应信息格式
                success: function (data) {
                	$("#ContractDatagridZhangdh201704241639").datagrid("hdReload");
                    HdUtils.messager.bottomRight('恢复成功！','提示');
                    HdUtils.dialog3.close();
                    $("#ContractFileDatagrid201704241639").datagrid("loadData",{total: 0, rows: []});
                }
            });
        });
    });
</script>
<!-- form 表单 -->
<form id="ContractFormZhangdh20170425">
    <table id="ContractTableZhangdh20170425" style="height:75%;width:80%" class="tableform">
        <tr>
            <td hidden="hidden"><input id="contractId201704250900" name="contractId"  data-options="required:true"  class="easyui-validate"/></td>
            <th><font color="red">*</font>合同编号：</th>
            <td><input id="contractNo201704250900" name="contractNo" disabled="disabled" data-options="required:false"  class="easyui-validate"/></td>
            <th>经办人：</th>
            <td><input disabled="disabled" id="signatory201704250900" name="signatory" disabled="disabled"  data-options="required:false"  class="easyui-validate"/></td>
            <th>签署日期： </th>
            <td><input disabled="disabled" id="signDat201704250900" disabled="disabled" name="signDat"  data-options="required:false"  class="easyui-datebox"/> </td>
        </tr>
        <tr>
        	<th><font color="red">*</font>合同名称： </th>
            <td colspan="5"><input style="width: 99.5%" id="contractNam201704250900" disabled="disabled" name="contractNam" maxlength="100" data-options="required:false"  class="easyui-validate"/></td>
        </tr>
        <tr>
        	<th><font color="red">*</font>客户名称： </th>
            <td colspan="5"><input style="width: 99.5%" id="custom201704250900" disabled="disabled" name="custom" maxlength="100" data-options="required:false"  class="easyui-validate"/></td>
        </tr>
        <tr>
            <th><font color="red">*</font>签约部门： </th>
            <td><input style="width: 99.5%" id="signDepartment201704250900" disabled="disabled" name="signDepartment" maxlength="100" data-options="required:false"  class="easyui-validate"/></td>
            <th>主合同： </th>
            <td><input style="width: 99.5%" id="parenContract201704250900" disabled="disabled" name="parenContract" data-options="required:false"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th><font color="red">*</font>合同类型： </th>
            <td><input id="contractTyp201704250900" name="contractTyp" disabled="disabled"  data-options="required:false"/></td>
            <th>公司名称： </th>
            <td><input id="companyCod201704250900" name="companyCod" disabled="disabled"  data-options="required:false"  class="easyui-validate"/></td>
            <th><font color="red">*</font>超期提醒： </th>
            <td><input id="remindDay201704250900" disabled="disabled" name="remindDay"  data-options="required:false"  class="easyui-number"/></td>     
        </tr>
        <tr>
       	 	<th><font color="red">*</font>开始日期： </th>
            <td><input id="begDte201704250900" disabled="disabled" name="begDte"  data-options="required:false"  class="easyui-datebox"/> </td>
            <th><font color="red">*</font>截止日期： </th>
            <td><input id="endDte201704250900" disabled="disabled" name="endDte"  data-options="required:false"  class="easyui-datebox"/> </td>
            <th>合同状态： </th>
            <td><input id="contractSat201704250900" disabled="disabled" name="contractSat"  data-options="required:false"/></td>
            <!-- <th>是否归档: </th>
            <td><input id="isArchive1493012840094" name="isArchive"  data-options="required:false"  </td> -->
        </tr>
        <tr>
        	<th>备注： </th>
            <td colspan="5"><input style="width: 99.5%" disabled="disabled" id="description201704250900" name="description" maxlength="100" data-options="required:false"  class="easyui-validate"/></td>
        </tr>
        <tr>
            <td></td><td></td>
        	<td style="text-align:center" colspan="2">
        		<a class="easyui-linkbutton" id="sign201704251005" plain="false">签署</a>
	    		<a class="easyui-linkbutton" id="stopSign201704251005" plain="false">终止签署</a>
	    		<a class="easyui-linkbutton" id="recover201704251005" plain="false">恢复</a>
	    		<a class="easyui-linkbutton" id="close201704251005" plain="false">关闭</a>
    		</td>
    		<td></td><td></td>
        </tr>
    </table>
</form>