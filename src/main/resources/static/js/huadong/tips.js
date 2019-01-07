/**
 * Created by yushihui on 2018/12/5.
 */
function showTips( content, height, time ){
  //窗口的宽度
  var windowWidth  = $(window).width();
  var tipsDiv = '<div class="tipsClass">' + content + '</div>';

  $( 'body' ).append( tipsDiv );
  $( 'div.tipsClass' ).css({
    'top'       : height + 'px',
    'left'      : ( windowWidth / 2 ) - 350/2 + 'px',
    'position'  : 'absolute',
    'padding'   : '40px 5px',
    'background': '#0e8bc5',
    'font-size' : 20+ 'px',
    'margin'    : '0 auto',
    'text-align': 'center',
    'width'     : '350px',
    'height'    : '40px',
    'color'     : '#fff',
    'opacity'   : '0.8'
  }).show();
  setTimeout( function(){$( 'div.tipsClass' ).fadeOut();}, ( time * 1000 ) );
}

/**
 * 初始化弹出框，为了避免因命名问题导致浏览器识别错误，因此在这里写实时推送显示的弹出框，傻浏览器
 * @param title
 * @param content
 */
function ontime_pop_init(title,content) {
  //取当前浏览器窗口大小
  var windowWidth=$(document).width();
  var windowHeight=$(document).height();
  //弹窗的大小
  var weight=320;
  var height=240;
  $("body").append(
    "<div id='ontime_pop_div'style='display:none;position:absolute;border:1px solid #e0e0e0;z-index:99;width:"+weight+"px;height:"+height+"px;top:"+(windowHeight-height-10)+"px;left:"+(windowWidth-weight-10)+"px'>"+
    "<div style='line-height:32px;background:#f6f0f3;border-bottom:1px solid #e0e0e0;font-size:14px;padding:0 0 0 10px;'>" +
    "<div style='float:left;'><b>"+title+"</b></div><div style='float:right;cursor:pointer;'><b onclick='ontime_pop_close()'>×</b></div>" +
    "<div style='clear:both'></div>"+
    "</div>" +
    "<div id='ontime_content'>" +
    content+
    "</div>"+
    "</div>"
  );
}
/**
 * 关闭弹出框
 */
function ontime_pop_close(){
  $('#ontime_pop_div').fadeOut(400);
}


/**
 * 实时推送消息
 */
function showOnTime(msg){
  var str="<ul><li>"+msg+"</li></ul>";
  ontime_pop_init("公告信息",str);
  $('#ontime_pop_div').fadeIn(400);
}
