/**
 * Created by yushihui on 2018/12/5.
 */
//弹出提示框
document.write("<script language=javascript src='../../js/huadong/tips.js'></script>");
//最终传递的数据
var submitJson;
//散货疏运的数据,//集装箱驳船的数据//集装箱作业线的数据//新沙集装箱驳船//车卡//集装箱堆存//汽车库存
var disper,barge,proroductionLine,bargeXS,truck,cntrStore, vehicle;
// 判断是否有条件不满足,不满足则为false,不进行操作
var isContinue;

//初始化数据格式
function initData() {
  submitJson= {
    dispersionVOList: [],
    productionLineList: [],
    bargeList: [],
    truckStoreList: [],
    cntrStoreList: [],
    bargeXSList: [],
    bulkStoreList:[]
  };
  disper=[];
  barge=[];
  proroductionLine=[];
  bargeXS=[];
  truck=[];
  cntrStore=[];
  vehicle=[];
  isContinue=true;
}

//待作业=在港艘数-作业
//驳船=作业
function work() {
  var str1=document.getElementById("inPort").value;
  var str2=document.getElementById("finishWork").value;
  document.getElementById("unWork").value = str1-str2;
  document.getElementById("bargeProLine").value=str2;
}
//总作业=大船+驳船
function proLine() {
  var str1=document.getElementById("shipProLine").value;
  var str2=document.getElementById("bargeProLine").value;
  document.getElementById("allProLine").value=(str1-0)+(str2-0);//-0是为了避免str拼接
}
//集装箱总堆存=重箱内外贸+控箱
function cntrOper() {
  var str1=document.getElementById("LIn").value;
  var str2=document.getElementById("LOut").value;
  var str3=document.getElementById("Emp").value;
  document.getElementById("allSto").value=(str1-0)+(str2-0)+(str3-0);
}
//车卡港内公司
function truckCmpOper() {
  var trkxg=document.getElementById("trkxg").value;
  var trkxj=document.getElementById("trkxj").value;
  var trkgct=document.getElementById("trkgct").value;
  var trkxs=document.getElementById("trkxs").value;
  document.getElementById("allcmp").value=(trkxg-0)+(trkxj-0)+(trkgct-0)+(trkxs-0);
}
//车卡港内货物
function truckCargoOper() {
  var trkmt=document.getElementById("trkmt").value;
  var trkks=document.getElementById("trkks").value;
  var trkzh=document.getElementById("trkzh").value;
  document.getElementById("allcgo").value=(trkmt-0)+(trkks-0)+(trkzh-0);
}
//目前只有西基需要计算总疏运量
function xjBarge() {
  var total=0;
  $(".dispersion1").each(function () {
    var str=$(this).val();
    console.log(str);
    total=total+(str-0);
  });
  document.getElementById("xjtotal").value=total;
}

//提交按钮的点击事件
function submitBtn() {
  //初始化数据
  initData();
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

  //整合数据
  submitJson.dispersionVOList=disper;
  submitJson.productionLineList=proroductionLine;
  submitJson.bargeList=barge;
  submitJson.truckStoreList=truck;
  submitJson.bargeXSList=bargeXS;
  submitJson.cntrStoreList=cntrStore;
  submitJson.bulkStoreList=vehicle;

  console.log(submitJson);

  //提交数据
  if(isContinue){
    postJson();
  }
}

//修改按钮点击的事件
function changeBtn() {
  //点击修改，输入框可编辑，提交按钮出现，再加一个取消修改
  $("#inputBtn").show();
  $("#cancel").show();
  $("#editBtn").hide();
  $(".kv-item input").each(function () {
    $(this).attr("disabled",false);
  });
}

//取消按钮的点击事件
function cancelBtn() {
  $("#inputBtn").hide();
  $("#cancel").hide();
  $("#editBtn").show();
  $(".kv-item input").each(function () {
    $(this).attr("disabled",true);
  });
}

//提交数据
function postJson() {
  //提交数据
  $.ajax({
    url: "/login/saveData",
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
      //显示修改按钮
      $("#editBtn").show();
      showTips("提交成功！",200,0.5);
    }
  });
}

