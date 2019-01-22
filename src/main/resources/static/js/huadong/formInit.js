/**
 * Created by yushihui on 2018/12/6.
 * 判断当天是否提交过数据，提交过就隐藏提交按钮，并向输入框中填充数据，设置输入框为不可编辑
 * 七点之后不能修改数据，获取当前系统时间，如果大于7点，就隐藏其他按钮，显示申请修改按钮，如果未提交数据可以提交数据
 * 传递的数据
 */
document.write("<script language=javascript src='../../js/huadong/dealTime.js'></script>");
var submitJson;
//当天是否传过数据//是否为历史数据,0为当前数据，1为历史数据
var isSubmit,isCur;
//散货疏运的数据,//集装箱驳船的数据//集装箱作业线的数据//新沙集装箱驳船//车卡//集装箱堆存//汽车库存//散货堆存//工人出勤情况
var disper,barge,proroductionLine,bargeXS,truck,cntrStore, vehicle,bulk,attend;
//区分新沙和西基的url
var compUrl,limitHour;

$(document).ready(function () {
  //设置默认时间为今天
  if(document.getElementById("dateInput")){
    $('#dateInput').datebox('setValue', getCurentDateStr());
    var postDate={time:$("#dateInput").datebox("getValue")};
  }
  isCur=0;
  //对西基与新港的特殊情况进行处理
  if(document.getElementById("company")){
    compUrl="/login/getDataByTerCodeAndTime/"+document.getElementById("company").title+"?timestamp="+Math.random();
  }else{
    compUrl="/login/getDataByTime?timestamp="+Math.random();
  }
  var date=new Date();
  limitHour= date.getHours();
  getDataAjax(postDate);
});

/**
 * datebox值改变监听事件，当值改变时，填充选择时间的数据
 * @param date
 */
function onChangeDate(date){
  var postDate={time:$("#dateInput").datebox("getValue")};
  if($("#dateInput").datebox("getValue")!=getCurentDateStr()){
    isCur=1;
  }else{
    isCur=0;
  }
  //对西基与新港的特殊情况进行处理
  if(document.getElementById("company")){
    compUrl="/login/getDataByTerCodeAndTime/"+document.getElementById("company").title+"?timestamp="+Math.random();
  }else{
    compUrl="/login/getDataByTime?timestamp="+Math.random();
  }
  //获取选择时间的数据
  getDataAjax(postDate);
}

/**
 * 获取选择时间的数据
 */
function getDataAjax(postDate) {
  $.ajax({
    type: "post",
    url: compUrl,
    contentType : 'application/json',
    data:JSON.stringify(postDate),
    success: function(data){
      console.log(data);
      //当天没有提交数据
      if(data.dispersionVOList == "" && data.productionLineList == "" && data.bargeList == "" && data.truckStoreList == "" && data.bargeXSList == "" && data.cntrStoreList == "" && data.carStoreList == "" && data.bulkStoreList == ""  && data.attendenceList == "" && isCur==0){
        isSubmit=0;
        clearAll();
        //隐藏修改和取消按钮
        $("#inputBtn").show();
        $("#editBtn").hide();
        $("#cancel").hide();
        $("#apply").hide();
        $("#editBtn").disable=true;
        $("#inputBtn").disable=false;
        $("#cancel").disable=true;
        $("#apply").disable=true;
        //禁用所有输入框
        $(".kv-item input").each(function () {
          $(this).attr("disabled",false);
        });
        //历史没有数据
      }else if(data.dispersionVOList == "" && data.productionLineList == "" && data.bargeList == "" && data.truckStoreList == "" && data.bargeXSList == "" && data.cntrStoreList == "" && data.carStoreList == ""  && data.bulkStoreList == ""  && data.attendenceList == "" && isCur==1){
        //清空所有框的值
        clearAll();
        $("#inputBtn").hide();
        $("#editBtn").hide();
        $("#cancel").hide();
        $("#apply").hide();
        $("#editBtn").disable=true;
        $("#inputBtn").disable=true;
        $("#cancel").disable=true;
        $("#apply").disable=true;
        //禁用所有输入框
        $(".kv-item input").each(function () {
          $(this).attr("disabled",true);
        });
      } else{
        isSubmit=1;
        submitJson=data;
        //当天已经提交过数据
        $("#inputBtn").hide();
        $("#cancel").hide();
        $("#inputBtn").disable=true;
        $("#cancel").disable=true;
        //向输入框插入数据
        insertIntoFormData();
        //禁用所有输入框
        $(".kv-item input").each(function () {
          $(this).attr("disabled",true);
        });
        //设置七点之后需要申请修改数据，历史数据不可修改
        if (isChangeData()==2){
          $("#editBtn").hide();
          $("#apply").show();
          $("#editBtn").disable=true;
          $("#apply").disable=false;
        }else if(isChangeData()==1){
          $("#editBtn").show();
          $("#apply").hide();
          $("#editBtn").disable=false;
          $("#apply").disable=true;
        }else{
          $("#inputBtn").hide();
          $("#editBtn").hide();
          $("#cancel").hide();
          $("#apply").hide();
          $("#editBtn").disable=true;
          $("#inputBtn").disable=true;
          $("#cancel").disable=true;
          $("#apply").disable=true;
        }
      }
    },
    error: function (data) {
      console.info(data);
    }
  });
}

