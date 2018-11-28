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
        //月度计划
        var formObject = $("#SbcProductionPlanYearForm1");//gpg
        //var GPCForm = $("#GPCForm1");
        var NCTForm = $("#NCTForm1");
        var NICTForm = $("#NICTForm1");
        var GCTForm = $("#GCTForm1");
        var HPCTForm = $("#HPCTForm1");
        var XSCTForm = $("#XSCTForm1");
        var HNCTForm = $("#HNCTForm1");
        var SHCTForm = $("#SHCTForm1");
        var CCCTForm = $("#CCCTForm1");
        var GOCTForm = $("#GOCTForm1");
        
        var dataObject = HdUtils.dialog.getValue("data");
        var dg = HdUtils.dialog.getValue("dataGrid");
        formObject.form("loadData", dataObject);
        $("#SbcProductionPlanYearCompanyCodGPG").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodGPG").combogrid("setValue","GPG");
        $("#SbcProductionPlanYearBulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTyp").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTyp").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTyp").combobox("setValue","Y");
      
//         $("#SbcProductionPlanYearCompanyCodGPC").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
//         $("#SbcProductionPlanYearCompanyCodGPC").combogrid("setValue","GPC");
//         $("#SbcProductionPlanYearBulkTypGPC").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
//         $("#SbcProductionPlanYearBulkTypGPC").combobox("setValue","B");
//         $("#SbcProductionPlanYearProdPlanTypGPC").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
//         $("#SbcProductionPlanYearProdPlanTypGPC").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodNCT").combogrid("setValue","NCT");
        $("#SbcProductionPlanYearBulkTypNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypNCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypNCT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodNICT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodNICT").combogrid("setValue","NICT");
        $("#SbcProductionPlanYearBulkTypNICT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypNICT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypNICT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypNICT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodGCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodGCT").combogrid("setValue","GCT");
        $("#SbcProductionPlanYearBulkTypGCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypGCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypGCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypGCT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodHPCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodHPCT").combogrid("setValue","HPCT");
        $("#SbcProductionPlanYearBulkTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypHPCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypHPCT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodXSCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodXSCT").combogrid("setValue","XSCT");
        $("#SbcProductionPlanYearBulkTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypXSCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypXSCT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodHNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodHNCT").combogrid("setValue","HNCT");
        $("#SbcProductionPlanYearBulkTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypHNCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypHNCT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodSHCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodSHCT").combogrid("setValue","SHCT");
        $("#SbcProductionPlanYearBulkTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypSHCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypSHCT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodCCCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodCCCT").combogrid("setValue","CCCT");
        $("#SbcProductionPlanYearBulkTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypCCCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypCCCT").combobox("setValue","Y");

        $("#SbcProductionPlanYearCompanyCodGOCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanYearCompanyCodGOCT").combogrid("setValue","GOCT");
        $("#SbcProductionPlanYearBulkTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearBulkTypGOCT").combobox("setValue","B");
        $("#SbcProductionPlanYearProdPlanTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanYearProdPlanTypGOCT").combobox("setValue","Y");

        var year= new Date(new Date()).format("yyyy-MM").substring(0,4);
        var  month=new Date(new Date()).format("yyyy-MM").substring(5,7);
        var date00=formObject.form('getData').prodPlanYmd;
        if(date00==null||date00==""){
            year =new Date(new Date()).format("yyyy-MM").substring(0,4);
            month=new Date(new Date()).format("yyyy-MM").substring(5,7)-1;
        }else{
            year= date00.substring(0,4);
            month=date00.substring(4,6)-1;
        }
        
        $('#SbcProductionGoalProdPlanYmdYear1').numberspinner({    
          min: 2000,    
          max: year+15, 
          value:year,
          required:true,
          editable: false   
          });  
     
