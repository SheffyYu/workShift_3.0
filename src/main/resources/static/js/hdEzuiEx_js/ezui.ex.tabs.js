/* 
 * Copyright (C) 2015 HuaDong CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */

//$.extend($.fn.tabs.defaults, {
//    onContextMenu: function(e, title, index) {
//        console.log("title=" + title + ",index=" + index);
//        e.preventDefault();
//        if (index >= 0) {
//            console
//            $($(this).tabs("options").rightMenu).menu('show', {
//                left: e.pageX,
//                top: e.pageY
//            }).data("tabTitle", title);
//        }
//    }
//});
//
//$.extend($.fn.tabs.methods, {
//    initMenu: function(jq, menu) {
//        return jq.each(function() {
//            console.log("menu="+menu);
//            console.log("op="+$(this).tabs("options"));
//            $(this).tabs("options").rightMenu = menu;
//            $.fn.tabs.options.rightMenu.menu('appendItem', {
//                text: '关闭',
//                iconCls: 'icon-ok',
//                onclick: function() {
//                    alert('New Item');
//                }
//            });
//        });
//    }
//});