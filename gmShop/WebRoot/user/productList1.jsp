<%@ page language="java" import="java.util.*,com.guimei.domain.*,Utils.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>贵美商城——商品列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet"	type="text/css"	href="css/global.css"	/>
 <link rel="stylesheet"	type="text/css"	href="css/layout.css"	/>
 <link rel="stylesheet"	type="text/css"	href="css/showpro.css"	/>
 <script type="text/JavaScript">
 	function one(frm,num){ 
 		var option=document.getElementById("option").value;
 		if(option=="onemenu"){
 			frm.action="product_findByCid.action";
 		}
 		if(option=="twomenu"){
 			frm.action="product_findByCsid.action";
 		}
		frm.page.value=num;
		frm.submit();
	}
	function jump_to(frm,pageNo){
		var reg=/^\d+$/;
	    if(!reg.test(pageNo)){
			alert("请输入正确数字");
		}else{
			one(frm,pageNo);
		}
	}
	</script>
  </head>
<body>
<form action="product_findByCsid.action" method="post" name="form1">
<input type="hidden" name="option" id="option" value="${requestScope.option }">
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
     <div class="show">
     	 <s:iterator var="pro" value="#request.propage.list">
     	 <div class="showimg">
        		<a href="product_findById.action?pid=<s:property value="#pro.pid"/>"><img src="<s:property value="#pro.image"/>" alt="alt" />
        		<span><s:property value="#pro.pname"/><br/></span>
        		<span style="color:red;">¥<s:property value="#pro.price"/><br/></span>
        		</a>			
			</div>	 
		</s:iterator>
		<s:if test="#request.propage.list.size==0">
			<h1>亲。。。网络中断了，现在没有图片。。。</h1>
		</s:if>
		<s:else>
		<div class="linkpro">
		<input type="hidden" name="page" value="1">
		<input type="hidden" name="csid" value="${requestScope.csid }">
		<input type="hidden" name="cid" value="${requestScope.cid }">
		<ul class="linkpage">
		<li><a>第${requestScope.propage.currentPage }页/共${requestScope.propage.totalPages}页</a></li>
		<s:if test="#request.propage.currentPage != 1">
			<li><a href="javascript:one(document.forms[0],1);">首页</a></li>
			<li><a href="javascript:one(document.forms[0],${propage.currentPage-1});">上一页</a></li>
		</s:if>
		<!-- 分页逻辑开始 -->
		<s:if test="#request.propage.totalPages<=5">
			<s:set name="begin" value="1" ></s:set>
			<s:set name="end" value="#request.propage.totalPages"></s:set>
		</s:if>
		<s:elseif test="#request.propage.currentPage<=3">
			<s:set name="begin" value="1"></s:set>
			<s:set name="end" value="5"></s:set>
		</s:elseif>
		<s:elseif test="#request.propage.currentPage>=#request.propage.totalPages-2">
			<s:set name="begin" value="#request.propage.totalPages-4" ></s:set>
			<s:set name="end" value="#request.propage.totalPages" ></s:set>
		</s:elseif>
		<s:else>
			<s:set name="begin" value="#request.propage.currentPage-2" ></s:set>
			<s:set name="end" value="#request.propage.currentPage+2"></s:set>
		</s:else>
	
		<s:iterator begin="#begin" step="1" end="#end" var="i">
			<s:if test="#request.propage.currentPage==#i">
				<li><a href="javascript:one(document.forms[0],<s:property value="#i"/>)" class="active"><s:property value="#i"/></a></li>
			</s:if>
			<s:else>
				<li><a href="javascript:one(document.forms[0],<s:property value="#i"/>)"><s:property value="#i"/></a></li>
			</s:else>
		</s:iterator>
		<!-- 分页逻辑结束-->
		<s:if test="#request.propage.currentPage != #request.propage.totalPages">
			<li><a href="javascript:one(document.forms[0],${propage.currentPage+1});">下一页</a></li>
			<li><a href="javascript:one(document.forms[0],${propage.totalPages});">尾页</a></li>
		</s:if>
		</ul>
		</div>
		</s:else>
			</div><!-- linkpro end -->
		</div><!-- show end -->
    </div><!-- main end -->
	<iframe id="footer" runat="server" src="user/footer.htm" width="980" height="136" frameborder="0" scrolling="no"></iframe>
 
</form>
</body>
</html>

