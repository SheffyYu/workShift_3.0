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
        var formObject = $("#SbcProductionGoalYearForm");//GPG
        //var GPCForm = $("#GPCForm3");
        var NCTForm = $("#NCTForm3");
        var NICTForm = $("#NICTForm3");
        var GCTForm = $("#GCTForm3");
        var HPCTForm = $("#HPCTForm3");
        var XSCTForm = $("#XSCTForm3");
        var HNCTForm = $("#HNCTForm3");
        var SHCTForm = $("#SHCTForm3");
        var CCCTForm = $("#CCCTForm3");
        var GOCTForm = $("#GOCTForm3");
        var dataObject = HdUtils.dialog.getValue("data");
        var dg = HdUtils.dialog.getValue("dataGrid");
        formObject.form("loadData", dataObject);
        $("#SbcProductionGoalYearCompanyCod").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCod").combogrid("setValue","GPG");
        $("#SbcProductionGoalYearBulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTyp").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTyp").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTyp").combobox("setValue","Y");
        
//         $("#SbcProductionGoalYearCompanyCodGPC").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
//         $("#SbcProductionGoalYearCompanyCodGPC").combogrid("setValue","GPC");
//         $("#SbcProductionGoalYearBulkTypGPC").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
//         $("#SbcProductionGoalYearBulkTypGPC").combobox("setValue","B");
//         $("#SbcProductionGoalYearProdPlanTypGPC").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
//         $("#SbcProductionGoalYearProdPlanTypGPC").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodNCT").combogrid("setValue","NCT");
        $("#SbcProductionGoalYearBulkTypNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypNCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypNCT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodNICT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodNICT").combogrid("setValue","NICT");
        $("#SbcProductionGoalYearBulkTypNICT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypNICT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypNICT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypNICT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodGCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodGCT").combogrid("setValue","GCT");
        $("#SbcProductionGoalYearBulkTypGCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypGCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypGCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypGCT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodHPCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodHPCT").combogrid("setValue","HPCT");
        $("#SbcProductionGoalYearBulkTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypHPCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypHPCT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodXSCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodXSCT").combogrid("setValue","XSCT");
        $("#SbcProductionGoalYearBulkTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypXSCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypXSCT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodHNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodHNCT").combogrid("setValue","HNCT");
        $("#SbcProductionGoalYearBulkTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypHNCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypHNCT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodSHCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodSHCT").combogrid("setValue","SHCT");
        $("#SbcProductionGoalYearBulkTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypSHCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypSHCT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodCCCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodCCCT").combogrid("setValue","CCCT");
        $("#SbcProductionGoalYearBulkTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypCCCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypCCCT").combobox("setValue","Y");
        
        $("#SbcProductionGoalYearCompanyCodGOCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalYearCompanyCodGOCT").combogrid("setValue","GOCT");
        $("#SbcProductionGoalYearBulkTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearBulkTypGOCT").combobox("setValue","B");
        $("#SbcProductionGoalYearProdPlanTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalYearProdPlanTypGOCT").combobox("setValue","Y");
        
        
        // TODO 
        var year= new Date(new Date()).format("yyyy-MM").substring(0,4);
        var date00=formObject.form('getData').prodPlanYmd;
        if(date00==null||date00==""){
            year =new Date(new Date()).format("yyyy-MM").substring(0,4);
        }else{
            year= date00.substring(0,4);
        }
        
        $('#SbcProductionGoalProdPlanYmdYear11').numberspinner({    
          min: 2000,    
          max: year+15, 
          value:year,
          required:true,
          editable: false   
        });  
//         $('#SbcProductionGoalProdPlanYmdYear11GPC').numberspinner({    
//             min: 2000,    
//             max: year+15, 
//             value:year,
//             required:true,
//             editable: false   
//         }); 
        $('#SbcProductionGoalProdPlanYmdYear11NCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11NICT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11GCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11HPCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11XSCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11HNCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11SHCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11CCCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        $('#SbcProductionGoalProdPlanYmdYear11GOCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        }); 
        
        HdUtils.dialog.setValue({
            saveHandler: function () {
                var GPGObject = formObject.form('getData');
                GPGObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11').val();
                //var GPCObject = GPCForm.form('getData');
                //GPCObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11GPC').val();
                var NCTObject = NCTForm.form('getData');
                NCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11NCT').val();
                var NICTObject = NICTForm.form('getData');
                NICTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11NICT').val();
                var GCTObject = GCTForm.form('getData');
                GCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11GCT').val();
                var HPCTObject = HPCTForm.form('getData');
                HPCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11HPCT').val();
                var XSCTObject = XSCTForm.form('getData');
                XSCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11XSCT').val();
                var HNCTObject = HNCTForm.form('getData');
                HNCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11HNCT').val();
                var SHCTObject = SHCTForm.form('getData');
                SHCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11SHCT').val();
                var CCCTObject = CCCTForm.form('getData');
                CCCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11CCCT').val();
                var GOCTObject = GOCTForm.form('getData');
                GOCTObject.prodPlanYmd=$('#SbcProductionGoalProdPlanYmdYear11GOCT').val();
                var insertList=[]
                insertList.push(NCTObject);
                insertList.push(NICTObject);
                insertList.push(GCTObject);
                insertList.push(HPCTObject);
                insertList.push(XSCTObject);
                insertList.push(HNCTObject);
                insertList.push(SHCTObject);
                insertList.push(CCCTObject);
                insertList.push(GOCTObject);
                //insertList.push(GPCObject);
                insertList.push(GPGObject);
                var dataJason = null;
                dataJason = {deletedRows: [], insertedRows: insertList, updatedRows: []};
                $.ajax({
                    type: "POST",
                    url: "../webresources/login/SbcProductionGoal/save",
                    contentType: "application/json",
                    dataType: "json",
                    data: $.toJSON(dataJason),
                    success: function (data) {
                        HdUtils.dialog.close();
                        HdUtils.messager.bottomRight('保存成功','保存操作');
                        dg.datagrid("hdReload");
                    },
                    error: function (data) {
                    	 HdUtils.messager.info('该计划已添加');
                    }
                });
            }
        });
    });
   
