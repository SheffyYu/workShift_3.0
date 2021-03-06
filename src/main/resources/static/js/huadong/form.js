/**
 * Created by yushihui on 2018/12/5.
 */
//弹出提示框
document.write("<script language=javascript src='../../js/huadong/tips.js'></script>");
// document.write("<script language=javascript src='../../js/huadong/formInit.js?v=20190113'></script>");
//最终传递的数据
var submitJson;
//散货疏运的数据,//集装箱驳船的数据//集装箱作业线的数据//新沙集装箱驳船//车卡//集装箱堆存//汽车库存//散货堆存//工人出勤情况
var disper,barge,proroductionLine,bargeXS,truck,cntrStore, vehicle,bulk,attend;
// 判断是否有条件不满足,不满足则为false,不进行操作
var isContinue;
var date=new Date();
var limitHour= date.getHours();
var company="";

/**
 * 初始化数据格式
 */
function initData() {
  submitJson= {
    dispersionVOList: [],
    productionLineList: [],
    bargeList: [],
    truckStoreList: [],
    cntrStoreList: [],
    bargeXSList: [],
    carStoreList:[],
    attendenceList:[],
    bulkStoreList:[]
  };
  disper=[];
  barge=[];
  proroductionLine=[];
  bargeXS=[];
  truck=[];
  cntrStore=[];
  vehicle=[];
  bulk=[];
  attend=[];
  isContinue=true;
}
/**
 * 待作业=在港艘数-作业
 * 驳船=作业
 */
function work() {
  var str1=document.getElementById("inPort").value;
  var str2=document.getElementById("finishWork").value;
  document.getElementById("unWork").value = str1-str2;
  document.getElementById("bargeProLine").value=str2;
  $("#bargeProLine").trigger("change");
}
$("#bargeProLine").on("change",function(){
  var str1=document.getElementById("shipProLine").value;
  var str2=document.getElementById("bargeProLine").value;
  document.getElementById("allProLine").value=(str1-0)+(str2-0);//-0是为了避免str拼接
});
/**
 * 总作业=大船+驳船
 */
function proLine() {
  var str1=document.getElementById("shipProLine").value;
  var str2=document.getElementById("bargeProLine").value;
  document.getElementById("allProLine").value=(str1-0)+(str2-0);//-0是为了避免str拼接
}
/**
 * 集装箱总堆存=重箱内外贸+控箱
 */
function cntrOper() {
  var str1=document.getElementById("LIn").value;
  var str2=document.getElementById("LOut").value;
  var str3=document.getElementById("Emp").value;
  document.getElementById("allSto").value=(str1-0)+(str2-0)+(str3-0);
}
/**
 * 车卡港内公司
 */
function truckCmpOper() {
  var trkxg=document.getElementById("trkxg").value;
  var trkxj=document.getElementById("trkxj").value;
  var trkgct=document.getElementById("trkgct").value;
  var trkxs=document.getElementById("trkxs").value;
  document.getElementById("allcmp").value=(trkxg-0)+(trkxj-0)+(trkgct-0)+(trkxs-0);
}
/**
 * 车卡港内货物
 */
function truckCargoOper() {
  var trkmt=document.getElementById("trkmt").value;
  var trkks=document.getElementById("trkks").value;
  var trkzh=document.getElementById("trkzh").value;
  document.getElementById("allcgo").value=(trkmt-0)+(trkks-0)+(trkzh-0);
  $("#allcgo").trigger("change");
}
/**
 * 目前只有西基需要计算总疏运量
 */
function xjBarge() {
  var total=0;
  $(".dispersion1").each(function () {
    var str=$(this).val();
    total=total+(str-0);
  });
  document.getElementById("xjtotal").value=total;
}

/**
 * 获取新港西基的公司
 */
function getCompany(){
  if (document.getElementById("company")){
    company=document.getElementById("company").title;
  }
}

/**
 *提交按钮的点击事件
 */
