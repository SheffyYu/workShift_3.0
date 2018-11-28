/*
 说明： 对Ezui标准的combogrid组件进行扩展，修正分页情况下不能显示名称等问题
【注意】 所有修改之处，请使用//【hd-modi】标注进行注明，必要时，增加begin/end字样
 
 author:fuxq@huadong.net 
 
 Modifications:
 
 1.4 on 2015-6-30 by fuxq@huadong.net: 对url为Post方式的下拉列表，改变传参方式，否则后台报错。同时对输入Q过滤的情况，不再发送额外后台请求
 1.3 on 2014-9-24 by fuxq@huadong.net: 由于combogrid可能被初始化两次（例如在js和html中又有class='combogrid'）因此以合并后的onHidePanel属性为准，而不是以options参数为准
 1.2 on 2014-9-15 by fuxq@huadong.net: 引入了combo的代码重构， 只对visible的组件调用onHidePanel事件，解决form中的combogrid大量数据访问的问题
 1.1 on 2014-9-10 by fuxq@huadong.net: 调试通过，解决了target引用， 数据行为简单数组等情况下造成的问题，代码通用性增加 
 1.0 on 2014-9-9 by fuxq@huadong.net : 创建,为了解决FORM中的combogrid在分页情况下不能显示名称的问题，拷贝easyUI源码进行扩展
 web:http://www.huadong.net

*/

/**
 * combo - jQuery EasyUI
 * 
 * Copyright (c) 2009-2013 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the GPL or commercial licenses
 * To use it on other terms please contact us: info@jeasyui.com
 * http://www.gnu.org/licenses/gpl.txt
 * http://www.jeasyui.com/license_commercial.php
 * 
 * Dependencies:
 *   panel
 *   validatebox
 * 
 */
