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
