/* 
 * main.jsp用到的通用方法，为了放着业务层扩展时误删、误改代码，抽取到单独的JS文件。
 * 
 * 修改记录：
 * 
 *  1.2 2016-08-25 by huxj   引入到idev7，修改部分内容
 *  1.1 2015-11-13 by 傅新奇  将$.main中的方法依次单独定义从而优化了代码结构（便于识别及修改），并增加了公共的searchbox配套方法 
 *  1.0 2014-xx-xx by 傅新奇  提取公共方法到$.main命名空间，用于配合main.jsp工作，并提供了全局的操作员信息，URL处理等工具方法
 */

var debug = true;
var mainPanel = undefined; //即$("#main"); 只有当窗口打开后再对mainPanel赋值。因为main.js在head中初始化

$.main={                    //FXQ2013-11-8为防止命名冲突，引入命名空间
    loginOper:{},	    //在获取登录信息后，保存在这里，方便判断
    contextMenuObj: [], //右键菜单对象
    getUrl:function(){  //获取当前功能的URL
            var selected=mainPanel.tabs('getSelected');
            if(!selected){
                    return undefined;
            }
            var node=selected.panel('options').treeNode;
            if(node){
                if(node.data!=null){
                    return node.data.url;             //新菜单补丁
                }else{
                    return node.url;      //翻页/从菜单打开时，已经保存在当前卡片，见openTab()函数
                }
                    
            }else{
                    return undefined;
            }
    },
    getCurFuncName:function(){  //获取当前功能的的名称
            var selected=mainPanel.tabs('getSelected');
            if(!selected){
                    return undefined;
            }
            var node=selected.panel('options').treeNode;
            if(node){
                    return node.text;      
            }else{
                    return undefined;
            }
    },
    getUrlVars: function(){    //获取全部参数
            var vars = [], hash; 
            var url=$.main.getUrl();
            if(!url){
                    return vars;
            }
            var hashes = url.slice(url.indexOf('?') + 1).split('&'); 
            for(var i = 0; i < hashes.length; i++) { 
                   hash = hashes[i].split('='); 
                   vars.push(hash[0]); 
                   vars[hash[0]] = hash[1]; 
            } 
            return vars; 
    }, 
     //获取URL参数取值
    getUrlVar: function(name){ 
            return $.main.getUrlVars()[name]; 
    }
};      

$.main.getObjWidthHeight= function(objId){ 
    alert("getObjWidthHeight尚未实现");
    return fff[objId]; 
};
    
//使用独立窗口target=blank打开一个网页（独立网页），不使用window.open防止被拦截
$.main.openModuleInNewWin = function(url, params) {
	//防止拦截方法一
	/*var a = $("<a href='"+url+"' target='_blank' >test</a>").get(0);
	 var e = document.createEvent('MouseEvents');
	 e.initEvent('click', true, true);
	 a.dispatchEvent(e);*/
	/*var openLink = $("");
	openLink.attr('href', url);
	openLink[0].click();*/
	//防止拦截方法二
	    /*var dataKey = url;
	    var me = $(this);
	    var A = me.data(dataKey);

	    var returnData = url;
	    if(!A){
	        A = $("");
	        me.data(dataKey, A);
	        A.click(function(e){
	            if(returnData){
	                A.attr("href", returnData);
	            }else {
	                A.before(me);
	                e.stop();
	            }
	        });
	    }
	    me.mouseover(function(){$(this).before(A).appendTo(A);});
	    me.mouseout(function(){A.before($(this));});
	    me.click(function(){
	        A.attr("href", "#|");
	        returnData = f.apply(this, arguments);
	    });*/

    // 动态创建一个FORM准备将params提交到后台 （防止拦截方法三：启用）
    var frm=document.createElement("form");
    frm.action=url; //"http://www.baidu.com"; //
    frm.target="_blank";
    frm.method="get";
    document.body.appendChild(frm);

    $.each(params, function(key, v) { // key 就是params中各字段名，无需处理
        var value; //
        if (!v) { // 字段无值，不处理
            value = "";
        } else { // params全部属性，按字符串处理
            value=""+v; //防止v不是字符类型 
        }
        var inp=document.createElement("input");
        inp.type="hidden"; 
        inp.name=key;
        inp.value=value;
        frm.appendChild(inp);
    });

    frm.submit(); //这里不使用jquery的form对象,因为xmlHttpRequest取消了get请求
    setTimeout(function(){document.body.removeChild(frm);},100);
};

