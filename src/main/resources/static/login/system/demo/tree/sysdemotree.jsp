<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8"/>
<div class="easyui-layout" data-options="fit:true" style="width:100%;height:100%;">
    <div data-options="region:'west',title:'组织架构',split:true" style="width:250px;">
        <ul id="authUserTenantOrgnTree" class="easyui-tree" data-options="url:'../webresources/login/SysDemoTree/get',method:'get',loadFilter:treeLoadFilter"></ul>
    </div>
    <div data-options="region:'center',title:''">
        <br/>
        当前选中的是<input id="text" type="text" />
    </div>
</div>
<script type="text/javascript">
    function treeLoadFilter(data, parent) {
        $(this).tree('options').onClick = function (node) {
            $('#text').val(node.text);
        };
        return data;
    }
</script>