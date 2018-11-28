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
    	var formObject = $("#SbcProductionPlanForm");//gpg
    	//var GPCForm = $("#GPCForm");
    	var NCTForm = $("#NCTForm");
    	var NICTForm = $("#NICTForm");
    	var GCTForm = $("#GCTForm");
    	var HPCTForm = $("#HPCTForm");
    	var XSCTForm = $("#XSCTForm");
    	var HNCTForm = $("#HNCTForm");
    	var SHCTForm = $("#SHCTForm");
    	var CCCTForm = $("#CCCTForm");
    	var GOCTForm = $("#GOCTForm");
    	
        var dataObject = HdUtils.dialog.getValue("data");
        var dg = HdUtils.dialog.getValue("dataGrid");
        formObject.form("loadData", dataObject);
        $("#SbcProductionPlanCompanyCodGPG").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodGPG").combogrid("setValue","GPG");
        $("#SbcProductionPlanBulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTyp").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTyp").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTyp").combobox("setValue","M");
      
//         $("#SbcProductionPlanCompanyCodGPC").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
//         $("#SbcProductionPlanCompanyCodGPC").combogrid("setValue","GPC");
//         $("#SbcProductionPlanBulkTypGPC").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
//         $("#SbcProductionPlanBulkTypGPC").combobox("setValue","B");
//         $("#SbcProductionPlanProdPlanTypGPC").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
//         $("#SbcProductionPlanProdPlanTypGPC").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodNCT").combogrid("setValue","NCT");
        $("#SbcProductionPlanBulkTypNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypNCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypNCT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodNICT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodNICT").combogrid("setValue","NICT");
        $("#SbcProductionPlanBulkTypNICT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypNICT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypNICT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypNICT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodGCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodGCT").combogrid("setValue","GCT");
        $("#SbcProductionPlanBulkTypGCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypGCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypGCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypGCT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodHPCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodHPCT").combogrid("setValue","HPCT");
        $("#SbcProductionPlanBulkTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypHPCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypHPCT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodXSCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodXSCT").combogrid("setValue","XSCT");
        $("#SbcProductionPlanBulkTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypXSCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypXSCT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodHNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodHNCT").combogrid("setValue","HNCT");
        $("#SbcProductionPlanBulkTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypHNCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypHNCT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodSHCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodSHCT").combogrid("setValue","SHCT");
        $("#SbcProductionPlanBulkTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypSHCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypSHCT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodCCCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodCCCT").combogrid("setValue","CCCT");
        $("#SbcProductionPlanBulkTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypCCCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypCCCT").combobox("setValue","M");

        $("#SbcProductionPlanCompanyCodGOCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionPlanCompanyCodGOCT").combogrid("setValue","GOCT");
        $("#SbcProductionPlanBulkTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanBulkTypGOCT").combobox("setValue","B");
        $("#SbcProductionPlanProdPlanTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionPlanProdPlanTypGOCT").combobox("setValue","M");

        
        
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
        $('#SbcProductionGoalProdPlanYmdMonth1').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
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
//           $('#SbcProductionGoalProdPlanYmdMonth1GPC').numberspinner({    
//               min: 1,    
//               max: 12, 
//               value:month,
//               required:true,
//               editable: false   
//               });
          $('#SbcProductionGoalProdPlanYmdYear1NCT').numberspinner({    
              min: 2000,    
              max: year+15, 
              value:year,
              required:true,
              editable: false   
              });  
            $('#SbcProductionGoalProdPlanYmdMonth1NCT').numberspinner({    
                min: 1,    
                max: 12, 
                value:month,
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
              $('#SbcProductionGoalProdPlanYmdMonth1NICT').numberspinner({    
                  min: 1,    
                  max: 12, 
                  value:month,
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
                $('#SbcProductionGoalProdPlanYmdMonth1GCT').numberspinner({    
                    min: 1,    
                    max: 12, 
                    value:month,
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
                  $('#SbcProductionGoalProdPlanYmdMonth1HPCT').numberspinner({    
                      min: 1,    
                      max: 12, 
                      value:month,
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
                    $('#SbcProductionGoalProdPlanYmdMonth1XSCT').numberspinner({    
                        min: 1,    
                        max: 12, 
                        value:month,
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
                      $('#SbcProductionGoalProdPlanYmdMonth1HNCT').numberspinner({    
                          min: 1,    
                          max: 12, 
                          value:month,
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
                        $('#SbcProductionGoalProdPlanYmdMonth1SHCT').numberspinner({    
                            min: 1,    
                            max: 12, 
                            value:month,
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
                          $('#SbcProductionGoalProdPlanYmdMonth1CCCT').numberspinner({    
                              min: 1,    
                              max: 12, 
                              value:month,
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
                            $('#SbcProductionGoalProdPlanYmdMonth1GOCT').numberspinner({    
                                min: 1,    
                                max: 12, 
                                value:month,
                                required:true,
                                editable: false   
                                });
        
        HdUtils.dialog.setValue({
            saveHandler: function () {
            	
                var GPGObject = formObject.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1").val().length==1){
                    var mon1="0"+$("#SbcProductionGoalProdPlanYmdMonth1").val();
                }
                GPGObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1").val()+mon1;
               
//                 var GPCObject = GPCForm.form('getData');
//                 if($("#SbcProductionGoalProdPlanYmdMonth1GPC").val().length==1){
//                     var mon2="0"+$("#SbcProductionGoalProdPlanYmdMonth1GPC").val();
//                 }
//                 GPCObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1GPC").val()+mon2;
                
                var NICTObject = NICTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1NICT").val().length==1){
                    var mon3="0"+$("#SbcProductionGoalProdPlanYmdMonth1NICT").val();
                }
                NICTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1NICT").val()+mon3;
                
                var GCTObject = GCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1GCT").val().length==1){
                    var mon5="0"+$("#SbcProductionGoalProdPlanYmdMonth1GCT").val();
                }
                GCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1GCT").val()+mon5;

                var HPCTObject = HPCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1HPCT").val().length==1){
                    var mon5="0"+$("#SbcProductionGoalProdPlanYmdMonth1HPCT").val();
                }
                HPCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1HPCT").val()+mon5;

                var XSCTObject = XSCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1XSCT").val().length==1){
                    var mon6="0"+$("#SbcProductionGoalProdPlanYmdMonth1XSCT").val();
                }
                XSCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1XSCT").val()+mon6;

                var HNCTObject = HNCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1HNCT").val().length==1){
                    var mon7="0"+$("#SbcProductionGoalProdPlanYmdMonth1HNCT").val();
                }
                HNCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1HNCT").val()+mon7;

                var SHCTObject = SHCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1SHCT").val().length==1){
                    var mon8="0"+$("#SbcProductionGoalProdPlanYmdMonth1SHCT").val();
                }
                SHCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1SHCT").val()+mon8;

                var CCCTObject = CCCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1CCCT").val().length==1){
                    var mon9="0"+$("#SbcProductionGoalProdPlanYmdMonth1CCCT").val();
                }
                CCCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1CCCT").val()+mon9;

                var GOCTObject = GOCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1GOCT").val().length==1){
                    var mon10="0"+$("#SbcProductionGoalProdPlanYmdMonth1GOCT").val();
                }
                GOCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1GOCT").val()+mon10;
                var NCTObject = NCTForm.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth1NCT").val().length==1){
                    var mon11="0"+$("#SbcProductionGoalProdPlanYmdMonth1NCT").val();
                }
                NCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear1NCT").val()+mon11;
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
<form id="SbcProductionPlanForm">
    <table id="SbcProductionPlanTable" >
        <tr>
            
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodGPG" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
               <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNum" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTyp" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTyp" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescription" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccount" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestamp" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccount" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestamp" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanId" name="planId"  type="hidden" />
        </tr>
         </table>
</form>
<!-- <form id="GPCForm"> -->
<!--  <table> -->
<!--         <tr> -->
<!--             <th><font color="red">*</font>作业公司： </th> -->
<!--             <td><input id="SbcProductionPlanCompanyCodGPC" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td> -->
<!--                <th><font color="red">*</font>计划量：</th> -->
<!--             <td><input id="SbcProductionPlanPlanNumGPC" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td> -->
<!--            <th><font color="red">*</font>箱货类型： </th> -->
<!--             <td><input id="SbcProductionPlanBulkTypGPC" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>       -->
<!--            <th><font color="red">*</font>计划类别： </th> -->
<!--             <td><input id="SbcProductionPlanProdPlanTypGPC" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>         -->
<!--            <th><font color="red">*</font>计划年月：</th> -->
<!--             <td> -->
<!--             <input id='SbcProductionPlanProdPlanYmd1GPC' name="prodPlanYmd" hidden='true'/> -->
<!--             <input id="SbcProductionGoalProdPlanYmdYear1GPC"  style="width:60px"/> -->
<!--             </td> -->
<!--             <td>      -->
<!--             <input id="SbcProductionGoalProdPlanYmdMonth1GPC"  style="width:40px"/> -->
<!--             </td> -->
<!--              <td><input id="SbcProductionPlanDescriptionGPC" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td> -->
<!--             <input id="SbcProductionPlanInsAccountGPC" name="insAccount"   type="hidden"/> -->
<!--             <input id="SbcProductionPlanInsTimestampGPC" name="insTimestamp"   type="hidden" /> -->
<!--             <input id="SbcProductionPlanUpdAccountGPC" name="updAccount"  type="hidden" /> -->
<!--             <input id="SbcProductionPlanUpdTimestampGPC" name="updTimestamp"   type="hidden"/> -->
<!--             <input id="SbcProductionPlanPlanIdGPC" name="planId"  type="hidden" /> -->
<!--         </tr> -->
<!--  </table> -->
<!-- </form>       -->
    
<form id="NCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
           <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumNCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypNCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1NCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1NCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1NCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionNCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdNCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>    

<form id="GOCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodGOCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
           <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumGOCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypGOCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypGOCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1GOCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1GOCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1GOCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionGOCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountGOCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampGOCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountGOCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampGOCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdGOCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form> 
  
<form id="NICTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodNICT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumNICT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypNICT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypNICT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1NICT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1NICT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1NICT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionNICT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountNICT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampNICT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountNICT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampNICT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdNICT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="GCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodGCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumGCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypGCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypGCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1GCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1GCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1GCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionGCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountGCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampGCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountGCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampGCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdGCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="HPCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodHPCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumHPCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypHPCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypHPCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1HPCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1HPCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1HPCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionHPCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountHPCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampHPCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountHPCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampHPCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdHPCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="XSCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodXSCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
           <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumXSCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypXSCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypXSCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1XSCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1XSCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1XSCT"  style="width:40px"/>
            </td>
             <td><input id="SbcProductionPlanDescriptionXSCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountXSCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampXSCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountXSCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampXSCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdXSCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
<form id="HNCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodHNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumHNCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypHNCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypHNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1HNCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1HNCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1HNCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionHNCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountHNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampHNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountHNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampHNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdHNCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      

<form id="SHCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodSHCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
          <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumSHCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypSHCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypSHCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1SHCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1SHCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1SHCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionSHCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountSHCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampSHCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountSHCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampSHCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdSHCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>      
  
  <form id="CCCTForm">
 <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionPlanCompanyCodCCCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量：</th>
            <td><input id="SbcProductionPlanPlanNumCCCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999' class="easyui-numberbox"/></td>
           <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionPlanBulkTypCCCT" name="bulkTyp" data-options="required:true"  class="easyui-validatebox"/></td>      
           <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionPlanProdPlanTypCCCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>        
           <th><font color="red">*</font>计划年月：</th>
            <td>
            <input id='SbcProductionPlanProdPlanYmd1CCCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear1CCCT"  style="width:60px"/>
            </td>
            <td>     
            <input id="SbcProductionGoalProdPlanYmdMonth1CCCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionPlanDescriptionCCCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionPlanInsAccountCCCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionPlanInsTimestampCCCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionPlanUpdAccountCCCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionPlanUpdTimestampCCCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionPlanPlanIdCCCT" name="planId"  type="hidden" />
        </tr>
 </table>
</form>  