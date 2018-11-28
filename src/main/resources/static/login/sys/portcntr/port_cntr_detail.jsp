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
    	$("#cntrTypCod1486946776099").combogrid(HdUtils.code.sbcCntrTyp({required:true, width:124}));
    	$("#cntrIso1486946776099").combogrid(HdUtils.code.sbcCntrIso({required:true, width:124}));
    	$("#cntrSizCod1486946776099").combogrid(HdUtils.code.sbcCntrSiz({required:true, width:124}));
    	$("#currentStat1486946776099").combobox(HdUtils.code.scode({fieldCod: 'CURRENT_STAT'},{required:false, width:124}));
    	$("#companyCod1486966544965").combogrid(HdUtils.code.companyId({required:true, width:124}));
    	$("#efMark1486946776099").combobox(HdUtils.code.scode({fieldCod: 'EF_MARK'},{required:true, width:124}));
    	$("#tradeMark1486946776099").combobox(HdUtils.code.scode({fieldCod: 'TRADE_MARK'},{required:true, width:124}));
    	$("#ieMark1486946776099").combobox(HdUtils.code.scode({fieldCod: 'IE_MARK'},{required:false, width:124}));
    	$("#cntrClass1486946776099").combobox(HdUtils.code.scode({fieldCod: 'CNTR_CLASS'},{required:true, width:124}));
    	$("#inTransportMod1486946776099").combobox(HdUtils.code.scode({fieldCod: 'TRANSPORT_MOD'},{required:false, width:124}));
    	$("#outTransportMod1486946776099").combobox(HdUtils.code.scode({fieldCod: 'TRANSPORT_MOD'},{required:false, width:124}));
    	$("#cargoCod1486946776099").combogrid(HdUtils.code.sbcCargo({required:false, width:124}));      
    	$("#transTyp1486946776099").combobox(HdUtils.code.scode({fieldCod: 'TRANS_TYP'},{required:false, width:124}));
    	$("#inspectionStat1486946776099").combobox(HdUtils.code.scode({fieldCod: 'INSPECTION_STAT'},{required:true, width:124}));
    	var formObject = $("#PortCntrForm1486946776099");
        var dataObject = HdUtils.dialog.getValue("data");
        var dg = HdUtils.dialog.getValue("dataGrid");
        if(dataObject.type === "ADD") {   
        	/* $("#cntrVisitNo1486946776099").validatebox({//验证代码唯一性
        	  	validType:'isCodeRepeat["","PortCntr","cntrVisitNo"]'
        	}); */
        	$("#cntr1486946776099").validatebox({//验证代码唯一性
        	  	validType:'isCodeRepeat["","PortCntr","cntr"]'
        	});
        } else {  
         	//document.getElementById("cntrVisitNo1486946776099").disabled=true; 
         	document.getElementById("cntr1486946776099").disabled=true;
        }
        formObject.form("loadData", dataObject);
        
        if(dataObject.lclMark==1) {
         	document.getElementById("lclMark1486946776099").checked = true;
        }
        if(dataObject.dangMark==1) {
          	document.getElementById("dangMark1486946776099").checked = true;
        }
        if(dataObject.reefMark==1) {
          	document.getElementById("reefMark1486946776099").checked = true;
        }
        if(dataObject.oogMark==1) {
         	document.getElementById("oogMark1486946776099").checked = true;
        }
        if(dataObject.damMark==1) {
          	document.getElementById("damMark1486946776099").checked = true;
        }
        if(dataObject.bundleMark==1) {
          	document.getElementById("bundleMark1486946776099").checked = true;
        }
        if(dataObject.transMark==1) {
          	document.getElementById("transMark1486946776099").checked = true;
        }
        if(dataObject.customsRelsMark==1) {
          	document.getElementById("customsRelsMark1486946776099").checked = true;
        }
        if(dataObject.ciqRelsMark==1) {
          	document.getElementById("ciqRelsMark1486946776099").checked = true;
        }
        if(dataObject.lockMark==1) {
          	document.getElementById("lockMark1486946776099").checked = true;
        }
        if(dataObject.chkMark==1) {
           	document.getElementById("chkMark1486946776099").checked = true;
        }
        if(dataObject.ptiMark==1) {
           	document.getElementById("ptiMark1486946776099").checked = true;
        }
        if(dataObject.fumigateMark==1) {
           	document.getElementById("fumigateMark1486946776099").checked = true;
        }
        // TODO 
        HdUtils.dialog.setValue({
            saveHandler: function () {
            	var isCntr = $("#cntr1486946776099").val();
            	var isCompanyCod = $("#companyCod1486966544965").combogrid("getValue");
            	var isCntrVisitNo = $("#cntrVisitNo1486946776099").val();
            	var flag;
            	$.ajax({
                    type: "POST",
                    url: "../webresources/login/common/countCntr?code=" + isCompanyCod + "&&value="+isCntr,
                    contentType: "application/json",
                    dataType: "text",
                    async: false,
                    success: function (data) {
                      if(data == 1){
                    	  HdUtils.messager.alert('警告','【客户代码】与【箱号】不可重复！');
                      } else{
                        flag = false;
                      }
                    }
                });
            	$.ajax({
                    type: "POST",
                    url: "../webresources/login/common/countCntrVisitNo?code=" + isCompanyCod + "&&value="+isCntrVisitNo,
                    contentType: "application/json",
                    dataType: "text",
                    async: false,
                    success: function (data) {
                      if(data == 1){
                    	  HdUtils.messager.alert('警告','【客户代码】与【箱到港编号】不可重复！');
                      } else{
                        flag = false;
                      }
                    }
                });
            	if(flag==false){
            		return;
            	}
                var changedObject = formObject.form('getData');
                changedObject.cntr = $("#cntr1486946776099").val();
                if(document.getElementById("lclMark1486946776099").checked) {
                	changedObject.lclMark="1";
        	    } else {
        	    	changedObject.lclMark="0";
        	    }
	       	    if(document.getElementById("dangMark1486946776099").checked) {
	       	    	changedObject.dangMark="1";
        	    } else {
        	    	changedObject.dangMark="0";
        	    }
	       	    if(document.getElementById("reefMark1486946776099").checked) {
	       	    	changedObject.reefMark="1";
        	    } else {
        	    	changedObject.reefMark="0";
        	    }  
	       	    if(document.getElementById("oogMark1486946776099").checked) {
	       	    	changedObject.oogMark="1";
        	    } else {
        	    	changedObject.oogMark="0";
	            }
	       	    if(document.getElementById("damMark1486946776099").checked) {
	       	    	changedObject.damMark="1";
        	    } else {
                	changedObject.damMark="0";
	        	}
	       	    if(document.getElementById("bundleMark1486946776099").checked) {
	       	    	changedObject.bundleMark="1";
	        	} else {
	        	    changedObject.bundleMark="0";
	        	}
	       	    if(document.getElementById("transMark1486946776099").checked) {
	       	    	changedObject.transMark="1";
	        	} else {
	        	    changedObject.transMark="0";
	        	}
	       	    if(document.getElementById("customsRelsMark1486946776099").checked) {
	       	    	changedObject.customsRelsMark="1";
	            } else {
	        	  	changedObject.customsRelsMark="0";
	        	}
	       	    if(document.getElementById("ciqRelsMark1486946776099").checked) {
	       	    	changedObject.ciqRelsMark="1";
	        	} else {
	        	    changedObject.ciqRelsMark="0";
	        	}
	       	    if(document.getElementById("lockMark1486946776099").checked) {
	       	    	changedObject.lockMark="1";
	        	} else {
	        	    changedObject.lockMark="0";
	        	}
	       	    if(document.getElementById("chkMark1486946776099").checked) {
	       	    	changedObject.chkMark="1";
	        	} else {
	        	    changedObject.chkMark="0";
	        	}
	       	    if(document.getElementById("ptiMark1486946776099").checked) {
	       	    	changedObject.ptiMark="1";
	        	} else {
	        	    changedObject.ptiMark="0";
	        	}
	       	    if(document.getElementById("fumigateMark1486946776099").checked) {
	       	    	changedObject.fumigateMark="1";
	        	} else {
	        	    changedObject.fumigateMark="0";
	        	}
                var dataJason = null;
                if (dataObject.type === "ADD") {
                    dataJason = {deletedRows: [], insertedRows: [changedObject], updatedRows: []};
                } else {
                    dataJason = {deletedRows: [], insertedRows: [], updatedRows: [changedObject]};
                }
                $.ajax({
                    type: "POST",
                    url: "../webresources/login/PortCntr/save",
                    contentType: "application/json",
                    dataType: "json",
                    data: $.toJSON(dataJason),
                    success: function (data) {
                        HdUtils.dialog.close();
                        HdUtils.messager.bottomRight('保存成功','保存操作');
                        dg.datagrid("hdReload");
                    },
                    error: function (data) {
                        HdUtils.messager.info(data.responseText);
                    }
                });
            }});
    });
