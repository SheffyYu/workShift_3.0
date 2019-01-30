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
  alert("do load data list");
  console.info("do load data list");
  clocker = null;
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
