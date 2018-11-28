<meta charset="UTF-8">
<!-- 工具栏 -->
<div class="easyui-layout" style="width:100%;height:100%;" fit="true">
    <div data-options="region:'center',split:true" title="系统代码" style="">
        <div id="SysCodToolBar1427420966140">
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
                    <input class="easyui-searchbox" id="SysCodSearchbox1427420966140"/>
                </span>
                <!-- 查询结束 -->
                <!-- 标准按钮 -->
                <!-- 如果存在 查询条件，请开启-->
                <!--        <span style="float:right">-->
                <shiro:hasPermission name="webresources:login:syscod:add">
                    <a class="easyui-linkbutton" iconCls="icon-add" plain="false">增加</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:syscod:update">
                    <a class="easyui-linkbutton" iconCls="icon-edit" plain="false">编辑</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:syscod:delete">
                    <a class="easyui-linkbutton" iconCls="icon-remove" plain="false">删除</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:syscod:save">
                    <a class="easyui-linkbutton" iconCls="icon-save" plain="false">保存</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="webresources:login:syscod:find">
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
        <table id="SysCodDatagrid1427420966140" style="height:100%"></table>
        <!-- end Datagrid -->
        <div id="chart-dlg">
            <div id="chart"></div>
        </div>
        <div id="chart-buttons">
            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#chart-dlg').dialog('close')">关闭</a>
        </div>
    </div>
    
    <div data-options="region:'east',split:true" title="实例" style="width:470px;padding:5px;">
       <a class="easyui-linkbutton"  id="btnBottom" plain="false">底部消息</a>
       <a class="easyui-linkbutton"  id="btnStatus" plain="false">状态栏消息</a>
       <a class="easyui-linkbutton"  id="btnCenter" plain="false">消息提示</a>
       <br><br>
       <a class="easyui-linkbutton"  id="btnMarquee" plain="false">跑马灯消息</a>
       <a class="easyui-linkbutton"  id="btnShow" plain="false">弹出窗口</a>
       <a class="easyui-linkbutton"  id="btnShow2" plain="false">弹出窗口-中国港口移动服务平台</a>
       <br><br>

        下拉列表实例：
        <select class="easyui-combogrid" id="testaa"></select>
        <a class="easyui-linkbutton" id="btnSetVal" plain="false">设值</a>
        <a class="easyui-linkbutton" id="btnDisplayVal" plain="false">获取值和文本</a><br/>
        <span id="testcod"></span><br/><span id="testnam"></span>
        <h3>格式化</h3>
        请输入数字：<input type="text" id="num_value" value="12345.234565"/>小数点位数：<input type="text" id="point_value" value="2"/>
        <br>
        <a class="easyui-linkbutton"  id="btn_nump" plain="false">格式化数字</a>&nbsp;&nbsp;结果：<span id="num_result" ></span>
		<hr>
		<h3>form提交测试</h3>
		<form id="form1">
		时间戳：<input id="ts" name="ts"  class="easyui-datetimebox"  required="required" />
		日期：<input id="dt" name="dt"  class="easyui-datebox"  required="required" />
		</form>
		<h3>测试create方法</h3>
		<a class="easyui-linkbutton" id="btnSave" plain="false">保存实体测试</a>
    </div>