//在独立的窗口打开外部url，使用iframe封装
$.main.openUrlInFrame = function(title,url){
	
	/*var a = document.createElement('a');  
    a.setAttribute('href', url);  
    a.setAttribute('target', '_blank');  
    a.setAttribute('id', url);  
    // 防止反复添加  
    if(!document.getElementById(url)) {                       
        document.body.appendChild(a);  
    }  
    a.click();  */
    function decrateHtml(data){   //工作方法：URL内容的检索/装点器
           var id= "tabPageFrame_"+$.hd.commonUtils.getRandomId();
           var prog="<iframe id='"+id+"' src='"+encodeURI(url)+"' " +
                            "  frameborder=yes scrolling=yes style=\"border:1px none;z-index: 1;width:100%;height:100%;\" />\n";
           return prog;
    };
    mainPanel.tabs('add', {
           title: title,
           content:decrateHtml(null), 
           cache: true,
           closable: true,
           'tools': [
            /** FXQ2015-11-20 新界面使用统一的刷新按钮，这里不放图标了   
            {
                           iconCls: 'icon-mini-refresh',
                           handler: function() {
                               var tab = $('#main').tabs('getSelected');  // get selected panel
                               tab.panel('refresh');
                           }
                     },
            **/         
                    {
                       iconCls: 'icon-mini-copy',
                       handler: function() {
                               $.main.openModuleInNewWin(url,{random:"r_"+$.hd.commonUtils.getRandomId()});
                       }
                   }]
       });
};
        
//使用SWF装载器打开swf模块
$.main.openSwfModule = function(title, url, refresh, node){
    lg("打开flex模块"+url);
    mainPanel = $("#main");
    var swfTabFound=false, swfPanel=undefined;
    $.each(mainPanel.tabs('tabs'),function(i,panel){
            var flag=panel.panel('options').isSwfPanel;
            if(flag && true==flag){
                    swfPanel=panel;swfTabFound=true;
                    return false; //终止循环
            }
    });
    var prog='<div id="swfPanelArea" style="width:100%; height:100%;">这里显示flex程序界面。如果您看到这些文字，说明flexLoader工作不正常，请通知系统维护人员。</div>';

    if (!swfTabFound) {
            mainPanel.tabs('add', {
                title: title,
                content: prog,
                // href: '../pages/flex_loader/loadFlex.jsp',  //由于tabpage的hide/show会导致flex应用频繁初始化，改为遮罩层方式显示SWF
                // method: 'GET',
                isSwfPanel: true, //设置标志
                closable: true, //允许关闭
                tools: [{
                        iconCls: 'icon-mini-refresh',
                        handler: function () {
                            loadModual(encodeURI(url));
                        }
                    }],
                onOpen: function () {
                    floatSwfMaskDiv(this);
                },
                onResize: function () {
                    floatSwfMaskDiv(this);
                },
                onMove: function () {
                    floatSwfMaskDiv(this);
                },
                onClose: function () {
                    $('#swfMaskDiv').css({width: '1px', height: '1px'});
                }
            });
            setTimeout(function(){loadModual(encodeURI(url));},100); //在FLEX组件中加载swf模块，见loadFlex.jsp
        }else{
            mainPanel.tabs('select', swfPanel);
            mainPanel.tabs('update', {     //注意： 由于TAB已经打开，用 defaultTab.panel('setTitle',title);无效
                tab: swfPanel,
                options: {'title': title}  // 为什么还是触发了onReady?
            });
            setTimeout(function(){loadModual(encodeURI(url));},100);
        }
        //工作方法：swf遮罩层随panel的DIV移动
        function floatSwfMaskDiv(panelTarget) {  //
            var panel = $(panelTarget);
            var opts = panel.panel('options'), offset = panel.offset();   //offset是相对当前viewport的（因为swf的DIV是绝对定位）
            var scrTop = document.documentElement.scrollTop;//滚动条距顶部的距离 
            var scrLeft = document.documentElement.scrollLeft;//滚动条距左边的距离 
            var objLeft = Number(scrLeft) + offset.left;
            var objTop = Number(scrTop) + offset.top;
            $('#swfMaskDiv').css({top: objTop, left: objLeft, width: opts.width, height: opts.height});    //swf遮罩层随本DIV移动,移动，缩放等情形			
        }
        //工作方法：真正加载一个swf模块
	function loadModual(modualName){  //工作方法，未来可能改变实现，所以抽取出来
            document.getElementById("appMain").loadSwf(modualName);    //  lg("加载模块:"+modualName);
        } 
 };
 
