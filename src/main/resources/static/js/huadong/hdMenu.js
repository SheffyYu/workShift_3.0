 $(function(){
	showLeftMenu();
    //3 主菜单
    var mainMenu1 = $("#mainnav");

    function showLeftMenu(){
    	  $.ajax({
              method: "get",
              url: "/login/getMenuForTree",
          contentType: "application/json",
          dataType: "json",
              success: function(nodes){
                console.log(nodes);
                  var maxTextLength = 0;
              	for(var i=0;i<nodes.length;i++) {

              		var node=nodes[i];
              		if(node.LEVEL=='1') {
              			 var li=" <li id='"+node.ID+"' class='nav-li'><a href='javascript:;' class='ue-clear'><i class='nav-ivon'></i><span class='nav-text'>"+node.TEXT+"</span></a><ul class='subnav'><div id='"+node.ID+"one'></div></ul></li>";
                    mainMenu1.append(li);
              		} else if(node.LEVEL=='2') {    //id=0one/1one/2one....为了避免和首页的data-id混淆
                    //判断是否为默认打开的页面
                    if(node.ID != node.DEFAULT_MENU){
                      $("#"+node.PARENT_ID+"one").append( "<li class='subnav-li' href='"+node.URL+"' data-id='"+node.ID+"'><a href='javascript:;' class='ue-clear'><i class='subnav-icon'></i><span class='subnav-text'>"+node.TEXT+"</span></a></li>");
                    }
                    else{
                      $("#"+node.PARENT_ID+"one").append( "<li class='subnav-li current' href='"+node.URL+"' data-id='"+node.ID+"'><a href='javascript:;' class='ue-clear'><i class='subnav-icon'></i><span class='subnav-text'>"+node.TEXT+"</span></a></li>");
                      menu._createContent($('.nav').find('li[data-id="'+node.ID+'"]'))
                    }

              		}else{
              			    //其他情况不处理
              		}
              	}

                // var menu = new Menu({
                //   defaultSelect: $('.nav').find('li[data-id="1"]'),
                // });

              	//console.info(mainMenu1.html());
                 // controlMenuColor();
                 // mouseenterOut();//鼠标移入移出
                 //  $(".menuUl li").hover(function(){
                 //  	//if($(".menuUl li").id)indexOf
                 //      $(".out",this).stop().animate({'left':'150px'},200);
                 //      $(".over",this).stop().animate({'left':	'48px'},200);
                 //      $('.menuTwo',this).css('display', 'block');
                 //      var index = $(this).index();
                 //      var mainMenu=$("#mainMenu").height();
                 //      var mainWindowTopbar=$("#mainWindowTopbar").height();
                 //      var userDivHeight = $("#userDiv").height();
                 //      if( (index*53+$('.menuTwo',this).height())<(mainMenu+mainWindowTopbar)){
                 //      	 $('.menuTwo',this).css('top','-3px');
                 //      } else  if(index*53<$('.menuTwo',this).height()){
                 //      	 $('.menuTwo',this).css('top',-index*53+'px');
                 //     }else {
                 //      	 $('.menuTwo',this).css('top',(-$('.menuTwo',this).height()+30)+'px');
                 //      }
                 //
                 //  }, function(){
                 //      $(".out",this).stop().animate({'left':'48px'},200);
                 //      $(".over",this).stop().animate({'left':'-150px'},200);
                 //      $('.menuTwo',this).css('display', 'none');
                 //  });
                 //
                 //  $("#menuDownUp").on("click", function(){
                 //      if(showMenuIndex == 1){
                 //          mainMenu1.hide();
                 //          mainMenu2.show();
                 //          showMenuIndex = 2;
                 //      }else {
                 //
                 //          mainMenu1.show();
                 //          mainMenu2.hide();
                 //          showMenuIndex = 1;
                 //      }
                 //  })
              },
	    	  error: function (data) {
	              HdUtils.messager.info(data.responseText);
	          }

          });
    }

    // function mouseenterOut() {
    //     var menu_li = $(".menuUl li");
    //     menu_li.bind("mouseleave", function() {
    //         var index = $(this).index();
    //         var seq = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
    //         menu_li.each(function() {
    //             var i = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
    //             if ($(this).hasClass('menuColor' + i+'Selt')) {
    //                 $(this).removeClass('menuColor' + i+'Selt');
    //                 $(this).children('div').css('display', 'none');
    //             }
    //         });
    //     });
    // }
    // function  controlMenuColor() {     //鼠标移动控制颜色变化
    //     var menu_li = $(".menuUl li");
    //     menu_li.bind("mouseenter", function() {
    //         var index = $(this).index();
    //         var seq = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
    //         menu_li.each(function() {
    //             var i = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
    //             if ($(this).hasClass('menuColor' + i+'Selt')) {
    //                 $(this).removeClass('menuColor' + i+'Selt');
    //                 $(this).children('div').css('display', 'none');
    //             }
    //         });
    //         $(this).addClass('menuColor' + seq+'Selt');
    //     });
    // }
/*    //解决idev7 升级hd-idev后无法openTab by huxj 2016/09/27
    function openMenufunc(id) {

        $.ajax({
            url: "/login/PrivilegeController/getNodeById?privilegeId="+id,
            type: 'GET',
            success: function(data) {
            	var funcNam = data[0].text;
                var node = data[0];
                var url = data[0].url;
                try {
                    if (!debug){
                        window.onerror = killErrorPrompt;
                    }
                    openTab(funcNam, url, false, node);
                } catch (e) {
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }*/
    // function openStateMenufunc(funcNam,url,node) {
    // 		openTab(funcNam, url, false, node);
    // }

});