/**
 * 返回是否能够修改数据，2为需要申请才可修改，1为可修改，0为完全不可修改
 */
function isChangeData() {
  //设置七点之后不能修改数据
  if(isCur == 1){
    return 0;
  } else if (limitHour>=7){
    return 2;
  }else{
    return 1;
  }
}

/**
 * 向表单中插入数据
 */
function insertIntoFormData() {
  disper = submitJson.dispersionVOList;
  proroductionLine = submitJson.productionLineList;
  barge = submitJson.bargeList;
  truck = submitJson.truckStoreList;
  bargeXS = submitJson.bargeXSList;
  cntrStore = submitJson.cntrStoreList;
  vehicle = submitJson.carStoreList;
  bulk=submitJson.bulkStoreList;
  attend = submitJson.attendenceList;

  if (document.getElementById("dispersion")) {
    //疏运部分数据插入
    if (disper != "") {
      insertDisperData();
    }
  }
  if (document.getElementById("barge")) {
    //集装箱驳船
    if (barge != "") {
      insertBargeData();
    }
  }
  if (document.getElementById("productionLine")) {
    //集装箱作业线
    if (proroductionLine != "") {
      insertProductionLineData();
    }
  }
  if (document.getElementById("cntrSto")) {
    //集装箱堆存
    if (cntrStore != "") {
      insertCntrStoreData();
    }
  }
  if (document.getElementById("truck")) {
    //车卡
    if (truck != "") {
      insertTruckData();
    }
  }
  if (document.getElementById("xsCntr")) {
    //新沙集装箱
    if (bargeXS != "") {
      insertBargeXSData();
    }
  }
  if (document.getElementById("bulkBus")) {
    //汽车库存
    if (vehicle != "") {
      insertVehicleData();
    }
  }
  if (document.getElementById("bulkStore")) {
    //散货库存
    if (bulk != "") {
      insertBulkData();
    }
  }
  if (document.getElementById("attendance")) {
    //工人出勤情况
    if (attend != "") {
      insertAttendData();
    }
  }
}

/**
 * 疏运部分数据插入
 */
