/**
 * Created by yushihui on 2018/12/6.
 */
  //判断当天是否提交过数据，提交过就隐藏提交按钮，并向输入框中填充数据，设置输入框为不可编辑
  //传递的数据
var submitJson;
//散货疏运的数据,//集装箱驳船的数据//集装箱作业线的数据//新沙集装箱驳船//车卡//集装箱堆存//汽车库存
var disper,barge,proroductionLine,bargeXS,truck,cntrStore, vehicle;
$(document).ready(function () {
  $.ajax({
    method: "get",
    url: "/login/getData",
    contentType: "application/json",
    success: function(data){
      console.log(data);
      submitJson=data;
      //当天没有提交数据
      if(data.dispersionVOList == "" && data.productionLineList == "" && data.bargeList == "" && data.truckStoreList == "" && data.bargeXSList == "" && data.cntrStoreList == "" && data.bulkStoreList == ""){
        //隐藏修改按钮
        $("#editBtn").hide();
        $("#cancelBtn").hide();
      }else{
        //当天已经提交过数据
        $("#inputBtn").hide();
        $("#cancelBtn").hide();
        //向输入框插入数据
        insertIntoFormData();
        //禁用所有输入框
        $(".kv-item input").each(function () {
          $(this).attr("disabled",true);
        });
      }
    },
    error: function (data) {
      console.info(data);
    }
  });
});

//向表单中插入数据
function insertIntoFormData() {
  disper=submitJson.dispersionVOList;
  proroductionLine=submitJson.productionLineList;
  barge=submitJson.bargeList;
  truck=submitJson.truckStoreList;
  bargeXS=submitJson.bargeXSList;
  cntrStore=submitJson.cntrStoreList;
  vehicle=submitJson.bulkStoreList;

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

//疏运部分数据插入
function insertDisperData(){
  //插入疏运部分
    var name=[],dis1=[],dis2=[],dis3=[];//存疏运类型//存疏运量;//存待疏运量//存机械数
    var count=0;
    var kk=0;
    var mark=0;//标记非固定货物名出现的位置
    $("#dispersion .kv-item span").each(function () {
        var node=$(this).attr("title");
        if(count<disper.length){
          if(node != "other"){
            mark++;
            name[kk]=node;
            if(disper[count].cargoName == node){
              dis1[kk]=disper[count].workingNumber;
              dis2[kk]=disper[count].unWorkNumber;
              dis3[kk]=disper[count].mechanicalNumber;
              count++;
            }else{
              dis1[kk]="";
              dis2[kk]="";
              dis3[kk]="";
            }
          }else{
            name[kk]=disper[count].cargoName;
            dis1[kk]=disper[count].workingNumber;
            dis2[kk]=disper[count].unWorkNumber;
            dis3[kk]=disper[count].mechanicalNumber;
          }
        }else {
          if(node != "other"){
            mark++;
            name[kk]=node;
          }else{
            name[kk]="";
          }
          dis1[kk]="";
          dis2[kk]="";
          dis3[kk]="";
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

//作业线部分数据插入
function insertProductionLineData() {
  document.getElementById("shipProLine").value=proroductionLine[0].shipLine;
  document.getElementById("bargeProLine").value=proroductionLine[0].bargeLine;
  document.getElementById("allProLine").value=proroductionLine[0].totalLine;
}

//集装箱驳船部分数据插入
function insertBargeData() {
  document.getElementById("inPort").value=barge[0].shipNumber;
  document.getElementById("finishWork").value=barge[0].workingNumber;
  document.getElementById("unWork").value=barge[0].unWorkNumber;
}

//车卡部分数据插入
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
  document.getElementById("alle").value=truck[0].loadOutport;
  document.getElementById("trkload").value=truck[0].unloadTruck;
  document.getElementById("trkunload").value=truck[0].waitUnload;
}

//新沙驳船
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

//集装箱堆存
function insertCntrStoreData() {
  document.getElementById("LIn").value=cntrStore[0].loadCntrI;
  document.getElementById("LOut").value=cntrStore[0].loadCntrE;
  document.getElementById("Emp").value=cntrStore[0].empCntr;
  document.getElementById("allSto").value=cntrStore[0].totalCntr;
}

//汽车库存
function insertVehicleData() {
  document.getElementById("busNumBulk").value=vehicle[0].carStore;
}