//散货疏运的数据处理
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
    if(!(dis1[k] == "" && dis2[k] == "" && dis2[k] == "") ){
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
  console.log(disper);
}

//集装箱驳船的数据处理
function bargeData(){
  var inPort=document.getElementById("inPort").value;
  var finishWork=document.getElementById("finishWork").value;
  var unWork=document.getElementById("unWork").value;

  //对取到的数据进行判断,不能为空
  if(inPort == "" || finishWork == "" || unWork ==""){
    isContinue=false;
    alert("集装箱驳船中数据不能为空，请返回填写！");//返回界面
  }else{
    var obj={
      bargeId:"",		//驳船Id，没有可以不填
      terCode:"",		//码头代码，不用填
      shipNumber:inPort,		//船数量
      workingNumber:finishWork,	//作业数量
      unWorkNumber:unWork		//待作业数量
    };
    barge.push(obj);
    console.log(barge);
  }
}

//集装箱作业线的数据处理
function proLineData() {
  var allLine=document.getElementById("allProLine").value;
  var shipLine=document.getElementById("shipProLine").value;
  var bargeLine=document.getElementById("bargeProLine").value;
  if(allLine == "" || shipLine == "" || bargeLine == ""){
    isContinue=false;
    alert("集装箱作业线中数据不能为空，请返回填写！");//返回界面
  } else{
    var obj={
      productionId:"",	//作业线Id,没有可以不填
      terCode:"",		//码头代码，不用填
      totalLine:allLine,		//总作业线
      shipLine:shipLine,		//大船作业线
      bargeLine:bargeLine		//驳船作业线
    };
    proroductionLine.push(obj);
    console.log(proroductionLine);
  }
}

//集装箱堆存的数据处理
function cntrStoreData() {
  var LIn=document.getElementById("LIn").value;
  var LOut=document.getElementById("LOut").value;
  var Emp=document.getElementById("Emp").value;
  var allSto=document.getElementById("allSto").value;
  if(LIn == "" || LOut == "" || Emp == "" || allSto == ""){
    isContinue=false;
    alert("集装箱堆存中数据不能为空，请返回填写！");
  }else {
    var obj={
      cntrStoreId:"",
      terCode:"",
      empCntr:Emp,
      loadCntrE:LOut,
      loadCntrI:LIn,
      totalCntr:allSto
    };
    cntrStore.push(obj);
    console.log(cntrStore);
  }
}

//车卡
function truckData() {
  var trkxg=document.getElementById("trkxg").value;
  var trkxj=document.getElementById("trkxj").value;
  var trkgct=document.getElementById("trkgct").value;
  var trkxs=document.getElementById("trkxs").value;
  var allcmp=document.getElementById("allcmp").value;
  var trkmt=document.getElementById("trkmt").value;
  var trkks=document.getElementById("trkks").value;
  var trkzh=document.getElementById("trkzh").value;
  var allcgo=document.getElementById("allcgo").value;
  var trkmte=document.getElementById("trkmte").value;
  var trkkse=document.getElementById("trkkse").value;
  var alle=document.getElementById("alle").value;
  var trkload=document.getElementById("trkload").value;
  var trkunload=document.getElementById("trkunload").value;
  var trkothere=document.getElementById("trkothere").value;

  //当港内货物总和与公司不相等时
  if(allcmp != allcgo){
    isContinue=false;
    alert("港内公司与港内货物合计不相等，请返回检查并修改！");
  }else{
    var obj={
      truckStoreId:"",
      loadInport:allcmp,
      loadOutport:alle,
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
      totalLoad:(allcmp-0)+(alle-0),
      unloadTruck:trkload,
      waitUnload:trkunload,
      terCode:""
    };
    truck.push(obj);
    console.log(truck);
  }
}

//新沙集装箱码头的数据处理
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
  console.log(bargeXS);
}

//汽车库存
function bulkVehicleData() {
  var busNum=document.getElementById("busNumBulk").value;
  var obj={
    bulkStoreId:"",		//
    terCode:"",		//码头Id
    carStore:busNum		//汽车库存
  }
  vehicle.push(obj);
  console.log(vehicle);
}