</script>
<!-- form 表单 -->
<form id="SbcProductionGoalYearForm">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCod" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNum" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTyp" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTyp" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescription" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccount" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestamp" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccount" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestamp" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanId" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<!-- <form id="GPCForm3"> -->
<!--     <table> -->
<!--        <tr> -->
<!--             <th><font color="red">*</font>作业公司： </th> -->
<!--             <td><input id="SbcProductionGoalYearCompanyCodGPC" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>         -->
<!--             <th><font color="red">*</font>计划量： </th> -->
<!--             <td><input id="SbcProductionGoalYearPlanNumGPC" name="planNum" style="width:90px" data-options='required:true, max: "999999999999999999.99",class="easyui-numberbox"/></td>        -->
<!--             <th><font color="red">*</font>箱货类型： </th> -->
<!--             <td><input id="SbcProductionGoalYearBulkTypGPC" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>              -->
<!--             <th><font color="red">*</font>计划类别： </th> -->
<!--             <td><input id="SbcProductionGoalYearProdPlanTypGPC" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>               -->
<!--             <th><font color="red">*</font>年： </th> -->
<!--             <td><input id="SbcProductionGoalProdPlanYmdYear11GPC" name="prodPlanYmd" style="width:60px"  /></td>          -->
<!--             <td><input id="SbcProductionGoalYearDescriptionGPC" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td> -->
<!--             <input id="SbcProductionGoalYearInsAccountGPC" name="insAccount"   type="hidden"/> -->
<!--             <input id="SbcProductionGoalYearInsTimestampGPC" name="insTimestamp"   type="hidden" /> -->
<!--             <input id="SbcProductionGoalYearUpdAccountGPC" name="updAccount"  type="hidden" /> -->
<!--             <input id="SbcProductionGoalYearUpdTimestampGPC" name="updTimestamp"   type="hidden"/> -->
<!--             <input id="SbcProductionGoalYearPlanIdGPC" name="planId"  type="hidden" /> -->
<!--         </tr> -->
<!--     </table> -->
<!-- </form> -->
<form id="NCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumNCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypNCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11NCT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionNCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdNCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="GOCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodGOCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumGOCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypGOCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypGOCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11GOCT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionGOCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountGOCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampGOCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountGOCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampGOCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdGOCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="NICTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodNICT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumNICT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypNICT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypNICT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11NICT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionNICT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountNICT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampNICT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountNICT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampNICT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdNICT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="GCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodGCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumGCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypGCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypGCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11GCT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionGCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountGCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampGCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountGCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampGCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdGCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="HPCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodHPCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumHPCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypHPCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypHPCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11HPCT" name="prodPlanYmd" style="width:60px"  /></td>         
           
            <td><input id="SbcProductionGoalYearDescriptionHPCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountHPCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampHPCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountHPCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampHPCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdHPCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="XSCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodXSCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumXSCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypXSCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypXSCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11XSCT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionXSCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountXSCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampXSCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountXSCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampXSCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdXSCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="HNCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodHNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumHNCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypHNCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypHNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11HNCT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionHNCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountHNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampHNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountHNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampHNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdHNCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="SHCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodSHCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumSHCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypSHCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypSHCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11SHCT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionSHCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountSHCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampSHCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountSHCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampSHCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdSHCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>
<form id="CCCTForm3">
    <table>
       <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalYearCompanyCodCCCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>        
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalYearPlanNumCCCT" name="planNum" style="width:90px" data-options='required:true,precision: 2, max: "999999999999999999.99",groupSeparator:","' class="easyui-numberbox"/></td>       
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalYearBulkTypCCCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>             
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalYearProdPlanTypCCCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>              
            <th><font color="red">*</font>年： </th>
            <td><input id="SbcProductionGoalProdPlanYmdYear11CCCT" name="prodPlanYmd" style="width:60px"  /></td>         
            
            <td><input id="SbcProductionGoalYearDescriptionCCCT" name="description"  data-options="required:false" maxlength="1000" hidden="true" style="width:145px"/></td>
            <input id="SbcProductionGoalYearInsAccountCCCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalYearInsTimestampCCCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalYearUpdAccountCCCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalYearUpdTimestampCCCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalYearPlanIdCCCT" name="planId"  type="hidden" />
        </tr>
    </table>
</form>

