/* 
 * ezui combo扩展
 */
$.extend($.fn.combo.defaults, {
    /**
     * 重写combo加载数据方法。
     * @name combo#loader
     */
    loader: function(param, successCallback, errorCallback) {
        var opts = $(this).combobox('options');
        if (!opts.url) {
            return false;
        }

        if (!opts.method || "post" === opts.method.toLowerCase()) {  //V1 对POST的行为进行修正，消除服务器端不能解析JSON的问题
            $.ajax({type: "post", url: opts.url, data: $.toJSON(param), dataType: "json", //以JSON发送全部参数，方便服务端统一处理
                contentType: "application/json", processData: false, //此为所加限定，见jQuery.ajax(url,[settings])说明文档
                success: function(data) {
                    successCallback(data);
                },
                error: function() {
                    errorCallback.apply(this, arguments);
                }
            });
        } else {
            //combo loader的标准代码
            $.ajax({type: opts.method, url: opts.url, data: param, dataType: "json",
                success: function(data) {
                    successCallback(data);
                },
                error: function() {
                    errorCallback.apply(this, arguments);
                }
            });
        }
        return true;
    }
});