//在单一的卡片中打开所有功能 
$.main.openSingleTab=function(title, url, refresh, node) {
    mainPanel = $("#main");      
    var defaultTab = $("#defaultTabpage");   

    //首先清除原窗口隐藏的dialog，然后再打开新窗口
    $.main.destroyDialogsOnClose(defaultTab);

    var oper = "";
    if(url.indexOf("?")<0) { oper = "?"; } else { oper = "&";  }

    $.hd.ezui.messager.status("当前【" + title + "】窗口");
    url = url + oper+"timestamp="+new Date().getTime();

    mainPanel.tabs('update', {     //注意： 由于TAB已经打开，用 defaultTab.panel('setTitle',title);无效
        tab: defaultTab,
        options: {
                'title': title,
                closable: false,
                'href' : '../login/' + encodeURI(url),
                'tools': [{
                            iconCls: 'icon-mini-refresh',
                            handler: function() {
                                var tab = $('#main').tabs('getSelected');  // get selected panel
                                tab.panel('refresh');  //, 'plugin/' + encodeURI(url)
                            }
                          },{
                    iconCls: 'icon-mini-copy',
                    handler: function() {
                         mainPanel.tabs('update', {     //注意： 由于不能重复打开同一网页（ID重复）,所以默认网页必须加载默认页
                                tab: defaultTab,
                                options: {'title': '关于本系统', 'href':'../pages/welcome.htm' }
                        });
                        $.main.openMultiTab(title,url,refresh, node);
                        setTimeout(function(){mainPanel.tabs('select', title);},50);
                    }
                }]
         }
    });
    mainPanel.tabs('select', title);
};

//多卡片打开各个URL
$.main.openMultiTab=function(title, url, refresh, node) {
    mainPanel = $("#main");    
    var oper = "";
    if(url.indexOf("?")<0) { oper = "?"; } else { oper = "&";  }
    url = url + oper+"timestamp="+new Date().getTime();
    mainPanel.tabs('add', {
        title: title,
        href: '../login/' + encodeURI(url),
        cache: true,
        method: 'GET',
        closable: true,
        fit:true,
        tools: [
/** FXQ2015-11-20 新界面使用统一的刷新按钮，这里不放图标了
            {
                iconCls: 'icon-mini-refresh',
                handler: function() {
                    var tab = $('#main').tabs('getSelected');  // get selected panel
                    tab.panel('refresh'); //, 'plugin/' + encodeURI(url)
                }
            }
**/            
//FXQ2015-7-13由于$.main状态同步等问题，暂不开放打开新网页功能  ,{
//                        iconCls: 'icon-mini-copy',
//                        handler: function() {
//                            var formUrl="../pages/modulePopupPreView.jsp"  //由于使用form进行GET,在url中不能使用参数，否则JSP中取不到
//                            var mainObj={};
//                            $.each($.main, function(key, v) {
//                                    if(!$.isFunction(v)){  //函数没必要复制，只复制数据
//                                            mainObj[key]=v;
//                                    }
//                            });
//                            var formData={moduleTitle:encodeURI(title),moduleUrl:encodeURI(url)/*,mainJson:encodeURI($.toJSON(mainObj))*/};  //fxq20150509 mainObj太大？导致URL无效    
//                            $.main.openModuleInNewWin(formUrl,formData);
//                           /* 以下为openModuleInNewWin的原理性代码，使用openModuleInNewWin方法，主要为了通过form传递URL参数
//                            var f=document.createElement("form");
//                            f.action=formUrl;//"http://www.baidu.com";
//                            f.target="_blank";
//                            f.method="get";
//                            document.body.appendChild(f);
//                            f.submit();*/
//                        }                        
//                    }
        ]
    }); 
};