function submitBtn() {
  //初始化数据
  initData();
  getCompany();
//散货疏运
  if(document.getElementById("dispersion")){
    dispersionData();
  }
  if(document.getElementById("barge")){
    //集装箱驳船
    bargeData();
  }
  if(document.getElementById("productionLine")){
    //集装箱作业线
    proLineData();
  }
  if(document.getElementById("cntrSto")){
    //集装箱堆存
    cntrStoreData();
  }
  if(document.getElementById("truck")){
    //车卡
    truckData();
  }
  if(document.getElementById("xsCntr")){
    //新沙集装箱
    xsCntrData();
  }
  if(document.getElementById("bulkBus")){
    //汽车库存
    bulkVehicleData();
  }
  if(document.getElementById("bulkStore")){
    //汽车库存
    bulkData();
  }
  if(document.getElementById("attendance")){
    //工人出勤情况
    attendanceData();
  }



  //整合数据
  submitJson.terCode=company;
  submitJson.dataTime=$("#dateInput").datebox("getValue");
  submitJson.dispersionVOList=disper;
  submitJson.productionLineList=proroductionLine;
  submitJson.bargeList=barge;
  submitJson.truckStoreList=truck;
  submitJson.bargeXSList=bargeXS;
  submitJson.cntrStoreList=cntrStore;
  submitJson.carStoreList=vehicle;
  submitJson.attendenceList=attend;
  submitJson.bulkStoreList=bulk;


  //提交数据
  if(isContinue){
    postJson();
  }
}

/**
 * 修改按钮点击的事件
 */
function changeBtn() {
  //点击修改，输入框可编辑，提交按钮出现，再加一个取消修改
  $("#editBtn").hide();
  $("#inputBtn").show();
  $("#cancel").show();
  $("#apply").hide();
  $("#editBtn").disable=true;
  $("#inputBtn").disable=false;
  $("#cancel").disable=false;
  $("#apply").disable=true;
  $(".kv-item input").each(function () {
    $(this).attr("disabled",false);
  });
}

/**
 * 取消按钮的点击事件
 */
function cancelBtn() {
  $("#inputBtn").hide();
  $("#cancel").hide();
  $("#inputBtn").disable=true;
  $("#cancel").disable=true;
  if (limitHour>7){
    $("#editBtn").hide();
    $("#editBtn").disable=true;
    $("#apply").show();
    $("#apply").disable=false;
  }else{
    $("#editBtn").show();
    $("#apply").hide();
    $("#editBtn").disable=false;
    $("#apply").disable=true;
  }
  $(".kv-item input").each(function () {
    $(this).attr("disabled",true);
  });
}

/**
 * 申请修改按钮的点击事件
 */
function applyBtn() {
  $("#editBtn").hide();
  $("#inputBtn").show();
  $("#cancel").show();
  $("#apply").hide();
  $("#editBtn").disable=true;
  $("#inputBtn").disable=false;
  $("#cancel").disable=false;
  $("#apply").disable=true;
  $(".kv-item input").each(function () {
    $(this).attr("disabled",false);
  });
}

/**
 * 提交数据,七点之后变成提交申请
 * 要判断是否提交过数据
 */
function postJson() {
  //提交数据
  $.ajax({
    url: "/login/saveData?timestamp="+Math.random(),
    contentType: "application/json",
    dataType: "json",
    type: "POST",
    data:JSON.stringify(submitJson),
    success: function (data) {
      //刷新窗口
      // window.location.reload();
      //设置输入框不可编辑以及提交按钮不可点击
      $(".kv-item input").each(function () {
        $(this).attr("disabled",true);
      });
      //隐藏提交按钮
      $("#inputBtn").hide();
      $("#cancel").hide();
      $("#inputBtn").disable=true;
      $("#cancel").disable=true;
      //显示修改按钮
      //设置七点之后不能修改数据
      if (limitHour>=7){
        $("#editBtn").hide();
        $("#apply").show();
        $("#editBtn").disable=true;
        $("#apply").disable=false;
      }else{
        $("#editBtn").show();
        $("#apply").hide();
        $("#editBtn").disable=false;
        $("#apply").disable=true;
      }
      isSubmit=1;
      showTips(data.message,200,2);
      setTimeout(function(){
        location.reload();
      },700);
    }
  });
}

/**
 * 散货疏运的数据处理
 */
