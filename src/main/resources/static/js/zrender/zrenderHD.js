var zr; // 全局可用zrender对象

var domGraphic = document.getElementById('graphic');
var domMain = document.getElementById('main');

//文本编辑<(‵^′)>器
var editor = CodeMirror.fromTextArea(
    document.getElementById("code"),
    { lineNumbers: true }
);
editor.setOption("theme", 'monokai');
editor.on('change', function(){});

function refresh(isBtnRefresh){
	
    (new Function(editor.doc.getValue()))();
}

function QueryString() {
    var name,value,i;
    var str = location.href;
    var num = str.indexOf("?")
    str = str.substr(num+1);
    var arrtmp = str.split("&");
    for(i = 0;i < arrtmp.length;i++){
        num = arrtmp[i].indexOf("=");
        if(num > 0){
            name = arrtmp[i].substring(0, num);
            value = arrtmp[i].substr(num + 1);
            this[name] = value;
        }
    }
}
//加载js配置
require.config({
    packages: [
        {
            name: 'zrender',
            location: '/js/zrender/src',
            main: 'zrender'
        }
    ]
});
require(
    ['zrender','zrender/shape/rose','zrender/shape/trochoid'],
    function(zrender) {
        zr = zrender.init(document.getElementById('main'));
        var request=new QueryString();
        if (request.code) {
            editor.doc.setValue(
                "zr.clear()\n" +
                decodeURIComponent(request.code)
            );
        }
        refresh();
    }
)