//         $('#SbcProductionGoalProdPlanYmdYear1GPC').numberspinner({    
//             min: 2000,    
//             max: year+15, 
//             value:year,
//             required:true,
//             editable: false   
//             });  
        
          $('#SbcProductionGoalProdPlanYmdYear1NCT').numberspinner({    
              min: 2000,    
              max: year+15, 
              value:year,
              required:true,
              editable: false   
              });  
          
            $('#SbcProductionGoalProdPlanYmdYear1NICT').numberspinner({    
                min: 2000,    
                max: year+15, 
                value:year,
                required:true,
                editable: false   
                });  
             
              $('#SbcProductionGoalProdPlanYmdYear1GCT').numberspinner({    
                  min: 2000,    
                  max: year+15, 
                  value:year,
                  required:true,
                  editable: false   
                  });  
             
                $('#SbcProductionGoalProdPlanYmdYear1HPCT').numberspinner({    
                    min: 2000,    
                    max: year+15, 
                    value:year,
                    required:true,
                    editable: false   
                    });  
               
                  $('#SbcProductionGoalProdPlanYmdYear1XSCT').numberspinner({    
                      min: 2000,    
                      max: year+15, 
                      value:year,
                      required:true,
                      editable: false   
                      });  
                   
                    $('#SbcProductionGoalProdPlanYmdYear1HNCT').numberspinner({    
                        min: 2000,    
                        max: year+15, 
                        value:year,
                        required:true,
                        editable: false   
                        });  
                  
                      $('#SbcProductionGoalProdPlanYmdYear1SHCT').numberspinner({    
                          min: 2000,    
                          max: year+15, 
                          value:year,
                          required:true,
                          editable: false   
                          });  
                     
                        $('#SbcProductionGoalProdPlanYmdYear1CCCT').numberspinner({    
                            min: 2000,    
                            max: year+15, 
                            value:year,
                            required:true,
                            editable: false   
                            });  
                   
                          $('#SbcProductionGoalProdPlanYmdYear1GOCT').numberspinner({    
                              min: 2000,    
                              max: year+15, 
                              value:year,
                              required:true,
                              editable: false   
                              });  
                        
        
        HdUtils.dialog.setValue({
            saveHandler: function () {
                
                var GPGObject = formObject.form('getData');
                GPGObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1").val();
//                 var GPCObject = GPCForm.form('getData');
//                 GPCObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1GPC").val();
                var NICTObject = NICTForm.form('getData');
                NICTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1NICT").val();
                var GCTObject = GCTForm.form('getData');
                GCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1GCT").val();
                var HPCTObject = HPCTForm.form('getData');
                HPCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1HPCT").val();
                var XSCTObject = XSCTForm.form('getData');
                XSCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1XSCT").val();
                var HNCTObject = HNCTForm.form('getData');
                HNCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1HNCT").val();
                var SHCTObject = SHCTForm.form('getData');
                SHCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1SHCT").val();
                var CCCTObject = CCCTForm.form('getData');
                CCCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1CCCT").val();
                var GOCTObject = GOCTForm.form('getData');
                GOCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1GOCT").val();
                var NCTObject = NCTForm.form('getData');
                NCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1NCT").val();
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
               // insertList.push(GPCObject);
                insertList.push(GPGObject);
                var dataJason = null;
                dataJason = {deletedRows: [], insertedRows: insertList, updatedRows: []};
                $.ajax({
                    type: "POST",
                    url: "../webresources/login/SbcProductionPlan/save",
                    contentType: "application/json",
                    dataType: "json",
                    data: $.toJSON(dataJason),
                    success: function (data) {
                        HdUtils.dialog.close();
                        HdUtils.messager.bottomRight('提示','保存成功');
                        dg.datagrid("hdReload");
                    },
                    error: function (data) {
                        HdUtils.messager.info('计划已添加');
                    }
                });
            }
        });
    });

</script>
<form id="SbcProductionPlanYearForm1">
    <table id="SbcProductionPlanYearTable" >
        <tr>
            
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodGPG" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
               <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNum" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTyp" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTyp" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescription" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccount" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestamp" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccount" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestamp" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanId" name="planId"  type="hidden" />
        </tr>
         </table>
