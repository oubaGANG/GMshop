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
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<title>贵美商城</title>
 <link rel="stylesheet"	type="text/css"	href="css/global.css"	/>
 <link rel="stylesheet"	type="text/css"	href="css/layout.css?id=7"	/>

	<script src="js/jquery.js"></script>
	<script src="js/lbt.js"></script>
	<script>
		$(function () {
			var timer;//用于控制定时器
			var moveX=1;//物体每次想X轴移动的速度
			var moveY=1;//物体每次想Y轴移动的速度
			function move() {
				var T=$('#pairflag').position().top+moveY//此时物体的上下移动值
				var L=$('#pairflag').position().left+moveX//此时物体的左右移动值
				if(T>($(window).height()-$('#pairflag').height())){
					moveY*=-1;//当运动到最下边时，Y变为负值，向上运动
				}
				if(T<0){
					T=0;
					moveY*=-1;//当运动到最上边时，Y变为正值，向下运动
					//负负得正
				}
				if(L>($(window).width()-$('#pairflag').width())){
					moveX*=-1;//当运动到最右边时，Y变为负值，向上运动
				}
				if(L<0){
					L=0
					moveX*=-1;//当运动到最左边时，Y变为正值，向下运动
					//负负得正
				}

				$('#pairflag').css({
					'top':T,
					'left':L
				})
			}
		//等待一秒开始执行
			setTimeout(function () {
				//调用开始移动
				timer=setInterval(move,30)
			},1000)

			//鼠标移入广告停止
			$('#pairflag').hover(function () {
				clearInterval(timer)
			},function () {
				//移出后继续移动
				timer=setInterval(move,30)
			})
		})
	</script>
</head>
<body> 
	<div id="container">
		<iframe id="header" runat="server" src="user/header.jsp" width="980" height="136" frameborder="0" scrolling="no"></iframe>
		<div id="main">
    <div class="cat">
    	<s:iterator var="c" value="#session.cList">
			<ul class="clear">
				<h1><s:property value="#c.cname"/></h1>
					<s:iterator var="cs" value="#c.categoryseconds">
						<li><a href="product_findByCsid.action?csid=<s:property value="#cs.csid"/>&page=1"><s:property value="#cs.csname"/></a>
					
					</s:iterator>				
			</ul>
		</s:iterator>	
    </div> <!--cat end-->
			<div id="content">
			  <div class="content_top">
        <div id="img">
            <img src="images/ad-01.jpg" alt="9月新品新气象"  />
            <img src="images/ad-02.jpg" alt="流行服饰魅力场" />
            <img src="images/ad-03.jpg" alt="食全食美" />
            <img src="images/ad-04.jpg" alt="outlets开张啦" />
        </div>
        <div id="adv">
            <a class="active">1</a>
            <a>2</a>
            <a>3</a>
            <a>4</a>
        </div>
    </div>
    
     <!-- content_top end -->
      <div class="content_list">
     	 <s:iterator var="p" value="hList">
        	<dl>
        		<dt>
        		<a href="product_findById.action?pid=<s:property value="#p.pid"/>"><img src="<s:property value="#p.image"/>" alt="alt" /></a>
        		</dt>
				
			</dl>
		</s:iterator>			
			</div><!-- content_list end -->
		</div><!-- content end -->
    <div class="sidebar">
         <div class="r1"></div>				
				 <div	class="r2">
					<dl>
						<dt><img src="images/show1.jpg" alt="alt" /></dt>
						<dd><a href="info.htm">大牌狂降价，三折直送</a></dd>
					</dl>
					<dl>
						<dt><img src="images/show2.jpg" alt="alt" /></dt>
						<dd><a href="info.htm">大学要求老师开网店</a></dd>
					</dl>
					<dl>
						<dt><img src="images/show5.jpg" alt="alt" /></dt>
						<dd><a href="info.htm">黑眼圈推荐，美白不停</a></dd>
					</dl>
					<dl>
						<dt><img src="images/show4.jpg" alt="alt" /></dt>
						<dd><a href="info.htm">瘦身狂潮风，修形之选</a></dd>
					</dl>
			</div> <!--r2	end-->	    
					<div id="tab">
					  <div id="tabtitle1" onmouseover="switchMe(1);"></div>
					  <div id="tabtitle2" onmouseover="switchMe(2);"></div>		
					  <div id="tabbody">
					  	<img src="images/tabbody2.gif" alt="手机充值" />
					  </div>											  
					</div>
				</div> <!--sidebar end-->				
		 </div>	<!--main end-->
     <iframe id="footer" runat="server" src="user/footer.htm" width="980" height="150" frameborder="0" scrolling="no"></iframe>
	<div id="pairflag">
		<a class="f_l" href="#" id="advLeft"><img src="images/list1.jpg" alt="alt" /></a>
		<img class="f_l" id="closeLeft" onclick="leftClose();" src="images/close.gif" alt="alt" />
	</div>	
	</div><!--container	end-->		
</body>
</html>
