(function($){
	$.extend($.fn.datagrid.defaults, {
		onBeforeDrag: function(row){},	
		onStartDrag: function(row){},
		onStopDrag: function(row){},
		onDragEnter: function(targetRow, sourceRow){},	
		onDragOver: function(targetRow, sourceRow){},	
		onDragLeave: function(targetRow, sourceRow){},
		onBeforeDrop: function(targetRow, sourceRow, point){},
		onDrop: function(targetRow, sourceRow, point){},	
	});
	
	var enable=true;
	$.extend($.fn.datagrid.methods, {
		enableDnd: function(jq, index){
			return jq.each(function(){
				var target = this;
				var state = $.data(this, 'datagrid');
				state.disabledRows = [];
				var dg = $(this);
				var opts = state.options;
				if (index != undefined){
					var trs = opts.finder.getTr(this, index);
				} else {
					var trs = opts.finder.getTr(this, 0, 'allbody');
				}
				trs.draggable({
					disabled: false,
					revert: true,
					cursor: 'pointer',
					proxy: function(source) {
						var index = $(source).attr('datagrid-row-index');
						var tr1 = opts.finder.getTr(target, index, 'body', 1);
						var tr2 = opts.finder.getTr(target, index, 'body', 2);
						var p = $('<div style="z-index:9999999999999"></div>').appendTo('body');
						tr2.clone().removeAttr('id').removeClass('droppable').appendTo(p);
						tr1.clone().removeAttr('id').removeClass('droppable').find('td').insertBefore(p.find('td:first'));
						$('<td><span class="tree-dnd-icon tree-dnd-no" style="position:static">&nbsp;</span></td>').insertBefore(p.find('td:first'));
						p.find('td').css('vertical-align','middle');
						p.hide();
						return p;
					},
					deltaX: 15,
					deltaY: 15,
					onBeforeDrag:function(e){
						if (opts.onBeforeDrag.call(target, getRow(this)) == false){return false;}
						if ($(e.target).parent().hasClass('datagrid-cell-check')){return false;}
						if (e.which != 1){return false;}
						opts.finder.getTr(target, $(this).attr('datagrid-row-index')).droppable({accept:'no-accept'});
					},
					onStartDrag: function() {
						$(this).draggable('proxy').css({
							left: -10000,
							top: -10000
						});
						var row = getRow(this);
						opts.onStartDrag.call(target, row);
						state.draggingRow = row;
					},
					onDrag: function(e) {
						var x1=e.pageX,y1=e.pageY,x2=e.data.startX,y2=e.data.startY;
						var d = Math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
						if (d>3){	// when drag a little distance, show the proxy object
							$(this).draggable('proxy').show();
							var tr = opts.finder.getTr(target, parseInt($(this).attr('datagrid-row-index')), 'body');
							$.extend(e.data, {
								startX: tr.offset().left,
								startY: tr.offset().top,
								offsetWidth: 0,
								offsetHeight: 0
							});
						}
						this.pageY = e.pageY;
					},
					onStopDrag:function(){
						for(var i=0; i<state.disabledRows.length; i++){
							var index = dg.datagrid('getRowIndex', state.disabledRows[i]);
							if (index >= 0){
								opts.finder.getTr(target, index).droppable('enable');
							}
						}
						state.disabledRows = [];
						var index = dg.datagrid('getRowIndex', state.draggingRow);
						dg.datagrid('enableDnd', index);
						opts.onStopDrag.call(target, state.draggingRow);
					}
				}).droppable({
					accept: 'tr.datagrid-row',
					onDragEnter: function(e, source){
						if (opts.onDragEnter.call(target, getRow(this), getRow(source)) == false){
							allowDrop(source, false);
							var tr = opts.finder.getTr(target, $(this).attr('datagrid-row-index'));
							tr.find('td').css('border', '');
							tr.droppable('disable');
							state.disabledRows.push(getRow(this));
						}
					},
					onDragOver: function(e, source) {
						var targetRow = getRow(this);
						if ($.inArray(targetRow, state.disabledRows) >= 0){return;}
						var pageY = source.pageY;
						var top = $(this).offset().top;
						var bottom = top + $(this).outerHeight();
						
						allowDrop(source, true);
						var tr = opts.finder.getTr(target, $(this).attr('datagrid-row-index'));
						tr.children('td').css('border','');
						if (pageY > top + (bottom - top) / 2) {
							tr.children('td').css('border-bottom','1px solid red');
						} else {
							tr.children('td').css('border-top','1px solid red');
						}
						
						if (opts.onDragOver.call(target, targetRow, getRow(source)) == false){
							allowDrop(source, false);
							tr.find('td').css('border', '');
							tr.droppable('disable');
							state.disabledRows.push(targetRow);
						}
					},
					onDragLeave: function(e, source) {
						allowDrop(source, false); 
						var tr = opts.finder.getTr(target, $(this).attr('datagrid-row-index'));
						tr.children('td').css('border','');
						opts.onDragLeave.call(target, getRow(this), getRow(source));
					},
					onDrop: function(e, source) {
						var sourceIndex = parseInt($(source).attr('datagrid-row-index'));
						var destIndex = parseInt($(this).attr('datagrid-row-index'));
						
						var tr = opts.finder.getTr(target, $(this).attr('datagrid-row-index'));
						var td = tr.children('td');
						var point =  parseInt(td.css('border-top-width')) ? 'top' : 'bottom';
						td.css('border','');
						
						var rows = dg.datagrid('getRows');
						var dRow = rows[destIndex];
						var sRow = rows[sourceIndex];
						if (opts.onBeforeDrop.call(target, dRow, sRow, point) == false){
							return;
						}
						insert();
						opts.onDrop.call(target, dRow, sRow, point);
						
						function insert(){
							var row = $(target).datagrid('getRows')[sourceIndex];
							var index = 0;
							var endindex;
							console.log("sourceIndex : ");
							console.log(sourceIndex);
							console.log("destIndex : ");
							console.log(destIndex);
							if (point == 'top'){
								index = destIndex;
							} else {
								index = destIndex+1;
							}
							console.log("index : ");
							console.log(index);
							var changeRows=[];
							if (index < sourceIndex){
								if(point == 'top'){
									for(var i=destIndex;i<=sourceIndex;i++){
										changeRows.push($(target).datagrid('getRows')[i]);
										}
								}else{
									for(var i=destIndex+1;i<=sourceIndex;i++){
										changeRows.push($(target).datagrid('getRows')[i]);
										}
								}
								dg.datagrid('insertRow', {
									index: index,
									row: row
								})
								dg.datagrid('deleteRow', sourceIndex+1);
								dg.datagrid('enableDnd', index);
							} else {
								if(point == 'top'){
									for(var i=sourceIndex;i<destIndex;i++){
										changeRows.push($(target).datagrid('getRows')[i]);
									}
								}else{
									for(var i=sourceIndex;i<index;i++){
										changeRows.push($(target).datagrid('getRows')[i]);
									}
								}
								dg.datagrid('insertRow', {
									index: index,
									row: row
								})
								dg.datagrid('deleteRow', sourceIndex);
								
								dg.datagrid('enableDnd', index-1);
							}
							if(changeRows.length>1){
								if(sourceIndex < destIndex){
									var Sorter=changeRows[changeRows.length-1].sorter;
									for(var i=changeRows.length-1;i>0;i--){
										changeRows[i].sorter=changeRows[i-1].sorter
									}
									changeRows[0].sorter=Sorter;
								}else{
									var Sorter=changeRows[0].sorter;
									for(var i=0;i<changeRows.length-1;i++){
										changeRows[i].sorter=changeRows[i+1].sorter
									}
									changeRows[changeRows.length-1].sorter=Sorter;
								}
								var dataJason = {deletedRows: [], insertedRows: [], updatedRows: changeRows};
								//dg.datagrid("hdSave",{url : "../webresources/login/DocumentData/save"});
								$.ajax({
				                    type: "POST",
				                    url: "../webresources/login/DocumentData/save",
				                    contentType: "application/json",
				                    dataType: "json",
				                    data: $.toJSON(dataJason),
				                    success: function (data) {
				                        var message = data.message;
				                        if (message == "保存成功。") {
				                        	HdUtils.messager.bottomRight('保存成功','保存操作');
				                            HdUtils.dialog.close();
				                            //dg.datagrid("hdReload");
				                        } else {
				                            HdUtils.messager.showDetailMessage(data.detail,null,3000,null,300,400);
				                        }
				                    },
				                    error: function (data) {
				                        HdUtils.messager.info(data.responseText);
				                    }
				                });
							}
						}
					}
				});
				
				function allowDrop(source, allowed){
					var icon = $(source).draggable('proxy').find('span.tree-dnd-icon');
					icon.removeClass('tree-dnd-yes tree-dnd-no').addClass(allowed ? 'tree-dnd-yes' : 'tree-dnd-no');
				}
				function getRow(tr){
					return opts.finder.getRow(target, $(tr));
				}
			});
		}
		
	},{
		disableDnd:function(jq, index){
			return jq.each(function(){
				var target = this;
				var state = $.data(this, 'datagrid');
				state.disabledRows = [];
				var dg = $(this);
				var opts = state.options;
				if (index != undefined){
					var trs = opts.finder.getTr(this, index);
				} else {
					var trs = opts.finder.getTr(this, 0, 'allbody');
				}
				trs.draggable({
					disabled: true,
					revert: true,
					cursor: 'pointer'
				});
			});
		}
	});
})(jQuery);
