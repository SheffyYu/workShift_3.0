/*
 * 箱尺寸
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCntrSiz = function(params) {
	var ret = {
		fieldMapping : {
			cntrSizCod : 'cntrSizCod',
			cntrSizNam : 'cntrSizNam'
		},
		panelWidth : 130,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cntrSizCod,cntrSizNam',
		showColumns : "cntrSizCod,cntrSizNam",
		url : '../webresources/login/SbcCntrSiz/find',
		columns : [[{
			field : 'cntrSizCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'cntrSizNam',
			title : '名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 公司下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.companyId=function(params) {
    var ret = {
		fieldMapping: {
	    	companyCod: 'companyCod',
	    	cnCompanyNam:'cnCompanyNam',
		},
		pagination : false,
        idField: 'companyCod',   
        panelHeight : 180,
        textField: 'cnCompanyNam',                    
        sortName: 'companyCod',
        sortOrder: 'asc',
        method:"POST",
        url: '../webresources/login/SbcCompany/find',
        columns: [[
                   {   
                    title:'公司代码',
                    field: 'companyCod',
                    width: 60
                },
                {   
                    title:'公司名称',
                    field: 'cnCompanyNam',
                    width: 100
                }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 用户下拉
 * @param {type} params
 * @returns 
 */
/*HdUtils.code.authUserId=function(params) {
    var ret = {
		fieldMapping: {
	    	account1: 'account',
	    	name1:'name',
		},
		pagination : true,
        idField: 'account',   
        panelHeight : 180,
        textField: 'name',                    
        sortName: 'account',
        sortOrder: 'asc',
        method:"POST",
        url: '../webresources/login/AuthUser/myFind',
        columns: [[
                   {   
                    title:'用户代码',
                    field: 'account',
                    width: 60
                },
                {   
                    title:'用户名称',
                    field: 'name',
                    width: 100
                }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};*/
/**
 * 机械类型下拉
 */
HdUtils.code.machTyp=function(params) {
    var ret = {fieldMapping: {
    	machTypCod: 'machTypCod',
    	machTypNam:'machTypNam',
        },
        pagination : false,
        idField: 'machTypCod',            
        textField: 'machTypNam', 
        panelHeight : 240,
        sortName: 'machTypCod',
        sortOrder: 'asc',
        method:"POST",
        url: '../../webresources/login/SbcMachineType/find',
        columns: [[
                   {   
                    title:'机械类型代码',
                    field: 'machTypCod',
                    width: 60
                },
                {   
                	title:'机械类型名称',
                    field: 'machTypNam',
                    width: 120
                }
            ]]  ,
    };
    $.extend(ret, params);
    return HdUtils.code.base(ret);
};
/*
 * 颜色下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.colorCategory=function(params) {
    var ret = {
		fieldMapping: {
			//COLOR_FILED_COD, COLOR_FILED_NAM
	    	colorFiledCod: 'colorFiledCod',
	    	colorFiledNam:'colorFiledNam',
		},
		pagination : false,
        idField: 'colorFiledCod',            
        textField: 'colorFiledNam',    
        panelHeight : 240,
        sortName: 'colorFiledCod',
        sortOrder: 'asc',
        method:"POST",
        url: '/webresources/login/ColorCategory/find',
        columns: [[
                   {   
                    title:'代码',
                    field: 'colorFiledCod',
                    width: 60
                },
                {   
                    title:'名称',
                    field: 'colorFiledNam',
                    width: 60
                }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 颜色对应值下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.colorFieldValue=function(params) {
    var ret = {
		fieldMapping: {
			colorFiledCod:"FIELD_COD",
			colorFiledValue: 'CODE',
	    	colorFiledValueNam:'NAME',
		},
        idField: 'CODE',            
        textField: 'NAME',
        panelWidth:300,
        panelHeight : 240,
        method:"POST",
        url: '/webresources/login/ColorSet/findColorValue',
        columns: [[{
        	title:'代码',
        	field:"FIELD_COD",
        	width: 60
        },
                   {   
                    title:'代码',
                    field: 'CODE',
                    width: 60
                },
                {   
                    title:'名称',
                    field: 'NAME',
                    width: 60
                }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 箱属性下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.codeCategory=function(params) {
    var ret = {
		fieldMapping: {
			columnCod:'columnCod',
	    	colorFiledCod: 'colorFiledCod',
	    	columnNam:'columnNam',
		},
		pagination : false,
        idField: 'columnCod',            
        textField: 'columnNam',   
        panelHeight : 240,
        sortName: 'columnCod',
        sortOrder: 'asc',
        method:"POST",
        url: '/webresources/login/CodeCategory/findCode',
        columns: [[
                   {   
                    title:'代码',
                    field: 'columnCod',
                    width: 60
                },
                {   
                    title:'名称',
                    field: 'columnNam',
                    width: 100
                }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 地图Sys_code下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.mapSysCode=function(params) {
    var ret = {
		fieldMapping:{
            code: 'code',
            name: 'name'
        },
        sortName: 'code',
        sortOrder: 'asc',
        idField: 'code',  
        pagination : false,
        textField: 'name',
        panelHeight : 240,
        panelWidth: 205,
        filterColumns: 'code,name',
        columns: [[
                   {
                                field: 'code',
                                title: '代码',
                                sortable: true,
                                width: 60
                            }, {
                                field: 'name',
                                title: '名称',
                                sortable: true,
                                width: 120
                            }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 库厂区/仓库下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCargoZone = function(params) {
	var ret = {
		fieldMapping : {
			cargoZoneCod : 'cargoZoneCod',
			cargoZoneNam : 'cargoZoneNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cargoZoneCod,cargoZoneNam',
		showColumns : "cargoZoneCod,cargoZoneNam",
		url : '../webresources/login/SbcCargoZone/find',
		columns : [[{
			field : 'cargoZoneCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'cargoZoneNam',
			title : '名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 箱ISO下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCntrIso = function(params) {
	var ret = {
		fieldMapping : {
			cntrIso : 'cntrIso',
			isoVersion : 'isoVersion'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cntrIso,isoVersion',
		showColumns : "cntrIso,isoVersion",
		url : '../webresources/login/SbcCntrIso/find',
		columns : [[{
			field : 'cntrIso',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'isoVersion',
			title : 'ISO版本',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 箱类型下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCntrTyp = function(params) {
	var ret = {
		fieldMapping : {
			cntrTypCod : 'cntrTypCod',
			cntrTypNam : 'cntrTypNam'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cntrTypCod,cntrTypNam',
		showColumns : "cntrTypCod,cntrTypNam",
		url : '../webresources/login/SbcCntrTyp/find',
		columns : [[{
			field : 'cntrTypCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'cntrTypNam',
			title : '名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 堆场地图
 * @param {type} params
 * @returns 
 */