function dispersionData() {
  var name=[],dis1=[],dis2=[],dis3=[];//存疏运类型//存疏运量;//存待疏运量//存机械数
  var i=0;
  $("#dispersion .kv-item span").each(function () {
    var node=$(this).attr("title");
    if(node != "other"){
      name[i]=node;
      i++;
    }
  });
  $(".cargo").each(function () {
    var node=$(this).val();
    if(node != null){
      name[i]=node;
      i++;
    }
  });
  i=0;
  $(".dispersion1").each(function () {
    var str= $(this).val();
    dis1[i]=str;
    i++;
  });
  i=0;
  $(".dispersion2").each(function () {
    var str= $(this).val();
    dis2[i]=str;
    i++;
  });
  i=0;
  $(".dispersion3").each(function () {
    var str= $(this).val();
    dis3[i]=str;
    i++;
  });
  for(var k=0;i>k;k++){
    if(!(dis1[k] == "" && dis2[k] == "" && dis2[k] == "" && name[k]=="") ){
      if(dis1[k] == ""){
        dis1[k]=0;
      }
      if(dis2[k] == ""){
        dis2[k]=0;
      }
      if(dis3[k] == ""){
        dis3[k]=0;
      }
      if(name[k] == ""){
        isContinue=false;
        alert("请输入货类名！");
      }else{
        var obj={
          dispersionId:"",
          terCode:"",
          cargoName:name[k],
          workingNumber:dis1[k],
          unWorkNumber:dis2[k],
          mechanicalNumber:dis3[k]
        };
        disper.push(obj);
      }
    }
  }
  //以上是疏运的内容
  // console.log(disper);
}

/**
 * 集装箱驳船的数据处理
 */
function bargeData(){
  var inPort=document.getElementById("inPort").value;
  var finishWork=document.getElementById("finishWork").value;
  var unWork=document.getElementById("unWork").value;

  //对取到的数据进行判断,不能为空
  if(inPort == ""){
    inPort =0;
  }
  if(finishWork == ""){
    finishWork =0;
  }
  if( unWork ==""){
    unWork=0;
  }
  if(inPort < 0 || finishWork < 0 || unWork < 0){
    isContinue=false;
    alert("集装箱驳船中数据存在负数，请返回修改！");//返回界面
  } else{
    var obj={
      bargeId:"",		//驳船Id，没有可以不填
      terCode:"",		//码头代码，不用填
      shipNumber:inPort,		//船数量
      workingNumber:finishWork,	//作业数量
      unWorkNumber:unWork		//待作业数量
    };
    barge.push(obj);
  }
}

/**
 * 集装箱作业线的数据处理
 */
function proLineData() {
  var allLine=document.getElementById("allProLine").value;
  var shipLine=document.getElementById("shipProLine").value;
  var bargeLine=document.getElementById("bargeProLine").value;
  if(allLine == ""){
    allLine=0;
  }
  if( shipLine == "" ){
    shipLine=0;
  }
  if( bargeLine == ""){
    bargeLine=0;
  }
  if(allLine < 0 || shipLine < 0 || bargeLine < 0){
    isContinue=false;
    alert("集装箱作业线中数据存在负数，请返回修改！");//返回界面
  } else{
    var obj={
      productionId:"",	//作业线Id,没有可以不填
      terCode:"",		//码头代码，不用填
      totalLine:allLine,		//总作业线
      shipLine:shipLine,		//大船作业线
      bargeLine:bargeLine		//驳船作业线
    };
    proroductionLine.push(obj);
  }
}

/**
 * 集装箱堆存的数据处理
 */
function cntrStoreData() {
  var LIn=document.getElementById("LIn").value;
  var LOut=document.getElementById("LOut").value;
  var Emp=document.getElementById("Emp").value;
  var allSto=document.getElementById("allSto").value;
  if(!(LIn == "" && LOut == "" && Emp == "" && allSto == "")){
    var obj={
      cntrStoreId:"",
      terCode:"",
      empCntr:Emp,
      loadCntrE:LOut,
      loadCntrI:LIn,
      totalCntr:allSto
    };
    cntrStore.push(obj);
  }
}

/**
 * 车卡
 */
