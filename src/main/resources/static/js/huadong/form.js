/**
 * Created by yushihui on 2018/12/5.
 */
//最终传递的数据
var submitJson;
//散货疏运的数据
var disper;
//集装箱驳船的数据
var barge;
//集装箱作业线的数据
var proroductionLine;

//初始化数据格式
function initData() {
  submitJson=[{
    dispersionVOList:[],
    productionLineList:[],
    bargeList:[],
    truckStoreList:[],
    cntrStoreList:[],
    bargeXSList:[]
  }];
  disper=[];
  barge=[];
  proroductionLine=[];
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
  document.getElementById("allProLine").value=(str1-0)+(str2-0);
}

//提交按钮的点击事件
function submitBtn() {
  //初始化数据
  initData();
//散货疏运
  dispersionData();
  //集装箱驳船
  bargeData();
  //集装箱作业线
  proLineData();

  //整合数据
  submitJson[0].dispersionVOList.push(disper);
  submitJson[0].productionLineList.push(proroductionLine);
  submitJson[0].bargeList.push(barge);

  console.log(submitJson);

  //提交数据
  postJson();
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
      console.log("提交成功！");
    },
    error: function (data) {
      console.info($.toJSON(data));
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
  //以上是疏运的内容
  console.log(disper);
}

//集装箱驳船的数据处理
function bargeData(){
  var inPort=document.getElementById("inPort").value;
  var finishWork=document.getElementById("finishWork").value;
  var unWork=document.getElementById("unWork").value;
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

//集装箱作业线的数据处理
function proLineData() {
  var allLine=document.getElementById("allProLine").value;
  var shipLine=document.getElementById("shipProLine").value;
  var bargeLine=document.getElementById("bargeProLine").value;
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
