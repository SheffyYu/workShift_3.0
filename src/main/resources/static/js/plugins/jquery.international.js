
$.fn.international = function(options) {
    var opts = $.extend({}, $.fn.international.defaults, options);
};
// plugin defaults - added as a property on our plugin function
$.fn.international.defaults = {
    navmenu: '导航菜单',
    msgwin: '消息窗口',
    login: '登录',
    reset: '重置',
    quit: '退出',
    add: '增加',
    edit: '编辑',
    delete: '删除',
    save: '保存',
    refresh: '刷新',
    address: '地址',
    fax: '传真',
    email: '电子邮件',
    telephone: '电话',
    tenancyname: '租户名称',
    datejoin: '加入日期',
    isactive: '是否激活',
    groupname: '<font color:"red">组名称</font>',
    grouptitle: '组名称',
    groupprititle: '组权限列表',
    userid: '用户名',
    passwd: '密  码',
    validatecode: '验证码',
    userlogin: '用户登录',
    WB_INFO:"提示",
    WB_NOSELECTED:"请选择一条数据！",
    WB_CONFIRM:"确认",
    WB_REMOVE_CONFIRM:"请确认是否删除？",
    WB_RELOAD_CONFIRM:"数据已改变，是否刷新?",
    WB_NOCHANGE_INFO:"数据未改变！"
};