//注册需要自动销毁的dialog的ID数组
//FXQ2015-11 用于取代如下代码： $('#main').tabs('getSelected').panel('options').destroies = [ '#id1','#id2','#id3'];
$.main.registerDialogs =function(ids){
    var selected=$('#main').tabs('getSelected');
    if(!selected || !$.isArray(ids)){
        return;
    }
    selected.destroies=ids;
};

//在页面关闭时，销毁dialog防止再次打开的影响
$.main.destroyDialogsOnClose = function(tabPage){
    if(!tabPage){
        return;
    }
    $('#swfMaskDiv').css({width:'1px',height:'1px'}); 
    //lg("---calling destroyDialogsOnClose--"+tabPage.panel('options').title);
    var targetArray = tabPage.panel('options').destroies;
    if (targetArray) {
        $.each(targetArray, function(i, v) {
         if("#"===v.charAt(0)){v=v.substr(1);}
            var dialog=$("#" + v);
            var parent=$(dialog).parent();
            if( dialog.size()>0 && parent.hasClass("panel")&& parent.hasClass("window")){  //确保已经打开过，而不是简单的div
             parent.next(".window-shadow").remove();  //根据观察，这2个DIV是与DIALOG配合用的，dialog删除后，它们成为垃圾
             parent.next(".window-mask").remove();
             dialog.dialog('destroy', true);
            }
        }); //end each
    } //end if
};    

//注册当前卡片的searchbox相关信息
//注意： 如果外部builer可能改变，应传入function(){return builder}，以便保留外边指针的改变
$.main.registerSeachbox =function(operation,builerOrQueryParam,columns){
    var selected=$('#main').tabs('getSelected');
    if(!selected || !operation ||!builerOrQueryParam){  //参数必须有效
        return;
    }
    selected.searchboxInfo={operation:operation,builerOrQueryParam:builerOrQueryParam,columns:columns};
};

//执行搜索,用于配合主界面的searchBox的searcher回调函数
$.main.onSeachboxValue = function(q,undefined){
    var selected=$('#main').tabs('getSelected');
    if(!selected || !selected.searchboxInfo || !selected.searchboxInfo.builerOrQueryParam || q== undefined || q==null){
        return;
    }

    lg('::开始条件查询,q='+q);
    var builerOrQueryParam=selected.searchboxInfo.builerOrQueryParam;
    if($.isFunction(builerOrQueryParam)){   //FXQ2015-1118  解决外边builder改变导致指针引用错误的问题
        builerOrQueryParam=builerOrQueryParam();
    }
    var operation =selected.searchboxInfo.operation;  //operation对象也可以传入函数
    if($.isFunction(operation)){    
        operation=operation();
    }
    if(builerOrQueryParam instanceof HdEzuiQueryParamsBuilder){
        builerOrQueryParam.set("q",q);
        builerOrQueryParam.set("queryColumns",selected.searchboxInfo.columns);
        operation.load(builerOrQueryParam.build());
    }else{ //不是builder,认为是以普通的queryParam方式查询
        builerOrQueryParam.q=q;
        builerOrQueryParam.queryColumns = selected.searchboxInfo.columns;
        operation.load(builerOrQueryParam);
    }
};