function insertDisperData(){
  //插入疏运部分
    var name=[],dis1=[],dis2=[],dis3=[];//存疏运类型//存疏运量;//存待疏运量//存机械数
    var count=0;
    var kk=0;
    var mark=0;//标记非固定货物名出现的位置
  var temp=0;
    $("#dispersion .kv-item span").each(function () {
      name[kk]="";
      dis1[kk]="";
      dis2[kk]="";
      dis3[kk]="";
        var node=$(this).attr("title");
        if (node != "other"){
          name[kk]=node;
          dis1[kk]="";
          dis2[kk]="";
          dis3[kk]="";
          for(var i=0;i<disper.length;i++){
            if(disper[i].cargoName == node){
              dis1[kk]=disper[i].workingNumber;
              dis2[kk]=disper[i].unWorkNumber;
              dis3[kk]=disper[i].mechanicalNumber;
              disper[i].cargoName="";
            }
          }
          mark++;
        }else{
          for(var i=0;i<disper.length;i++){
            if(disper[i].cargoName != ""){
              name[kk]=disper[i].cargoName;
              dis1[kk]=disper[i].workingNumber;
              dis2[kk]=disper[i].unWorkNumber;
              dis3[kk]=disper[i].mechanicalNumber;
              disper[i].cargoName="";
              break;
            }
          }

        }
        kk++;
      }
    );
  count=0;
    var xjtotal=0;
    $(".cargo").each(function () {
      $(this).attr("value",name[mark]);
      mark++;
    });
    $(".dispersion1").each(function () {
      $(this).attr("value",dis1[count]);
      xjtotal=xjtotal+(dis1[count]-0);
      count++;
    });
    count=0;
    $(".dispersion2").each(function () {
      $(this).attr("value",dis2[count]);
      count++;
    });
    count=0;
    $(".dispersion3").each(function () {
      $(this).attr("value",dis3[count]);
      count++;
    });
    if(document.getElementById("xjtotal")) {
      document.getElementById("xjtotal").value = xjtotal;
    }
}

/**
 * 作业线部分数据插入
 */
function insertProductionLineData() {
  document.getElementById("shipProLine").value=proroductionLine[0].shipLine;
  document.getElementById("bargeProLine").value=proroductionLine[0].bargeLine;
  document.getElementById("allProLine").value=proroductionLine[0].totalLine;
}

/**
 * 集装箱驳船部分数据插入
 */
function insertBargeData() {
  document.getElementById("inPort").value=barge[0].shipNumber;
  document.getElementById("finishWork").value=barge[0].workingNumber;
  document.getElementById("unWork").value=barge[0].unWorkNumber;
}

/**
 * 车卡部分数据插入
 */
function insertTruckData() {
  if(document.getElementById("trkxg")){
    document.getElementById("trkxg").value=truck[0].loadiXg;
  }
  if(document.getElementById("trkxj")){
    document.getElementById("trkxj").value=truck[0].loadiXj;
  }
  if(document.getElementById("trkgct")){
    document.getElementById("trkgct").value=truck[0].loadiGct;
  }
  if(document.getElementById("trkxs")){
    document.getElementById("trkxs").value=truck[0].loadiXs;
  }
  if(document.getElementById("allcmp")){
    document.getElementById("allcmp").value=truck[0].loadInport;
  }
  if(document.getElementById("trkmt")){
    document.getElementById("trkmt").value=truck[0].loadiCoal;
  }
  if(document.getElementById("trkks")){
    document.getElementById("trkks").value=truck[0].loadiOre;
  }
  if(document.getElementById("trkzh")){
    document.getElementById("trkzh").value=truck[0].loadiOther;
  }
  if(document.getElementById("allcgo")){
    document.getElementById("allcgo").value=truck[0].loadInport;
  }
  if(document.getElementById("trkmte")){
    document.getElementById("trkmte").value=truck[0].loadoCoal;
  }
  if(document.getElementById("trkkse")){
    document.getElementById("trkkse").value=truck[0].loadoOre;
  }
  if(document.getElementById("trkothere")){
    document.getElementById("trkothere").value=truck[0].loadoOther;
  }
  if(document.getElementById("alle")){
    document.getElementById("alle").value=truck[0].loadOutPort;
  }
  if(document.getElementById("trkload")){
    document.getElementById("trkload").value=truck[0].unloadTruck;
  }
  if(document.getElementById("trkunload")){
    document.getElementById("trkunload").value=truck[0].waitUnload;
  }
  if(document.getElementById("totalLoad")){
    document.getElementById("totalLoad").value=truck[0].totalLoad;
  }
}

/**
 * 新沙驳船
 */
