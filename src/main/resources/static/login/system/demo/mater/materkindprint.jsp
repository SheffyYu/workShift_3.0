<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="TestDevMaterKindToolBar1428042321867">
    <div>
        <!-- TODO:查询条件 -->
        <!--        <fieldset style="float: left;width:100px;height:10px">
                    <input type="radio" name="check" checked="checked">未审
                    <input type="radio" name="check">已审
                </fieldset>
                &nbsp;船名：<input id="shipForecastWebSearchShipNam" type="text" style="width:100px"/>
                 已审核  
                状态：<input id="shipApplyForForecastShipStatId" style="width:60px"/>
                离港日期：<input id="shipApplyForForecastOtherBegDate" style="width:90px" disabled="disabled"/>&nbsp;-
                <input id="shipApplyForForecastEndDate" style="width:90px" disabled="disabled"/>
                <a class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>
                 end 
                <a class="easyui-linkbutton" iconCls="icon-search" plain="false">查询</a>-->
        <!-- 查询条件 结束-->
        <!-- 查询 -->
        <span style="float:right;">
            <input class="easyui-searchbox" id="TestDevMaterKindSearchbox1428042321867"/>
        </span>
        <!-- 查询结束 -->
        <!-- 标准按钮 -->
        <!-- 如果存在 查询条件，请开启-->
<!--        <span style="float:right">-->
        <shiro:hasPermission name="webresources:login:TestDevMaterKind:add">
        <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:TestDevMaterKind:update">
        <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:TestDevMaterKind:delete">
        <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:TestDevMaterKind:save">
        <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="webresources:login:TestDevMaterKind:refresh">
        <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">刷新</a>
        </shiro:hasPermission>
        &nbsp;
        <!-- 如果存在 查询条件，请开启-->
<!--        </span>-->
<!--请选择图表样式：<select id="chart-type" class="easyui-combobox">
                    <option value ="pie">饼图</option>
                    <option value ="column">柱状图</option>
                    <option value ="line">折线图</option>
                    <option value ="spline">曲线图</option>             
             </select>
        <a class="easyui-linkbutton" iconCls="icon-tip" plain="false" href="javascript:createChart()">生成图表</a>-->

        <!-- 标准按钮 结束-->
    </div>
</div>
<!-- 工具栏 结束 -->
<!-- Datagrid -->
<div id="TestDevMaterKindDialog1428042321867"   style="display:none"></div>
<table id="TestDevMaterKindDatagrid1428042321867" style="height:100%;fit:true"></table>
<!-- end Datagrid -->
<div id="chart-dlg">
    <div id="chart"></div>
</div>
<div id="chart-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
</div>

