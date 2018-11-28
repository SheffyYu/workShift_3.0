 $(function(){
	showLeftMenu();
    var menuTwoMaxHeight = 550;
    //3 主菜单
    var mainMenu1 = $("#mainMenu");
    var mainMenu2 = $("#subMenu");
    var showMenuIndex = 1;
    
    function showLeftMenu(){
    	  $.ajax({
              method: "get",
              //async:false,
              url: "/login/PrivilegeController/findMenuAllForTree?s="+Math.random(),
              success: function(nodes) {
              	//一层菜单样式
            	  var menuTwoMaxHeight=window.screen.height-167;//电脑的分辨率高
                 // menuTwoMaxHeight = $('#mainMenuDiv').height();
                  var userDivHeight =0;// $("#userDiv").height();
                  var menuNum = parseInt((menuTwoMaxHeight - userDivHeight)/53)-2;
                  console.info(menuTwoMaxHeight+"@@@"+userDivHeight+"@@@"+menuNum);
                  var subOnePartId="0";
                  var maxTextLength = 0;
              	for(var i=0;i<nodes.length;i++) {
              	
              		var node=nodes[i];
              		if(node.LEVEL=='1') {
              			 var li=" <li id='"+node.ID+"' class='menuColor"+(i+1)+"Unselt'><a href='#'>"+node.TEXT+"</a>"+
              			 	" <div id='"+node.ID+"one' class='menuTwo' width='100%' style='display:none; max-height:"+(menuTwoMaxHeight-100)+"px;'></div></li>";
              			 if(i<menuNum){

                               mainMenu1.append(li);
                             
                         }else{
                             if(i== menuNum){
                                 $("#menuDownUp").show();
                             }
                             mainMenu2.append(li);
                         } 
              		} else if(node.LEVEL=='2') {
              			if(node.PARENT_ID!=subOnePartId){
    	                        $("#"+node.PARENT_ID+ "one").append( "<div class='menuTwoDiv menuTwoBottomLine' style='z-index:9999;'> "+"<span class='menuSpan' width='100%'>"+"<img src='../images/menuTwoIcon.jpg'/>" +node.TEXT + "</span>" +
    	                           "<div id='" + node.ID + "two'  class='menuTwoMenu' width='100%'></div>");
    	                        	subPartid=node.PARENT_ID;
              			}else{
              	             $("#"+node.PARENT_ID+ "one").append( "<div class='menuTwoDiv' style='z-index:9999;'> "+
                                  "<span class='menuSpan' width='100%'>" +"<img src='../images/menuTwoIcon.jpg'/>"+node.TEXT + "</span>" +
                                  "<div id='" + node.ID + "two'  class='menuTwoMenu' width='100%' ></div>");
              			}
                          if(node.TEXT.length > maxTextLength){
                          	maxTextLength = node.TEXT.length;
                          }
                           $("#" + node.PARENT_ID + "one").find('.menuSpan').css('width', '100%');
                           $("#" + node.PARENT_ID + "one").find('.menuTwoMenu').css('width','100%');                  
              		}else if(node.LEVEL=='3') {
              			    var item= "<a id='" + node.ID + "' paraname='"+node.TEXT+"' paraurl='"+node.URL+"' href='#'>" + node.TEXT+ "&nbsp;&nbsp;|</a>";
                        	$("#" +  node.PARENT_ID + "two").append(item);
                         	$("#" + node.ID ).on('click', function() { 
                         		openStateMenufunc(this.getAttribute("paraname"),this.getAttribute("paraurl"),this.attributes);
                         	}); 
              		}
              	}
              	//console.info(mainMenu1.html());
                 controlMenuColor();
                 mouseenterOut();//鼠标移入移出
                  $(".menuUl li").hover(function(){
                  	//if($(".menuUl li").id)indexOf
                      $(".out",this).stop().animate({'left':'150px'},200);
                      $(".over",this).stop().animate({'left':	'48px'},200); 
                      $('.menuTwo',this).css('display', 'block');
                      var index = $(this).index();  
                      var mainMenu=$("#mainMenu").height();
                      var mainWindowTopbar=$("#mainWindowTopbar").height();
                      var userDivHeight = $("#userDiv").height();
                      if( (index*53+$('.menuTwo',this).height())<(mainMenu+mainWindowTopbar)){
                      	 $('.menuTwo',this).css('top','-3px');
                      } else  if(index*53<$('.menuTwo',this).height()){
                      	 $('.menuTwo',this).css('top',-index*53+'px');
                     }else {
                      	 $('.menuTwo',this).css('top',(-$('.menuTwo',this).height()+30)+'px');
                      }

                  }, function(){
                      $(".out",this).stop().animate({'left':'48px'},200);
                      $(".over",this).stop().animate({'left':'-150px'},200); 
                      $('.menuTwo',this).css('display', 'none');
                  });
                  
                  $("#menuDownUp").on("click", function(){
                      if(showMenuIndex == 1){
                          mainMenu1.hide();
                          mainMenu2.show();
                          showMenuIndex = 2;
                      }else {
                   
                          mainMenu1.show();
                          mainMenu2.hide();
                          showMenuIndex = 1;
                      }
                  })
              },
	    	  error: function (data) {
	              HdUtils.messager.info(data.responseText);
	          }

          });
    }

    function mouseenterOut() {
        var menu_li = $(".menuUl li");
        menu_li.bind("mouseleave", function() {
            var index = $(this).index();
            var seq = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
            menu_li.each(function() {
                var i = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
                if ($(this).hasClass('menuColor' + i+'Selt')) {
                    $(this).removeClass('menuColor' + i+'Selt');
                    $(this).children('div').css('display', 'none');
                }
            });
        });
    }
    function  controlMenuColor() {     //鼠标移动控制颜色变化
        var menu_li = $(".menuUl li");
        menu_li.bind("mouseenter", function() {
            var index = $(this).index();
            var seq = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
            menu_li.each(function() {
                var i = parseInt($(this).attr('class').split(' ')[0].replace('menuColor','').replace('Unselt',''));
                if ($(this).hasClass('menuColor' + i+'Selt')) {
                    $(this).removeClass('menuColor' + i+'Selt');
                    $(this).children('div').css('display', 'none');
                }
            });
            $(this).addClass('menuColor' + seq+'Selt');
        });
    }
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
    function openStateMenufunc(funcNam,url,node) {
    		openTab(funcNam, url, false, node);
    }

});