<meta charset="UTF-8">
<!-- 工具栏 -->
<div id="ContractToolBar1493102217824" style="float:left;padding-left: 10px;">
            合同开始日期：<input id="begDte1493102217824" data-options="required:false" style="width:100px" class="easyui-datebox"/>
            合同截止日期：<input id="endDte1493102217824" data-options="required:false" style="width:100px" class="easyui-datebox"/>
            签署日期：<input id="signDat1493102217824" data-options="required:false" style="width:100px" class="easyui-datebox"/>
    <a class="easyui-linkbutton" iconCls="icon-reload" plain="false">查询</a>
</div>
<div style="height:100%">
    <table id="ContractDatagrid1493102217824" ></table>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var dg = $("#ContractDatagrid1493102217824");
        // 刷新。
        $("#ContractToolBar1493102217824 a[iconCls='icon-reload']").on("click", function () {
        	/* var dateBeg=$("#begDte1493102217824").datetimebox("getValue");//.replace(/-/g,"");
        	var dateEnd=$("#endDte1493102217824").datetimebox("getValue");//.replace(/-/g,"");;
        	if( dateBeg== ""){
        		HdUtils.messager.info('请输入合同开始时间');
        		return ;
            }
        	if( dateEnd== ""){
        		HdUtils.messager.info('请输入合同结束时间');
        		return ;
            }   */
        	var builder1493102217824 = new HdEzuiQueryParamsBuilder();
        	if($("#begDte1493102217824").datebox("getValue") != ""){
        		builder1493102217824.setAndClause("begDte", $("#begDte1493102217824").datebox("getValue")+" 00:00:00", ">=", "and");
            }
        	if($("#begDte1493102217824").datebox("getValue") != ""){
        		builder1493102217824.setAndClause("begDte", $("#begDte1493102217824").datebox("getValue")+" 23:59:59", "<=", "and");
            }
        	if($("#endDte1493102217824").datebox("getValue") != ""){
        		builder1493102217824.setAndClause("endDte", $("#endDte1493102217824").datebox("getValue")+" 00:00:00", ">=", "and");
            }
        	if($("#endDte1493102217824").datebox("getValue") != ""){
        		builder1493102217824.setAndClause("endDte", $("#endDte1493102217824").datebox("getValue")+" 23:59:59", "<=", "and");
            }
        	if($("#signDat1493102217824").datebox("getValue") != ""){
        		builder1493102217824.setAndClause("signDat",$("#signDat1493102217824").datebox("getValue")+" 00:00:00", ">=","and");
     	    }
        	startDate = new Date($("#signDat1493102217824").datebox("getValue"));
            startDate = +startDate + 1000*60*60*24;
            startDate = new Date(startDate);
            var nextStartDate = startDate.getFullYear()+"-"+(startDate.getMonth()+1)+"-"+startDate.getDate();
        	if($("#signDat1493102217824").datebox("getValue") != ""){
        		builder1493102217824.setAndClause("signDat",nextStartDate+" 00:00:00", "<=","and");
     	    } 
        	
        	builder1493102217824.setAndClause("contractSat","URE","<>","and");
        	builder.hdEzuiQueryParams.hdConditions=builder1493102217824.hdEzuiQueryParams.hdConditions;
        	dg.datagrid("hdReload");
        });
        var builder = new HdEzuiQueryParamsBuilder();
        var date = new Date();
        builder.setAndClause("contractSat","URE","<>","and");
        // datagrid
        $("#ContractDatagrid1493102217824").datagrid({
        	striped:true,
            url: "../webresources/login/Contract/find",
            queryParams: builder.build(),
            method: "POST",
            pagination: true,
            singleSelect: true,
            rownumbers: true,
            sortOrder: 'desc',
            sortName: 'updTimestamp',
            remoteSort:false,
            pageSize: 20,
            toolbar: "#ContractToolBar1493102217824",
            fit: true,
            fitColumns: false,
            frozenColumns:[[
					{
					    field: "contractId",
					    title: '<font color="red"></font>',
					    multiSort: true,
					    halign: "center",
					    hidden:true,
					    sortable: true
					},
					{
					    field: "contractNo",
					    title: '合同编号',
					    multiSort: true,
					    halign: "center",
					    width: 100,
					    sortable: true
					},
					{
					    field: "contractNam",
					    title: '合同名称',
					    multiSort: true,
					    halign: "center",
					    width: 180,
					    sortable: true
					}
                            ]],
            columns: [[
                    {
                        field: "contractTyp",
                        title: '合同类型',
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_TYP', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "contractSat",
                        title: '合同状态',
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        formatter: function (value) {
                            if (value === null || value === '')
                                return;
                            var list = HdUtils.global.scode.query({fieldCod: 'CONTRACT_STAT', code: value});
                            return list.length > 0 ? list[0].name : "";
                        },
                        sortable: true
                    },
                    {
                        field: "parenContract",
                        title: "主合同",
                        multiSort: true,
                        halign: "center",
                        width: 120,
                        sortable: true
                    },
                    {
                        field: "signatory",
                        title: '经办人',
                        multiSort: true,
                        halign: "center",
                        width: 90,
                        formatter: function (value, row, index) {
                            return row.signatoryNam;
                        },
                        sortable: true
                    },
                    {
                        field: "signDepartment",
                        title: '签约部门',
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        sortable: true
                    },
                    {
                        field: "signDat",
                        title: "签署日期",
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "remindDay",
                        title: '超期提醒',
                        multiSort: true,
                        halign: "center",
                        width: 60,
                        sortable: true
                    },
                    {
                        field: "custom",
                        title: '客户名称',
                        multiSort: true,
                        halign: "center",
                        width: 140,
                        sortable: true
                    },
                    {
                        field: "companyCod",
                        title: "公司名称",
                        multiSort: true,
                        halign: "center",
                        width: 140,
                        sortable: true
                    },
                    {
                        field: "begDte",
                        title: '有效开始期',
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "endDte",
                        title: '有效截至期',
                        multiSort: true,
                        halign: "center",
                        width: 80,
                        formatter: $.hd.ezui.formatter.date,
                        sortable: true
                    },
                    {
                        field: "isArchive",
                        title: "是否归档",
                        multiSort: true,
                        halign: "center",
                        align: "center",
                        width: 60,
                        formatter:$.hd.ezui.formatter.checkbox2,
                        editor:$.hd.ezui.editor.checkbox,
                        sortable: true
                    },
                    {
                        field: "description",
                        title: "描述",
                        multiSort: true,
                        halign: "center",
                        width: 180,
                        sortable: true
                    },
                ]],
          });
    });
</script>


