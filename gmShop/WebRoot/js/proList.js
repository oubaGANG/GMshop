//打开编辑窗口
function showEdit(pid){
	$('#addWin').window({
		width : 620,
		height : 'auto',
		modal : true,
		collapsible : false,
		 iconCls: 'icon-proEdit',
		minimizable : false,
		title:'修改商品',
		href:'proManage_findById.action?pid='+pid,		
		//关闭时触发
		onClose:function(){
			//刷新当前数据
			$('#proList').datagrid('reload')
		//刷新更改的那一行的数据
		//$('#proList').datagrid('refreshRow',pid-1)
		}
		});
}

$(function() {	
	//下拉列表点击时获取一级菜单的名字
	$('#cname2').combobox({
		url : 'firManage_findAllName.action',
		 valueField:'cid',   
		 textField:'cname',
		/* 当一级菜单选择后，重新加载商品*/
		 onSelect: function(rec) {
			 $('#csname2').combobox('clear');
			 var url = 'secManage_findAllName.action?cid='+rec.cid;
			 $('#csname2').combobox('reload', url);
		 }
	})
	//二级菜单
	$('#csname2').combobox({
		url : 'secManage_findAllName.action',
		 valueField:'csid',   
		 textField:'csname',
	})

	
	//定义操作对象和方法
	obj4 = {
		editRow : undefined,//判断是否是可编辑状态
			search : function() {// 查询功能
				//得到下拉框选中的value值
				var cid= $.trim($('#cname2').combobox('getValue'));
				var csid= $.trim($('#csname2').combobox('getValue'));
				var pname = $.trim($('input[name="pname"]').val());
				$('#proList').datagrid('load', {
					cid: cid,
					csid:csid,
					pname:pname
				});
			},
			add : function() {// 添加功能
				if ($('#tabs').tabs('exists','新增商品')) {
		            $('#tabs').tabs('close','新增商品');
		        }
				$('#addWin').window({
					width : 620,
					height : 'auto',
					modal : true,
					collapsible : false,
					 iconCls: 'icon-proAdd',
					minimizable : false,
					title:'添加商品',
					href:'manager/proAdd.jsp',		
					//关闭时触发
					onClose:function(){
						//刷新当前数据
						$('#proList').datagrid('reload')
					}
					});
				
			
			},
			edit:function(){//点击进行修改
				
				var rows = $('#proList').datagrid('getSelections');//获取选中的个数
				var rowIndex=$('#proList').datagrid('getRowIndex',rows[0]);//获取选区de第几行
				 //如果pid没有赋值
				
					var pid=rows[0].pid//获取选中的pid
				 
		
				if(rows.length==1){
					
					showEdit(pid)
					
				} else {
					$.messager.alert('警告', '修改必须选择一行！', 'warning');
				}
			},
			del:function(){//点击进行删除
				var rows = $('#proList').datagrid('getSelections');//获取选中的个数
				if (rows.length > 0) {
					$.messager.confirm('确定操作', '您确定要删除所选的信息吗？', function (flag) {
						if (flag) {
							var ids = [];
							for (var i = 0; i < rows.length; i ++) {
								ids.push(rows[i].pid);
							}							
							$.ajax({
								type : 'POST',
								url : 'proManage_delSome.action',
								data : {
									ids : ids.join(','),
								},
								beforeSend : function () {
									$('#proList').datagrid('loading');
								},
								success : function (data) {
									if (data) {
										$('#proList').datagrid('loaded');//隐藏载入状态
										$('#proList').datagrid('load');//刷新当前页
										$('#proList').datagrid('unselectAll');
										$.messager.show({
											title : '提示',
											msg : data + '个商品删除成功！',
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
				
			}
	$('#proList').datagrid({
						url : 'proManage_findAll.action',
						title : '商品列表',
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
						pageSize : 5,
						pageList : [ 5, 10, 15, 20, 25],
						pageNumber : 1,
						toolbar : '#pro_tool',						
						columns : [ [
						         {
									field : 'pid',
			                        checkbox : true,			                       		                      
								},     
								{
									field : 'pname',
									title : '商品名称',
									align : 'center',
									sortable : true,
									width:'13%',
									formatter : function(value, row, index) {										
										return "<a href='javascript:void(0)' onclick='showEdit("
												+ row.pid
												+ ")' style='color: blue;cursor: pointer'>"+value+"</a>";
									},                       
								},
								{
									field : 'price',
									title : '商品价格',
									align : 'center',
									sortable : true,
									width:'13%',
							                          
								},
								{
									field : 'image',
									title : '图片',
									align : 'center',
									width:'16%',
									formatter : function(value, row, index) {									
										return "<img src="+value+" style='width:80%;padding:10px 0'>";
									},                  
								},
								{
									field : 'pdesc',
									title : '商品描述',
									align : 'center',
									width:'13%',
							                          
								},
								{
									field : 'count',
									title : '商品库存',
									align : 'center',
									width:'13%',
							                          
								},
								{
									field : 'isHot',
									title : '是否热门',
									align : 'center',
									sortable : true,
									width:'13%',
									formatter : function(value, row, index) {	
										if(value==1){
											return "热门";
										}else{
											return "no";
										}
										
									},                 
								},
								{
									field : 'pdate',
									title : '出厂日期',
									align : 'center',
									sortable : true,
									width:'13%',
								                
								},
								
						] ],
				
					})  
			
})