<!-- 脚本控制 -->
<script type="text/javascript">
$(document).ready(function() {
    var dialogTitleAddF="添加物资类别";
    var dialogTitleEditF="编辑物资类别";
    var diog = $("#TestDevMaterKindDialog1428042321867");
    var dg = $("#TestDevMaterKindDatagrid1428042321867");
    var colNum3=5;//接收一下，自动调整diog.dialog的宽度
    var colNum4=5;//接收一下，自动调整diog.dialog的高度
    if(colNum3>3){colNum3=870}else if(colNum3==1){colNum3=288}else if(colNum3==2){colNum3=480}else if(colNum3=3){colNum3=680}else{colNum3=colNum3*260};
    if(colNum4===1){colNum4=350;}else if(colNum4===2){colNum4=320;}else if(colNum4>2&&colNum4<5){colNum4=230;} else{colNum4=200;};
    // buttons
    // 增加。
    $("#TestDevMaterKindToolBar1428042321867 a[iconCls='icon-add']").on("click",function() {
         $("#TestDevMaterKindDialog1428042321867").show();
        HdUtils.dialog.show({height: colNum4,title:dialogTitleAddF,href:"../test/devmaterkindtest.html",isSaveHandler:true});
        HdUtils.dialog.setValue({data:{type:"ADD"},dataGrid:dg});    
    });
    // 编辑。
        $("#TestDevMaterKindToolBar1428042321867 a[iconCls='icon-edit']").on("click",function() {
             $("TestDevMaterKindDialog1428042321867").show();
             var selectRow = $("#TestDevMaterKindDatagrid1428042321867").datagrid("getSelected");
              if (selectRow == undefined) {
                    HdUtils.messager.info("请选择一条记录");
              } else{
                  HdUtils.dialog.setValue({data:selectRow,dataGrid:dg});
                  HdUtils.dialog.show({height: colNum4,title:dialogTitleEditF,href:"../test/devmaterkindtest.html",isSaveHandler:true});
              }
    });
    // 删除。
            $("#TestDevMaterKindToolBar1428042321867 a[iconCls='icon-remove']").on("click",function() {
                    dg.datagrid("hdRemove");
    });
    // 保存。
        $("#TestDevMaterKindToolBar1428042321867 a[iconCls='icon-save']").on("click",function() {
             dg.datagrid("hdSave",{url:"../webresources/login/TestDevMaterKind/save"});              
    });
    // 刷新。
                $("#TestDevMaterKindToolBar1428042321867 a[iconCls='icon-reload']").on("click",function() {
        dg.datagrid("hdReload");
    });
    dg.datagrid({
             onDblClickCell: function(index){
                var selectRow = $("#TestDevMaterKindDatagrid1428042321867").datagrid("getSelected");
                HdUtils.dialog.setValue({data: selectRow,dataGrid:dg});
                HdUtils.dialog.show({height: 200, title: dialogTitleEditF, href: "../test/devmaterkindtest.html", isSaveHandler: true});
             }
         });
    // 条件类。
        //var hdConditions = new HdConditions();
        var builder = new HdEzuiQueryParamsBuilder();
        // 返回后台参数。
//        var queryParams = {
//            builder: builder.build(),
//            queryColumns: {}
//        };
    // searchbox
    $("#TestDevMaterKindSearchbox1428042321867").searchbox({prompt:"请输入...",searcher:function(value,name) {
            builder.set("q",value);
            //根据具体需求修改要模糊查询的字段，替换text
            builder.set("queryColumns","text");
            dg.datagrid("hdReload");
        }});
    // datagrid
$("#TestDevMaterKindDatagrid1428042321867").datagrid({
        	striped:true,
    url:"../webresources/login/TestDevMaterKind/find",
    queryParams:builder.build(),
    method:"post",
    pagination:true,
    singleSelect:true,
    rownumbers:true,
    pageSize:20,
    toolbar:"#TestDevMaterKindToolBar1428042321867",
    fit:true,
    fitColumns:false,
    columns:[[
{
    field:"id",
    title:'<font color="red">ID</font>',
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:true}},
sortable:true
},
{
    field:"materKindCod",
    title:'<font color="red">类别编码</font>',
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:true}},
sortable:true
},
{
    field:"materKindNam",
    title:'<font color="red">类别名称</font>',
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:true}},
sortable:true
},
{
    field:"recordTim",
    title:"创建时间",
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:true
},
{
    field:"recordNam",
    title:"创建人",
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:true
},
{
    field:"updateNam",
    title:"更新人",
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:true
},
{
    field:"buyTypCod",
    title:"采购类型（1集团采购2公司采购）",
    multiSort:true,
    halign:"center",
editor:{type:"validatebox",options:{required:false}},
sortable:true
},

]]});
$("#TestDevMaterKindDatagrid1428042321867").datagrid("hdGetColumnNames");
});
function createChart(){
                 $("#chart-dlg").dialog({
                            title: '生成图表',
                            width: 800,
                            height: 500,
                            padding: 10,
                            iconCls: 'icon-save',
                            buttons: '#chart-buttons',
                            maximizable: true
                        });
                        var divId='chart';
                        var type=$("#chart-type").combobox("getValue");
               var s=new ShapeBase();
               s.show("xxx",divId,type);//XXX是查询数据的方法路径\
}

</script>