</form>
<!-- <form id="GPCForm1"> -->
<!--  <table> -->
<!--         <tr> -->
<!--             <th><font color="red">*</font>作业公司： </th> -->
<!--             <td><input id="SbcProductionPlanYearCompanyCodGPC" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td> -->
<!--                <th><font color="red">*</font>计划量：</th> -->
<!--             <td><input id="SbcProductionPlanYearPlanNumGPC" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td> -->
<!--            <th><font color="red">*</font>箱货类型： </th> -->
<!--             <td><input id="SbcProductionPlanYearBulkTypGPC" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>       -->
<!--            <th><font color="red">*</font>计划类别： </th> -->
<!--             <td><input id="SbcProductionPlanYearProdPlanTypGPC" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>         -->
<!--            <th><font color="red">*</font>月：</th> -->
<!--             <td> -->
<!--             <input id='SbcProductionPlanYearProdPlanYmd1GPC' name="prodPlanYmd" hidden='true'/> -->
<!--             <input id="SbcProductionGoalProdPlanYmdYear1GPC"  style="width:60px"/> -->
<!--             </td> -->
<!--              <td><input id="SbcProductionPlanYearDescriptionGPC" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td> -->
<!--             <input id="SbcProductionPlanYearInsAccountGPC" name="insAccount"   type="hidden"/> -->
<!--             <input id="SbcProductionPlanYearInsTimestampGPC" name="insTimestamp"   type="hidden" /> -->
<!--             <input id="SbcProductionPlanYearUpdAccountGPC" name="updAccount"  type="hidden" /> -->
<!--             <input id="SbcProductionPlanYearUpdTimestampGPC" name="updTimestamp"   type="hidden"/> -->
<!--             <input id="SbcProductionPlanYearPlanIdGPC" name="planId"  type="hidden" /> -->
<!--         </tr> -->
<!--  </table> -->
<!-- </form>       -->
    
<form id="NCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
           <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumNCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypNCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1NCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1NCT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionNCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdNCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>    

<form id="GOCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodGOCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
           <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumGOCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypGOCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypGOCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1GOCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1GOCT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionGOCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountGOCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampGOCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountGOCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampGOCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdGOCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form> 
  
<form id="NICTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodNICT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumNICT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypNICT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypNICT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1NICT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1NICT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionNICT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountNICT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampNICT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountNICT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampNICT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdNICT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="GCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodGCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumGCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypGCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypGCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1GCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1GCT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionGCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountGCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampGCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountGCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampGCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdGCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="HPCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodHPCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumHPCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypHPCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypHPCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1HPCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1HPCT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionHPCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountHPCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampHPCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountHPCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampHPCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdHPCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="XSCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodXSCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
           <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumXSCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypXSCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypXSCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1XSCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1XSCT"  style="width:60px"/>
            </td>
             <td><input id="SbcProductionPlanYearDescriptionXSCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountXSCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampXSCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountXSCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampXSCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdXSCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="HNCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodHNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumHNCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypHNCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypHNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1HNCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1HNCT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionHNCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountHNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampHNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountHNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampHNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdHNCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      

<form id="SHCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodSHCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
          <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumSHCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypSHCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypSHCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1SHCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1SHCT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionSHCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountSHCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampSHCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountSHCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampSHCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdSHCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
  
  <form id="CCCTForm1">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanYearCompanyCodCCCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanYearPlanNumCCCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanYearBulkTypCCCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanYearProdPlanTypCCCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>年：</th>
            <td>
            <input id='SbcProductionPlanYearProdPlanYmd1CCCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1CCCT"  style="width:60px"/>
            </td>
            <td><input id="SbcProductionPlanYearDescriptionCCCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanYearInsAccountCCCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanYearInsTimestampCCCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanYearUpdAccountCCCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanYearUpdTimestampCCCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanYearPlanIdCCCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>  