//向后台设置当前功能，后台日志等
$.main.sendCurFuncToBack = function(node) {
    return;
    $.ajax({type: "post",
        url: '../webresources/normal/workspaceRest/setCurFunc',
        data: $.toJSON({funcId: node.id, funcName: node.text, funcUrl: node.attributes.url}),
        dataType: "json", //以JSON发送全部参数 
        method:'post',
        contentType: "application/json",
        processData: false  //此为所加限定，见jQuery.ajax(url,[settings])说明文档
    });
};

/**
 * 判断当起操作员是否具有菜单要求的权限。如果有，则某些按钮才可以用（还可能依赖其他条件），否则程序应关闭或隐藏这些按钮
 * @returns 如果按钮可用（不考虑其他限定条件，只判断是否当前人员权限符合要求）则返回true，其他情况一律返回false
 */
$.main.isHaveRequiredRole=function(){
    var requiredRole=$.main.getRequiredRole();
    if(!requiredRole){  //菜单没有特定要求
            return true;
    }
    return $.main.isOperatorHasRole(requiredRole);
};

/**
 * 判断当前操作员是否具有指定的角色
 * @param roles 角色或角色的列表（以逗号分割）
 * @returns 如果具有改角色或者角色列表的某一个，则返回true，没有角色则返回false
 */
$.main.isOperatorHasRole=function(roles){
    if(!roles || ''===roles){
            return false;
    }
    try{ 
            var roleArray=(""+roles).split(',', 100);  //需要的ROLE列表
            var operRole=$.main.loginOper.postCod;     //当前操作员只有一个ROLE（目前数据库设计），只要看此role是否在数组中就OK了
            return roleArray.contains(operRole);       //见extension.js 已经扩展 Array.prototype.contains
    }catch(e){
            return false;
    }
};

/**
 * 获得当前功能要求的角色/角色列表（以逗号分割）
 * 原理是：根据当前功能的URL（菜单树点击时记录在当前卡片），分析是否有 ?role= 或者&role=参数，
 * 这样在不同现场，角色代码不同，调整菜单的定义就可以了
 * @returns 如果当前功能定义了角色参数，则返回参数设置。否则返回undefined
 */
$.main.getRequiredRole=function(){
    try{
            return $.main.getUrlVar('role');
    }catch(e){
            return undefined;
    }
};

//处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外
$.main.forbidBackSpace=function(e) {
    var ev = e || window.event; //获取event对象 
    var obj = ev.target || ev.srcElement; //获取事件源 
    var t = obj.type || obj.getAttribute('type'); //获取事件源类型 
    //获取作为判断条件的事件类型 
    var vReadOnly = obj.readOnly;
    var vDisabled = obj.disabled;
    //处理undefined值情况 
    vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
    vDisabled = (vDisabled == undefined) ? true : vDisabled;
    //当敲Backspace键时，事件源类型为密码或单行、多行文本的， 
    //并且readOnly属性为true或disabled属性为true的，则退格键失效 
    var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效 
    var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
    //判断 
    if (flag2 || flag1) return false;
};


/**
 * 打开tab页，全局函数，为了保证与原来的代码兼容。
 * @param {type} plugin
 * @returns {undefined}
 */
