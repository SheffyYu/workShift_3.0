/* 
 * Copyright (C) 2013 HUADONG CO.,LTD.
 * Author:jason <caiyj@huadong.net>
 */
/**
 * @fileOverview 通用条件文件。
 */
/**
 * 前台查询条件对象。
 * @class
 * @extends HdOjbect
 * @author jason <caiyj@huadong.net>
 * @returns {HdConditions}
 */
function HdConditions() {

    /**
     * 
     * @type 前台条件的json数据对象。
     */
    this.hdConditions = {};

}
/**
 * @description 设置导出excel信息。
 * @param {string} columnTitles 列中文名。
 * @param {string} columnNames  列属性。
 * @param {string} exportFileName   导出excel文件名。
 * @returns {undefined}
 */
HdConditions.prototype.setHdExportExcel = function(columnTitles, columnNames, exportFileName) {
    if (this.hdConditions.hdExportExcel === undefined) {
        this.hdConditions.hdExportExcel = {};
    }
    this.hdConditions.hdExportExcel.columnTitles = columnTitles;
    this.hdConditions.hdExportExcel.columnNames = columnNames;
    this.hdConditions.hdExportExcel.exportFileName = exportFileName;
};
/**
 * 是否做distinct。
 * @param {boolean} distinct 是否做distinct。
 * @returns {undefined}
 */
HdConditions.prototype.setDistinct = function(distinct) {
    this.hdConditions.distinct = distinct;
};

/**
 * 并列条件函数。
 * @param {string} column 列属性。
 * @param {string} value 列值。
 * @param {string} operation 操作符：> = < !=。
 * @param {string} conjunction "and" 或者 "or"。
 * @returns {undefined}
 */
HdConditions.prototype.setAndClause = function(column, value, operation, conjunction) {
    if (this.hdConditions.hdPredicates === undefined) {
        this.hdConditions.hdPredicates = [];
        this.hdConditions.hdPredicates.push({});
        this.hdConditions.hdPredicates[0].hdClauses = [];
    }
    this.hdConditions.hdPredicates[0].hdClauses.push({column: column, value: value, operation: operation, conjunction: conjunction});
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
HdConditions.prototype.setClause = function(column, value, operation, conjunction, isNewPredicate, conjunctionPredicate) {
    if (this.hdConditions.hdPredicates === undefined) {
        this.hdConditions.hdPredicates = [];
        this.hdConditions.hdPredicates.push({});
        this.hdConditions.hdPredicates[0].hdClauses = [];
    } else if (isNewPredicate) {
        this.hdConditions.hdPredicates.push({});
        this.hdConditions.hdPredicates[this.hdConditions.hdPredicates.length - 1].hdClauses = [];
    }
    this.hdConditions.hdPredicates[this.hdConditions.hdPredicates.length - 1].conjunction = conjunctionPredicate;
    this.hdConditions.hdPredicates[this.hdConditions.hdPredicates.length - 1].hdClauses.push({column: column, value: value, operation: operation, conjunction: conjunction});
};

/**
 * order by字句。
 * @param {string} column 列属性。
 * @param {string} operation "asc" 或者 "desc"。
 * @returns {undefined}
 */
HdConditions.prototype.setOrderByClause = function(column, operation) {
    if (this.hdConditions.orderByClause === undefined) {
        this.hdConditions.orderByClause = [];
    }
    this.hdConditions.orderByClause.push({column: column, operation: operation});
};

/**
 * 
 * @param {string} column 列属性。
 * @returns {undefined}
 */
HdConditions.prototype.setGroupByClause = function(column) {
   debugger
	if (this.hdConditions.groupByClause === undefined) {
        this.hdConditions.groupByClause = [];
    }
    this.hdConditions.groupByClause.push({column: column});
};

/**
 * @description 获得当前hdConditions。
 * @returns {HdConditions.hdConditions} 返回HdConditions.
 */
HdConditions.prototype.getHdConditions = function() {
    return $.toJSON(this.hdConditions);
};

// 继承。
//HdConditions.prototype = new HdObject();
//HdConditions.prototype.constructor = HdConditions;