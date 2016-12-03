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
       
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<title>贵美商城</title>
	<link rel="stylesheet"	type="text/css"	href="css/global.css"	/>
	<link rel="stylesheet"	type="text/css"	href="css/layout.css"	/>
	<script src="js/jquery.js"></script>
	<script src="js/jquery.validate.js"></script>
<script>
		$(function () {
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
				},

			})
		})
	</script>
</head>
<body>
<div id="container">
	<iframe id="header" src="user/header.jsp" width="980" height="136" frameborder="0" scrolling="no"></iframe>
	<form action="user_login.action" method="post" id="loginForm">
		<div class="login">
			<ul class="form f_l">
				<h1><img src="images/logintitle.gif" alt="会员登录" /></h1>
				<li style="text-align:center;color:red"><s:actionerror /></li>
				<li class="login_list"><label>会员名：</label><input type="text" name="username" /></li>
				<li class="login_list"><label>密&nbsp;&nbsp;&nbsp;码：</label><input type="password" name="password" /></li>
				<li class="a_c"><input type="submit" value="" class="submit"></li>
				<li class="desc">&delta;&nbsp;&nbsp;<a href="#">什么是安全登录</a>。</li>
				<li class="desc">&delta;&nbsp;&nbsp;香港會員（繁體中文用戶）由此<a href="#">登入</a></li>
				<li class="desc">&delta;&nbsp;&nbsp;<a href="#">密码安全贴士</a>。</li>
				<li class="desc">&delta;&nbsp;&nbsp;防止病毒或者木马窃取您的账户信息，<a href="#">在线检查</a>您的电脑是否安全。</li>
			</ul>
			<h1><img src="images/register.gif" alt="注册会员" /></h1>
			<ul class="aside f_l">
				<li class="regpic"><span>便宜有好货！</span>超过7000万件商品任您选。</li>
				<li class="regpic regpic2"><span>买卖更安全！</span>交易超安全。</li>
				<li class="regpic regpic3"><span>免费开网店！</span>轻松赚钱交友。</li>
				<li class="regpic regpic4"><span>超人气社区！</span>彩活动每一天</li>
				<li class="a_c"><a href="user/register.jsp"><img src="images/registernow.gif" alt="现在就注册" /></a></li>
				<ul class="reged">
					<li class="regpic regpic5">您已经是会员？<a href="#">由此登入</a></li>
					<li class="regpic regpic6">繁体中文用户由此<a href="user/register.jsp">注册</a></li>
				</ul>
			</ul>
		</div>
	</form>
	<iframe id="footer" src="user/footer.htm" width="980" height="136" frameborder="0" scrolling="no"></iframe>
</div> <!--container end-->
</body>
</html>