</div>
<!-- 脚本控制 -->
<script type="text/javascript">
    $(document).ready(function() {
    	$("#form1").form("loadData",{ts:1474856463641,dt:1474856463641});
    	$("#btnSave").click(function(e) {
    		
    	});
        var msgContent = "消息内容<br>详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容详细内容";
        var msgTitle="消息标题";
        // 右侧底部。
        $("#btnBottom").click(function(e) {
              HdUtils.messager.bottomRight(msgContent,msgTitle);
        });
      // 状态栏。
      $("#btnStatus").click(function(e) {
         HdUtils.messager.status("状态栏信息xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"); 
      });
      // 消息提示。
      $("#btnCenter").click(function(e) {
          HdUtils.messager.info(msgContent);
      });
      // 跑马灯。
      $("#btnMarquee").click(function(e) {
          HdUtils.messager.marquee("欢迎使用iDeveloper3.0，iDeveloper开发团队！");
      });
      // 展现dialog界面。
      $("#btnShow").click(function(e) {
          HdUtils.dialog.show({title:"标题:[测试]",href:"system/demo/syscod/dialog.html",width:400,height:300});
          HdUtils.dialog.setValue({callback:function(){alert("hello,iDeveloper3.0");},param1:"参数1"});
      });
                      
        //下拉列表demo
        $("#testaa").combogrid(HdUtils.code.resources({}));
        $("#btnSetVal").click(function() {
            $("#testaa").combogrid('setValue', 'webresources:login:syscod:update');
            $("#testaa").combogrid('setText', '编辑');
        });
        $("#btnDisplayVal").click(function() {
            $("#testcod").text('值：' + $("#testaa").combogrid('getValue'));
            $("#testnam").text('文本：' + $("#testaa").combogrid('getText'));
        });
        //参考HdUtils.js
        //demo
//        $("#btn_botom").on("click", function() {
//            HdUtils.messager.bottomRight("右侧底部提示", "右侧底部提示", 50);
//        });
//        $("#btn_state").on("click", function() {
//            HdUtils.messager.status("状态栏提示");
//        });
//        $("#btn_nomal").on("click", function() {
//            HdUtils.messager.info("普通提示");
//        });
//        $("#btn_horse").on("click", function() {
//            HdUtils.messager.marquee($("#pao_value").val());
//        });
        $("#btnShow2").on("click", function() {
            HdUtils.dialog.show({title:"华东软件服务平台",href:'http://x.huadong.net',openWithIframe:true,width:380,height:600});
        });
        $("#btn_nump").on("click", function() {
            $("#num_result").html(HdUtils.formatter.precisionCommon($("#num_value").val(), $("#point_value").val()));
        });






        var dg = $("#SysCodDatagrid1427420966140");
        // buttons
        // 增加。
        $("#SysCodToolBar1427420966140 a[iconCls='icon-add']").on("click", function() {
            dg.datagrid("hdAdd");
        });
        // 编辑。
        $("#SysCodToolBar1427420966140 a[iconCls='icon-edit']").on("click", function() {
            dg.datagrid("hdEdit");
        });
        // 删除。
        $("#SysCodToolBar1427420966140 a[iconCls='icon-remove']").on("click", function() {
            dg.datagrid("hdRemove");
        });
        // 保存。
        $("#SysCodToolBar1427420966140 a[iconCls='icon-save']").on("click", function() {
            dg.datagrid("hdSave", {url: "../webresources/login/SysCode/save"});
        });
        // 刷新。
        $("#SysCodToolBar1427420966140 a[iconCls='icon-reload']").on("click", function() {
            dg.datagrid("hdReload");
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
        $("#SysCodSearchbox1427420966140").searchbox({prompt: "请输入...", searcher: function(value, name) {
                builder.set("q", value);
                builder.set("queryColumns", "codValue,codText,codTyp");
                dg.datagrid("hdReload");
            }});
        // datagrid
        $("#SysCodDatagrid1427420966140").datagrid({
        	striped:true,
            url: "../webresources/login/SysCode/find",
            queryParams: builder.build(),
            method: "post",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            pageSize: 20,
            toolbar: "#SysCodToolBar1427420966140",
            fit: true,
            fitColumns: false,
            frozenColumns:[[    
                    {
                        field: "codeId",
                        title: '<font color="red">系统代码ID</font>',
                        multiSort: true,
                        halign: "center",
                        sortable: true
                    },
                    {
                        field: "fieldCod",
                        title: "字段代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    }
            ]],
            columns: [[
                    {
                        field: "fieldNam",
                        title: "字段名称",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "code",
                        title: "代码",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "name",
                        title: "代码名称",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "sorter",
                        title: "排序编号",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "customEx1",
                        title: "自定义字段1",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "customEx2",
                        title: "自定义字段2",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "customEx3",
                        title: "自定义字段3",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "customEx4",
                        title: "自定义字段4",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "customEx5",
                        title: "自定义字段5",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "customEx6",
                        title: "自定义字段6",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "sysMark",
                        title: "系统标识",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "abandonedMark",
                        title: "废弃标识",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "备注",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "insAccount",
                        title: "创建人",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                        field: "insTimestamp",
                        title: "创建时间",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "datetimebox", options: {required: false}},
                        formatter: function(value) {
                            if (value != null && value != undefined) {
                                return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                            } else {
                                return value;
                            }
                         }
                    },
                    {
                        field: "updAccount",
                        title: "更新人",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "validatebox", options: {required: false}},
                        sortable: true
                    },
                    {
                    	field: "updTimestamp",
                        title: "更新时间",
                        multiSort: true,
                        halign: "center",
                        editor: {type: "datebox", options: {required: false}},
                        formatter: function(value) {
                            if (value != null && value != undefined) {
                                return new Date(value).format("yyyy-MM-dd hh:mm:ss");
                            } else {
                                return value;
                            }
                        }
                    }
                ]]});
        $("#SysCodDatagrid1427420966140").datagrid("hdGetColumnNames");
    });
    function createChart() {
        $("#chart-dlg").dialog({
            title: '生成图表',
            width: 800,
            height: 500,
            padding: 10,
            iconCls: 'icon-save',
            buttons: '#chart-buttons',
            maximizable: true
        });
        var divId = 'chart';
        var type = $("#chart-type").combobox("getValue");
        var s = new ShapeBase();
        s.show("xxx", divId, type);//XXX是查询数据的方法路径
    }

</script>