(function($){
	function setSize(target, width){
		var opts = $.data(target, 'combo').options;
		var combo = $.data(target, 'combo').combo;
		var panel = $.data(target, 'combo').panel;
		
		if (width) opts.width = width;
		if (isNaN(opts.width)){
			var c = $(target).clone();
			c.css('visibility','hidden');
			c.appendTo('body');
			opts.width = c.outerWidth();
			c.remove();
		}
		
		combo.appendTo('body');
		
		var input = combo.find('input.combo-text');
		var arrow = combo.find('.combo-arrow');
		var arrowWidth = opts.hasDownArrow ? arrow._outerWidth() : 0;
		
		combo._outerWidth(opts.width)._outerHeight(opts.height);
		input._outerWidth(combo.width() - arrowWidth);
		input.css({
			height: combo.height()+'px',
			lineHeight: combo.height()+'px'
		});
		arrow._outerHeight(combo.height());
		
		panel.panel('resize', {
			width: (opts.panelWidth ? opts.panelWidth : combo.outerWidth()),
			height: opts.panelHeight
		});
		
		combo.insertAfter(target);
	}
	
	/**
	 * create the combo component.
	 */
	function init(target){
		$(target).addClass('combo-f').hide();
		
		var span = $('<span class="combo"></span>').insertAfter(target);
		var input = $('<input type="text" class="combo-text">').appendTo(span);
		$('<span><span class="combo-arrow"></span></span>').appendTo(span);
		$('<input type="hidden" class="combo-value">').appendTo(span);
		var panel = $('<div class="combo-panel"></div>').appendTo('body');
		panel.panel({
			doSize:false,
			closed:true,
			cls:'combo-p',
			style:{
				position:'absolute',
				zIndex:10
			},
			onOpen:function(){
				$(this).panel('resize');
			},
			onClose:function(){
				var state = $.data(target, 'combo');
				if (state){
					state.options.onHidePanel.call(target);
				}
			}
		});
		
		var name = $(target).attr('name');
		if (name){
			span.find('input.combo-value').attr('name', name);
			$(target).removeAttr('name').attr('comboName', name);
		}
		input.attr('autocomplete', 'off');
		
		return {
			combo: span,
			panel: panel
		};
	}
	
	function buildCombo(target){
		var state = $.data(target, 'combo');
		var opts = state.options;
		var combo = state.combo;
		if (opts.hasDownArrow){
			combo.find('.combo-arrow').show();
		} else {
			combo.find('.combo-arrow').hide();
		}
		setDisabled(target, opts.disabled);
		setReadonly(target, opts.readonly);
	}
	
	function destroy(target){
		var state = $.data(target, 'combo');
		var input = state.combo.find('input.combo-text');
		input.validatebox('destroy');
		state.panel.panel('destroy');
		state.combo.remove();
		$(target).remove();
	}
	
	function bindEvents(target){
		var state = $.data(target, 'combo');
		var opts = state.options;
		var panel = state.panel;
		var combo = state.combo;
		var input = combo.find('.combo-text');
		var arrow = combo.find('.combo-arrow');
		
		$(document).unbind('.combo').bind('mousedown.combo', function(e){
			var p = $(e.target).closest('span.combo,div.combo-panel');
			if (p.length){return;}
			$('body>div.combo-p>div.combo-panel:visible').panel('close');
		});
		
//		combo.unbind('.combo');
//		panel.unbind('.combo');
		input.unbind('.combo');
		arrow.unbind('.combo');
		
		if (!opts.disabled && !opts.readonly){
			input.bind('mousedown.combo', function(e){
				$('div.combo-panel:visible').not(panel).panel('close');  //【hd-modi】只对visible的组件调用onHidePanel，由于大量combogrid因clear导致重新检索，加大了网络负载
				e.stopPropagation();
			}).bind('keydown.combo', function(e){
				switch(e.keyCode){
					case 38:	// up
						opts.keyHandler.up.call(target);
						break;
					case 40:	// down
						opts.keyHandler.down.call(target);
						break;
					case 13:	// enter
						e.preventDefault();
						opts.keyHandler.enter.call(target);
						return false;
					case 9:		// tab
					case 27:	// esc
						hidePanel(target);
						break;
					default:
						if (opts.editable){
							if (state.timer){
								clearTimeout(state.timer);
							}
							state.timer = setTimeout(function(){
								var q = input.val();
								if (state.previousValue != q){
									state.previousValue = q;
									$(target).combo('showPanel');
									opts.keyHandler.query.call(target, input.val());
									validate(target, true);
								}
							}, opts.delay);
						}
				}
			});
			
			arrow.bind('click.combo', function(){
				if (panel.is(':visible')){
					hidePanel(target);
				} else {
					$('div.combo-panel:visible').panel('close');
					$(target).combo('showPanel');
				}
				input.focus();
			}).bind('mouseenter.combo', function(){
				$(this).addClass('combo-arrow-hover');
			}).bind('mouseleave.combo', function(){
				$(this).removeClass('combo-arrow-hover');
			});
		}
	}
	
	/**
	 * show the drop down panel.
	 */
	function showPanel(target){
		var opts = $.data(target, 'combo').options;
		var combo = $.data(target, 'combo').combo;
		var panel = $.data(target, 'combo').panel;
		
		if ($.fn.window){
			panel.panel('panel').css('z-index', $.fn.window.defaults.zIndex++);
		}
		
		panel.panel('move', {
			left:combo.offset().left,
			top:getTop()
		});
		if (panel.panel('options').closed){
			panel.panel('open');
			opts.onShowPanel.call(target);
		}
		
		(function(){
			if (panel.is(':visible')){
				panel.panel('move', {
					left:getLeft(),
					top:getTop()
				});
				setTimeout(arguments.callee, 200);
			}
		})();
		
		function getLeft(){
			var left = combo.offset().left;
			if (left + panel._outerWidth() > $(window)._outerWidth() + $(document).scrollLeft()){
				left = $(window)._outerWidth() + $(document).scrollLeft() - panel._outerWidth();
			}
			if (left < 0){
				left = 0;
			}
			return left;
		}
		function getTop(){
			var top = combo.offset().top + combo._outerHeight();
			if (top + panel._outerHeight() > $(window)._outerHeight() + $(document).scrollTop()){
				top = combo.offset().top - panel._outerHeight();
			}
			if (top < $(document).scrollTop()){
				top = combo.offset().top + combo._outerHeight();
			}
			return top;
		}
	}
	
	/**
	 * hide the drop down panel.
	 */
	function hidePanel(target){
//		var opts = $.data(target, 'combo').options;
		var panel = $.data(target, 'combo').panel;
		panel.panel('close');
//		opts.onHidePanel.call(target);
	}
	
	function validate(target, doit){
		var opts = $.data(target, 'combo').options;
		var input = $.data(target, 'combo').combo.find('input.combo-text');
//		input.validatebox(opts);
		input.validatebox($.extend({}, opts, {
			deltaX: (opts.hasDownArrow ? opts.deltaX : (opts.deltaX>0?1:-1))
		}));
		if (doit){
			input.validatebox('validate');
//			input.trigger('mouseleave');
		}
	}
	
	function setDisabled(target, disabled){
		var state = $.data(target, 'combo');
		var opts = state.options;
		var combo = state.combo;
		if (disabled){
			opts.disabled = true;
			$(target).attr('disabled', true);
			combo.find('.combo-value').attr('disabled', true);
			combo.find('.combo-text').attr('disabled', true);
		} else {
			opts.disabled = false;
			$(target).removeAttr('disabled');
			combo.find('.combo-value').removeAttr('disabled');
			combo.find('.combo-text').removeAttr('disabled');
		}
	}
	
	function setReadonly(target, mode){
		var state = $.data(target, 'combo');
		var opts = state.options;
		opts.readonly = mode==undefined ? true : mode;
		state.combo.find('.combo-text').attr('readonly', opts.readonly ? true : (!opts.editable));
	}
	
	function clear(target){
		var state = $.data(target, 'combo');
		var opts = state.options;
		var combo = state.combo;
		if (opts.multiple){
			combo.find('input.combo-value').remove();
		} else {
			combo.find('input.combo-value').val('');
		}
		combo.find('input.combo-text').val('');
	}
	
	function getText(target){
		var combo = $.data(target, 'combo').combo;
		return combo.find('input.combo-text').val();
	}
	
	function setText(target, text){
		var combo = $.data(target, 'combo').combo;
		combo.find('input.combo-text').val(text);
		validate(target, true);
		$.data(target, 'combo').previousValue = text;
	}
	
	function getValues(target){
		var values = [];
		var combo = $.data(target, 'combo').combo;
		combo.find('input.combo-value').each(function(){
			values.push($(this).val());
		});
		return values;
	}
	
	function setValues(target, values){
		var opts = $.data(target, 'combo').options;
		var oldValues = getValues(target);
		
		var combo = $.data(target, 'combo').combo;
		combo.find('input.combo-value').remove();
		var name = $(target).attr('comboName');
		for(var i=0; i<values.length; i++){
			var input = $('<input type="hidden" class="combo-value">').appendTo(combo);
			if (name) input.attr('name', name);
			input.val(values[i]);
		}
		
		var tmp = [];
		for(var i=0; i<oldValues.length; i++){
			tmp[i] = oldValues[i];
		}
		var aa = [];
		for(var i=0; i<values.length; i++){
			for(var j=0; j<tmp.length; j++){
				if (values[i] == tmp[j]){
					aa.push(values[i]);
					tmp.splice(j, 1);
					break;
				}
			}
		}
		
		if (aa.length != values.length || values.length != oldValues.length){
			if (opts.multiple){
				opts.onChange.call(target, values, oldValues);
			} else {
				opts.onChange.call(target, values[0], oldValues[0]);
			}
		}
	}
	
	function getValue(target){
		var values = getValues(target);
		return values[0];
	}
	
	function setValue(target, value){
		setValues(target, [value]);
	}
	
	/**
	 * set the initialized value
	 */
	function initValue(target){
		var opts = $.data(target, 'combo').options;
		var fn = opts.onChange;
		opts.onChange = function(){};
		if (opts.multiple){
			if (opts.value){
				if (typeof opts.value == 'object'){
					setValues(target, opts.value);
				} else {
					setValue(target, opts.value);
				}
			} else {
				setValues(target, []);
			}
			opts.originalValue = getValues(target);
		} else {
			setValue(target, opts.value);	// set initialize value
			opts.originalValue = opts.value;
		}
		//add  by huxj 2016-10-18 解决combigrid 的必填验证，只有获取焦点的时候显示，页面加载后不显示
		validate(target, true);
		
		opts.onChange = fn;
	}
	
	$.fn.combo = function(options, param){
		if (typeof options == 'string'){
			return $.fn.combo.methods[options](this, param);
		}
		
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'combo');
			if (state){
				$.extend(state.options, options);
			} else {
				var r = init(this);
				state = $.data(this, 'combo', {
					options: $.extend({}, $.fn.combo.defaults, $.fn.combo.parseOptions(this), options),
					combo: r.combo,
					panel: r.panel,
					previousValue: null
				});
				$(this).removeAttr('disabled');
			}
			buildCombo(this);
			
//			$('input.combo-text', state.combo).attr('readonly', !state.options.editable);
//			setDownArrow(this);
//			setDisabled(this, state.options.disabled);
			
			setSize(this);
			bindEvents(this);
			validate(this);
			initValue(this);
		});
	};
	
	$.fn.combo.methods = {
		options: function(jq){
			return $.data(jq[0], 'combo').options;
		},
		panel: function(jq){
			return $.data(jq[0], 'combo').panel;
		},
		textbox: function(jq){
			return $.data(jq[0], 'combo').combo.find('input.combo-text');
		},
		destroy: function(jq){
			return jq.each(function(){
				destroy(this);
			});
		},
		resize: function(jq, width){
			return jq.each(function(){
				setSize(this, width);
			});
		},
		showPanel: function(jq){
			return jq.each(function(){
				showPanel(this);
			});
		},
		hidePanel: function(jq){
			return jq.each(function(){
				hidePanel(this);
			});
		},
		disable: function(jq){
			return jq.each(function(){
				setDisabled(this, true);
				bindEvents(this);
			});
		},
		enable: function(jq){
			return jq.each(function(){
				setDisabled(this, false);
				bindEvents(this);
			});
		},
		readonly: function(jq, mode){
			return jq.each(function(){
				setReadonly(this, mode);
				bindEvents(this);
			});
		},
		validate: function(jq){
			return jq.each(function(){
				validate(this, true);
			});
		},
		isValid: function(jq){
			var input = $.data(jq[0], 'combo').combo.find('input.combo-text');
			return input.validatebox('isValid');
		},
		clear: function(jq){
			return jq.each(function(){
				clear(this);
			});
		},
		reset: function(jq){
			return jq.each(function(){
				var opts = $.data(this, 'combo').options;
				if (opts.multiple){
					$(this).combo('setValues', opts.originalValue);
				} else {
					$(this).combo('setValue', opts.originalValue);
				}
			});
		},
		getText: function(jq){
			return getText(jq[0]);
		},
		setText: function(jq, text){
			return jq.each(function(){
				setText(this, text);
			});
		},
		getValues: function(jq){
			return getValues(jq[0]);
		},
		setValues: function(jq, values){
			return jq.each(function(){
				setValues(this, values);
			});
		},
		getValue: function(jq){
			return getValue(jq[0]);
		},
		setValue: function(jq, value){
			return jq.each(function(){
				setValue(this, value);
			});
		}
	};
	
	$.fn.combo.parseOptions = function(target){
		var t = $(target);
		return $.extend({}, $.fn.validatebox.parseOptions(target), $.parser.parseOptions(target, [
			'width','height','separator',
			{panelWidth:'number',editable:'boolean',hasDownArrow:'boolean',delay:'number',selectOnNavigation:'boolean'}
		]), {
			panelHeight: (t.attr('panelHeight')=='auto' ? 'auto' : parseInt(t.attr('panelHeight')) || undefined),
			multiple: (t.attr('multiple') ? true : undefined),
			disabled: (t.attr('disabled') ? true : undefined),
			readonly: (t.attr('readonly') ? true : undefined),
			value: (t.val() || undefined)
		});
	};
	
	// Inherited from $.fn.validatebox.defaults
	$.fn.combo.defaults = $.extend({}, $.fn.validatebox.defaults, {
		width: 'auto',
		height: 22,
		panelWidth: null,
		panelHeight: 200,
		multiple: false,
		selectOnNavigation: true,
		separator: ',',
		editable: true,
		disabled: false,
		readonly: false,
		hasDownArrow: true,
		value: '',
		delay: 200,	// delay to do searching from the last key input event.
		deltaX: 19,
		
		keyHandler: {
			up: function(){},
			down: function(){},
			enter: function(){},
			query: function(q){}
		},
		
		onShowPanel: function(){},
		onHidePanel: null, //function(){}, fxq20150509取消默认函数，否则导致误判
		onChange: function(newValue, oldValue){}
	});
})(jQuery);

