/* 
 * ezui form扩展
 */
$.extend($.fn.form.defaults, {
	originalData : {}
});

/*
 * ezui form method扩展
 */
$
		.extend(
				$.fn.form.methods,
				{
					/**
					 * 返回form属性对象。
					 * 
					 * @function
					 * @name form#options
					 */
					options : function(jq) {
						return $.data(jq[0], 'form').options;
					},
					/**
					 * 加载数据（不直接使用 form('load')方法,因为日期、disabled表单等数据需要处理）。
					 * 
					 * @function
					 * @name form#loadData
					 */
					loadData : function(jq, data) {
						return jq
								.each(function() {
									// 0 CHECK
									if (!$.isPlainObject(data)) {
										data = $.evalJSON(data); // 确保是对象
									}
									if (!$.isPlainObject(data)) {
										alert("发现编程错误：调用FormOperation.loadData给定参数不是对象也不是JSON格式");
										return false; // 不是对象，也不是对象JSON无法处理了
									}
									// 1 CLEAR
									var form = $(this);
									form.form('clear'); // 防止load的数据某些字段为空,无法覆盖原有的表单值

									// 2 保存原始数据
									$.fn.form.defaults.originalData = $.extend(
											{}, data, true);
									form.data("oldValue", form.serialize()); // 用于判断表单数据是否修改

									if (form.data('isFirst') == undefined) {
										form.data('isFirst', 1);
									} else {
										form.data('isFirst', 0);
									}
									// 3 FORM LOAD
									$.hd.form.load($(this), data);
									return true;
								});
					},
					/**
					 * add by huxj 2016-10-14
					 * dialog特殊处理，比如打开dialog不立即调用loadData方法，而是在请求相关数据后在点用loadData，需要先执行该方法
					 * 例如：$("#formID").form('setIsFirst', 0);
					 * 
					 * @function
					 * @name form#setIsFirst
					 */
					setIsFirst : function(jq, value) {
						return jq.each(function() {
							var form = $(this);
							form.data('isFirst', value);
						});
					},
					/**
					 * 获得FORM数据，以JSON串返回。
					 * 
					 * @function
					 * @name form#getData
					 */
					getData : function(jq) {
						var ret;
						jq.each(function(){
							ret = $.hd.form.getDataAsObject($(this));
						});
						return ret;
					},
					/**
					 * 清空FORM数据，并保存old值。
					 * 
					 * @function
					 * @name form#clearData
					 */
					clearData : function(jq) {
						jq.each(function(){
							$(this).form('clear');
							$(this).data("oldValue", $(this).serialize()); // 这里不能赋予NULL，否则无从判定
							// 最新的serialize()是不是改过的
							$.fn.form.defaults.originalData = {};
						});
					},
					/**
					 * 标记为新FORM。
					 * 
					 * @function
					 * @name form#markAsNew
					 */
					markAsNew : function() {
						$.fn.form.defaults.originalData = {};
						$(this).data("oldValue", $(this).serialize()); // 用户直接clear而不loadData，将导致oldValue为null最终判定为未改变
					},
					/**
					 * 标记FORM未改变。
					 * 
					 * @function
					 * @name form#markAsUnmodified
					 */
					markAsUnmodified : function() {
						$(this).data("oldValue", $(this).serialize());
						$.fn.form.defaults.originalData = $.hd.form
								.getDataAsObject($(this));
					},
					/**
					 * 还原FORM为之前的值。
					 * 
					 * @function
					 * @name form#undo
					 */
					undo : function() {
						$(this).form('reset');
						$(this).loadData($.fn.form.defaults.originalData);
						$(this).data("oldValue", $(this).serialize());
					},
					/**
					 * 检查FORM是否更改。
					 * 
					 * @function
					 * @name form#isChanged
					 */
					isChanged : function() {
						var oldValue = $(this).data("oldValue");
						var newValue = $(this).serialize();

						if (oldValue != null && oldValue != newValue
								|| oldValue == null && newValue != null) {
							return true;
						} else {
							return false;
						}
					},
					/**
					 * 获取FORM更改值。
					 * 
					 * @function
					 * @param {string
					 *            or array} pkField。
					 * @name form#getChangedData
					 */
					getChangedData : function(jq, pkField) {
						var changedData = {};
						var newData = $(this).getData();
						$
								.each(
										newData,
										function(name, value) {
											if (value != $.fn.form.defaults.originalData[name]) {
												changedData[name] = value;
											}
										});
						if (!pkField) {
							return changedData;
						}
						if ($.type(pkField) === 'string') {
							changedData[pkField] = newData[pkField];
						} else if ($.isArray(pkField)) {
							$.each(pkField, function(i, value) {
								changedData[value] = newData[value];
							});
						}
						return changedData;
					},
					/**
					 * 保存方法。
					 * 
					 * @function
					 * @param {object}
					 *            params {url:xxx,callback:function(){}}。
					 * @name form#submit
					 */
					submit : function(jq, params) {
						if (!$(this).form('validate')) {
							$.messager.alert(Resources.WB_INFO,
									Resources.INFO_INVALID, "info");
							return;
						}
						$.ajax({
							url : params.url,
							data : $.toJSON($(this).getData()),
							dataType : "json",
							type : 'POST',
							success : function(data) {
								HdUtils.messager.show(data, function() {
									if ($.isFunction(params.callback)) {
										params.callback();
									}
								});
							},
							error : function(data) {
								HdUtils.messager.show(data);
							}
						});
					},
					deleteData : function(jq, params) {
						if (!params.url || "" == params.url) {
							return;
						}
						if (!params.data || !$.isPlainObject(params.data)
								|| {} == params.data) {
							params.data = $(this).getData();
						}
						$.messager
								.confirm(
										Resources.WB_CONFIRM,
										Resources.WB_REMOVE_CONFIRM,
										function(r) {
											if (r) {
												$
														.ajax({
															url : params.url,
															type : 'POST',
															data : $
																	.toJSON(params.data),
															success : function(
																	data) {
																HdUtils.messager
																		.show(
																				data,
																				function() {
																					if (jQuery
																							.isFunction(params.callback)) {
																						params
																								.callback();
																					}
																				});
															},
															error : function(
																	data) {
																HdUtils.messager
																		.show(data);
															}
														});
											}
										});
					}
				});

