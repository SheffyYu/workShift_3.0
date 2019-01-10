/**
 * Created by yushihui on 2019/1/10.
 */
/**
 * 获取当前日期
 * @returns {string}
 */
function getCurentDateStr()
{
  var now = new Date();
  var year = now.getFullYear();       //年
  var month = now.getMonth() + 1;     //月
  var day = now.getDate();            //日
  var clock = year + "-";
  if(month < 10) clock += "0";
  clock += month + "-";
  if(day < 10) clock += "0";
  clock += day;
  return clock;
}
