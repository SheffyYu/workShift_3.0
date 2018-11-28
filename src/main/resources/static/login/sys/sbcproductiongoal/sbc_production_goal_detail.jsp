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
        var formObject = $("#SbcProductionGoalForm");//GPG
        //var GPCForm2 = $("#GPCForm2");
    	var NCTForm2 = $("#NCTForm2");
    	var NICTForm2 = $("#NICTForm2");
    	var GCTForm2 = $("#GCTForm2");
    	var HPCTForm2 = $("#HPCTForm2");
    	var XSCTForm2 = $("#XSCTForm2");
    	var HNCTForm2 = $("#HNCTForm2");
    	var SHCTForm2 = $("#SHCTForm2");
    	var CCCTForm2 = $("#CCCTForm2");
    	var GOCTForm2 = $("#GOCTForm2");
        var dataObject = HdUtils.dialog.getValue("data");
        var dg = HdUtils.dialog.getValue("dataGrid");
        formObject.form("loadData", dataObject);
        $("#SbcProductionGoalCompanyCod").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCod").combogrid("setValue","GPG");
        $("#SbcProductionGoalBulkTyp").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTyp").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTyp").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTyp").combobox("setValue","M");
        
        //$("#SbcProductionGoalCompanyCodGPC").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        //$("#SbcProductionGoalCompanyCodGPC").combogrid("setValue","GPC");
       // $("#SbcProductionGoalBulkTypGPC").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
       // $("#SbcProductionGoalBulkTypGPC").combobox("setValue","B");
       // $("#SbcProductionGoalProdPlanTypGPC").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
       // $("#SbcProductionGoalProdPlanTypGPC").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodNCT").combogrid("setValue","NCT");
        $("#SbcProductionGoalBulkTypNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypNCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypNCT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodNICT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodNICT").combogrid("setValue","NICT");
        $("#SbcProductionGoalBulkTypNICT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypNICT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypNICT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypNICT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodGCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodGCT").combogrid("setValue","GCT");
        $("#SbcProductionGoalBulkTypGCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypGCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypGCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypGCT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodHPCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodHPCT").combogrid("setValue","HPCT");
        $("#SbcProductionGoalBulkTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypHPCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypHPCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypHPCT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodXSCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodXSCT").combogrid("setValue","XSCT");
        $("#SbcProductionGoalBulkTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypXSCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypXSCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypXSCT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodHNCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodHNCT").combogrid("setValue","HNCT");
        $("#SbcProductionGoalBulkTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypHNCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypHNCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypHNCT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodSHCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodSHCT").combogrid("setValue","SHCT");
        $("#SbcProductionGoalBulkTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypSHCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypSHCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypSHCT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodCCCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodCCCT").combogrid("setValue","CCCT");
        $("#SbcProductionGoalBulkTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypCCCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypCCCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypCCCT").combobox("setValue","M");
        
        $("#SbcProductionGoalCompanyCodGOCT").combogrid(HdUtils.code.findVwGroupOrgn({required:true, textField: 'companyNam', width:80}));
        $("#SbcProductionGoalCompanyCodGOCT").combogrid("setValue","GOCT");
        $("#SbcProductionGoalBulkTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'BULK_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalBulkTypGOCT").combobox("setValue","B");
        $("#SbcProductionGoalProdPlanTypGOCT").combobox(HdUtils.code.scode({fieldCod: 'PROD_PLAN_TYP'},{required:true, width:80}));
        $("#SbcProductionGoalProdPlanTypGOCT").combobox("setValue","M");
      
        
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
        
        $('#SbcProductionGoalProdPlanYmdYear').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonth').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