function truckData() {
  if(document.getElementById("trkxg")){
    var trkxg=document.getElementById("trkxg").value;
    if(trkxg==""){
      trkxg=0;
    }
  }else{
    var trkxg=0;
  }
  if(document.getElementById("trkxj")){
    var trkxj=document.getElementById("trkxj").value;
    if(trkxj==""){
      trkxj=0;
    }
  }else{
    var trkxj=0;
  }
  if(document.getElementById("trkgct")){
    var trkgct=document.getElementById("trkgct").value;
    if(trkgct==""){
      trkgct=0;
    }
  }else{
    var trkgct=0;
  }
  if(document.getElementById("trkxg")){
    var trkxs=document.getElementById("trkxs").value;
    if(trkxs==""){
      trkxs=0;
    }
  }else{
    var trkxs=0;
  }
  if(document.getElementById("allcmp")){
    var allcmp=document.getElementById("allcmp").value;
    if(allcmp==""){
      allcmp=0;
    }
  }else{
    var allcmp=0;
  }
  if(document.getElementById("trkmt")){
    var trkmt=document.getElementById("trkmt").value;
    if(trkmt==""){
      trkmt=0;
    }
  }else{
    var trkmt=0;
  }
  if(document.getElementById("trkks")){
    var trkks=document.getElementById("trkks").value;
    if(trkks==""){
      trkks=0;
    }
  }else{
    var trkks=0;
  }
  if(document.getElementById("trkzh")){
    var trkzh=document.getElementById("trkzh").value;
    if(trkzh==""){
      trkzh=0;
    }
  }else{
    var trkzh=0;
  }
  if(document.getElementById("allcgo")){
    var allcgo=document.getElementById("allcgo").value;
    if(allcgo==""){
      allcgo=0;
    }
  }else{
    var allcgo=0;
  }
  if(document.getElementById("trkmte")){
    var trkmte=document.getElementById("trkmte").value;
    if(trkmte==""){
      trkmte=0;
    }
  }else{
    var trkmte=0;
  }
  if(document.getElementById("trkkse")){
    var trkkse=document.getElementById("trkkse").value;
    if(trkkse==""){
      trkkse=0;
    }
  }else{
    var trkkse=0;
  }
  if(document.getElementById("alle")){
    var alle=document.getElementById("alle").value;
    if(alle==""){
      alle=0;
    }
  }else{
    var alle=0;
  }
  if(document.getElementById("trkload")){
    var trkload=document.getElementById("trkload").value;
    if(trkload==""){
      trkload=0;
    }
  }else{
    var trkload=0;
  }
  if(document.getElementById("trkunload")){
    var trkunload=document.getElementById("trkunload").value;
    if(trkunload==""){
      trkunload=0;
    }
  }else{
    var trkunload=0;
  }
  if(document.getElementById("trkothere")){
    var trkothere=document.getElementById("trkothere").value;
    if(trkothere==""){
      trkothere=0;
    }
  }else{
    var trkothere=0;
  }
  if(document.getElementById("totalLoad")){
    var totalLoad=document.getElementById("totalLoad").value;
    if(totalLoad==""){
      totalLoad=0;
    }
  }else{
    var totalLoad=0;
  }
  //当港内货物总和与公司不相等时
  if(allcmp != allcgo){
    isContinue=false;
    alert("港内公司与港内货物合计不相等，请返回检查并修改！");
  }else{
    var obj={
      truckStoreId:"",
      loadInport:allcmp,
      loadOutPort:alle,
      loadiCoal:trkmt,
      loadiOre:trkks,
      loadiOther:trkzh,
      loadiGct:trkgct,
      loadiXg:trkxg,
      loadiXj:trkxj,
      loadiXs:trkxs,
      loadoCoal:trkmte,
      loadoOre:trkkse,
      loadoOther:trkothere,
      totalLoad:totalLoad,
      unloadTruck:trkload,
      waitUnload:trkunload,
      terCode:""
    };
    truck.push(obj);
  }
}

/**
 * 新沙集装箱码头的数据处理
 */
