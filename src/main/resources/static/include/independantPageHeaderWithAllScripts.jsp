<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path;
%>

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/themes/metro-white/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/themes/metro-white/hdMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/themes/metro-white/hdStyle.css" />

<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/themes/icon.css" />
<!--<link href="<%=basePath%>/css/index.css" rel="stylesheet" type="text/css" />
        <link href="<%=basePath%>/css/layout_index.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="<%=basePath%>/css/themes/icon.css"/>
        <link href="<%=basePath%>/css/themes/metro-green/easyui.css" rel="stylesheet" type="text/css"/>-->
<!--[if IE]>
                <link rel="stylesheet" href="css/ie.css" />
        <![endif]-->
<!--[if lt IE 9]>
                <script src="js/html5.js"></script>
        <![endif]-->
<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
<script src="<%=basePath%>/js/jquery.cycle.all.min.js"></script>
<script src="<%=basePath%>/js/jquery.jcarousel.min.js"></script>
<script src="<%=basePath%>/js/jquery.easyui.min.js"></script>
<script src="<%=basePath%>/js/plugins/jquery.international.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/highcharts.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/jquery.json-2.4.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/js/jquery-migrate-1.2.1.min.js"></script>

<%-- BEGIN: 在公司idev库之前执行，定义$.hd等命名空间  公司ezui.ex.form.js重载submit导致mulitpart方式提交无效，保留一个副本 --%>
<script type="text/javascript">
	$.hd = $.hd || {};
	$.fn.form.methods.defaultSubmit = $.fn.form.methods.submit || function() {
	};
</script>
<%-- END: 在公司idev库之前执行 --%>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.tabs.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.combo.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.datagrid.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.form.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.datebox.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.datetimebox.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.combogrid.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezui.ex.treegrid.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/HdObject.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/HdConditions.js"></script>
<script src="<%=basePath%>/js/hdUtils/HdUtils.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/HdEzuiQueryParams.js"></script>
<script src="<%=basePath%>/js/hdEzuiEx_js/ezuiCode.js"
	type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath%>/js/hdEzuiEx_js/extension.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/huadong/main.js"></script>
<%-- BEGIN: 国际化 --%>
<script type="text/javascript"
	src="<%=basePath%>/js/jquery.i18n.properties-min-1.0.9.js"></script>
<script id="language2"
	src="<%=basePath%>/js/hdEzuiEx_js/ezuiEx-lang-zh.js"></script>
<script id="language" src="<%=basePath%>/i18n/locale/easyui-lang-zh.js"
	type="text/javascript"></script>
<%-- END: 国际化 --%>

