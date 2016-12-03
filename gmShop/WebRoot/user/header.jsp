<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
 	<script type="text/JavaScript">

	function showTime(){
		now=new Date;
		document.write(now.getFullYear()+"年"+(now.getMonth()+1)+"月"+now.getDate()+"日"+now.getHours()+"点"+now.getMinutes()+"分");	
	}
	</script>
</head>
<body>
		<div id="header">
			<div id="logo"></div>
			<div class="menu">
				<ul>
					<li class="pic pic1"></li>
					<li class="txt"><a href="user/cart.jsp" target="_parent">购物车</a></li>
					<li class="pic pic2"></li>
					<li class="txt"><a href="user/help.htm" target="_parent">帮助中心</a></li>
					<li class="pic pic3"></li>
					<li class="txt"><a href="orderAction_selectAll" target="_parent">我的订单</a></li>		
					<li class="pic pic4"></li>
					<li class="txt"><a href="JavaScript:void(0);" onclick="setHome(this);">设为首页</a></li>			
					<li class="pic btn txt"><a href="user/login.jsp" target="_parent">登录</a></li>
					<li class="pic btn txt"><a href="user/register.jsp" target="_parent">注册</a></li>
				</ul>
			</div> <!--menu	end-->
			<div class="f_r w62p">
				<ul>
					<li class="txt hello">你好<s:property value="#session.exitUser.name"/>，欢迎访问贵美商城！<script type="text/JavaScript">showTime();</script></li>
				</ul>
			</div> 
  		<div class="nav f_l w100p">
  			<ul>
  				<li><a href="index.action" target="_parent">&nbsp;首&nbsp;&nbsp;&nbsp;页&nbsp;</a></li>
  				<s:iterator var="c" value="#session.cList">
			<li><a target="_parent" href="product_findByCid.action?cid=<s:property value="#c.cid"/>&page=1"><s:property value="#c.cname"/></a> </li>
		</s:iterator>
  				<li><a href="user/help.htm" target="_parent">帮助中心</a></li>
  				<li><a href="user/help.htm" target="_parent">免费开店</a></li>
  				<li><a href="user/help.htm" target="_parent">全球咨询</a></li>  				
  			</ul>
  		</div>	<!--nav	end-->		
		</div> <!--header	end-->	
 </body>
</html>