function xsCntrData() {
var xstitle=[],xsShen=[],xsI=[],xsE=[],xsBus=[],xstotal=[];
var i=0;
$("#xsCntr .subfild span").each(function () {
  var node=$(this).attr("title");
    xstitle[i]=node;
    i++;
});
i=0;
$("#xsCntr .xsShen").each(function () {
  var node=$(this).val();
  xsShen[i]=node;
  i++;
});
  i=0;
  $("#xsCntr .xsI").each(function () {
    var node=$(this).val();
    xsI[i]=node;
    i++;
  });
  i=0;
  $("#xsCntr .xsE").each(function () {
    var node=$(this).val();
    xsE[i]=node;
    i++;
  });
  i=0;
  $("#xsCntr .xsBus").each(function () {
    var node=$(this).val();
    xsBus[i]=node;
    i++;
  });
  i=0;
  $("#xsCntr .xstotal").each(function () {
    var node=$(this).val();
    xstotal[i]=node;
    i++;
  });
  for(var k=0;k<i;k++){
    var obj={
      bargeXSId:"",		//新沙驳船Id,没有可不填
      terCode:"",		//码头代码，不用填
      workType:xstitle[k],		//类型
      totalNumber:xstotal[k],		//总数
      shenzhenNumber:xsShen[k],	//深圳数量
      shuttlebusNumber:xsBus[k],	//穿巴数
      itNumber:xsI[k],		//内贸
      etNumber:xsE[k]		//外贸
    };
    bargeXS.push(obj);
  }

  var xsShipLine=document.getElementById("xsShip").value;
  var xsBargeLine=document.getElementById("xsLT").value;

  if(xsShipLine ==""){
    xsShipLine=0
  }
  if(xsBargeLine==""){
    xsBargeLine=0;
  }

  var obj={
    productionId:"",	//作业线Id,没有可以不填
    terCode:"",		//码头代码，不用填
    totalLine:(xsBargeLine-0)+(xsShipLine-0),		//总作业线
    shipLine:xsShipLine,		//大船作业线
    bargeLine:xsBargeLine		//驳船作业线
  };
  proroductionLine.push(obj);
}

/**
 * 汽车库存
 */
function bulkVehicleData() {
  var busNum=document.getElementById("busNumBulk").value;
  var obj={
    carStoreId:"",		//
    terCode:"",		//码头Id
    carNumber:busNum		//汽车库存
  }
  vehicle.push(obj);
}

/**
 * 散货库存界面-------目前只有亚太
 */
function bulkData() {
  var bulkAll=document.getElementById("bulkAll").value;
  var bulkCoal=document.getElementById("bulkCoal").value;
  var bulkOre=document.getElementById("bulkOre").value;
  var bulkFood=document.getElementById("bulkFood").value;
  var bulkSteel=document.getElementById("bulkSteel").value;
  if (bulkAll==""){
    bulkAll=0;
  }
  if (bulkCoal==""){
    bulkCoal=0;
  }
  if (bulkOre==""){
    bulkOre=0;
  }
  if (bulkFood==""){
    bulkFood=0;
  }
  if (bulkSteel==""){
    bulkSteel=0;
  }

  var obj={
    bulkStoreId:"",
    totalStore:bulkAll,
    coalStore:bulkCoal,
    oreStore:bulkOre,
    foodStore:bulkFood,
    steelStore:bulkSteel,
    terCode:""
  };
  bulk.push(obj);
}

/**
 * 工人出勤候工情况
 */
function attendanceData() {
  var count=0;
  var worktime=[],work=[],unwork=[];
  $("#attendance .kv-item span").each(function () {
    worktime[count]=$(this).attr("title");
    count++;
  });
  count=0;
  $(".attendwork").each(function () {
    work[count]=$(this).val();
    if(work[count]==""){
      work[count]=0;
    }
    count++;
  });
  count=0;
  $(".attendwait").each(function () {
    unwork[count]=$(this).val();
    if(unwork[count]==""){
      unwork[count]=0;
    }
    count++;
  });
  console.log(count);
  for(var i=0;i<count;i++){
    var obj={
      attId:"",
      attTime:worktime[i],
      workingStaff:work[i],
      watiStaff:unwork[i],
      terCode:""
    };
    attend.push(obj);
    console.log(obj);
  }
}
