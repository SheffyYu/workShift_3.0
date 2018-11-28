/* 
 * Copyright (C) 2015 HUADONG CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */
/**
 * @fileOverview 通用查询条件。
 * @since 2015-03-20
 */

/**
 * 前台查询条件对象。
 * @class
 * @extends HdOjbect
 * @author jason <caiyj@huadong.net>
 * @returns {HdEzuiQueryParamsBuilder}
 */
function HdEzuiQueryParamsBuilder() {
    /**
     * 
     * @type 前台条件的json数据对象。
     */
    this.hdEzuiQueryParams = {};
    this.hdEzuiQueryParams.hdConditions = {};
    this.hdEzuiQueryParams.others = {};
}

/**
 * 通用查询需要查询的属性名（列名）
 * @param {type} queryColumns
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setQueryColumns = function(queryColumns) {
    this.hdEzuiQueryParams.queryColumns = queryColumns;
};
/**
 * 显示哪些属性名（列名）
 * @param {type} showColumns
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setShowColumns = function(showColumns) {
    this.hdEzuiQueryParams.showColumns = showColumns;
};
/**
 * 隐藏哪些属性名（列名）
 * @param {type} hideColumns
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setHideColumns = function(hideColumns) {
    this.hdEzuiQueryParams.hideColumns = hideColumns;
};
/**
 * 业务参数。
 * @param {type} key
 * @param {type} value
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setOtherskeyValue = function(key,value) {
    this.hdEzuiQueryParams.others[key] = value;
};
/**
 * @description 设置导出excel信息。
 * @param {string} columnTitles 列中文名。
 * @param {string} columnNames  列属性。
 * @param {string} exportFileName   导出excel文件名。
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setHdExportExcel = function(columnTitles, columnNames, exportFileName) {
    if (this.hdEzuiQueryParams.hdConditions.hdExportExcel === undefined) {
        this.hdEzuiQueryParams.hdConditions.hdExportExcel = {};
    }
    this.hdEzuiQueryParams.hdConditions.hdExportExcel.columnTitles = columnTitles;
    this.hdEzuiQueryParams.hdConditions.hdExportExcel.columnNames = columnNames;
    this.hdEzuiQueryParams.hdConditions.hdExportExcel.exportFileName = exportFileName;
};
/**
 * 是否做distinct。
 * @param {boolean} distinct 是否做distinct。
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setDistinct = function(distinct) {
    this.hdEzuiQueryParams.hdConditions.distinct = distinct;
};

/**
 * 并列条件函数。
 * @param {string} column 列属性。
 * @param {string} value 列值。
 * @param {string} operation 操作符：> = < !=。
 * @param {string} conjunction "and" 或者 "or"。
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setAndClause = function(column, value, operation, conjunction) {
    if (this.hdEzuiQueryParams.hdConditions.hdPredicates === undefined) {
        this.hdEzuiQueryParams.hdConditions.hdPredicates = [];
        this.hdEzuiQueryParams.hdConditions.hdPredicates.push({});
        this.hdEzuiQueryParams.hdConditions.hdPredicates[0].hdClauses = [];
    }
    this.hdEzuiQueryParams.hdConditions.hdPredicates[0].hdClauses.push({column: column, value: value, operation: operation, conjunction: conjunction});
};

/**
 * 设置复杂条件。
 * @param {string} column 列属
 * @param {string} value 列值
 * @param {string} operation 操符符
 * @param {string} conjunction 括号内的"and" 或者 "or"
 * @param {string} isNewPredicate 与前面的分离新括号中内容。
 * @param {string} conjunctionPredicate 括号与括号之间的。"and" 或者 "or"
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setClause = function(column, value, operation, conjunction, isNewPredicate, conjunctionPredicate) {
    if (this.hdEzuiQueryParams.hdConditions.hdPredicates === undefined) {
        this.hdEzuiQueryParams.hdConditions.hdPredicates = [];
        this.hdEzuiQueryParams.hdConditions.hdPredicates.push({});
        this.hdEzuiQueryParams.hdConditions.hdPredicates[0].hdClauses = [];
    } else if (isNewPredicate) {
        this.hdEzuiQueryParams.hdConditions.hdPredicates.push({});
        this.hdEzuiQueryParams.hdConditions.hdPredicates[this.hdEzuiQueryParams.hdConditions.hdPredicates.length - 1].hdClauses = [];
    }
    this.hdEzuiQueryParams.hdConditions.hdPredicates[this.hdEzuiQueryParams.hdConditions.hdPredicates.length - 1].conjunction = conjunctionPredicate;
    this.hdEzuiQueryParams.hdConditions.hdPredicates[this.hdEzuiQueryParams.hdConditions.hdPredicates.length - 1].hdClauses.push({column: column, value: value, operation: operation, conjunction: conjunction});
};

/**
 * order by字句。
 * @param {string} column 列属性。
 * @param {string} operation "asc" 或者 "desc"。
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setOrderByClause = function(column, operation) {
    if (this.hdEzuiQueryParams.hdConditions.orderByClause === undefined) {
        this.hdEzuiQueryParams.hdConditions.orderByClause = [];
    }
    this.hdEzuiQueryParams.hdConditions.orderByClause.push({column: column, operation: operation});
};

/**
 * 
 * @param {string} column 列属性。
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.setGroupByClause = function(column) {
	if (this.hdEzuiQueryParams.hdConditions.groupByClause === undefined) {
        this.hdEzuiQueryParams.hdConditions.groupByClause = [];
    }
    this.hdEzuiQueryParams.hdConditions.groupByClause.push({column: column});
};

/**
 * @description 获得当前hdEzuiQueryParams实体。
 * @returns {HdEzuiQueryParamsBuilder.hdEzuiQueryParams} 返回HdEzuiQueryParamsBuilder.
 */
HdEzuiQueryParamsBuilder.prototype.build = function() {
    return this.hdEzuiQueryParams;
};
/**
 * @description 获得当前hdEzuiQueryParams字符串。
 * @returns {HdEzuiQueryParamsBuilder.hdEzuiQueryParams} 返回HdEzuiQueryParamsBuilder.
 */
HdEzuiQueryParamsBuilder.prototype.toJSON = function() {
    return $.toJSON(this.hdEzuiQueryParams);
};
/**
 * @description 获得method='get'时hdEzuiQueryParams实体。
 * @returns {HdEzuiQueryParamsBuilder.hdEzuiQueryParams} 返回HdEzuiQueryParamsBuilder.
 */
HdEzuiQueryParamsBuilder.prototype.buildGet = function() {
    var obj = {};
    for(var key in this.hdEzuiQueryParams){
        obj[key] = $.toJSON(this.hdEzuiQueryParams[key]);
    }
    return obj;
};
// 继承。
//HdEzuiQueryParamsBuilder.prototype = new HdObject();
//HdEzuiQueryParamsBuilder.prototype.constructor = HdEzuiQueryParamsBuilder;

HdEzuiQueryParamsBuilder.prototype.self = function() {
    return this.hdEzuiQueryParams;
};

/**
 * 设置参数值。
 * @param {type} key
 * @param {type} value
 * @returns {undefined}
 */
HdEzuiQueryParamsBuilder.prototype.set = function(key,value) {
    this.hdEzuiQueryParams[key] = value;
};

/**
 * 设置hdEzuiQueryParams。
 * @param {object} params
 */
HdEzuiQueryParamsBuilder.prototype.setHdEzuiQueryParams = function(params) {
    this.hdEzuiQueryParams = params;
};