function insertBargeXSData() {
  var xsShen=[],xsI=[],xsE=[],xsBus=[],xstotal=[];
  var count=0;
  $("#xsCntr .subfild span").each(function () {
    var node=$(this).attr("title");
    for(var i=0;i<bargeXS.length;i++){
      if(node == bargeXS[i].workType){
        xsShen[count]=bargeXS[i].shenzhenNumber;
        xsI[count]=bargeXS[i].itNumber;
        xsE[count]=bargeXS[i].etNumber;
        xsBus[count]=bargeXS[i].shuttlebusNumber;
        xstotal[count]=bargeXS[i].totalNumber;
        count++;
      }
    }
  });
  count=0;
  $("#xsCntr .xsShen").each(function () {
    $(this).attr("value",xsShen[count]);
    count++;
  });
  count=0;
  $("#xsCntr .xsI").each(function () {
    $(this).attr("value",xsI[count]);
    count++;
  });
  count=0;
  $("#xsCntr .xsE").each(function () {
    $(this).attr("value",xsE[count]);
    count++;
  });
  count=0;
  $("#xsCntr .xsBus").each(function () {
    $(this).attr("value",xsBus[count]);
    count++;
  });
  count=0;
  $("#xsCntr .xstotal").each(function () {
    $(this).attr("value",xstotal[count]);
    count++;
  });

  if(proroductionLine != ""){
    document.getElementById("xsShip").value=proroductionLine[0].shipLine;
  }
}

/**
 * 集装箱堆存
 */
function insertCntrStoreData() {
  document.getElementById("LIn").value=cntrStore[0].loadCntrI;
  document.getElementById("LOut").value=cntrStore[0].loadCntrE;
  document.getElementById("Emp").value=cntrStore[0].empCntr;
  document.getElementById("allSto").value=cntrStore[0].totalCntr;
}

/**
 * 汽车库存
 */
function insertVehicleData() {
  document.getElementById("busNumBulk").value=vehicle[0].carNumber;
}

/**
 * 散货库存
 */
function insertBulkData() {
  document.getElementById("bulkAll").value=bulk[0].totalStore;
  document.getElementById("bulkCoal").value=bulk[0].coalStore;
  document.getElementById("bulkOre").value=bulk[0].oreStore;
  document.getElementById("bulkFood").value=bulk[0].foodStore;
  document.getElementById("bulkSteel").value=bulk[0].steelStore;
}

/**
 * 工人出勤情况
 */
function insertAttendData(){
  console.log(attend);
  var count=0,work=[],unwork=[];
  $("#attendance .kv-item span").each(function () {
    var title=$(this).attr("title");
    for(var i=0;i<attend.length;i++){
      if(attend[i].attTime==title){
        work[count]=attend[i].workingStaff;
        unwork[count]=attend[i].watiStaff;
        count++;
      }
    }
  });
  count=0;
  $(".attendwork").each(function () {
    $(this).attr("value",work[count]);
    count++;
  });
  count=0;
  $(".attendwait").each(function () {
    $(this).attr("value",unwork[count]);
    count++;
  });
}

/**
 * 清空所有框的值
 */
function clearAll() {
  if(document.getElementById("dispersion")){
    //疏运部分数据插入
    $("#dispersion input").each(function () {
      $(this).attr("value","");
    });
  }
  if(document.getElementById("barge")){
    //集装箱驳船
    $("#barge input").each(function () {
      $(this).attr("value","");
    });
  }
  if(document.getElementById("productionLine")){
    //集装箱作业线
    $("#productionLine input").each(function () {
      $(this).attr("value","");
    });
  }
  if(document.getElementById("cntrSto")){
    //集装箱堆存
    $("#cntrSto input").each(function () {
      $(this).attr("value","");
    });
  }
  if(document.getElementById("truck")){
    //车卡
    $("#truck input").each(function () {
      $(this).attr("value","");
    });
  }
  if(document.getElementById("xsCntr")){
    //新沙集装箱
    $("#xsCntr input").each(function () {
      $(this).attr("value","");
    });
  }
  if(document.getElementById("bulkBus")){
    //汽车库存
    $("#bulkBus input").each(function () {
      $(this).attr("value","");
    });
  }
}
