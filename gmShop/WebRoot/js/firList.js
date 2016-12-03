$(function() {	

	
	//定义操作对象和方法
	obj2 = {
			editRow : undefined,//判断是否是可编辑状态
			search : function() {// 查询功能
				var cname= $.trim($('input[name="cname"]').val());
			
				$('#firList').datagrid('load', {
					cname: cname,
				});
			},
			add : function() {// 添加功能
			$('#save,#redo').show();
			if(this.editRow==undefined){
				//添加一行 
				$('#firList').datagrid('insertRow', {
					index : 0,
					row:{},
				})
			//将第一行设置为可编辑状态
			$('#firList').datagrid('beginEdit', 0);	
			this.editRow = 0;
			}
			},
			edit:function(){//点击进行修改
			var rows = $('#firList').datagrid('getSelections');//获取选中的个数
			if(rows.length==1){
				
				if(this.editRow!=undefined){
					//可编辑状态，执行保存编辑操作
					$('#firList').datagrid('endEdit', this.editRow);
				}
				if (this.editRow == undefined) {
					//不可编辑，则打让选中行变为可执行状态
					var index = $('#firList').datagrid('getRowIndex', rows[0]);//编辑的哪一行
					$('#save,#redo').show();
					$('#firList').datagrid('beginEdit', index);//开始编辑
					//alert($("table tr").eq(index).children("td").eq(1).text())
					this.editRow = index;//编辑状态为可编辑
					$('#firList').datagrid('unselectRow', index);//取消指定选择的行。
				}	
			} else {
				$.messager.alert('警告', '修改只能选择一行！', 'warning');
			}
			},
			del:function(){//点击进行删除
				var rows = $('#firList').datagrid('getSelections');//获取选中的个数
				if (rows.length > 0) {
					$.messager.confirm('确定操作', '您确定要删除所选的信息吗？', function (flag) {
						if (flag) {
							var ids = [];
							for (var i = 0; i < rows.length; i ++) {
								ids.push(rows[i].cid);
							}							
							$.ajax({
								type : 'POST',
								url : 'firManage_delSome.action',
								data : {
									ids : ids.join(','),
								},
								beforeSend : function () {
									$('#firList').datagrid('loading');
								},
								success : function (data) {
									if (data) {
										$('#firList').datagrid('loaded');//隐藏载入状态
										$('#firList').datagrid('load');//刷新当前页
										$('#firList').datagrid('unselectAll');
										$.messager.show({
											title : '提示',
											msg : data + '个菜单信息删除成功！',
										});
									}
								},
							});		
						}
					});
				} else {
					$.messager.alert('提示', '请选择要删除的信息！', 'info');
				}
				},
			save : function () {	//保存修改信息		
				//将第一行设置为结束编辑状态
				$('#firList').datagrid('endEdit', this.editRow);
			},
			redo : function () {//取消当前的编辑
				$('#save,#redo').hide();
				this.editRow = undefined;//变为不可编辑
				$('#firList').datagrid('rejectChanges');//撤销修改
			},	
			}
	$('#firList').datagrid({
						url : 'firManage_findAll.action',
						title : '一级菜单列表',
						iconCls : 'icon-search',	
						fit : true,// 充满整个父容器			
						fitColumns : true,// 列宽自适应
						striped : true,// 是否显示斑马线效果
						rownumbers : true,// 是否显示行号
						// singleSelect:true,//只能选择一行
						loadMsg:'数据加载中,请稍后...',
						border : false,
						pagination : true,// 是否显示分页
						nowrap : false,// 每列是否不换行
						checkOnSelect : false,//checkOnSelect如果为true,当一级菜单点击行的时候该复选框就会被选中或取消选中。
						//如果为false,当一级菜单仅在点击该复选框的时候才会呗选中或取消
						pageSize : 10,
						pageList : [ 5, 10, 15, 20, 25],
						pageNumber : 1,
						toolbar : '#fir_tool',						
						columns : [ [
						         {
									field : 'cid',
			                        checkbox : true,			                       		                      
								},     
								{
									field : 'cname',
									title : '一级菜单',
									align : 'center',
									sortable : true,
									width:'20%',
									editor : {
										type : 'validatebox',
										options : {
											required : true,
										},
									},                              
								},
								
							
						] ],
						//双击进行修改
						onDblClickRow : function (rowIndex, rowData){
							if (obj2.editRow != undefined) {
								$('#firList').datagrid('endEdit', obj2.editRow);
							}
							if(obj2.editRow==undefined){
								$('#save,#redo').show();
								$('#firList').datagrid('beginEdit', rowIndex);
								obj2.editRow = rowIndex;
							}
						},
						//在一级菜单完成编辑一行的时候触发
						onAfterEdit : function (rowIndex, rowData, changes) {							
							$('#save,#redo').hide();
							obj2.editRow = undefined;
							var inserted = $('#firList').datagrid('getChanges', 'inserted');
							var updated = $('#firList').datagrid('getChanges', 'updated');							
							var method = info =  '';							
							//新增一级菜单
							if (inserted.length > 0) {
								method='add';
								info = '新增';
							}							
							//修改一级菜单
							if (updated.length > 0) {
								method='edit';
								info = '修改';
							}
						
						if(method!=''){
							$.ajax({
								type : 'POST',
								url : 'firManage_'+method+'.action',							
								data : {
									cid:rowData.cid,
									cname:rowData.cname,

								},
								beforeSend : function () {
									
									$('#firList').datagrid('loading');
								},
								success : function (data) {
								
									if(data=='error'){
										$('#firList').datagrid('loaded');
										$('#firList').datagrid('load');
										$('#firList').datagrid('unselectAll');
										$.messager.alert('错误', '操作失败！一级菜单名字已经存在！！！', 'error');				
										obj2.editRow = undefined;
									}else{
										$('#firList').datagrid('loaded');
										$('#firList').datagrid('load');
										$('#firList').datagrid('unselectAll');
										
										$.messager.show({
											title : '提示',
											msg : data + '个一级菜单信息' + info + '成功！',
										});
										obj2.editRow = undefined;
									}
								},
							});
						}		
						},
					})  
			
})
