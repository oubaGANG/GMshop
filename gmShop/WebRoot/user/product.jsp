<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>贵美商城——商品详情</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet"	type="text/css"	href="css/global.css"	/>
 <link rel="stylesheet"	type="text/css"	href="css/layout.css"	/>
	<script src="js/jquery.js"></script>
	<script src="js/fdj.js"></script>
	
 </head>
<body>
<div id="container">
	<iframe id="header" src="user/header.jsp" width="980" height="136" frameborder="0" scrolling="no"></iframe>
	<div class="good">
		<h1><s:property value="proList.pname"/></h1>
		<ul class="f_l" id="show">
			<li class="bigimg clear"><a href="buy.htm" class="s_box"><img src="<s:property value="proList.image"/>"  alt="" class="simg"/>
				<!--	放大镜-->
				<div class="zoomMask"></div>
			</a>
				<!--	放预览大图的位置-->
				<div class="zoomDiv">
					<img src="" alt="" class="bimg">
				</div>

			</li>
			<li class="smallimg"><img src="products/1/cs10001.jpg" alt="小图1" /></li>
			<li class="smallimg"><img src="products/1/cs10002.jpg" alt="小图2" /></li>
			<li class="smallimg"><img src="products/1/cs10003.jpg" alt="小图3" /></li>
			<li class="smallimg"><img src="products/1/cs10004.jpg" alt="小图4" /></li>
			<li class="smallimg"><img src="products/1/cs10005.jpg" alt="小图5" /></li>			
			<li class="op clear f_l"><a href="#"><img src="images/share.gif" alt="分享" /></a></li>
			<li class="op f_l"><a href="#"><img src="images/favthis.gif" alt="藏" /></a></li>			
		</ul>
		<ul class="goodinfo f_l">
			<li>单       价：<span><s:property value="proList.price"/></span></li>
			<li>运　　费：<span>免运费</span></li>
			<li class="h74 buynow"><a href="buy.htm"><img src="images/buynow.gif" alt="alt" /></a></li>
			<li class="onlinepay">此商品支持<a href="#">网银支付</a>，网上汇款免手续费。<br />收货满意后出售者才能拿钱，货款都安全！</li>
			<li>剩余时间：<span>10天23小时</span></li>
			<li>本期售出：<span>2件</span></li>
			<li>累计售出：<span>8件</span></li>
			<li class="f_l w175">商品类型：<span><s:property value="proList.categorysecond.csname"/></span></li>
			<li>所 在 地：<span>山西太原</span></li>
			<li class="f_l w175">商品数量：<span><s:property value="proList.count"/></span></li>
			<li>浏 览 量：<span>17次</span></li>			
		</ul>
	</div>
	<iframe id="footer" src="user/footer.htm" width="980" height="136" frameborder="0" scrolling="no"></iframe>
</div> <!--container end-->
</body>
</html>
