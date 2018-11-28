<meta charset="UTF-8">
<style type="text/css">
    .tableform{
       
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
    	$("#courseCod20170714").combogrid(HdUtils.code.sbcCourse({required:false,width:131}));//èªå
    	$("#shipServiceCod20170714").combogrid(HdUtils.code.sbcShipService({required:false,width:131}));//èªçº¿
    	var formObject = $("#PortCntrForm201666");
    	var dataObject = HdUtils.dialog3.getValue("data");
    	//var dg = HdUtils.dialog.getValue("dataGrid");
        debugger
         formObject.form("loadData", dataObject);
      
       
//         HdUtils.dialog.setValue({
//             saveHandler: function () {
//                 var changedObject = dataObject;
                
//              	changedObject.courseCod = $("#courseCod20170714").combogrid("getValue");
//              	changedObject.shipServiceCod = $("#shipServiceCod20170714").combogrid("getValue");
//              	changedObject.cnRouting = $("#cnRouting20170714").val();
//              	changedObject.enRouting = $("#enRouting20170714").val();
//              	changedObject.cnEta = $("#cnEta20170714").val();
//              	changedObject.enEta = $("#enEta20170714").val();
//              	changedObject.cnCarrier = $("#cnCarrier20170714").val();
//              	changedObject.enCarrier = $("#enCarrier20170714").val();
//              	changedObject.bookingTel= $("#bookingTel20170714").val();
//              	changedObject.insAccount = $("#insAccount20170714").val();
//              	changedObject.insTimestamp = $("#insTimestamp20170714").val();
//              	changedObject.updAccount = $("#updAccount20170714").val();
//              	changedObject.updTimestamp = $("#updTimestamp20170714").val();
//                 var dataJason = null;
//                 if (dataObject.type === "ADD") {
//                     dataJason = {deletedRows: [], insertedRows: [changedObject], updatedRows: []};
//                 } else {
//                     dataJason = {deletedRows: [], insertedRows: [], updatedRows: [changedObject]};
//                 }
//                 $.ajax({
//                     type: "POST",
//                     url: "../webresources/login/VesselSchedule/save",
//                     contentType: "application/json",
//                     dataType: "json",
//                     data: $.toJSON(dataJason),
//                     success: function (data) {
//                         HdUtils.dialog.close();
//                         HdUtils.messager.bottomRight('保存成功','保存操作');
//                         dg.datagrid("hdReload");
//                     },
//                     error: function (data) {
//                         HdUtils.messager.info(data.responseText);
//                     }
//                 });
//             }}); 
    });
</script>
<form id="PortCntrForm201666">
    <table id="PortCntrTable2455" style="height:97%;width:93%"  class="tableform">
        <tr>
            <th>航向代码： </th>
            <td style="width:180px"><input id="courseCod20170714" name="courseCod"/></td>
            <th>航线代码： </th>
            <td><input id="shipServiceCod20170714" name="shipServiceCod" /></td>
        </tr>
        <tr>
            <th>挂港序(中)： </th>
           <!--  <td><input id="cnRouting20170714" name="cnRouting"/></td> -->
            <td colspan="6"><textarea id="cnRouting20170714" name="cnRouting" rows="5" cols="55"/></td>
        </tr>
        <tr>
            <th>挂港序(英)： </th>
            <td colspan="6"><textarea id="enRouting20170714" name="enRouting" rows="5" cols="55"/></td>
                     
        </tr>
        <tr>
            <th>抵港时间(中)： </th>
            <td ><input id="cnEta20170714" name="cnEta" style='width:92%' class="easyui-validate"/></td>
            <th>抵港时间(英)： </th>
            <td><input id="enEta20170714" name="enEta"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th>承运人(中)： </th>
            <td><input id="cnCarrier20170714" name="cnCarrier" style='width:92%' data-options="required:false" maxlength="12"
                        class="easyui-validatebox"/></td>
            <th>承运人(英)： </th>
            <td><input id="enCarrier20170714" name="enCarrier"  data-options="required:false" maxlength="12"
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th>订舱电话： </th>
            <td><input id="bookingTel20170714" maxlength="1000" name="bookingTel" style='width:92%' data-options="required:false"  class="easyui-validatebox"/></td>
        </tr>
            <input id="insAccount20170714" name="insAccount" type="hidden" />
            <input id="insTimestamp20170714" name="insTimestamp" type="hidden" /> 
            <input id="updAccount20170714" name="updAccount" type="hidden" />
            <input id="updTimestamp20170714" name="updTimestamp" type="hidden" /> 
            <input id="cntrVisitId20170714" name="cntrVisitId" type="hidden" /> 
    </table>
</form>