<!--
  Document   : 最近访问列表界面
   
         说明：
              1、此界面调用Privilege类作为后台，从session中取得当前操作员最近访问的网页，并取得菜单名、URL等数据
              2、操作员可以从近到远查看操作记录，通过点击URL打开相应功能（这些功能都是菜单树的功能项）
              3、暂不支持列表存盘功能，因此所谓MRU是从本次登录开始记录的。下次登录此列表为空

   Created on : 2014-12-27
   Author     : 傅新奇

   Modifications:
   
      1.0 2014-12-27 by fuxinqi: 配合iDeveloper3.0界面改善，实现最近访问列表功能
-->


<%@page import="net.huadong.idev.tpl.privilege.resources.PrivilegeResource"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="net.huadong.idev.tpl.privilege.entity.AuthUser"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<meta charset="UTF-8">


<!-- 工具栏 -->
<div class="easyui-layout" data-options="fit:true"  style="height:100%;width:100%;border: 0px">
    <div id="user_toolbar" data-options="region:'north'" style="border: 0px">
        <div>
            <a id="form_reload" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'"><label name="reload">刷新</label></a>  
        </div>
    </div>
    <table id="user_table" style="height:95%"  data-options="region:'center'"></table>    
</div>
<%
    AuthUser user = (AuthUser) SecurityUtils.getSubject().getSession().getAttribute(PrivilegeResource.SESSION_USER);
%>
<!-- 脚本控制 -->
<script type="text/javascript">

    var tenId = '<%=user.getTenantId().getTenantId()%>'
    var auth = '<%=user.getAccount()%>'
    $(document).ready(function () {
    	
    	$.i18n.properties({
            name: 'MostRecentUsedPages', //资源文件名称
            path: '../i18n/project/', //资源文件路径
            mode: 'map', //用Map的方式使用资源文件中的值
            language: getBrowserLanguage(),
//            language: "en",
            callback: function () {//加载成功后设置显示内容
                $("label").each(function (i) {
                    $(this).html($.i18n.prop($(this).attr("name")));
                });
            }
        });
    	
        // 条件类。
        var builder = new HdEzuiQueryParamsBuilder();
        builder.setAndClause("inuser",auth,"=","and");
//        var hdConditions = new HdConditions();
//        // 返回后台参数。
//        var queryParams = {
//            hdConditions: hdConditions.getHdConditions(),
//            queryColumns: {}
//        };
//        var hdConditions1=new HdConditions();
////        hdConditions1.setAndClause("user.tenantId.tenantId",tenId,"=","and")
//            queryParams.hdConditions=hdConditions1.getHdConditions();
        // buttons
        // 增加。
        // 刷新。
        $("#form_reload").on("click", function () {
            dg.datagrid("hdReload");
        });
        // datagrid
        $("#user_table").datagrid({
        	striped:true,
            toolbar: '#user_toolbar',
            url:"../webresources/login/UserLogAccess/find",
            queryParams:builder.build(),
            method: 'post',
            sortName: 'intime',
            sortOrder: 'desc',
            remoteSort: false,
            fitColumns: false,
            pagination: true,
            columns: [[{
                        title: $.i18n.prop("visitcount"),
                        field: 'visitcount',
                        sortable: true,
                        align: 'left',
                        width:70,
                        halign: 'center'
                    }, {
                        title: $.i18n.prop("menucod"),
                        field: 'menucod',
                        sortable: true,
                        align: 'left',
                        width:170,
                        halign: 'center'
                    }, {
                        title: $.i18n.prop("menunam"),
                        field: 'menunam',
                        align: 'left',
                        width:170,
                        formatter: function (value, row, index) {
                            return "<a href='#'>" + row.menunam + "</a>";
                        },
                        sortable: true,
                        halign: 'center'
                    }, {
                        title: $.i18n.prop("menuurl"),
                        field: 'menuurl',
                        align: 'left',
                        width:250,
                        formatter: function (value, row, index) {
                            return "<a href='#'>" + row.menuurl + "</a>";
                        },
                        sortable: true,
                        halign: 'center'
                    },{
                        title: $.i18n.prop("intime"),
                        field: 'intime',
                        align: 'left',
                        sortable: true,
                        width:200,
                        halign: 'center',
                    }]],
            onClickCell: function (rowIndex, field, value) {
                var row = $("#user_table").datagrid('getRows')[rowIndex];
                var row_menunam = row.menunam;
                var row_menuurl = row.menuurl;
                
               if(row.menunam=="最近访问"){
            	   return ;
               }
              
                if (field == "menunam" || field == "menuurl") {
                		 openTab(row_menunam,row_menuurl,false,null);
                }
            }, 
          
            onLoadSuccess: function (data) {
            }

        });
        $("#user_table").datagrid("hdGetColumnNames");
    });
    
   

</script>
