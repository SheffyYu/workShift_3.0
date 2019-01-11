/**
 * Created by yushihui on 2018/12/6.
 * 判断当天是否提交过数据，提交过就隐藏提交按钮，并向输入框中填充数据，设置输入框为不可编辑
 * 七点之后不能修改数据，获取当前系统时间，如果大于7点，就隐藏其他按钮，显示申请修改按钮，如果未提交数据可以提交数据
 * 传递的数据
 */
document.write("<script language=javascript src='../../js/huadong/dealTime.js'></script>");
var submitJson;
//当天是否传过数据//是否为历史数据
var isSubmit,isHis;
//散货疏运的数据,//集装箱驳船的数据//集装箱作业线的数据//新沙集装箱驳船//车卡//集装箱堆存//汽车库存
var disper,barge,proroductionLine,bargeXS,truck,cntrStore, vehicle;
//区分新沙和西基的url
var compUrl,limitHour;

$(document).ready(function () {
  //设置默认时间为今天
  if(document.getElementById("dateInput")){
    $('#dateInput').datebox('setValue', getCurentDateStr());
  }
  var postDate={time:$("#dateInput").datebox("getValue")};
  isHis=0;
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
  if($("#dateInput").datebox("getValue")<getCurentDateStr()){
    isHis=1;
  }else{
    isHis=0;
  }
  //获取选择时间的数据
  getDataAjax(postDate);
}

/**
 * 获取选择时间的数据
 */
function getDataAjax(postDate) {
  $.ajax({
    method: "post",
    url: compUrl,
    contentType : 'application/json',
    data:JSON.stringify(postDate),
    success: function(data){
      //当天没有提交数据
      if(data.dispersionVOList == "" && data.productionLineList == "" && data.bargeList == "" && data.truckStoreList == "" && data.bargeXSList == "" && data.cntrStoreList == "" && data.carStoreList == ""){
        isSubmit=0;
        //隐藏修改和取消按钮
        $("#editBtn").hide();
        $("#cancel").hide();
        $("#apply").hide();
      }else{
        isSubmit=1;
        submitJson=data;
        //当天已经提交过数据
        $("#inputBtn").hide();
        $("#cancel").hide();
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
        }else if(isChangeData()==1){
          $("#editBtn").show();
          $("#apply").hide();
        }else{
          $("#inputBtn").hide();
          $("#editBtn").hide();
          $("#cancel").hide();
          $("#apply").hide();
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
  if(isHis == 1){
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
  disper=submitJson.dispersionVOList;
  proroductionLine=submitJson.productionLineList;
  barge=submitJson.bargeList;
  truck=submitJson.truckStoreList;
  bargeXS=submitJson.bargeXSList;
  cntrStore=submitJson.cntrStoreList;
  vehicle=submitJson.carStoreList;

  if(document.getElementById("dispersion")){
    //疏运部分数据插入
    if(disper != "") {
      insertDisperData();
    }
  }
  if(document.getElementById("barge")){
    //集装箱驳船
    if(barge != ""){
      insertBargeData();
    }
  }
  if(document.getElementById("productionLine")){
    //集装箱作业线
    if(proroductionLine != ""){
      insertProductionLineData();
    }
  }
  if(document.getElementById("cntrSto")){
    //集装箱堆存
    if(cntrStore != ""){
      insertCntrStoreData();
    }
  }
  if(document.getElementById("truck")){
    //车卡
    if(truck != ""){
      insertTruckData();
    }
  }
  if(document.getElementById("xsCntr")){
    //新沙集装箱
    if(bargeXS != ""){
      insertBargeXSData();
    }
  }
  if(document.getElementById("bulkBus")){
    //汽车库存
    if(vehicle != ""){
      insertVehicleData();
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
  document.getElementById("trkxg").value=truck[0].loadiXg;
  document.getElementById("trkxj").value=truck[0].loadiXj;
  document.getElementById("trkgct").value=truck[0].loadiGct;
  document.getElementById("trkxs").value=truck[0].loadiXs;
  document.getElementById("allcmp").value=truck[0].loadInport;
  document.getElementById("trkmt").value=truck[0].loadiCoal;
  document.getElementById("trkks").value=truck[0].loadiOre;
  document.getElementById("trkzh").value=truck[0].loadiOther;
  document.getElementById("allcgo").value=truck[0].loadInport;
  document.getElementById("trkmte").value=truck[0].loadoCoal;
  document.getElementById("trkkse").value=truck[0].loadoOre;
  document.getElementById("trkothere").value=truck[0].loadoOther;
  document.getElementById("alle").value=truck[0].loadOutPort;
  document.getElementById("trkload").value=truck[0].unloadTruck;
  document.getElementById("trkunload").value=truck[0].waitUnload;
  document.getElementById("totalLoad").value=truck[0].totalLoad;
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