$.hd = {};

$.extend($.hd, {
	form : {
		load : function(form, data) {
				$.each(form.find('.easyui-datetimebox'), function() {
					var fname = $(this).attr("name") == undefined ? $(this).attr("comboname") : $(this).attr("name");
					if (typeof (data[fname]) == "number") {
						data[fname] = new Date(parseInt(data[fname])).format("yyyy-MM-dd hh:mm:ss");
					}
				});
//				if(form.data('isFirst') == 0) {
					$.each(form.find('.easyui-datebox'), function() {
						var fname = $(this).attr("name") == undefined ? $(this).attr("comboname") : $(this).attr("name");
						if (typeof (data[fname]) == "number") {
							data[fname] = new Date(parseInt(data[fname])).format("yyyy-MM-dd");
						}
					});
//				}
			form.form('load', data);
//			$.each(form.find('.easyui-datebox'),
//					function() {
//						var value = $(this).val();
//						if (form.data('isFirst') == 0) {
//							value = $(this).datebox('getTsValue');
//							if (typeof(value)=="number") {
//								$(this).datebox('setValue',
//										new Date(value).format("yyyy-MM-dd"));
//							}
//						} else {
//							if (typeof(value)=="number") {
//								$(this).val(
//										new Date(parseInt(value))
//												.format("yyyy-MM-dd"));
//							}
//						}
//					});
//			$.each(form.find('.easyui-datetimebox'), function() {
//				var value = $(this).val();
//				if (form.data('isFirst') == 0) {
//					value = $(this).datetimebox('getValue');
//					if (typeof(value)=="number") {
//						$(this).datetimebox('setValue',
//								new Date(value).format("yyyy-MM-dd hh:mm:ss"));
//					}
//				} else {
//					if (typeof(value)=="number") {
//						$(this).val(
//								new Date(value).format("yyyy-MM-dd hh:mm:ss"));
//					}
//				}
//			});
			$.each(form.find('.easyui-combogrid'), function() {
				var value = $(this).combogrid('getValue');
				if (value === '')
					return true;
				var opts = $(this).combogrid('options');
				var isPaging = opts.pagination;
				if (!isPaging)
					return true;
				var isValid = opts.isValid === undefined ? true : opts.isValid;
				if (!isValid)
					return true;
				var selections = $(this).combogrid('grid').datagrid(
						'getSelections');
				if (selections == null || selections.length == 0) { // 没有对应行
					var _this = $(this);
					var valueField = opts.idField;
					var textField = opts.textField;
					var opts = _this.combogrid('grid').datagrid("options");
					var params = new HdEzuiQueryParamsBuilder();
					params.setHdEzuiQueryParams($.extend(true, {},
							opts.queryParams));
					params.setAndClause(valueField, value, '=', 'and');

					$.ajax({
						type : "get",
						url : opts.url,
						data : params.buildGet(),
						dataType : "json",
						contentType : "application/json",
						success : function(data) {
							if (data.total > 0) {
								_this.combogrid('setValue',
										data.rows[0][valueField]);
								_this.combogrid('setText',
										data.rows[0][textField]);
							}
						},
						error : function() {
						}
					});
				}
			});
		},
		/**
		 * 获得FORM数据，合并附加数据，以JSON串返回，用于AJAX提交后台。 HCB:
		 * 增加params(Object键值对):用于提交时添加的其它参数 FXQ:
		 * 重构，分离getDataAsObject方法返回对象，本方法基于此方法实现
		 * 
		 * @param {ezuiObject}
		 *            form 选择器选中的 easyUI对象,数据已经初始化
		 * @param {object}
		 *            params 附加参数，用于一并提交到后台
		 * @return {object} FORM数据内容，键值对对应于FORM各个字段
		 */
		getData : function(form, params) {
			var formObj = $.hd.form.getDataAsObject(form);
			if (!params || !$.isPlainObject(params)) {
				params = {}; // FXQ 保持兼容，防范undefined
			}
			$.each(params, function(name, value) {
				if (formObj[name]) {
					formObj[name] = formObj[name] + "," + value;
				} else {
					formObj[name] = value;
				}
			});
			return $.toJSON(formObj);
		},
		/**
		 * 获得FORM数据，以对象格式返回。
		 * 
		 * @param {ezuiObject}
		 *            form 选择器选中的 easyUI对象,数据已经初始化
		 * @return {object} FORM数据内容，键值对对应于FORM各个字段
		 */
		getDataAsObject : function(form) {
			// 打开所有disabled项
//			var temp = form.find('input[disabled="disabled"]');
//			$.each(temp, function() {
//				$(this).removeAttr("disabled");
//			});
			// datebox值转成datetimebox值
//			var temp2 = form.find('.easyui-datebox');

			/*
			 * datetimebox 转换成标准格式。 @author jason
			 */
//			var temp4 = form.find('.easyui-datetimebox');
//			$.each(temp4, function() {
//				var value = $(this).datetimebox('getTsValue');
////				if (value != null) {
////					var howmany = value.split(":").length;
////					if (howmany == 2) {
////						$($(this).next().children().get(2)).val(value + ":00");
////					}
////				}
//			});
			var formObj = serializeObject(form,form.find('.easyui-datebox'),form.find('.easyui-datetimebox'));
			// serializeObject改为不对外公开的函数
			// 添加位选中的checkbox
			// 修改选中方式为prop,兼容性好,同时增加选中时为1的if分支
			// auth by zz
			var temp3 = form.find('input[type="checkbox"]');
			$.each(temp3, function() {
				if ($(this).prop('checked') == true) {
					formObj[this.name] = "1";
				} else {
					formObj[this.name] = "0";
				}
			});

			// [MARK]至此，formObj各变量赋值完毕

			// 本方法返回OBJECT, 用getData返回JSON串。 var data = $.toJSON(formObj);

//			$.each(temp, function() { // 恢复disabled项
//				$(this).attr("disabled", "disabled");
//			});

//			$.each(temp2,
//					function() { // 恢复datebox值
//						var value = $(this).datebox('getValue');
//						if (value !== '') {
//							$(this).datebox('setValue',
//									value.replace(' 00:00:00', ''));
//						}
//					});
			return formObj;

			function serializeObject(form,dt,dtt) {
				var o = {};
				var data = form.serializeArray();

				$.each(data, function() {
					var name = this['name'];
					var value = this['value'];
					if (o[name]) {
						o[name] = o[name] + "," + value;
					} else {
						o[name] = value;
					}
				});
				// 改变datebox值。
				$.each(dt, function() {
					var fname = $(this).attr("name") == undefined ? $(this).attr("comboname") : $(this).attr("name");
						o[fname] = new Date(o[fname]).getTime();
				});
				// 改变datetimebox值。
				$.each(dtt, function() {
					var fname = $(this).attr("name") == undefined ? $(this).attr("comboname") : $(this).attr("name");
						o[fname] = new Date(o[fname]).getTime();
				});
				return o;
			}
		}
	}
});