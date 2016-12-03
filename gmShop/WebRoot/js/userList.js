$(function() {	
	//定义下拉框的值
	var Sexoptions=[
	          {value:'男',text:'男'},
	          {value:'女',text:'女'}
	             ]
	
	//定义操作对象和方法
	obj = {
			editRow : undefined,//判断是否是可编辑状态
			search : function() {// 查询功能
				var username= $.trim($('input[name="username"]').val());
				var name = $.trim($('input[name="name"]').val());
				var gender= $.trim($('select[name="gender"]').val());				
				$('#userList').datagrid('load', {
					username: username,
					name : name,
					gender : gender,
				});
			},
			add : function() {// 添加功能
			$('#save,#redo').show();
			if(this.editRow==undefined){
				//添加一行 
				$('#userList').datagrid('insertRow', {
					index : 0,
					row:{},
				})
			//将第一行设置为可编辑状态
			$('#userList').datagrid('beginEdit', 0);	
			this.editRow = 0;
			}
			},
			edit:function(){//点击进行修改
			var rows = $('#userList').datagrid('getSelections');//获取选中的个数
			if(rows.length==1){
				
				if(this.editRow!=undefined){
					//可编辑状态，执行保存编辑操作
					$('#userList').datagrid('endEdit', this.editRow);
				}
				if (this.editRow == undefined) {
					//不可编辑，则打让选中行变为可执行状态
					var index = $('#userList').datagrid('getRowIndex', rows[0]);//编辑的哪一行
					$('#save,#redo').show();
					$('#userList').datagrid('beginEdit', index);//开始编辑
					//alert($("table tr").eq(index).children("td").eq(1).text())
					this.editRow = index;//编辑状态为可编辑
					$('#userList').datagrid('unselectRow', index);//取消指定选择的行。
				}	
			} else {
				$.messager.alert('警告', '修改只能选择一行！', 'warning');
			}
			},
			del:function(){//点击进行删除
				var rows = $('#userList').datagrid('getSelections');//获取选中的个数
				if (rows.length > 0) {
					$.messager.confirm('确定操作', '您确定要删除所选的信息吗？', function (flag) {
						if (flag) {
							var ids = [];
							for (var i = 0; i < rows.length; i ++) {
								ids.push(rows[i].uid);
							}							
							$.ajax({
								type : 'POST',
								url : 'uManage_delSome.action',
								data : {
									ids : ids.join(','),
								},
								beforeSend : function () {
									$('#userList').datagrid('loading');
								},
								success : function (data) {
									if (data) {
										$('#userList').datagrid('loaded');//隐藏载入状态
										$('#userList').datagrid('load');//刷新当前页
										$('#userList').datagrid('unselectAll');
										 if(data=='err'){
											$.messager.alert('错误', '操作失败！该用户还有订单未完成，不能删除！！！', 'error');				
										}else{
										
											$.messager.show({
												title : '提示',
												msg : data + '个用户信息删除成功！',
											});
										}
										
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
				$('#userList').datagrid('endEdit', this.editRow);
			},
			redo : function () {//取消当前的编辑
				$('#save,#redo').hide();
				this.editRow = undefined;//变为不可编辑
				$('#userList').datagrid('rejectChanges');//撤销修改
			},	
			}
	$('#userList').datagrid({
						url : 'uManage_findAll.action',
						title : '用户列表',
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
						toolbar : '#user_tool',						
						columns : [ [
						         {
									field : 'uid',
			                        checkbox : true,			                       		                      
								},     
								{
									field : 'username',
									title : '登录账号',
									align : 'center',
									sortable : true,
									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
											required : true,
											validType:'length[2,20]', 
										},
									},                            
								},
								{
									field : 'password',
									title : '密码',
									align : 'center',				
									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
											required : true,
											validType:'length[2,20]', 
										},
									},                              
								},
								{
									field : 'name',
									title : '用户姓名',
									align : 'center',
									sortable : true,
									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
											required : true,
											validType:'length[2,6]', 
										},
									},
								},								
								{
									field : 'email',
									title : '邮箱',
									align : 'center',
									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
									
											validType : 'email',
										},
									},
								},
								{
									field : 'phone',
									title : '手机电话',
									align : 'center',

									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
		
											validType:'length[2,11]', 
										},
									},
								},
								{
									field : 'addr',
									title : '地址',
									align : 'center',
									width:'12%',
									editor : {
										type:'text'
									},
								},
								{
									field : 'gender',
									title : '性别',
									align : 'center',
									sortable : true,
									width:'12%',	
									editor : {
										type:'combobox',
										options:{valueField:'value',textField:'text',data:Sexoptions},
										
									},
									
								},	
							
						] ],
						//双击进行修改
						onDblClickRow : function (rowIndex, rowData){
							if (obj.editRow != undefined) {
								$('#userList').datagrid('endEdit', obj.editRow);
							}
							if(obj.editRow==undefined){
								$('#save,#redo').show();
								$('#userList').datagrid('beginEdit', rowIndex);
								obj.editRow = rowIndex;
							}
						},
						//在用户完成编辑一行的时候触发
						onAfterEdit : function (rowIndex, rowData, changes) {							
							$('#save,#redo').hide();
							obj.editRow = undefined;
							var inserted = $('#userList').datagrid('getChanges', 'inserted');
							var updated = $('#userList').datagrid('getChanges', 'updated');							
							var method = info =  '';							
							//新增用户
							if (inserted.length > 0) {
								method='add';
								info = '新增';
							}							
							//修改用户
							if (updated.length > 0) {
								method='edit';
								info = '修改';
							}
						
						if(method!=''){
							$.ajax({
								type : 'POST',
								url : 'uManage_'+method+'.action',							
								data : {
									uid:rowData.uid,
									username:rowData.username,
									password:rowData.password,
									name:rowData.name,
									gender:rowData.gender,
									email:rowData.email,
									phone:rowData.phone,
									addr:rowData.addr,
									gender:rowData.gender,
									nYear:rowData.nYear,
								},
								beforeSend : function () {
									
									$('#userList').datagrid('loading');
								},
								success : function (data) {
									$('#userList').datagrid('loaded');
									$('#userList').datagrid('load');
									$('#userList').datagrid('unselectAll');
									if(data=='error'){
									
										$.messager.alert('错误', '操作失败！用户名已经存在', 'error');				
										obj.editRow = undefined;
									}
									else{
																
										$.messager.show({
											title : '提示',
											msg : data + '个用户信息' + info + '成功！',
										});
										obj.editRow = undefined;
									}
								},
							});
						}		
						},
					})  
			
})