</script>
<!-- form 表单 -->
<form id="PortCntrForm1486946776099">
    <table id="PortCntrTable1486946776099" style="height:75%;width:80%" class="tableform">
        <tr>
            <th>箱到港编号: </th>
            <td><input id="cntrVisitNo1486946776099" name="cntrVisitNo" 
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" 
                       data-options="required:false"  class="easyui-validate" maxlength="36"/></td>
            <th>箱号: </th>
            <td><input id="cntr1486946776099" name="cntr"  data-options="required:true" 
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"
                       maxlength="12"/></td>
            <th>当前状态: </th>
            <td><input id="currentStat1486946776099" name="currentStat"/></td>
            <th>箱位: </th>
            <td><input id="cySlotNo1486946776099" name="cySlotNo"  data-options="required:false" maxlength="12"
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th>堆场编号: </th>
            <td><input id="cyBlockNo1486946776099" name="cyBlockNo"  data-options="required:false" maxlength="12"
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>
            <th>堆场贝号: </th>
            <td><input id="cyBayNo1486946776099" name="cyBayNo"  data-options="required:false"  class="easyui-validatebox" maxlength="5"/></td>
            <th>堆场排号: </th>
            <td><input id="cyRowNo1486946776099" name="cyRowNo"  data-options="required:false"  class="easyui-validatebox" maxlength="3"/></td>
            <th>堆场层号: </th>
            <td><input id="cyTierNo1486946776099" name="cyTierNo"  data-options="required:false"  class="easyui-validatebox" maxlength="2"/></td>
        </tr>
        <tr>
            <th>箱ISO代码: </th>
            <td><input id="cntrIso1486946776099" name="cntrIso"  data-options="required:false"  class="easyui-validatebox" maxlength="4"/></td>
            <th><font color="red">*</font>箱尺寸代码: </th>
            <td><input id="cntrSizCod1486946776099" name="cntrSizCod"/></td>
            <th><font color="red">*</font>箱类型代码: </th>
            <td><input id="cntrTypCod1486946776099" name="cntrTypCod"  data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>空重标志: </th>
            <td><input id="efMark1486946776099" name="efMark"  data-options="required:true"/></td>
        </tr>
        <tr>
            <th>拼箱标志: </th>
            <td><input id="lclMark1486946776099" name="lclMark"  data-options="required:false"  type="checkbox"/></td>
            <th><font color="red">*</font>箱公司代码: </th>
            <td><input id="cntrCorpCod1486946776099" name="cntrCorpCod"  data-options="required:true"  class="easyui-validatebox" maxlength="40"/></td>
            <th><font color="red">*</font>箱代理代码: </th>
            <td><input id="cntrOperCod1486946776099" name="cntrOperCod"  data-options="required:true"  class="easyui-validatebox" maxlength="40"/></td>
            <th>箱毛重: </th>
            <td><input id="cntrGrossWgt1486946776099" name="cntrGrossWgt"
                       data-options='required:true,precision: 2, max: "99999999999.99",groupSeparator:","'
                       class="easyui-numberbox"  /></td>
        </tr>
        <tr>
            <th>称重重量: </th>
            <td><input id="cntrRealWgt1486946776099" name="cntrRealWgt"
                       data-options='required:true,precision: 2, max: "99999999.99",groupSeparator:","'
                       class="easyui-numberbox" /></td>
            <th>箱皮重: </th>
            <td><input id="cntrTareWgt1486946776099" name="cntrTareWgt"
                       data-options='required:true,precision: 2, max: "99999999.99",groupSeparator:","'
                       class="easyui-numberbox"/></td>
            <th>VGM重量: </th>
            <td><input id="cntrVgmWgt1486946776099" name="cntrVgmWgt"
                       data-options='required:true,precision: 2, max: "99999999.99",groupSeparator:","'
                       class="easyui-numberbox"/></td>
            <th>铅封号1: </th>
            <td><input id="sealNo11486946776099" name="sealNo1" maxlength="10" data-options="required:false"  
             		   style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"
          	    /></td>
        </tr>
        <tr>
            <th>铅封号2: </th>
            <td><input id="sealNo21486946776099" name="sealNo2" maxlength="24" data-options="required:false"
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>      
            <th>铅封号3: </th>
            <td><input id="sealNo31486946776099" name="sealNo3" maxlength="24" data-options="required:false"
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>
            <th>铅封号4: </th>
            <td><input id="sealNo41486946776099" name="sealNo4" maxlength="24" data-options="required:false"
                       style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>
            <th>危险品标志: </th>
            <td><input id="dangMark1486946776099" name="dangMark" data-options="required:true"  type="checkbox"/></td>
        </tr>
        <tr>
            <th>危险品等级: </th>
            <td><input id="dangClass1486946776099" name="dangClass" maxlength="10" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>国际危规号: </th>
            <td><input id="undgNo1486946776099" name="undgNo"
                       data-options='required:true,precision: 0, max: "9999",groupSeparator:","'
                       class="easyui-numberbox"/></td>
            <th>冷藏标志: </th>
            <td><input id="reefMark1486946776099" name="reefMark"  data-options="required:true"  type="checkbox"/></td>
            <th>温度单位: </th>
            <td><input id="tempUnit1486946776099" name="tempUnit" maxlength="1" data-options="required:false"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th>设定温度1: </th>
            <td><input id="setTemp1486946776099" name="setTemp" maxlength="8" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>当前温度: </th>
            <td><input id="curTemp1486946776099" name="curTemp" maxlength="8" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>最低温度: </th>
            <td><input id="minTemp1486946776099" name="minTemp" maxlength="8" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>最高温度: </th>
            <td><input id="maxTemp1486946776099" name="maxTemp" maxlength="8" data-options="required:false"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th>通风量: </th>
            <td><input id="ventilation1486946776099" name="ventilation" maxlength="12" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>湿度: </th>
            <td><input id="humidity1486946776099" name="humidity" maxlength="12" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>超限标志: </th>
            <td><input id="oogMark1486946776099" name="oogMark" data-options="required:true"  type="checkbox"/></td>
            <th>左超: </th>
            <td><input id="oogLeft1486946776099" name="oogLeft" 
            		   data-options='required:true,precision: 2, max: "999.99",groupSeparator:","'
                       class="easyui-numberbox"/></td>
        </tr>
        <tr>
            <th>右超: </th>
            <td><input id="oogRight1486946776099" name="oogRight" 
					   data-options='required:true,precision: 2, max: "999.99",groupSeparator:","'
                       class="easyui-numberbox"/></td>
            <th>前超: </th>
            <td><input id="oogFront1486946776099" name="oogFront"
					   data-options='required:true,precision: 2, max: "999.99",groupSeparator:","'
                       class="easyui-numberbox"/></td>
            <th>后超: </th>
            <td><input id="oogBack1486946776099" name="oogBack"
                	   data-options='required:true,precision: 2, max: "999.99",groupSeparator:","'
                       class="easyui-numberbox"/></td>
            <th>超高: </th>
            <td><input id="oogHigh1486946776099" name="oogHigh"
                       data-options='required:true,precision: 2, max: "999.99",groupSeparator:","'
                       class="easyui-numberbox"/></td>
        </tr>
        <tr>
            <th>残损标志: </th>
            <td><input id="damMark1486946776099" name="damMark"  data-options="required:true"  type="checkbox"/></td>
            <th>折叠标志: </th>
            <td><input id="bundleMark1486946776099" name="bundleMark"  data-options="required:false"  type="checkbox"/></td>           
            <th>折叠主箱号: </th>
            <td><input id="bundleCntr1486946776099" name="bundleCntr" maxlength="12" data-options="required:false"
            		   style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>
            <th>折叠主箱到港编号: </th>
            <td><input id="bundleCntrVisitNo1486946776099" maxlength="36" name="bundleCntrVisitNo"  data-options="required:false"
            		   style=" text-transform:uppercase" onkeyup="this.value = this.value.toUpperCase()" class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th><font color="red">*</font>通电状态: </th>
            <td><input id="onPowerMark1486946776099" name="onPowerMark"  data-options="required:true"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>贸易性质: </th>
            <td><input id="tradeMark1486946776099" name="tradeMark" data-options="required:true"/></td>
            <th>进出口标志: </th>
            <td><input id="ieMark1486946776099" name="ieMark" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>装货港代码: </th>
            <td><input id="loadPortCod1486946776099" name="loadPortCod" maxlength="5" data-options="required:false"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th>卸货港代码: </th>
            <td><input id="discPortCod1486946776099" name="discPortCod" maxlength="5" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>目的港代码: </th>
            <td><input id="destPortCod1486946776099" name="destPortCod" maxlength="5" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>提单号: </th>
            <td><input id="billNo1486946776099" name="billNo" maxlength="50" data-options="required:false"  class="easyui-validatebox"/></td>
             <th>订舱号: </th>
            <td><input id="bookingNo1486946776099" name="bookingNo" maxlength="50" data-options="required:false"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th><font color="red">*</font>流向类别: </th>
            <td><input id="cntrClass1486946776099" name="cntrClass"  data-options="required:true" /></td>
            <th>中转标志: </th>
            <td><input id="transMark1486946776099" name="transMark" type="checkbox"/></td>
            <th>中转类型: </th>
            <td><input id="transTyp1486946776099" name="transTyp" maxlength="10" data-options="required:false"  class="easyui-validatebox"/></td>
            <th>海关放行标志: </th>
            <td><input id="customsRelsMark1486946776099" name="customsRelsMark" type="checkbox"/></td>
        </tr>
        <tr>
            <th>国检放行标志: </th>
            <td><input id="ciqRelsMark1486946776099" name="ciqRelsMark" type="checkbox"/></td>
            <th>锁扣标志: </th>
            <td><input id="lockMark1486946776099" name="lockMark" type="checkbox"/></td>
            <th>进港时间: </th>
            <td><input id="inPortTim1486946776099" name="inPortTim"  data-options="required:false"  class="easyui-datetimebox"/> </td>
            <th>进港类别: </th>
            <td><input id="inTransportMod1486946776099" name="inTransportMod"  data-options="required:false"/></td>
        </tr>
        <tr>
            <th>进港明细: </th>
            <td><input id="inVisitNo1486946776099" maxlength="36" name="inVisitNo"  data-options="required:false"  class="easyui-validatebox"/></td>
            <th>落场时间: </th>
            <td><input id="inCyTim1486946776099" name="inCyTim"  data-options="required:false"  class="easyui-datetimebox"/> </td>
            <th>出场时间: </th>
            <td><input id="outCyTim1486946776099" name="outCyTim"  data-options="required:false"  class="easyui-datetimebox"/> </td>
             <th>出港时间: </th>
            <td><input id="outPortTim1486946776099" name="outPortTim"  data-options="required:false"  class="easyui-datetimebox"/> </td>
        </tr>
        <tr>
            <th>出港类别: </th>
            <td><input id="outTransportMod1486946776099" name="outTransportMod"  data-options="required:false"/></td>
            <th>出港明细: </th>
            <td><input id="outVisitNo1486946776099" maxlength="36" name="outVisitNo"  data-options="required:false"  class="easyui-validatebox"/></td>
            <th>验箱标志: </th>
            <td><input id="chkMark1486946776099" name="chkMark" type="checkbox"/></td>
            <th>PTI检测标志: </th>
            <td><input id="ptiMark1486946776099" name="ptiMark" type="checkbox"/></td>
            
        </tr>
        <tr>
            <th>熏蒸标志: </th>
            <td><input id="fumigateMark1486946776099" name="fumigateMark" type="checkbox"/></td>
            <th><font color="red">*</font>查验状态: </th>
            <td><input id="inspectionStat1486946776099" name="inspectionStat"  data-options="required:true"  class="easyui-validatebox"/></td>
            <th>货物代码: </th>
            <td><input id="cargoCod1486946776099" maxlength="10" name="cargoCod"  data-options="required:false"  class="easyui-validatebox"/></td>
            <th>货物描述: </th>
            <td><input id="cargoDescribe1486946776099" maxlength="1000" name="cargoDescribe"  data-options="required:false"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th>备注/描述: </th>
            <td><input id="description1486946776099" maxlength="1000" name="description"  data-options="required:false"  class="easyui-validatebox"/></td>
            <th><font color="red">*</font>公司代码: </th>
            <td><input id="companyCod1486966544965" name="companyCod"/></td>
            <th></th>
            <td><input id="insAccount1486966544965" name="insAccount" type="hidden" data-options="required:true"  class="easyui-validatebox"/></td>
        </tr>
        <tr>
            <th> </th>
            <td><input id="insTimestamp1486966544965" name="insTimestamp" type="hidden" data-options="required:true"  class="easyui-datetime"/> </td>
            <th></th>
            <td><input id="updAccount1486966544965" name="updAccount" type="hidden" data-options="required:true"  class="easyui-validatebox"/></td>
            <th></th>
            <td><input id="updTimestamp1486966544965" name="updTimestamp" type="hidden" data-options="required:true"  class="easyui-datetime"/> </td>
            <td><input id="cntrVisitId1486966544965" name="cntrVisitId" type="hidden" data-options="required:true"  class="easyui-validatebox"/> </td>
        </tr>
    </table>
</form>