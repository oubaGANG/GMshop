<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SecAdd.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
       
  </head>
  
  <body>

  <form id="SecAddForm" method="post" style="padding: 50px 0 50px 30px;width:560px;border:1px solid #ccc">
    <div style="display:inline-block;">
        <label for="cid" style="margin-right: 10px">一级菜单列表: </label>
       	<select name="cid" id="cid" class="easyui-combobox easyui-validatebox" data-options="required:true" style="width:150px"></select>	
    </div>
    <div style="display:inline-block;margin-left: 30px">
        <label for="csname" style="margin-right: 10px">二级菜单:</label>
        <input type="text" name="csname" id="csname" class="textbox" style="height:20px">
    </div>
    <p style="margin-top: 50px;text-align: center">
    <a class="easyui-linkbutton" iconCls="icon-proAdd" style="margin:0 5px;cursor: pointer" id="sub">添  加</a>
	<a class="easyui-linkbutton" iconCls="icon-cancel" style="margin:0 5px;cursor: pointer" id="res"><input type="reset" value="重填" style="border:none"></a>
    </p>
</form>
<script>
	$(function(){

		
		//下拉列表点击时获取一级菜单的名字
	$('#cid').combobox({
		url : 'firManage_findAllName.action',
		 valueField:'cid',   
		 textField:'cname' ,
		 editable: false,//不可编辑		 
	})
	//默认下拉列表选中第一个
	//$('#cid').combobox('select',firData[0].cid)

	
	   //验证er级菜单
    $('#csname').validatebox({
         required: true,
       missingMessage : '请输入二级菜单',   
    });

  //提交数据
	$('#sub').click(function(){
	//提交时验证
	  if($('#cid').combobox('getValue')==""){
        	
         alert("请选择一级菜单")
         	return false;
        }
	   else if(!$('#csname').validatebox('isValid')){
        	$('#csname').focus();  
        
        }
       
        else{
        
        	    $.ajax({
   			type : 'POST',
   			url : 'secManage_add.action',
   			data : {
   				cid:$('#cid').combobox('getValue'),
   				csname:$('#csname').val()
   			},
 
   			success : function (data) {
   			
   				if(data=='error'){	
						$.messager.alert('错误', '操作失败！菜单已经存在！！', 'error');				
								}
				else{
						$.messager.alert('消息', "恭喜添加成功!!!", 'info');
								}
   			}
   		
   			})
   			
        }
        

		
	})
	})
</script>
  </body>
</html>