//         $('#SbcProductionGoalProdPlanYmdYearGPC').numberspinner({    
//             min: 2000,    
//             max: year+15, 
//             value:year,
//             required:true,
//             editable: false   
//         });  
//         $('#SbcProductionGoalProdPlanYmdMonthGPC').numberspinner({    
//             min: 1,    
//             max: 12, 
//             value:month,
//             required:true,
//             editable: false   
//         });
        $('#SbcProductionGoalProdPlanYmdYearNCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthNCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearNICT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthNICT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearGCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthGCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearHPCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthHPCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearXSCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthXSCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearHNCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthHNCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearSHCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthSHCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearCCCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthCCCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        $('#SbcProductionGoalProdPlanYmdYearGOCT').numberspinner({    
            min: 2000,    
            max: year+15, 
            value:year,
            required:true,
            editable: false   
        });  
        $('#SbcProductionGoalProdPlanYmdMonthGOCT').numberspinner({    
            min: 1,    
            max: 12, 
            value:month,
            required:true,
            editable: false   
        });
        HdUtils.dialog.setValue({
            saveHandler: function () {
                var GPGObject = formObject.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonth").val().length==1){
                	var mon="0"+$("#SbcProductionGoalProdPlanYmdMonth").val();
                }
                GPGObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYear").val()+mon;
                
                //var GPCObject = GPCForm2.form('getData');
//                 if($("#SbcProductionGoalProdPlanYmdMonthGPC").val().length==1){
//                 	var mon1="0"+$("#SbcProductionGoalProdPlanYmdMonthGPC").val();
//                 }
//                 GPCObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearGPC").val()+mon1;
                
                var NCTObject = NCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthNCT").val().length==1){
                	var mon2="0"+$("#SbcProductionGoalProdPlanYmdMonthNCT").val();
                }
                NCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearNCT").val()+mon2;
                
                var NICTObject = NICTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthNICT").val().length==1){
                	var mon3="0"+$("#SbcProductionGoalProdPlanYmdMonthNICT").val();
                }
                NICTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearNICT").val()+mon3;
                
                var GCTObject = GCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthGCT").val().length==1){
                	var mon4="0"+$("#SbcProductionGoalProdPlanYmdMonthGCT").val();
                }
                GCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearGCT").val()+mon4;
                
                var HPCTObject = HPCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthHPCT").val().length==1){
                	var mon5="0"+$("#SbcProductionGoalProdPlanYmdMonthHPCT").val();
                }
                HPCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearHPCT").val()+mon5;
                
                var XSCTObject = XSCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthXSCT").val().length==1){
                	var mon6="0"+$("#SbcProductionGoalProdPlanYmdMonthXSCT").val();
                }
                XSCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearXSCT").val()+mon6;
                
                var HNCTObject = HNCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthHNCT").val().length==1){
                	var mon7="0"+$("#SbcProductionGoalProdPlanYmdMonthHNCT").val();
                }
                HNCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearHNCT").val()+mon7;
                
                var SHCTObject = SHCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthSHCT").val().length==1){
                	var mon8="0"+$("#SbcProductionGoalProdPlanYmdMonthSHCT").val();
                }
                SHCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearSHCT").val()+mon8;
                
                var CCCTObject = CCCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthCCCT").val().length==1){
                	var mon9="0"+$("#SbcProductionGoalProdPlanYmdMonthCCCT").val();
                }
                CCCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearCCCT").val()+mon9;
                
                var GOCTObject = GOCTForm2.form('getData');
                if($("#SbcProductionGoalProdPlanYmdMonthGOCT").val().length==1){
                	var mon10="0"+$("#SbcProductionGoalProdPlanYmdMonthGOCT").val();
                }
                GOCTObject.prodPlanYmd=$("#SbcProductionGoalProdPlanYmdYearGOCT").val()+mon10;
                
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
<form id="SbcProductionGoalForm"><!-- GPG -->
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCod" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNum" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTyp" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTyp" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmd' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYear"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonth"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescription" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccount" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestamp" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccount" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestamp" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanId" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<!-- <form id="GPCForm2"> -->
<!--     <table> -->
<!--         <tr> -->
<!--             <th><font color="red">*</font>作业公司： </th> -->
<!--             <td><input id="SbcProductionGoalCompanyCodGPC" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td> -->
<!--             <th><font color="red">*</font>计划量： </th> -->
<!--             <td><input id="SbcProductionGoalPlanNumGPC" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td> -->
<!--             <th><font color="red">*</font>箱货类型： </th> -->
<!--             <td><input id="SbcProductionGoalBulkTypGPC" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td>  -->
<!--             <th><font color="red">*</font>计划类别： </th> -->
<!--             <td><input id="SbcProductionGoalProdPlanTypGPC" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                 -->
<!--             <th><font color="red">*</font>计划年月： </th> -->
<!--             <td> -->
<!--             <input id='SbcProductionGoalProdPlanYmdGPC' name="prodPlanYmd" hidden='true'/> -->
<!--             <input id="SbcProductionGoalProdPlanYmdYearGPC"  style="width:60px"/> -->
<!--             </td> -->
<!--             <td>             -->
<!--             <input id="SbcProductionGoalProdPlanYmdMonthGPC"  style="width:40px"/> -->
<!--             </td> -->
<!--             <td><input id="SbcProductionGoalDescriptionGPC" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td> -->
<!--             <input id="SbcProductionGoalInsAccountGPC" name="insAccount"   type="hidden"/> -->
<!--             <input id="SbcProductionGoalInsTimestampGPC" name="insTimestamp"   type="hidden" /> -->
<!--             <input id="SbcProductionGoalUpdAccountGPC" name="updAccount"  type="hidden" /> -->
<!--             <input id="SbcProductionGoalUpdTimestampGPC" name="updTimestamp"   type="hidden"/> -->
<!--             <input id="SbcProductionGoalPlanIdGPC" name="planId"  type="hidden" /> -->
<!--         </tr> -->
       
