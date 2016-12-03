<%@ page language="java" import="java.util.*,Utils.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>贵美商城——订单列表</title>
    
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
  <form action="orderAction_selectAll" method="post">
   <div id="container">
    <iframe id="header" src="user/header.jsp" width="980" height="136" frameborder="0" scrolling="no"></iframe>
    <div class="order">
        <div class="step step1">
            <ul>
                <li  class="current"></li>
                <li>订单共计${page.totalNums }条</li>
            </ul>
        </div>
        <table class="order_tab">
        <c:forEach items="${page.list }" var="order">
            <tbody>
            <tr>
                <th>图片</th>
                <th>商品</th>
                <th>价格</th>
                <th>数量</th>
                <th>小计</th>
            </tr>

			<c:forEach items="${order.orderitems }" var="item">
            <tr>
                <td width="60">
                    <input type="hidden" name="id" value="1"/>
                    <img src="${pageContext.request.contextPath}/${item.product.image }"/>
                </td>
                <td>
                    <a target="_blank">${item.product.pname }</a>
                </td>
                <td>
                    ${item.product.price }
                </td>
                <td class="quantity" width="60">
                    <input type="text" name="count" value="${item.count }" maxlength="4" onpaste="return false;"/>

                </td>
                <td width="140">
                    <span class="subtotal"> ${item.subtotal }</span>
                </td>

            </tr>
            </c:forEach>
            
			<tr>
			<td>支付状态：</td>
			<td> <c:if test="${order.state==2 }">等待发货</c:if>
                <c:if test="${order.state==1 }"><a href="orderAction_pay?oid1=${order.oid }" style="color:red;">付款</a></c:if>
                 <c:if test="${order.state==3 }">确认收货</c:if>
                <c:if test="${order.state==4 }">交易完成</c:if>
			</td>
			<td>操作：</td>
			<td><a href="orderAction_delete?oid=${order.oid }">删除</a></td>
			<td> <div class="total">
            <em id="promotion"></em>
            商品金额: <strong id="effectivePrice">${order.total }</strong>
        </div></td>
			</tr>
            </tbody>
            </c:forEach>
        </table>
       	<div class="linkpro" style="margin-top: 0">
		<input type="hidden" name="page" value="1">
		<%-- <input type="hidden" name="csid" value="${requestScope.csid }">
		<input type="hidden" name="cid" value="${requestScope.cid }"> --%>
		<ul class="linkpage">
		<li>第${page.currentPage }页/共${page.totalPages}页</li>
		<li><a href="javascript:one(document.forms[0],1);">首页</a></li>
		<li><a href="javascript:one(document.forms[0],${page.currentPage-1});">上一页</a></li>
		<!-- 分页逻辑开始 -->
		<s:if test="#request.page.totalPages<=5">
			<s:set name="begin" value="1" ></s:set>
			<s:set name="end" value="#request.page.totalPages"></s:set>
		</s:if>
		<s:elseif test="#request.page.currentPage<=3">
			<s:set name="begin" value="1"></s:set>
			<s:set name="end" value="5"></s:set>
		</s:elseif>
		<s:elseif test="#request.page.currentPage>=#request.page.totalPages-2">
			<s:set name="begin" value="#request.page.totalPages-4" ></s:set>
			<s:set name="end" value="#request.page.totalPages" ></s:set>
		</s:elseif>
		<s:else>
			<s:set name="begin" value="#request.page.currentPage-2" ></s:set>
			<s:set name="end" value="#request.page.currentPage+2"></s:set>
		</s:else>
	
		<s:iterator begin="#begin" step="1" end="#end" var="i">
			<s:if test="#request.page.currentPage==#i">
				<li><a href="javascript:one(document.forms[0],<s:property value="#i"/>)" class="active"><s:property value="#i"/></a></li>
			</s:if>
			<s:else>
				<li><a href="javascript:one(document.forms[0],<s:property value="#i"/>)"><s:property value="#i"/></a></li>
			</s:else>
		</s:iterator>
		<!-- 分页逻辑结束-->
		<li><a href="javascript:one(document.forms[0],${page.currentPage+1});">下一页</a></li>
		<li><a href="javascript:one(document.forms[0],${page.totalPages});">尾页</a></li>
		</ul>
		</div>
		<%-- </s:else> --%>
			</div><!-- linkpro end -->
   </div>
    <iframe id="footer" src="user/footer.htm" width="980" height="150" frameborder="0" scrolling="no"></iframe>
<!-- </div> -->
</form>
</body>
</html>
