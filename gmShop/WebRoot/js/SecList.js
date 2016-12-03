$(function() {	
	//下拉列表点击时获取一级菜单的名字
	$('#cname').combobox({
		url : 'firManage_findAllName.action',
		 valueField:'cid',   
		 textField:'cname' 
	})

/*	$('#cname').click(function(){
		
		$.ajax({
			method:'post',
			url : 'firManage_findAllName.action',
			success:function (data) {
				$('#cname').html('<option value="">请选择</option>')
				for (var i = 0; i < data.length; i++) {
					//$('#cname').append("<option value="+data[i].cid+">"+data[i].cname+"</option>")
				$("<option value="+data[i].cid+">"+data[i].cname+"</option>").appendTo($('#cname'))
				}
			},
		})
	})*/
	
	//定义操作对象和方法
	obj3 = {
		editRow : undefined,//判断是否是可编辑状态
			search : function() {// 查询功能
				//得到下拉框选中的value值
				var cid= $.trim($('#cname').combobox('getValue'));
				var csname=$.trim($('input[name="csname"]').val())
				
				$('#SecList').datagrid('load', {
					cid: cid,
					csname:csname
				});
			},
			add : function() {// 添加功能
				if ($('#tabs').tabs('exists','二级菜单添加')) {
		            $('#tabs').tabs('close','二级菜单添加');
		        }
				$('#addWin').window({
					width : 608,
					height : 'auto',
					modal : true,
					collapsible : false,
					 iconCls: 'icon-SecAdd',
					minimizable : false,
					title:'添加二级菜单',
					href:'manager/SecAdd.jsp',
					//窗口打开时
				/*	onOpen:function(){
						$('#cid').combobox({
							url : 'firManage_findAllName.action',
							 valueField:'cid',   
							 textField:'cname' ,
							 editable: false,//不可编辑		 
						})
					},*/
					//关闭时触发
					onClose:function(){
						//刷新当前数据
						$('#SecList').datagrid('reload')
					}
					});
				
			
			},
			edit:function(){//点击进行修改
				var rows = $('#SecList').datagrid('getSelections');//获取选中的个数
			
				if(rows.length==1){
					
					if(this.editRow!=undefined){
						//可编辑状态，执行保存编辑操作
						$('#SecList').datagrid('endEdit', this.editRow);
					}
					if (this.editRow == undefined) {
						//不可编辑，则打让选中行变为可执行状态
						var index = $('#SecList').datagrid('getRowIndex', rows[0]);//编辑的哪一行
						$('#save,#redo').show();
						$('#SecList').datagrid('beginEdit', index);//开始编辑
						//alert($("table tr").eq(index).children("td").eq(1).text())
						this.editRow = index;//编辑状态为可编辑
						$('#SecList').datagrid('unselectRow', index);//取消指定选择的行。
					}	
				} else {
					$.messager.alert('警告', '修改必须选择一行！', 'warning');
				}
			},
			del:function(){//点击进行删除
				var rows = $('#SecList').datagrid('getSelections');//获取选中的个数
				if (rows.length > 0) {
					$.messager.confirm('确定操作', '您确定要删除所选的信息吗？', function (flag) {
						if (flag) {
							var ids = [];
							for (var i = 0; i < rows.length; i ++) {
								ids.push(rows[i].csid);
							}							
							$.ajax({
								type : 'POST',
								url : 'secManage_delSome.action',
								data : {
									ids : ids.join(','),
								},
								beforeSend : function () {
									$('#SecList').datagrid('loading');
								},
								success : function (data) {
									if (data) {
										$('#SecList').datagrid('loaded');//隐藏载入状态
										$('#SecList').datagrid('load');//刷新当前页
										$('#SecList').datagrid('unselectAll');
										$.messager.show({
											title : '提示',
											msg : data + '个二级菜单删除成功！',
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
					$('#SecList').datagrid('endEdit', this.editRow);
				},
				redo : function () {//取消当前的编辑
					$('#save,#redo').hide();
					this.editRow = undefined;//变为不可编辑
					$('#SecList').datagrid('rejectChanges');//撤销修改
				},	
			}
	$('#SecList').datagrid({
						url : 'secManage_findAll.action',
						title : '二级菜单列表',
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
						checkOnSelect : false,//checkOnSelect如果为true,当用户点击行的时候该复选框就会被选中或取消选中。
						//如果为false,当用户仅在点击该复选框的时候才会呗选中或取消
						pageSize : 10,
						pageList : [ 5, 10, 15, 20, 25],
						pageNumber : 1,
						toolbar : '#sec_tool',						
						columns : [ [
						         {
									field : 'csid',
			                        checkbox : true,			                       		                      
								},     
								{
									field : 'csname',
									title : '二级菜单',
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
								{
									field : 'cid',
									title : '所属的一级菜单',
									align : 'center',
									sortable : true,
									width:'20%',
									editor : {
										type:'combobox',/*一级下拉菜单*/
										options:{
											 
											valueField:'cname',
											textField:'cname',
											 url:'firManage_findAllName.action', 
											 required: true ,  
	                                          editable:false 
											},
										
									},                          
								},
							
						] ],
						//双击进行修改
						onDblClickRow : function (rowIndex, rowData){
							if (obj3.editRow != undefined) {
								$('#SecList').datagrid('endEdit', obj3.editRow);
							}
							if(obj3.editRow==undefined){
								$('#save,#redo').show();
								$('#SecList').datagrid('beginEdit', rowIndex);
								obj3.editRow = rowIndex;
							}
						},
						//在用户完成编辑一行的时候触发
						onAfterEdit : function (rowIndex, rowData, changes) {							
							$('#save,#redo').hide();
							obj3.editRow = undefined;
							//修改用户
							var updated = $('#SecList').datagrid('getChanges', 'updated');							
				
						if(updated!=''){
								
							$.ajax({
								type : 'POST',
								url : 'secManage_update.action',							
								data : {
									csid:rowData.csid,
									csname:rowData.csname,
									cname:rowData.cid,					
								},
								beforeSend : function () {
									
									$('#SecList').datagrid('loading');
								},
								success : function (data) {
									$('#SecList').datagrid('loaded');
									$('#SecList').datagrid('load');
									$('#SecList').datagrid('unselectAll');
									if(data=='error'){								
										$.messager.alert('错误', '操作失败！二级菜单名字已经存在', 'error');				
										obj.editRow = undefined;
									}else{
										$.messager.show({
											title : '提示',
											msg : data + '个二级列表更新成功！',
										});
									}
								
									obj3.editRow = undefined;
								},
							});
						}		
						},
					})  
			
})
