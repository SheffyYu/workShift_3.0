/**
 * Created by yushihui on 2019/1/3.
 */
/**
 * 初始化弹出框
 * @param title
 * @param content
 */
function pop_init(title,content) {
  //取当前浏览器窗口大小
  var windowWidth=$(document).width();
  var windowHeight=$(document).height();
  //弹窗的大小
  var weight=320;
  var height=240;
  $("body").append(
    "<div id='pop_div'style='display:none;position:absolute;border:1px solid #e0e0e0;z-index:99;width:"+weight+"px;height:"+height+"px;top:"+(windowHeight-height-10)+"px;left:"+(windowWidth-weight-10)+"px'>"+
    "<div style='line-height:32px;background:#f6f0f3;border-bottom:1px solid #e0e0e0;font-size:14px;padding:0 0 0 10px;'>" +
    "<div style='float:left;'><b>"+title+"</b></div><div style='float:right;cursor:pointer;'><b onclick='pop_close()'>×</b></div>" +
    "<div style='clear:both'></div>"+
    "</div>" +
    "<div id='content'>" +
    content+
    "</div>"+
    "</div>"
  );
}
/**
 * 关闭弹出框
 */
function pop_close(){
  $('#pop_div').fadeOut(400);
}
/**
 * 在界面加载时显示
 */
$(document).ready(function(){
  //只有存在需要推送的信息时才显示弹出框，信息为空不显示
  //只有总调可以看到
  $.ajax({
    method: "get",
    url: "/login/getLoginUser?timestamp="+Math.random(),
    contentType: "application/json",
    success: function(data){
      if(data.company == 'YWB'){
        getUnwriteTer();
      }
    },
    error: function (data) {
      console.info(data);
    }
  });
});
//保存显示的信息
var content="<ul>";
/**
 *获取未填写数据的码头
 */
function getUnwriteTer(){
  //记录是否有数据
  var isTrue=0;
  //获取没有填写数据的码头和申请修改的码头
  $.ajax({
    type:"get",
    url:"/login/getUnwirteTerCode?timestamp="+Math.random(),
    contentType: "application/json",
    success: function(data){
      //当有码头没有填写时
      if(data != ""){
        //获取码头名称
        content+="<li>**目前还未填写数据的公司有"+data.length+"个，其中包括："+data[0].terCode;
        for(var i=1;i<data.length;i++){
          content+="，"+data[i].terCode;
        }
        content+="</li>";
        isTrue=1;
        getApplyTer(isTrue);
      }else{
        getApplyTer(isTrue);
      }
    }
  });
}

/**
 * 获取申请修改数据的码头
 */
function getApplyTer(isTrue) {
  $.ajax({
    type:"get",
    url:"/login/getAllKey?timestamp="+Math.random(),
    contentType: "application/json",
    success: function(data){
      //当有码头申请修改数据时
      if(data != ""){
        //获取码头名称
        content+="<li>**"+data[0].auth.company;
        for(var i=1;i<data.length;i++){
          content+="，"+data[i].auth.company;
        }
        content+="申请修改数据</li>";
        showNotice();
      }else{
        //当都为空时不显示
        if(isTrue == 1) {
          showNotice();
        }
      }
    }
  });
}

/**
 * 显示公告信息
 */
function showNotice() {
  content+="</ul>";
  pop_init("公告信息",content);
  $('#pop_div').fadeIn(400);
}

