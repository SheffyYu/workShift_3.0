
<meta charset="UTF-8">

<script>
    var rtree = $('#rolePRTree');
    var roleId = HdUtils.dialog.getValue("roleId");
    var userId = HdUtils.dialog.getValue("userId");
    rtree.tree({
        url: '../webresources/login/VjPrivilegeResource/normal/PrivillegeResources/findResourcesForTree?roleId='+roleId,
        method: 'GET',
        animate: true,
        checkbox: true
    });
</script>
<ul id="rolePRTree" class="easyui-tree"></ul>
