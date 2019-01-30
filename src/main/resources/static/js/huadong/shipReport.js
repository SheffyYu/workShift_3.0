/**
 * Created by yushihui on 2019/1/30.
 */

/**
 * 输入船名后获取船舶资料，如果有数据则填入表单，否则不做操作
 */
// function getShipData() {
//
// }
var loseInputMillsecs = 1000;
var clocker = null;

function loadData()
{
  var shipName=document.getElementById("shipName").value;
  // alert("do load data list");
  $.ajax({
    type:"GET",
    url:"/login/vessles/findByShipName?shipName="+shipName,
    success: function (data) {
      console.log(data);
      if(data!=""){
        document.getElementById("vslNationality").value=data.vslNationality;
        document.getElementById("vslType").value=data.vslType;
        document.getElementById("vslTotalweight").value=data.vslTotalweight;
        document.getElementById("vslLength").value=data.vslLength;
        document.getElementById("vslLoadton").value=data.vslLoadton;
        document.getElementById("vslMaxseagauge").value=data.vslMaxseagauge;
        document.getElementById("vslWidth").value=data.vslWidth;
      }else {
        document.getElementById("vslNationality").value="";
        document.getElementById("vslType").value="";
        document.getElementById("vslTotalweight").value="";
        document.getElementById("vslLength").value="";
        document.getElementById("vslLoadton").value="";
        document.getElementById("vslMaxseagauge").value="";
        document.getElementById("vslWidth").value="";
      }

      clocker = null;
    }
  });

}

function innerKeydown()
{
  if(null == clocker)
  {
    clocker = setTimeout(loadData,loseInputMillsecs);
  }
  else	//连续击键，重新开始计时
  {
    clearTimeout(clocker);
    clocker = setTimeout(loadData,loseInputMillsecs);
  }
}

$('#shipName').keydown(function() {
  innerKeydown();
});
/**
 * 加载
 */
$(document).ready(function () {
  //默认日期为今天
  $('#beginDate').datebox('setValue', getCurentDateStr());
  $('#endDate').datebox('setValue', getCurentDateStr());

});
