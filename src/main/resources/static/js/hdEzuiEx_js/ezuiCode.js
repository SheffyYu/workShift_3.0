/* 
 * Copyright (C) 2013 HUADONG CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */

// 基础代码。
HdUtils.code.vWebCBaseCod = function(params) {
    var ret = {fieldMapping: {
            sysCod: 'sysCod',
            sysNam: 'sysNam'
        },
        url: '../webresources/login/VWebCBaseCod',
        columns: [[{
                    field: 'sysCod',
                    title: '代码',
                    sortable: false,
                    width: 1
                },
                {
                    field: 'sysNam',
                    title: '名称',
                    sortable: false,
                    width: 1
                }
            ]]};
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.cBaseCod = function(params) {
    var ret = {fieldMapping: {
            cBaseCodPK: 'cBaseCodPK.sysCod',
            sysNam: 'sysNam'
        },
        url: '../webresources/login/CBaseCod',
        columns: [[{
                    field: 'cBaseCodPK.sysCod',
                    title: '代码',
                    sortable: false,
                    width: 1
                },
                {
                    field: 'sysNam',
                    title: '名称',
                    sortable: false,
                    width: 1
                }
            ]]};
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.cClass = function(params) {
    var ret = {fieldMapping: {
            classId: 'classId',
            classNam: 'classNam'
        },
        height: 21,
        panelWidth: 300,
        panelHeight: 300,
        showColumns: "classId,classNam",
        url: '../webresources/login/CClass',
        columns: [[
                {
                    field: 'classId',
                    title: '班次代码',
                    sortable: false,
                    width: 1
                },
                {
                    field: 'classNam',
                    title: '班次名称',
                    sortable: false,
                    width: 1
                }
            ]]};
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.cClient = function(params) {
    var ret = {
        fieldMapping: {
            clientCod: 'clientCod',
            clientNam: 'shotNam'
        },
        height: 21,
        panelWidth: 600,
        panelHeight: 300,
        pagination: true,
        filterColumns: "clientCod,shotNam,clientNam,hzts",
        showColumns: 'clientCod,shotNam,clientNam,hzts',
        url: '../webresources/login/CClient',
        columns: [[{
                    field: 'clientCod',
                    title: '客户代码',
                    sortable: true,
                    width: 2
                }, {
                    field: 'shotNam',
                    title: '客户简称',
                    sortable: true,
                    width: 2
                }, {
                    field: 'clientNam',
                    title: '客户名称',
                    sortable: true,
                    width: 4
                }, {
                    field: 'hzts',
                    title: '汉字提示',
                    sortable: true,
                    width: 2
                }
            ]]
    };
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.cCargoNam = function(params) {
    var ret = {
        fieldMapping: {
            cargoCod: 'cargoCod',
            cargoNam: 'cargoNam'
        },
        panelWidth: 450,
        height: 21,
        panelHeight: 300,
        pagination: true,
        showColumns: "cargoCod,cargoNam,hzts",
        filterColumns: 'cargoCod,cargoNam,hzts',
        url: '../webresources/login/CCargoNam',
        columns: [[{
                    field: 'cargoCod',
                    title: '货物代码',
                    sortable: true,
                    width: 80
                }, {
                    field: 'cargoNam',
                    title: '货物名称',
                    sortable: true,
                    width: 100
                },
                {
                    field: 'hzts',
                    title: '汉字提示',
                    sortable: true,
                    width: 80
                }
            ]]
    };
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.cPkgKind = function(params) {
    var ret = {
        fieldMapping: {
            pkgKindCod: 'pkgKindCod',
            cPkgKindNam: 'cPkgKindNam'
        },
        panelWidth: 450,
        height: 21,
        panelHeight: 300,
        pagination: true,
        showColumns: 'pkgKindCod,cPkgKindNam',
        filterColumns: 'pkgKindCod,cPkgKindNam',
        url: '../webresources/login/CPkgKind',
        columns: [[{
                    field: 'pkgKindCod',
                    title: '包装代码',
                    sortable: true,
                    width: 80
                }, {
                    field: 'cPkgKindNam',
                    title: '包装名称',
                    sortable: true,
                    width: 100
                }
            ]]
    };
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.vWebMachNo = function(params) {
    var ret = {
        fieldMapping: {
            machNo: 'machNo',
            machNam: 'machNam'
        },
        panelWidth: 450,
        height: 21,
        panelHeight: 300,
        pagination: true,
        filterColumns: 'machNo,machNam',
        showColumns: "machNo,machNam",
        url: '../webresources/login/VWebMachNo',
        columns: [[{
                    field: 'machNo',
                    title: '车牌号',
                    sortable: true,
                    width: 80
                }, {
                    field: 'machNam',
                    title: '车牌名称',
                    sortable: true,
                    width: 100
                }
            ]]
    };
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
//提货单远程预约 条件 进提货单位下拉
HdUtils.code.vWebClientCod = function(params) {
    var ret = {
        fieldMapping: {
            clientCod: 'clientCod',
            shotNam: 'shotNam'
        },
        height: 21,
        panelWidth: 600,
        panelHeight: 300,
        pagination: true,
        filterColumns: "clientCod,shotNam,clientNam,hzts",
//                    showColumns: 'clientCod,shotNam,clientNam,hzts',
        url: '../webresources/login/CClient',
        columns: [[{
                    field: 'clientCod',
                    title: '客户代码',
                    sortable: true,
                    width: 2
                }, {
                    field: 'shotNam',
                    title: '客户简称',
                    sortable: true,
                    width: 2
                }, {
                    field: 'clientNam',
                    title: '客户名称',
                    sortable: true,
                    width: 4
                }, {
                    field: 'hzts',
                    title: '汉字提示',
                    sortable: true,
                    width: 2
                }
            ]]
    };
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.cDept = function(params) {
    var ret = {
        fieldMapping: {
            deptCod: 'deptCod',
            deptNam: 'shortNam'
        },
        panelWidth: 450,
        height: 21,
        panelHeight: 300,
        pagination: true,
        filterColumns: 'deptCod,shortNam',
//        showColumns: 'deptCod,shortNam',
        url: '../webresources/login/CDept',
        columns: [[{
                    field: 'deptCod',
                    title: '部门代码',
                    sortable: true,
                    width: 80
                }, {
                    field: 'shortNam',
                    title: '部门名称',
                    sortable: true,
                    width: 100
                }
            ]]
    };
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.cMaterial = function(params) {
    var ret = {fieldMapping: {
            materialCod: 'materialCod',
            materialNam: 'materialNam'
        },
        height: 21,
        panelWidth: 300,
        panelHeight: 300,
        url: '../webresources/login/CMaterial',
        columns: [[
                {
                    field: 'materialCod',
                    title: '材质代码',
                    sortable: false,
                    width: 1
                },
                {
                    field: 'materialNam',
                    title: '材质名称',
                    sortable: false,
                    width: 1
                }
            ]]};
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
HdUtils.code.portCargo = function(params) {
    var ret = {fieldMapping: {
            cargoCod: 'cargoCod',
            cargoNam: 'cCargoNam.cargoNam'
        },
        height: 21,
        panelWidth: 300,
        panelHeight: 300,
//        pagination: true,
        showColumns: "cargoCod,cCargoNam.cargoNam,clientCod",
        url: '../webresources/login/PortCargo',
        columns: [[
                {
                    field: 'cargoCod',
                    title: '货物代码',
                    sortable: false,
                    width: 1
                },
                {
                    field: 'cCargoNam.cargoNam',
                    title: '货物名称',
                    sortable: false,
                    width: 1
                }
            ]]};
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
// 资源代码。
HdUtils.code.resources = function(params) {
    var ret = {fieldMapping: {
            permissions: 'permissions',
            name: 'name'
        },
        url: '../webresources/login/AuthResource/find2',
        panelWidth: 500,
        panelHeight: 300,
        columns: [[{
                    field: "resourceId",
                    title: "ID",
                    sortable: false,
                    hidden:true
                },
                {
                    field: "name",
                    title: "名称",
                    sortable: false
                },
                {
                    field: "permissions",
                    title: "编码",
                    sortable: false
                }
            ]]};
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};

//租户类型
HdUtils.code.tenantTyp = function(params) {
     var obj = {
            fieldMapping: {
            tenantTypId:   'TENANT_TYP_ID',
            tenantTypName: 'TENANT_TYP_NAM'
            },
            fit: true,
            fitColumns: true,
            required: false,
            width: 150,
            pagination : false,
            url: "../webresources/login/authTenant/getTenantTyp",
            method: "get",
            mode: "remote",
            idField: 'TENANT_TYP_ID',
            panelWidth: 150,
            panelHeight: 300,
            textField: 'TENANT_TYP_NAM',
            columns: [[
                            {
                                field: "TENANT_TYP_ID",
                                title: "租户类型ID",
                                multiSort: true,
                                align: "center",
                                sortable: true,
                                width: 65,
                                hidden: true
                            },
                            {
                                field: "TENANT_TYP_NAM",
                                title: "租户类型名称",
                                multiSort: true,
                                align: "center",
                                sortable: true,
                                width: 65
                            }
                        ]]
                    };
            $.extend(obj, params);
            return HdUtils.code.base(obj);
};