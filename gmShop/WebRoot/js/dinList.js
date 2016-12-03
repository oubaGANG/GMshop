	//点击更改订单状态
	function sendGoods(oid){
		$.ajax({
			method:'post',
			url : 'dinManage_sendGoods.action',
			data:{
				oid:oid
			},
			success:function (data) {
				$.messager.show({
					title : '提示',
					msg : "发货成功！！！",				
				});
				//刷新当前数据
				$('#dinList').datagrid('reload')
			},
		})
	}
	
$(function() {	
	//转换成时间
/*	function formattime(val) { 
	    var year=parseInt(val.year)+1900;  
	    var month=(parseInt(val.month)+1);  
	    month=month>9?month:('0'+month);  
	    var date=parseInt(val.date);  
	    date=date>9?date:('0'+date);  
	    var hours=parseInt(val.hours);  
	    hours=hours>9?hours:('0'+hours);  
	    var minutes=parseInt(val.minutes);  
	    minutes=minutes>9?minutes:('0'+minutes);  
	    var seconds=parseInt(val.seconds);  
	    seconds=seconds>9?seconds:('0'+seconds);  
	    var time=year+'-'+month+'-'+date+' '+hours+':'+minutes+':'+seconds;  
	        return time;  
	    }*/  
	editRow : undefined,//判断是否是可编辑状态
	//定义操作对象和方法
	obj5 = {
		editRow : undefined,//判断是否是可编辑状态
			search : function() {// 查询功能
				//得到下拉框选中的value值
				var state= $.trim($('select[name="state"]').val());	
				var name = $.trim($('input[name="name"]').val());
		
				$('#dinList').datagrid('load', {
					state: state,
					name:name
				});
			},
		
			edit:function(){//点击进行修改
				var rows = $('#dinList').datagrid('getSelections');//获取选中的个数
				if(rows.length==1){
					
					if(this.editRow!=undefined){
						//可编辑状态，执行保存编辑操作
						$('#dinList').datagrid('endEdit', this.editRow);
					}
					if (this.editRow == undefined) {
						//不可编辑，则打让选中行变为可执行状态
						var index = $('#dinList').datagrid('getRowIndex', rows[0]);//编辑的哪一行
						$('#save,#redo').show();
						$('#dinList').datagrid('beginEdit', index);//开始编辑
						this.editRow = index;//编辑状态为可编辑
						$('#dinList').datagrid('unselectRow', index);//取消指定选择的行。
					}	
				} else {
					$.messager.alert('警告', '修改只能选择一行！', 'warning');
				}
				},	
				save : function () {	//保存修改信息		
					//将第一行设置为结束编辑状态
					$('#dinList').datagrid('endEdit', this.editRow);
				},
				redo : function () {//取消当前的编辑
					$('#save,#redo').hide();
					this.editRow = undefined;//变为不可编辑
					$('#dinList').datagrid('rejectChanges');//撤销修改
				},
			}
	$('#dinList').datagrid({
						url : 'dinManage_findAll.action',
						title : '订单商品',
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
						toolbar : '#din_tool',						
						columns : [ [
						         {
									field : 'uid',
			                        checkbox : true,			                       		                      
								},     
								{
									field : 'oid',
									title : '订单编号',
									align : 'center',
									sortable : true,
									width:'12%',
							                          
								},
								{
									field : 'total',
									title : '订单总价',
									align : 'center',
									sortable : true,
									width:'14%',
							                          
								},
								{
									field : 'ordertime',
									title : '订单时间',
									align : 'center',
									sortable : true,
									width:'14%',
									formatter : function(value, row, index) {		
										if(value=='"null"'){
											return "未填写"
										}else{
											return value
										}
										
									},        
								},
								{
									field : 'state',
									title : '订单状态',
									align : 'center',
									sortable : true,
									width:'14%',
									formatter : function(value, row, index) {										
										if(value==1){
											return "未付款";
										}else if(value==2){
											return "<a href='javascript:void(0)' onclick='sendGoods("
												+ row.oid
												+ ")' style='color: blue;cursor: pointer'>发货</a>";
										}else if(value==3){
											return "等待收货";
										}else{
											return "订单完成";
										}
									},                       
								},
								{
									field : 'name',
									title : '订单者',
									align : 'center',
									sortable : true,
									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
											required : true,
										},
									},
									formatter : function(value, row, index) {										
										if(value=='"null"'){
											return '未填写';
										}
										return value;
									}, 
								},
								{
									field : 'phone',
									title : '订单者电话',
									align : 'center',
									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
											required : true,
										},
									},   
									formatter : function(value, row, index) {										
										if(value=='"null"'){
											return '未填写';
										}
										return value;
									}, 
								},
								{
									field : 'addr',
									title : '订单者地址',
									align : 'center',							
									width:'14%',
									editor : {
										type : 'validatebox',
										options : {
											required : true,
										},
									}, 
									formatter : function(value, row, index) {										
										if(value=='"null"'){
											return '未填写';
										}
										return value;
									}, 
								},
							
								
						] ],
						//双击进行修改
						onDblClickRow : function (rowIndex, rowData){
							if (obj5.editRow != undefined) {
								$('#dinList').datagrid('endEdit', obj5.editRow);
							}
							if(obj5.editRow==undefined){
								$('#save,#redo').show();
								$('#dinList').datagrid('beginEdit', rowIndex);
								obj5.editRow = rowIndex;
							}
						},
						//在用户完成编辑一行的时候触发
						onAfterEdit : function (rowIndex, rowData, changes) {							
							$('#save,#redo').hide();
							obj5.editRow = undefined;
							//修改用户
							var updated = $('#dinList').datagrid('getChanges', 'updated');							
				
						if(updated!=''){
						
							$.ajax({
								type : 'POST',
								url : 'dinManage_update.action',							
								data : {
									oid:rowData.oid,
									total:rowData.total,
									ordertime:rowData.ordertime,
									state:rowData.state,
									name:rowData.name,
									phone:rowData.phone,
									addr:rowData.addr,
									uid:rowData.uid
								},
								beforeSend : function () {
									
									$('#dinList').datagrid('loading');
								},
								success : function (data) {
									$('#dinList').datagrid('loaded');
									$('#dinList').datagrid('load');
									$('#dinList').datagrid('unselectAll');
									
									$.messager.show({
										title : '提示',
										msg : data + '个订单更新成功！',
									});
									obj5.editRow = undefined;
								},
							});
						}		
						},
					})  
			
})