/**
 * combogrid - jQuery EasyUI
 * 
 * Copyright (c) 2009-2013 www.jeasyui.com. All rights reserved.
 *
 * Licensed under the GPL or commercial licenses
 * To use it on other terms please contact us: info@jeasyui.com
 * http://www.gnu.org/licenses/gpl.txt
 * http://www.jeasyui.com/license_commercial.php
 * 
 * Dependencies:
 *   combo
 *   datagrid
 * 
 */
(function($){
    //【hd-modi】BEGIN  validateInputValue
    /**
     * 在分页情况下，如果value对应的下拉项不在当前页，从后台调入该行，代码来自原$.hd.ezui.code.cCommon基类的 onHidePanel 方法
     * @param value 当前值，来自用户输入或程序赋值
     * @param isOnHidePanel 默认为undefined/false，只有在onHinePanel事件查找成功后，自动对value/text赋值，不成功则清理
     */
      function loadRowForValue(value,isOnHidePanel){
          var _this = $(this);     //这里this是combo框
          
          var opts = _this.combogrid('grid').datagrid("options");
          var valueField = _this.combogrid('options').idField;  //FXQ2013-10-23消除BUG
          var textField  = _this.combogrid('options').textField; 
          var params=$.extend(true,{},opts.queryParams);        //FXQ 2013-11-29防止对原有条件的影响
//          var andItems;   
//          try{
//              andItems= $.evalJSON(params.andItems);
//          }catch(e){     //fxq2013-11-14防范没有andItems的情况
//              andItems=[];
//          }
//
//          $.hd.search.addAndItem(params, andItems, valueField, value);  
          
        //update by huxj 2016-10-17 为了兼容idev7 去掉以上注释部分
          var bulider = new HdEzuiQueryParamsBuilder();
          bulider.setHdEzuiQueryParams($.extend(true, {}, params.queryParams));
          bulider.setAndClause(valueField, value, '=' , 'and');
          
          opts.method=opts.method||"get";
          if("get"==opts.method.toLowerCase()){
              var option={data:params,processData:true};
          }else{
              var option={data:$.toJSON(params),processData:false};
          }
          $.ajax({
              type: opts.method, 
              url: opts.url, 
              data: option.data, 
              dataType: "json",
              contentType: "application/json",
              processData: option.processData,    //对POST请求，body中应该是JSON串，而不是处理后的URL片段，见jQuery.ajax(url,[settings])说明文档
              success: function(data) {
            	  if($.isArray(data)){  //结果集只是数组，不是total/row格式
            		  var result={total:data.length,rows:data.concat()}
            		  data=result;      //转变为标准格式
            	  }
                  if(data.total <= 0){    //非法数据（后台也查不到）清空
                        if(isOnHidePanel){  //只有在onHidePanel事件中才需要校验
                            _this.combogrid('clear');
                        }
                  }else{                //合法数据，但不再当页，插入一行(以便不再显示代码。多的行不会产生影响，用户如果编辑过滤有得到原始数据）
                      var grid=_this.combogrid('grid');   //此时data有且只有1行
                      {
                            _this.combogrid('setValue', data.rows[0][valueField]); 
                            _this.combogrid('setText', data.rows[0][textField]); 
                      }
                      var dispRows=grid.datagrid('getRows');
                      var keys={}; 
                      keys[valueField]=data.rows[0][valueField];
                      
                      var findrow={};
	            		$.each(dispRows,function(i,row){
	            			var keyEquals=true;
	            			for (var key in keys) {
	            				if((keys[key]!==undefined || row[key]!==undefined)&&((keys[key]===null && row[key]===null) || keys[key]==row[key])){
	            					keyEquals=false; 
	            					break;
	            				}
	            			}
	            			if(keyEquals){    //每个KEY列相同，返回找到的行
	            				findrow=row;
	            				return false; //这个return只是跳出each循环
	            			}
	            		});
                      if($.isEmptyObject(findrow)){
                            grid.datagrid('appendRow',data.rows[0]);
                      }
                  }
              },
              error: function() {}
          });
	  }
		/**
		 * 检查下拉数据有效性，代码来自原$.hd.ezui.code.cCommon基类的 onHidePanel 方法
		 */
	  function validateInputValue(){     
		 var target=this; //本方法必须用call来调用，否则this不对 
         var isPaging=$(target).combogrid('options').pagination;

          //hcb 2013-10-08 分页的情况，后台校验
         var foundRow = $(target).combogrid('grid').datagrid('getSelections');  //得到当前值
         if (foundRow == null || foundRow.length == 0) {   //没有对应行
             var value = $(target).combogrid('getValue');  //编辑状态，取得的是编辑框内的数据
             if(!isPaging){
                 if(value !== ''){$(target).combogrid('clear');}
             }else{
                 if(value !== ''){
                 	 //loadRowForValue.call(target,value,true);
                 }
             }
         }
     };
     
 	//【hd-modi】END  validateInputValue
	
	/**
	 * create this component.
	 */
	function create(target){
		var state = $.data(target, 'combogrid');
		var opts = state.options;
		var grid = state.grid;
		
		$(target).addClass('combogrid-f').combo(opts);
		var panel = $(target).combo('panel');
		if (!grid){
			grid = $('<table></table>').appendTo(panel);
			state.grid = grid;
		}
		grid.datagrid($.extend({}, opts, {
			border: false,
			fit: true,
			singleSelect: (!opts.multiple),
			onLoadSuccess: function(data){
                            var values = $(target).combo('getValues');
                            // prevent from firing onSelect event.
                            var oldOnSelect = opts.onSelect;
                            opts.onSelect = function(){};
                            setValues(target, values, state.remainText);
                            opts.onSelect = oldOnSelect;
                            //【hd-modi】 begin 检查，如果当前值对应的行不在当前页，从数据库调取此行。
                             if(opts.pagination){    //分页情况才有此问题
                                    var value = $(target).combogrid('getValue');  //赋予的初始值，对应datagrid的 id field
                                    var accordingIndex = grid.datagrid('getRowIndex', value);   //combo当前值,对应combo的ID FIELD
                                    if (value && accordingIndex >= 0){  //有对应的行，value 为空也无需考虑
                                            //已有默认动作，此处不需代码
                                    }else{            		   //没有对应行
                                        //var cmbState=$.data(target, 'combo'); //判断haveQ的逻辑有问题
                                        //var haveQ=cmbState.previousValue && value && value==cmbState.previousValue ||false;
                                        var haveQ= value && value!=target.value ||false;
                                        if(value !== ''&& !haveQ){       //FXQ2015-7-1当前处在编辑状态，而不是从FORM中加载数据，此时没必要再补发请求
                                              //loadRowForValue.call(target,value,false);
                                         }
                                    }
                            }
                             //【hd-modi】 end 
                            opts.onLoadSuccess.apply(target, arguments);
			},
			onClickRow: onClickRow,
			onSelect: function(index, row){retrieveValues(); opts.onSelect.call(this, index, row);},
			onUnselect: function(index, row){retrieveValues(); opts.onUnselect.call(this, index, row);},
			onSelectAll: function(rows){retrieveValues(); opts.onSelectAll.call(this, rows);},
			onUnselectAll: function(rows){
				if (opts.multiple) retrieveValues(); 
				opts.onUnselectAll.call(this, rows);
			}
		}));
		
		function onClickRow(index, row){
			state.remainText = false;
			retrieveValues();
			if (!opts.multiple){
				$(target).combo('hidePanel');
			}
			opts.onClickRow.call(this, index, row);
		}
		
		/**
		 * retrieve values from datagrid panel.
		 */
		function retrieveValues(){
			var rows = grid.datagrid('getSelections');
			var vv = [],ss = [];
			for(var i=0; i<rows.length; i++){
				vv.push(rows[i][opts.idField]);
				ss.push(rows[i][opts.textField]);
			}
			if (!opts.multiple){
				$(target).combo('setValues', (vv.length ? vv : ['']));
			} else {
				$(target).combo('setValues', vv);
			}
//			$(target).combo('setValues', vv);
//			if (!vv.length && !opts.multiple){
//				$(target).combo('setValues', ['']);
//			}
			if (!state.remainText){
				$(target).combo('setText', ss.join(opts.separator));
			}
		}
	}
	
	function nav(target, dir){
		var state = $.data(target, 'combogrid');
		var opts = state.options;
		var grid = state.grid;
		var rowCount = grid.datagrid('getRows').length;
		if (!rowCount){return}
		
		var tr = opts.finder.getTr(grid[0], null, 'highlight');
		if (!tr.length){
			tr = opts.finder.getTr(grid[0], null, 'selected');;
		}
		var index;
		if (!tr.length){
			index = (dir == 'next' ? 0 : rowCount-1);
		} else {
			var index = parseInt(tr.attr('datagrid-row-index'));
			index += (dir == 'next' ? 1 : -1);
			if (index < 0) {index = rowCount - 1}
			if (index >= rowCount) {index = 0}
		}
		
		grid.datagrid('highlightRow', index);
		if (opts.selectOnNavigation){
			state.remainText = false;
			grid.datagrid('selectRow', index);
		}
	}
	
	/**
	 * set combogrid values
	 */
	function setValues(target, values, remainText){
		var state = $.data(target, 'combogrid');
		var opts = state.options;
		var grid = state.grid;
		var rows = grid.datagrid('getRows');
		var ss = [];
		
		var oldValues = $(target).combo('getValues');
		var cOpts = $(target).combo('options');
		var oldOnChange = cOpts.onChange;
		cOpts.onChange = function(){};	// prevent from triggering onChange event
		
		grid.datagrid('clearSelections');
		for(var i=0; i<values.length; i++){
			var index = grid.datagrid('getRowIndex', values[i]);
			if (index >= 0){
				grid.datagrid('selectRow', index);
				ss.push(rows[index][opts.textField]);
			} else {
				ss.push(values[i]);
			}
		}
		$(target).combo('setValues', oldValues);
		cOpts.onChange = oldOnChange;	// restore to trigger onChange event
		
		$(target).combo('setValues', values);
		if (!remainText){
			var s = ss.join(opts.separator);
			if ($(target).combo('getText') != s){
				$(target).combo('setText', s);
			}
		}
		
//		if ($(target).combo('getValues').join(',') == values.join(',')){
//			return;
//		}
//		$(target).combo('setValues', values);
//		if (!remainText){
//			$(target).combo('setText', ss.join(opts.separator));
//		}
	}
	
	/**
	 * do the query action
	 */
	function doQuery(target, q){
		var state = $.data(target, 'combogrid');
		var opts = state.options;
		var grid = state.grid;
		state.remainText = true;
		
		if (opts.multiple && !q){
			setValues(target, [], true);
		} else {
			setValues(target, [q], true);
		}
		
		if (opts.mode == 'remote'){
			grid.datagrid('clearSelections');
			grid.datagrid('load', $.extend({}, opts.queryParams, {q:q}));
		} else {
			if (!q) return;
			var rows = grid.datagrid('getRows');
			for(var i=0; i<rows.length; i++){
				if (opts.filter.call(target, q, rows[i])){
					grid.datagrid('clearSelections');
					grid.datagrid('selectRow', i);
					return;
				}
			}
		}
	}
	
	function doEnter(target){
		var state = $.data(target, 'combogrid');
		var opts = state.options;
		var grid = state.grid;
		var tr = opts.finder.getTr(grid[0], null, 'highlight');
		if (!tr.length){
			tr = opts.finder.getTr(grid[0], null, 'selected');
		}
		if (!tr.length){return}
		
		state.remainText = false;
		var index = parseInt(tr.attr('datagrid-row-index'));
		if (opts.multiple){
			if (tr.hasClass('datagrid-row-selected')){
				grid.datagrid('unselectRow', index);
			} else {
				grid.datagrid('selectRow', index);
			}
		} else {
			grid.datagrid('selectRow', index);
			$(target).combogrid('hidePanel');
		}
	}
	
	$.fn.combogrid = function(options, param){
		if (typeof options == 'string'){
			var method = $.fn.combogrid.methods[options];
			if (method){
				return method(this, param);
			} else {
				return $.fn.combo.methods[options](this, param);
			}
		}
		
		options = options || {};
		
		return this.each(function(){
			
			//【hd-modi】begin 插入 检查无效输入值的方法
			var validateInput=options.validateInput;
			// fxq 2014-9-24 由于combogrid可能被初始化两次（例如在js和html中又有class='combogrid'）因此以合并后的onHidePanel属性为准，而不是以options参数为准
			if(validateInput){
				options.onHidePanel=function(){
					var target=this;
					validateInputValue.call(target);     //combo的代码为： state.options.onHidePanel.call(target);
				};
			}else if(validateInput==undefined ){       //默认情况
				//需要在state被归并后执行
			}else{   //validateInput取值为FALSE
				//不需要额外动作，相当于 givenOptsFun.call(target);
			} 
			
			//【hd-modi】end 插入 检查无效输入值的方法			
			
			var state = $.data(this, 'combogrid');
			if (state){
				$.extend(state.options, options);
			} else {
				state = $.data(this, 'combogrid', {
					options: $.extend({}, $.fn.combogrid.defaults, $.fn.combogrid.parseOptions(this), options)
				});
			}

			//【hd-modi】begin 插入 检查无效输入值的方法
			if(validateInput==undefined ){       //默认情况
				var isDefinedOnHidePanelEvent=  state.options.onHidePanel && $.isFunction(state.options.onHidePanel);
				if (isDefinedOnHidePanelEvent){
					//不需要额外动作，相当于 givenOptsFun.call(target);
					lg("----- has defined event, do according things....");
				}else{
					state.options.onHidePanel=function(){
						var target=this;
						validateInputValue.call(target);  //用户没有定义onHidePanel时才校验
					};
				}
			} 
			
			//【hd-modi】end 插入 检查无效输入值的方法			
			create(this);
		});
	};
	
	$.fn.combogrid.methods = {
		options: function(jq){
			var copts = jq.combo('options');
			return $.extend($.data(jq[0], 'combogrid').options, {
				originalValue: copts.originalValue,
				disabled: copts.disabled,
				readonly: copts.readonly
			});
		},
		// get the datagrid object.
		grid: function(jq){
			return $.data(jq[0], 'combogrid').grid;
		},
		setValues: function(jq, values){
			return jq.each(function(){
				setValues(this, values);
			});
		},
		setValue: function(jq, value){
			return jq.each(function(){
				setValues(this, [value]);

				//【hd-modi】begin 针对form的loadData等情况，调入不存在的显示值。不能使用validateInput方法，否则在“过滤输入”方式会导致值被清空
				var target=this;
				var state = $.data(target, 'combogrid');
				var opts = state.options;
				var grid = state.grid;
				if(opts.pagination && value ){    //分页情况才有此问题, 如果value为空，也不予考虑
					var accordingIndex = grid.datagrid('getRowIndex', value);   //combo当前值,对应combo的ID FIELD
					if (accordingIndex >= 0){  //有对应的行
						//已有默认动作，此处不需代码
					}else{            		   //没有对应行
		                if(value !== ''){
		                	 //loadRowForValue.call(target,value,false);
		                 }
			        }
				}
				//【hd-modi】 end
			});
		},
		clear: function(jq){
			return jq.each(function(){
				$(this).combogrid('grid').datagrid('clearSelections');
				$(this).combo('clear');
			});
		},
		reset: function(jq){
			return jq.each(function(){
				var opts = $(this).combogrid('options');
				if (opts.multiple){
					$(this).combogrid('setValues', opts.originalValue);
				} else {
					$(this).combogrid('setValue', opts.originalValue);
				}
			});
		}
	};
	
	$.fn.combogrid.parseOptions = function(target){
		var t = $(target);
		return $.extend({}, $.fn.combo.parseOptions(target), $.fn.datagrid.parseOptions(target), 
				$.parser.parseOptions(target, ['idField','textField','mode']));
	};
	
	$.fn.combogrid.defaults = $.extend({}, $.fn.combo.defaults, $.fn.datagrid.defaults, {
		loadMsg: null,
		idField: null,
		textField: null,	// the text field to display.
		mode: 'local',		// or 'remote'
		
		validateInput:undefined,    //【hd-modi】新增加的属性，默认情况下可被调用方通过重写onHidePanel重写，如果为true则强制校验（不论是否有onHidePanel回调函数）
		missingMessage: '该输入项为必输项',  //【hd-modi】easyui-lang-zh_CN.js中的汉字被替换成英文了？
		pagination:false,   //【hd-modi】排除plugin/js/config.js重定义$.fn.datagrid.defaults.pagination的干扰
		
		keyHandler: {
			up: function(){nav(this, 'prev');},
			down: function(){nav(this, 'next');},
			enter: function(){doEnter(this);},
			query: function(q){doQuery(this, q);}
		},
		filter: function(q, row){
			var opts = $(this).combogrid('options');
			return row[opts.textField].indexOf(q) == 0;
		}
	});
})(jQuery);