HdUtils.code.yardMap = function(params) {
	var ret = {
		fieldMapping : {
			mapNo : 'mapNo',
			mapUrl : 'mapUrl'
		},
		panelWidth : 430,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'mapNo,mapUrl',
		showColumns : "mapNo,mapUrl",
		url : '../webresources/login/YardMap/find',
		columns : [[{
			field : 'mapNo',
			title : '编号',
			sortable : true,
			width : 60
		}, {
			field : 'mapUrl',
			title : 'URL',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 堆场地图
 * @param {type} params
 * @returns 
 */
HdUtils.code.yardMapLayer = function(params) {
	var ret = {
		fieldMapping : {
			layerNo : 'layerNo',
			mapNo : 'mapNo'
		},
		panelWidth : 430,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'layerNo,mapNo',
		showColumns : "layerNo,mapNo",
		url : '../webresources/login/YardMapLayer/find',
		columns : [[{
			field : 'layerNo',
			title : '图层编号',
			sortable : true,
			width : 60
		}, {
			field : 'mapNo',
			title : '堆场布局图编号',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 堆场地图
 * @param {type} params
 * @returns 
 */
HdUtils.code.yardMapObj = function(params) {
	var ret = {
		fieldMapping : {
			objNo:'objNo',
			layerNo : 'layerNo',
			mapNo : 'mapNo'
		},
		panelWidth : 430,
		height : 21,
		panelHeight : 300,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'objNo,layerNo,mapNo',
		showColumns : "objNo,layerNo,mapNo",
		url : '../webresources/login/YardMapObj/find',
		columns : [[{
			field : 'objNo',
			title : '图元编号',
			sortable : true,
			width : 60
		},{
			field : 'layerNo',
			title : '图层编号',
			sortable : true,
			width : 60
		}, {
			field : 'mapNo',
			title : '堆场布局图编号',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 机械类型
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcMachineType = function(params) {
	var ret = {
		fieldMapping : {
			machTypCod : 'machTypCod',
			machTypNam : 'machTypNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'machTypCod,machTypNam',
		showColumns : "machTypCod,machTypNam",
		url : '../webresources/login/SbcMachineType/find',
		columns : [[{
			field : 'machTypCod',
			title : '机械类型代码',
			sortable : true,
			width : 60
		}, {
			field : 'machTypNam',
			title : '机械类型名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 包装
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcPackage = function(params) {
	var ret = {
		fieldMapping : {
			packageCod : 'packageCod',
			cnPackageNam : 'cnPackageNam',
			enPackageNam : 'enPackageNam'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'packageCod,cnPackageNam,enPackageNam',
		showColumns : "packageCod,cnPackageNam,enPackageNam",
		url : '../webresources/login/SbcPackage/find',
		columns : [[{
			field : 'packageCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'cnPackageNam',
			title : '包装中文名称',
			sortable : true,
			width : 60
		},{
			field : 'enPackageNam',
			title : '包装英文名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 地点
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcPlace = function(params) {
	var ret = {
		fieldMapping : {
			placeCod : 'placeCod',
			cnPlaceNam : 'cnPlaceNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'placeCod,cnPlaceNam',
		showColumns : "placeCod,cnPlaceNam",
		url : '../webresources/login/SbcPlace/find',
		columns : [[{
			field : 'placeCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'cnPlaceNam',
			title : '名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 港口代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcPort = function(params) {
	var ret = {
		fieldMapping : {
			portCod : 'portCod',
			cnPortNam : 'cnPortNam'
		},
		panelWidth : 400,
		height : 21,
		panelHeight : 240,
		pagination : true,
		isPost : false,
		method:'post',
		filterColumns : 'portCod,cnPortNam',
		showColumns : "portCod,cnPortNam",
		url : '/webresources/login/SbcPort/find',
		columns : [[{
			field : 'portCod',
			title : '代码',
			sortable : true,
			width : 120
		}, {
			field : 'cnPortNam',
			title : '名称',
			sortable : true,
			width : 200
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 货位维护
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCargoLoc = function(params) {
	var ret = {
		fieldMapping : {
			cargoLocCod : 'cargoLocCod',
			cargoLocNam : 'cargoLocNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cargoLocCod,cargoLocNam',
		showColumns : "cargoLocCod,cargoLocNam",
		url : '../webresources/login/cargoloc/find',
		columns : [[{
			field : 'cargoLocCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'cargoLocNam',
			title : '名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 项目费用
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcFeeItme = function(params) {
	var ret = {
		fieldMapping : {
			feeItemCod:'feeItemCod',
			cnFeeItemNam : 'cnFeeItemNam',
			enFeeItemNam : 'enFeeItemNam'
		},
		panelWidth : 300,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'feeItemCod,cnFeeItemNam,enFeeItemNam',
		showColumns : "feeItemCod,cnFeeItemNam,enFeeItemNam",
		url : '../webresources/login/SbcFeeItme/find',
		columns : [[{
			field : 'feeItemCod',
			title : '费用项目代码',
			sortable : true,
			width : 60
		},{
			field : 'cnFeeItemNam',
			title : '中文费用名称',
			sortable : true,
			width : 120
		}, {
			field : 'enFeeItemNam',
			title : '费用英文名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 堆场维护
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCargoYard = function(params) {
	var ret = {
		fieldMapping : {
			cargoYardCod : 'cargoYardCod',
			cargoYardNam : 'cargoYardNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 300,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cargoYardCod,cargoYardNam',
		showColumns : "cargoYardCod,cargoYardNam",
		url : '../webresources/login/cargoyard/find',
		columns : [[{
			field : 'cargoYardCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'cargoYardNam',
			title : '名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};


/*
 * 闸口通道
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcGateLane = function(params) {
	var ret = {
		fieldMapping : {
			gateLaneCod:'gateLaneCod',
			gateLaneNam : 'gateLaneNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 300,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'gateLaneCod,gateLaneNam',
		showColumns : "gateLaneCod,gateLaneNam",
		url : '/webresources/login/SbcGateLane/find',
		columns : [[{
			field : 'gateLaneCod',
			title : '闸口通道代码',
			sortable : true,
			width : 60
		},{
			field : 'gateLaneNam',
			title : '闸口通道名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 锁扣原因
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcLockReason = function(params) {
	var ret = {
		fieldMapping : {
			lockReasonCod:'lockReasonCod',
			lockReasonNam : 'lockReasonNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'lockReasonCod,lockReasonNam',
		showColumns : "lockReasonCod,lockReasonNam",
		url : '../webresources/login/SbcLockReason/find',
		columns : [[{
			field : 'lockReasonCod',
			title : '锁定原因代码',
			sortable : true,
			width : 60
		},{
			field : 'lockReasonNam',
			title : '锁扣原因名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 货物下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCargo = function(params) {
	var ret = {
		fieldMapping : {
			cargoCod : 'cargoCod',
			cnCargoNam : 'cnCargoNam'
		},
		panelWidth : 260,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cargoCod,cnCargoNam',
		showColumns : "cargoCod,cnCargoNam",
		url : '../webresources/login/cargo/find',
		columns : [[{
			field : 'cargoCod',
			title : '货物',
			sortable : true,
			width : 60
		}, {
			field : 'cnCargoNam',
			title : '名称',
			sortable : true,
			width : 120
		}, {
			field : 'enCargoNam',
			title : '英文名称',
			sortable : true,
		    hidden: true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 货类下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCargoKind = function(params) {
	var ret = {
		fieldMapping : {
			cargoKindCod : 'cargoKindCod',
			cargoKindNam : 'cargoKindNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		idField: 'cargoKindCod', 
		textField: 'cargoKindNam',                    
        sortName: 'cargoKindNam',
		method:'post',
		filterColumns : 'cargoKindCod,cargoKindNam',
		showColumns : "cargoKindNam,cargoKindCod",
		url : '../webresources/login/cargokind/find',
		columns : [[{
			field : 'cargoKindCod',
			title : '货类',
			sortable : true,
			width : 60
		}, {
			field : 'cargoKindNam',
			title : '名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 视频设备代码对应表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.videoDevCod = function(params) {
	var ret = {
		fieldMapping : {
			devCod: 'devCod',
			devNam : 'devNam'
		},
		panelWidth : 430,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'devCod,devNam',
		showColumns : "devCod,devNam",
		url : '../webresources/login/SbcViedoDev/find',
		columns : [[{
			field : 'devCod',
			title : '代码',
			sortable : true,
			width : 60
		}, {
			field : 'devNam',
			title : '设备名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 作业班次对应表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.workShift=function(params) {
    var ret = {
		fieldMapping: {
			workShiftId: 'workShiftId',
			sorter:'sorter',
			beginTim: 'beginTim',
			endTim:'endTim'
		},
		pagination : false,
        idField: 'workShiftId',           
        textField: 'beginTim',  
        panelWidth : 250,
        panelHeight : 240,
        sortName: 'sorter',
        sortOrder: 'asc',
        method:"POST",
        url: '../webresources/login/SbcWorkShift/find',
        columns: [[
                   {   
                    title:'开始时间',
                    field: 'beginTim',
                    width: 120
                },
                {   
                    title:'结束时间',
                    field: 'endTim',
                    width: 120
                }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 机械代码表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.machineCodS=function(params) {
    var ret = {
		fieldMapping: {
			machCod: 'machCod',
			machNam:'machNam'
		},
		pagination : false,
        idField: 'machCod',           
        textField: 'machNam',                    
        sortName: 'machNam',
        sortOrder: 'asc',
        method:"POST",
        panelWidth : 140,
        panelHeight : 240,
        url: '../webresources/login/SbcMachine/find',
        columns: [[
                   {   
                    title:'机械代码',
                    field: 'machCod',
                    width: 60
                },
                {   
                    title:'机械名称',
                    field: 'machNam',
                    width: 60
                }
            ]]  ,
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 残损范围表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcDamArea=function(params) {
    var ret = {
		fieldMapping: {
			damAreaCod: 'damAreaCod',
			cnDamAreaNam:'cnDamAreaNam'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'damAreaCod,cnDamAreaNam',
		showColumns : "damAreaCod,cnDamAreaNam",
		url : '../webresources/login/SbcDamArea/find',
		columns : [[{
			field : 'damAreaCod',
			title : '残损范围代码',
			sortable : true,
			width : 60
		}, {
			field : 'cnDamAreaNam',
			title : '残损范围中文名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 残损代码表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcDamCod=function(params) {
    var ret = {
		fieldMapping: {
			damCod: 'damCod',
			cnDamNam:'cnDamNam',
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'damCod,cnDamNam',
		showColumns : "damCod,cnDamNam",
		url : '../webresources/login/SbcDamCod/find',
		columns : [[{
			field : 'damCod',
			title : '残损代码',
			sortable : true,
			width : 60
		}, {
			field : 'cnDamNam',
			title : '残损中文名称',
			sortable : true,
			width : 60
		}, {
			field : 'enDamNam',
			title : '残损英文名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 残损程度表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcDamSeverity=function(params) {
    var ret = {
		fieldMapping: {
			damSeverityCod: 'damSeverityCod',
			cnSeverityNam:'cnSeverityNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'damSeverityCod,cnSeverityNam',
		showColumns : "damSeverityCod,cnSeverityNam",
		url : '../webresources/login/SbcDamSeverity/find',
		columns : [[{
			field : 'damSeverityCod',
			title : '残损程度代码',
			sortable : true,
			width : 60
		}, {
			field : 'cnSeverityNam',
			title : '残损程度中文名称',
			sortable : true,
			width : 60
		}, {
			field : 'enSeverityNam',
			title : '残损程度英文名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 危险品等级表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcDangClass=function(params) {
    var ret = {
		fieldMapping: {
			dangClass: 'dangClass',
			dangClassNam:'dangClassNam'
		},
		panelWidth : 130,
		height : 21,
		panelHeight :240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'dangClass,dangClassNam',
		showColumns : "dangClass,dangClassNam",
		url : '../webresources/login/SbcDangClass/find',
		columns : [[{
			field : 'dangClass',
			title : '危险品等级',
			sortable : true,
			width : 60
		}, {
			field : 'dangClassNam',
			title : '危险品等级名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 内部公司代码对应表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCompany = function(params) {
	var ret = {
		fieldMapping : {
			companyCod : 'companyCod',
			cnCompanyNam : 'cnCompanyNam'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'companyCod,cnCompanyNam',
		showColumns : "companyCod,cnCompanyNam",
		url : '../webresources/login/SbcCompany/find',
		columns : [[{
                        field: "companyCod",
                        title: '公司代码',
                        sortable: true,
                        width : 60
                    },
                    {
                        field: "cnCompanyNam",
                        title: '公司中文名称',
                        sortable: true,
                        width : 100
                    }]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 内部公司代码对应表下拉根据当前用户过滤其公司代码，
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCompanyByCompanyCod = function(params) {
	var ret = {
		fieldMapping : {
			companyCod : 'COMPANY_COD',
			cncompanyNam : 'CN_COMPANY_NAM'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'COMPANY_COD,CN_COMPANY_NAM',
		showColumns : "COMPANY_COD,CNCOMPANYNAM",
		url : '../webresources/login/SbcCompany/findByCompanyCod',
		columns : [[{
                        field: "COMPANY_COD",
                        title: '公司代码',
                        sortable: true,
                        width : 60
                    },
                    {
                        field: "CN_COMPANY_NAM",
                        title: '公司中文名称',
                        sortable: true,
                        width : 100
                    }]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 国家代码对应表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCountry = function(params) {
	var ret = {
		fieldMapping : {
			countryCod : 'countryCod',
			cnCountryNam : 'cnCountryNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'countryCod,cnCountryNam',
		showColumns : "countryCod,cnCountryNam",
		url : '../webresources/login/SbcCountry/find',
		columns : [[{
            field: "countryCod",
            title: '国家代码',
            sortable: true,
            width : 60
        },
        {
            field: "cnCountryNam",
            title: "中文国家名称",
            sortable: true,
            width : 120
        }]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 航向代码ID对应表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCourse = function(params) {
	var ret = {
		fieldMapping : {
			courseCod : 'courseCod',
			cnCourseNam: 'cnCourseNam'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'courseCod,cnCourseNam',
		showColumns : "courseCod,cnCourseNam",
		url : '../webresources/login/SbcCourse/find',
		columns : [[{
            field: "courseCod",
            title: '航向代码',
            sortable: true,
            width : 60
        },
        {
            field: "cnCourseNam",
            title: "中文航向名称",
            sortable: true,
            width : 100
        }]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 客户分类对应表下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCustomerTyp = function(params) {
	var ret = {
		fieldMapping : {
			customerCod : 'customerCod',
			customerTypCod : 'customerTypCod'
		},
		panelWidth : 150,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'customerCod,customerTypCod',
		showColumns : "customerCod,customerTypCod",
		url : '../webresources/login/SbcCustomerTyp/find',
		columns : [[{
            field: "customerCod",
            title: '客户代码',
            sortable: true,
            width : 60
        },
        {
            field: "customerTypCod",
            title: '客户类型代码',
            sortable: true,
            width : 60
        }]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 区域代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcArea = function(params) {
	var ret = {
		fieldMapping : {
			areaCod : 'areaCod',
			cnAreaNam : 'cnAreaNam'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'areaCod,cnAreaNam',
		showColumns : "areaCod，cnAreaNam",
		url : '../webresources/login/SbcArea/find',
		columns : [[{
			field : 'areaCod',
			title : '区域代码',
			sortable : true,
			width : 60
		}, {
			field : 'cnAreaNam',
			title : '区域名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 缆桩代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcBollard = function(params) {
	var ret = {
		fieldMapping : {
			bollardCod : 'bollardCod',
			bollardNam : 'bollardNam'
		},
		panelWidth : 170,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'bollardCod,bollardNam',
		showColumns : "bollardCod,bollardNam",
		url : '../webresources/login/SbcBollard/find',
		columns : [[{
			field : 'bollardCod',
			title : '缆桩代码',
			sortable : true,
			width : 60
		}, {
			field : 'bollardNam',
			title : '缆桩名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 泊位代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcBerth = function(params) {
	var ret = {
		fieldMapping : {
			berthCod : 'berthCod',
			berthNam : 'berthNam',
		},
		panelWidth : 140,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'berthCod',
		showColumns : "berthCod",
		url : '/webresources/login/SbcBerth/find',
		columns : [[{
			field : 'berthCod',
			title : '泊位代码',
			sortable : true,
			width : 60
		},{
			field : 'berthNam',
			title : '泊位名称',
			sortable : true,
			width : 80
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 航线代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcShipService = function(params) {
	var ret = {
		fieldMapping : {
			shipServiceCod : 'shipServiceCod',
			cnShipServiceNam : 'cnShipServiceNam',
		},
		panelWidth : 170,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'shipServiceCod,cnShipServiceNam',
		showColumns : "shipServiceCod,cnShipServiceNam",
		url : '../webresources/login/SbcShipService/find',
		columns : [[{
			field : 'shipServiceCod',
			title : '航线代码',
			sortable : true,
			width : 60
		},{
			field : 'cnShipServiceNam',
			title : '航线名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 航线代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.srcShipService = function(params) {
	var ret = {
		fieldMapping : {
			shipServiceCod : 'shipServiceCod',
			cnShipServiceNam : 'cnShipServiceNam',
		},
		panelWidth : 170,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'shipServiceCod,cnShipServiceNam',
		showColumns : "shipServiceCod,cnShipServiceNam",
		url : '../webresources/login/SbcShipService/findScrShipService',
		columns : [[{
			field : 'shipServiceCod',
			title : '航线代码',
			sortable : true,
			width : 60
		},{
			field : 'cnShipServiceNam',
			title : '航线名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 船舶代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcShipData = function(params) {
	var ret = {
		fieldMapping : {
			shipCod : 'shipCod',
			cnShipNam : 'cnShipNam',
		},
		panelWidth :180,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'shipCod,cnShipNam',
		showColumns : "shipCod,cnShipNam",
		url : '../webresources/login/SbcShipData/find',
		columns : [[{
			field : 'shipCod',
			title : '船舶代码',
			sortable : true,
			width : 60
		},{
			field : 'cnShipNam',
			title : '船舶名称',
			sortable : true,
			width : 100
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 扣鎖原因
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcLockReason = function(params) {
	var ret = {
		fieldMapping : {
			lockReasonCod : 'lockReasonCod',
			lockReasonNam : 'lockReasonNam',
		},
		panelWidth : 130,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'lockReasonCod,lockReasonNam',
		showColumns : "lockReasonCod,lockReasonNam",
		url : '../webresources/login/SbcLockReason/find',
		columns : [[{
			field : 'lockReasonCod',
			title : '扣锁原因代码',
			sortable : true,
			width : 60
		},{
			field : 'lockReasonNam',
			title : '扣锁原因名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 船舶停时代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcShipStay = function(params) {
	var ret = {
		fieldMapping : {
			shipStayCod : 'shipStayCod',
			cnShipStayNam : 'cnShipStayNam',
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'shipStayCod,cnShipStayNam',
		showColumns : "shipStayCod,cnShipStayNam",
		url : "../webresources/login/SbcShipStay/find",
		columns : [[{
			field : 'shipStayCod',
			title : '停时代码',
			sortable : true,
			width : 60
		},{
			field : 'cnShipStayNam',
			title : '停时中文名称',
			sortable : true,
			width : 60
		},{
			field : 'enShipStayNam',
			title : '停时英文名称',
			sortable : true,
			hidden:true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 箱公司代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCntrCorp = function(params) {
	var ret = {
		fieldMapping : {
			cntrCorpCod : 'cntrCorpCod',
			cnCntrCorpNam : 'cnCntrCorpNam',
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'cntrCorpCod,',
		showColumns : "cntrCorpCod,cnCntrcnCntrCorpNamCorpNam",
		url : "../webresources/login/SbcCntrCorp/find",
		columns : [[{
			field : 'cntrCorpCod',
			title : '箱公司代码',
			sortable : true,
			width : 60
		},{
			field : 'cnCntrCorpNam',
			title : '箱公司名称',
			sortable : true,
			width : 60
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 客户代码（只有客户名称、代码、类型的下拉）
 * @param {type} params
 * @returns 
 */
HdUtils.code.VjsbcCustomer=function(params) {
    var ret = {
		fieldMapping: {
			customerCod: 'customerCod',
			cnCustomerNam: 'cnCustomerNam'
		},
		panelWidth : 400,
		height : 21,
		panelHeight : 220,
		//pagination : false,
        idField: 'customerCod', 
        pagination: false,
        //pageSize: 40,
        textField: 'cnCustomerNam',                    
        sortName: 'customerCod',
        method:"POST",
        url: '../webresources/login/VjCustomer/find',
        columns: [[
               {   
                title:'客户代码',
                field: 'customerCod',
                width: 70
               },
               {   
                title:'客户名称',
                field: 'cnCustomerNam',
                width: 220
               }
            ]]
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};

HdUtils.code.sbcCustomerVip=function(params) {
    var ret = {
		fieldMapping: {
			customerCod: 'customerCod',
			cnCustomerNam: 'cnCustomerNam'
		},
		panelWidth : 400,
		height : 21,
		panelHeight : 220,
		pagination : false,
        idField: 'customerCod', 
        pagination: true,
        pageSize: 40,
        textField: 'cnCustomerNam',                    
        //sortName: 'customerCod',
        method:"POST",
        url: '../webresources/login/SbcCustomer/findVip',
        columns: [[
               {   
                title:'客户代码',
                field: 'customerCod',
                width: 70
               },
               {   
                title:'客户名称',
                field: 'cnCustomerNam',
                width: 220
               }
            ]]
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 交通公司
 * @param {type} params
 * @returns 
 */
HdUtils.code.IntfPubCompany=function(params) {
    var ret = {
		fieldMapping: {
			companyCod: 'companyCod',
			companyNam: 'companyNam'
		},
		panelWidth : 220,
		height : 21,
		panelHeight : 220,
		pagination : false,
        idField: 'companyCod', 
        pagination: true,
        pageSize: 100,
        textField: 'companyNam',                    
        sortName: 'companyCod',
        method:"POST",
        url: '../webresources/login/common/IntfPubCompany',
        columns: [[
               {   
                title:'客户代码',
                field: 'companyCod',
                width: 80
               },
               {   
                title:'客户名称',
                field: 'companyNam',
                width: 100
               }
            ]]
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 客户代码
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCustomer=function(params) {
    var ret = {
		fieldMapping: {
			customerCod: 'customerCod',
			cnCustomerNam: 'cnCustomerNam'
		},
		panelWidth : 420,
		height : 21,
		panelHeight : 220,
		pagination : false,
        idField: 'customerCod', 
        pagination: true,
        pageSize: 100,
        textField: 'cnCustomerNam',                    
        sortName: 'customerCod',
       // sortOrder: 'asc',
        method:"POST",
        url: '/webresources/login/ViSbcCustomer/find',
        columns: [[
               {   
                title:'客户代码',
                field: 'customerCod',
                width: 70
               },
               {   
                title:'客户名称',
                field: 'cnCustomerNam',
                width: 280
               }
            ]]
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 客户代码往来记录
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCustomer2=function(params) {
    
	var ret = {
		fieldMapping: {
			customerCod: 'customerCod',
			cnCustomerNam: 'cnCustomerNam'
		},
		panelWidth : 420,
		height : 21,
		panelHeight : 270,
		pagination : false,
        idField: 'customerCod', 
        textField: 'cnCustomerNam',                    
        sortName: 'customerCod',
       // sortOrder: 'asc',
        method:"POST",
        url: '/webresources/login/ViSbcCustomer/find',
        columns: [[
               {   
                title:'客户代码',
                field: 'customerCod',
                width: 70
               },
               {   
                title:'客户名称',
                field: 'cnCustomerNam',
                width: 280
               }
            ]]
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 船公司下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcCustomer3=function(params) {
    var ret = {
		fieldMapping: {
			customerCod: 'customerCod',
			cnCustomerNam: 'cnCustomerNam'
		},
		panelWidth : 450,
		height : 21,
		panelHeight : 220,
		pagination : false,
        idField: 'customerCod', 
        pagination: true,
        pageSize: 40,
        textField: 'cnCustomerNam',                    
        sortName: 'customerCod',
       // sortOrder: 'asc',
        method:"POST",
        url: '../webresources/login/SbcCustomer/find3',
        columns: [[
               {   
                title:'客户代码',
                field: 'customerCod',
                width: 70
               },
               {   
                title:'客户名称',
                field: 'cnCustomerNam',
                width: 220
               }
            ]]
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 客户类型
 * @param {type} params
 * @returns 
 */
HdUtils.code.customerTypCod = function(params) {
	var ret = {
		fieldMapping : {
			code : 'code',
			name : 'name',
		},
		panelWidth : 280,
		height : 21,
		panelHeight : 235,
		pagination : false,
		isPost : false,
		method:'post',
		sortOrder: 'asc',
		//sortName: 'customEx2',
		remoteSort:false,
		idField:'code',
		filterColumns : 'name',
		showColumns : "code,name",
		url : "../webresources/login/SysCode/findAll?fieldCod=CUSTOMER_TYP_COD",
		columns : [[{
			field : 'code',
			title : '客户类型代码',
			sortable : true,
			width : 60
		},{
			field : 'name',
			title : '客户类型名称',
			sortable : true,
			width : 100
		},
//		{
//			field : 'customEx2',
//			title : '客户大类',
//			sortable : true,
//			width : 120
//		}
		]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 所属港区
 * @param {type} params
 * @returns 
 */
HdUtils.code.sbcPortZone = function(params) {
	var ret = {
		fieldMapping : {
			portZoneCod : 'portZoneCod',
			cnPortZoneNam : 'cnPortZoneNam',
		},
		panelWidth : 230,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'portZoneCod,cnPortZoneNam,',
		showColumns : "portZoneCod,cnPortZoneNam",
		url : "../webresources/login/SbcPortZone/find",
		columns : [[{
			field : 'portZoneCod',
			title : '港区代码',
			sortable : true,
			width : 60
		},{
			field : 'cnPortZoneNam',
			title : '港区名称',
			sortable : true,
			width : 120
		}]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/*
 * 公司代码对应表下拉
 * @param {type} params
 * @returns 
 */
//HdUtils.code.vwGroupOrgn = function(params) {
//	var ret = {
//		fieldMapping : {
//			companyCod : 'COMPANY_COD',
//			cncompanyNam : 'COMPANY_NAM'
//		},
//		panelWidth : 180,
//		height : 21,
//		panelHeight : 280,
//		pagination : false,
//		isPost : false,
//		method:'post',
//		filterColumns : 'COMPANY_COD,COMPANY_NAM',
//		showColumns : "COMPANY_COD,COMPANY_NAM",
//		url : '../webresources/login/SbcCompany/findVwGroupOrgn',
//		columns : [[{
//                        field: "COMPANY_COD",
//                        title: '公司代码',
//                        sortable: true,
//                        width : 60
//                    },
//                    {
//                        field: "COMPANY_NAM",
//                        title: '公司中文名称',
//                        sortable: true,
//                        width : 100
//                    }]]
//	};
//	$.extend(ret, params);
//	return HdUtils.code.base(ret);
//};
//包括集团的下拉公司
HdUtils.code.findVwGroupOrgn = function(params) {
	var ret = {
		fieldMapping : {
			companyCod : 'companyCod',
			companyNam : 'companyNam'
		},
		panelWidth : 180,
		height : 21,
		panelHeight : 280,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'companyCod,companyNam',
		showColumns : "companyCod,companyNam",
		url : '../webresources/login/SbcProductionPlan/findVwGroupOrgn',
		columns : [[{
                        field: "companyCod",
                        title: '公司代码',
                        sortable: true,
                        width : 60
                    },
                    {
                        field: "companyNam",
                        title: '公司中文名称',
                        sortable: true,
                        width : 100
                    }]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/**
 * 合同下拉
 */
HdUtils.code.contract = function(params) {
	var ret = {
		fieldMapping : {
			contractNo : 'contractNo',
			contractNam : 'contractNam'
		},
		panelWidth : 230,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		idField:'contractNo',
		textField:'contractNo',
		filterColumns : 'contractNo,contractNam',
		showColumns : "contractNo,contractNam",
		url : '/webresources/login/Contract/find',
		columns : [[{
                        field: "contractNo",
                        title: '合同编号',
                        sortable: true,
                        width : 100
                    },
                    {
                        field: "contractNam",
                        title: '合同名称',
                        sortable: true,
                        width : 90
                    },
                    {
                        field: "contractSat",
                        title: "合同状态",
                        multiSort: true,
                        hidden:true,
                    },
                    {
                        field: "signDepartment",
                        title: "签约部门",
                        multiSort: true,
                        hidden:true,
                    },
                    ]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};


/*
 * 部门下拉
 * @param {type} params
 * @returns 
 */
HdUtils.code.authOrgn = function(params) {
	var ret = {
		fieldMapping : {
			orgnId : 'orgnId',
			text : 'text'
		},
		panelWidth : 120,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'orgnId,text',
		showColumns : "text",
		url : '/webresources/login/AuthPrivilege/find',
		columns : [[{
			field : 'text',
			title : '部门名称',
			sortable : true,
			width : 100
		}
		]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};

/*
 * 部门下拉人员
 * @param {type} params
 * @returns 
 */
HdUtils.code.authOrgnUser = function(params) {
	var ret = {
		fieldMapping : {
			account : 'account',
			name : 'name'
		},
		panelWidth : 130,
		height : 21,
		panelHeight : 240,
		pagination : false,
		isPost : false,
		method:'post',
		filterColumns : 'account,name',
		showColumns : "name",
		url : '/webresources/login/ContractUser/find',
		columns : [[{
			field : 'name',
			title : '人员姓名',
			sortable : true,
			width : 60
		}
		]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
/**
 * 交通报表传入公司id转化相应报表的参数
 * @param 公司下拉comid
 */
HdUtils.code.jtgCom = function(params) {
	var ret = {
		fieldMapping : {
			comid : 'comid',
			printname : 'printname'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 240,
		pagination : false,
		method:'post',
		fit:true,
		fitColumns:true,
		filterColumns : 'printname',
		showColumns : "printname",
		url : '/webresources/login/Jtg/find',
		columns : [[{
			field : 'printname',
			title : '公司名称',
			sortable : true,
			width : 200
		}
		]]
	};
	$.extend(ret, params);
	return HdUtils.code.base(ret);
};
HdUtils.code.SbcCustomerContact = function(params) {
	var ret = {
			fieldMapping : {
				contactNam : 'contactNam',
			},
			panelWidth : 550,
			height : 21,
			panelHeight : 240,
			pagination : false,
			isPost : false,
			method:'post',
			filterColumns : 'contactNam',
			showColumns : "contactNam",
			url : '/webresources/login/SbcCustomerContact/find',
			columns : [[{
				field : 'contactNam',
				title : '人员姓名',
				sortable : true,
				width : 60
			},
			{
				field : 'deptNam',
				title : '部门',
				sortable : true,
				width : 60
			},{
				field : 'postNam',
				title : '职务',
				sortable : true,
				width : 60
			},{
				field : 'gender',
				title : '性别',
				formatter: function (value) {
                    if (value === null || value === '')
                        return;
                    var list = HdUtils.global.scode.query({fieldCod: 'GENDER', code: value});
                    return list.length > 0 ? list[0].name : "";
                },
				sortable : true,
				width : 60
			},{
				field : 'personalTel',
				title : '手机',
				sortable : true,
				width : 100
			},{
				field : 'emailAddress',
				title : '邮箱',
				sortable : true,
				width : 100
			},{
				field : 'favouriteTxt',
				title : '爱好',
				sortable : true,
				width : 60
			}
			]]
		};
		$.extend(ret, params);
		return HdUtils.code.base(ret);
};
/**
 * 职务
 */
HdUtils.code.Position = function(params) {
	var ret = {
			fieldMapping : {
				postNam : 'postNam',
			},
			panelWidth : 140,
			height : 21,
			panelHeight : 240,
			pagination : false,
			isPost : false,
			method:'post',
			filterColumns : 'postNam',
			showColumns : "postNam",
			url : '/webresources/login/Position/find',
			columns : [[{
				field : 'postNam',
				title : '职务',
				sortable : true,
				width : 120
			},
			]]
		};
		$.extend(ret, params);
		return HdUtils.code.base(ret);
};
/**
 * 客户部门下拉
 */
HdUtils.code.SbcCustomerOrgan = function(params) {
	var ret = {
			fieldMapping : {
				organNam : 'organNam',
			},
			panelWidth : 140,
			height : 21,
			panelHeight : 240,
			pagination : false,
			isPost : false,
			method:'post',
			filterColumns : 'organNam',
			showColumns : "organNam",
			url : '/webresources/login/SbcCustomerOrgan/find',
			columns : [[{
				field : 'organNam',
				title : '部门',
				sortable : true,
				width : 100
			},
			]]
		};
		$.extend(ret, params);
		return HdUtils.code.base(ret);
};
HdUtils.code.ContactNam=function(params) {
    var ret = {
		fieldMapping: {
			contactNam: 'contactNam'
		},
		panelWidth : 200,
		height : 21,
		panelHeight : 220,
		pagination : false,
        idField: 'contactNam', 
        pagination: false,
        pageSize: 40,
        textField: 'contactNam',                    
        sortName: 'contactNam',
       // sortOrder: 'asc',
        method:"POST",
        url: '/webresources/login/SbcCustomerContact/find',
        columns: [[
               {
                field: 'contactNam',
                title : '姓名',
                width: 60
               }
            ]]
    };
    $.extend(ret, params);
	return HdUtils.code.base(ret);
};