<!--     </table> -->
<!-- </form> -->
<form id="NCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumNCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypNCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdNCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearNCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthNCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionNCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdNCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="GOCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodGOCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumGOCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypGOCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypGOCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdGOCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearGOCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthGOCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionGOCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountGOCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampGOCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountGOCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampGOCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdGOCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="NICTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodNICT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumNICT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypNICT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypNICT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdNICT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearNICT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthNICT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionNICT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountNICT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampNICT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountNICT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampNICT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdNICT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="GCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodGCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumGCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypGCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypGCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdGCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearGCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthGCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionGCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountGCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampGCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountGCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampGCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdGCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="HPCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodHPCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumHPCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypHPCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypHPCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdHPCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearHPCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthHPCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionHPCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountHPCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampHPCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountHPCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampHPCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdHPCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="XSCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodXSCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumXSCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypXSCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypXSCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdXSCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearXSCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthXSCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionXSCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountXSCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampXSCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountXSCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampXSCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdXSCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="HNCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodHNCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumHNCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypHNCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypHNCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdHNCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearHNCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthHNCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionHNCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountHNCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampHNCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountHNCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampHNCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdHNCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="SHCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodSHCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumSHCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypSHCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypSHCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdSHCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearSHCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthSHCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionSHCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountSHCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampSHCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountSHCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampSHCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdSHCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>
<form id="CCCTForm2">
    <table>
        <tr>
            <th><font color="red">*</font>作业公司： </th>
            <td><input id="SbcProductionGoalCompanyCodCCCT" name="companyCod" data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>计划量： </th>
            <td><input id="SbcProductionGoalPlanNumCCCT" name="planNum" style="width:90px" data-options='required:true,precision: 0, max: 999999999999999999,groupSeparator:","' class="easyui-numberbox"/></td>
            <th><font color="red">*</font>箱货类型： </th>
            <td><input id="SbcProductionGoalBulkTypCCCT" name="bulkTyp" data-options="required:true" class="easyui-validatebox"/></td> 
            <th><font color="red">*</font>计划类别： </th>
            <td><input id="SbcProductionGoalProdPlanTypCCCT" name="prodPlanTyp" data-options="required:true"  disabled="true" class="easyui-validatebox"/></td>                
            <th><font color="red">*</font>计划年月： </th>
            <td>
            <input id='SbcProductionGoalProdPlanYmdCCCT' name="prodPlanYmd" hidden='true'/>
            <input id="SbcProductionGoalProdPlanYmdYearCCCT"  style="width:60px"/>
            </td>
            <td>            
            <input id="SbcProductionGoalProdPlanYmdMonthCCCT"  style="width:40px"/>
            </td>
            <td><input id="SbcProductionGoalDescriptionCCCT" name="description"  type="hidden" data-options="required:false" maxlength="1000" style="width:145px"/></td>
            <input id="SbcProductionGoalInsAccountCCCT" name="insAccount"   type="hidden"/>
            <input id="SbcProductionGoalInsTimestampCCCT" name="insTimestamp"   type="hidden" />
            <input id="SbcProductionGoalUpdAccountCCCT" name="updAccount"  type="hidden" />
            <input id="SbcProductionGoalUpdTimestampCCCT" name="updTimestamp"   type="hidden"/>
            <input id="SbcProductionGoalPlanIdCCCT" name="planId"  type="hidden" />
        </tr>
       
    </table>
</form>