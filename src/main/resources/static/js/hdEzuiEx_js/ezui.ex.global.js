/* 
 * Copyright (C) 2015 HuaDong CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */

$.ajaxSetup({
    beforeSend: function(xhr) {
        var tab = $('#main').tabs('getSelected');
        if (tab != undefined) {
            var title = tab.panel("options").title;
            xhr.setRequestHeader('test',"title");
            xhr.setRequestHeader('hdTabTitle', encodeURI(tab.panel("options").title,"UTF-8"));
        }
    },
    error: function(XMLHttpRequest, textStatus, errorThrown) {
        HdUtils.messager.bottomRight("状态信息:"+textStatus
                +"<br>url:"+this.url
                +"<br>type:"+this.type
                +"<br>dataType:"+this.dataType
                +"<br>contentType:"+this.contentType
        ,"错误状态-["+XMLHttpRequest.status+"]");
    }
});