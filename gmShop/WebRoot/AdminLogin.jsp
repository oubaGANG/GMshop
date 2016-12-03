<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags"  prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>后台登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="css/adminLogin.css">
	<style>
		label.error{color: red;}
	</style>

  </head>
  
 <body class="blue-style">
 <h3 style="width:100%;text-align:center;color:green;position:absolute;top:100px"> <s:actionmessage/></h3>
<h3 style="width:100%;text-align:center;color:red;position:absolute;top:100px"><s:actionerror /></h3>
<div id="login">
	<div class="icon"></div>
	<div class="login-box">
		<form method="post" action="adminManage_login.action" id="loginForm">
			<dl>
				<dt>用户名：</dt>
				<dd><input type="text" name="username" class="input-text"/></dd>
				<dt>密　码：</dt>
				<dd><input type="password" name="password" class="input-text"/></dd>
			</dl>
			<div class="buttons">
				<input type="submit" value="登录系统" class="input-button" />
				<input type="reset" name="reset" value="重　　填" class="input-button" />
			</div>
		</form>
	</div>
</div>
<script src="js/jquery.js"></script>
<script src="js/jquery.validate.js"></script>
	<script>
		$(function(){
			$('#loginForm').validate({
			//失去焦点时触发
				onfocusout: function(element){
   						 $(element).valid();
					},
			//验证规则
				rules:{
					username:{
       					 required: true,
        				minlength: 2
      				},
					password:{
       					 required: true,
        				 minlength: 3
      				},
				},
			//错误信息	
				messages:{
      				 username: {
        			  		required: "请输入用户名",
        			  		minlength: "用户名至少为两个字符"
      						},
      				password: {
        					required: "请输入密码",
        					minlength: "密码长度不能小于 3 "
     						 },
      			}
			})
		})
	</script>
	
  </body>
</html>