function openTab(title, url, refresh,node) {
    mainPanel = $("#main");     //2013-11-8 已经将mainPanel定义为全局变量，方便不同功能之间的耦合。下一步可考虑加入到$.main命名空间
    $.hd.ezui.messager.status("当前【" + title + "】窗口");
    if (mainPanel.tabs('exists', title)) {
        mainPanel.tabs('select', title);
        var oper = ""; if(url.indexOf("?")<0) { oper = "?"; } else { oper = "&";  }
        url = url + oper+"timestamp="+new Date().getTime();
        if(refresh){
        	$('#main').tabs('getSelected').panel('refresh', '../login/' + encodeURI(url));
        }
    }else {
    	url= url.replace("/(^/s*)/g", "");      //去掉左空格
    	if(url.toLowerCase().search("://")>=0){  // http , https, ftp, file 绝对地址，使用IFRAME方式打开
    		$.main.openUrlInFrame(title, url);
//    		$.main.openModuleInNewWin(url,{random:"r_"+$.hd.commonUtils.getRandomId()});
    	}else if(url.match(/\.swf$/i)){        //是swf后缀
    		$.main.openSwfModule(title, url, false ,node);
    	}else{
    		if(undefined==node){  //没有NODE参数，在页面直接调用的情况（非菜单打开，使用独立页面）
    			$.main.openMultiTab(title, url, false ,node);
    		}else{
    			$.main.openMultiTab(title, url, false ,node);      //多卡片方式
    			//$.main.openSingleTab(title, url, false ,node);   //单一卡片方式
    		}
    		
    		//$.main.openSingleTab(title, url, false ,node);   //单一卡片方式
    	}
        var selectedPanelOpts=mainPanel.tabs('getSelected').panel('options');
        selectedPanelOpts.treeNode=node;  //将信息存贮在卡片上，翻页时再次发送
        if(node){
        	$.main.sendCurFuncToBack(node);          //向后台发送消息，记录当前功能
        }
    } 
    mainPanel.tabs('options').onSelect =function(title,index){    //要重新注册一下才，事件才有效  FXQ2013-1031
    	$.hd.ezui.messager.status("当前【" + title + "】窗口");
        var selected=mainPanel.tabs('getTab',index);
        var node=selected.panel('options').treeNode;
        if(node){
                $.main.sendCurFuncToBack(node);      //翻页时向后台发送消息。 node可能为空，不是从菜单打开的情况
        }
    };	
};

/**
 * 在浏览器控制台输出调试信息，未来关闭。
 * @param {obj} obj 要输出的对象
 * @returns {undefined}
 */
function lg(obj){
    if(debug){
            console.log(obj);
    }
}

/**
 * 为主页定制化的tabs组件
 * @param {type} $
 * @returns {undefined}
 */
(function($){
	// 创建实例，container参数为 调用 $(#x).tabsMain({})构造函数的HTML原件，即选择器 $(#x)对应的 DOM 对象
	function doInit(container){
            var cc = $(container);
            var opts= $.data(container,'tabs').options;
            $.data(container, 'tabs',null);  //清除data数据，以确保父类构造市能调用到wrapTabs()
            cc.tabs(opts);                   //调用父类的构造函数
            //var tabs =opts.tabs;
            cc.children('div.tabs-header').each(function(){
                $(this).addClass('tabs-header2');
            });
            cc.children('div.tabs-header').find('.tabs-wrap').each(function(){
                $(this).addClass('tabs-wrap2');
            });              
            cc.children('div.tabs-header').find('.tabs-inner').each(function(){
                $(this).addClass('tabs-inner2');
            });           
	}
	
	//这里定义dateboxMonth组件，同时定义了接口 即：     
	$.fn.tabsMain = function(options, param){
		if (typeof options == 'string'){ //调用方法，options参数的位置为方法名
			var method = $.fn.tabsMain.methods[options];
			if (method){
				return method(this, param);
			} else {
				return this.tabs(options, param); //认为是父类的方法
			}
		}
		//初始化，此时options为对象而不是string
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'tabs');
			if (state){
				$.extend(state.options, options);
			} else {
				$.data(this, 'tabs', {
                                    options: $.extend({}, $.fn.tabs.defaults, $.fn.tabs.parseOptions(this), options)
				});
			}
			doInit(this);  //  通过$(target) 创建实例
		});
	};
	
	//沿用tabs的所有方法，覆盖部分实现
        var oldFunc=$.fn.tabs.methods.add;
	$.fn.tabs.methods.add = function(jq, options){
            oldFunc(jq, options);
            jq.children('div.tabs-header').find('.tabs-inner').each(function(){
                $(this).addClass('tabs-inner2');
            }); 
        };

	//定义组件的默认行为
	$.fn.tabsMain.defaults = $.extend({}, $.fn.tabs.defaults, {
	});
})(jQuery);


 
