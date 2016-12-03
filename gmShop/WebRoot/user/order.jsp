<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>贵美商城-订单页</title>
    <link rel="stylesheet"	type="text/css"	href="css/global.css"	/>
    <link rel="stylesheet"	type="text/css"	href="css/layout.css"	/>
       <script src="js/jquery.js"></script>
    <script type="text/javascript">
    	function funcheck(all)
    	{
    		//alert("事件已经触发");
    		//var all=document.getElementsById("all");
    		//alert(all);
    		var obj=document.getElementsByName("obj");
    		if(all.checked==true)
    		{
    			//alert("进入了if判断");
    			for(var i=0;i<obj.length;i++)
    			{
    				obj[i].checked=true;
    			}
    		}
    		else
    		{
    			for(var i=0;i<obj.length;i++)
    			{
    				obj[i].checked=false;
    			}
    		}
    	}
    	
    	function submit1()
    	{
    		//alert("提交表单");
    	/* 	var form1=document.getElementById("form1");
    		form1.submit();
    		form1.action="orderAction_pay"; */
    		
    		$('#form1').attr('action','orderAction_pay');
    		$('#form1').submit();
    	}
    </script>
  </head>
  
  <body>
    <div id="container">
    <iframe id="header" src="user/header.jsp" width="980" height="136" frameborder="0" scrolling="no"></iframe>
    <div class="order">
     <form id="form1" name="form1" method="post" action="orderAction_pay">
        <div class="step step1">
            <ul>
                <li  class="current"></li>
                <li>订单状态:</li>
                <li>
                 <c:if test="${orders.state==2 }">等待发货</c:if>
                <c:if test="${orders.state==1 }">未支付</c:if>
                 <c:if test="${orders.state==3 }">已发货</c:if>
                <c:if test="${orders.state==4 }">确认收货</c:if>
                </li>
               <!--  <li>生成订单成功</li> -->
            </ul>
        </div>
      
        <table class="order_tab">
            <tbody>
            <tr>
            	<!-- <th width="15"><input type="checkbox" name="all" id="all" onchange="funcheck(this)"/></th> -->
                <th>图片</th>
                <th>商品</th>
                <th>价格</th>
                <th>数量</th>
                <th>小计</th>
                <th>操作</th>
            </tr>
			<c:forEach items="${orders.orderitems }" var="item">
            <tr>
               <%--  <td width="18">
                    <input type="checkbox" name="obj" value="${item.itemid }"/>
                </td> --%>
                <td width="60">
                    <input type="hidden" name="${item.itemid }" value="${item.itemid }"/>
                    <img src="${pageContext.request.contextPath}/${item.product.image}"/>
                </td>
                <td>
                    <a target="_blank">${item.product.pname }</a>
                </td>
                <td>
                    ${item.product.price }
                </td>
                <td class="quantity" width="60">
                    <input type="text" name="${item.itemid }" value="${item.count }" maxlength="4" onpaste="return false;"/>

                </td>
                <td width="140">
                    <span class="subtotal">${item.subtotal }</span>
                </td>
                <td>
                    <a href="orderitemAction_del?itemid=${item.itemid }&oid=${orders.oid}" class="delete">删除</a>
                </td>
            </tr>
			</c:forEach>
            </tbody>
        </table>
        <input type="hidden" name="oid1" value="${orders.oid }"/>
	  
        <div class="total">
            <em id="promotion"></em>
            商品金额: <strong id="effectivePrice">${orders.total }</strong>
        </div>
      <!--   <form id="buyForm" method="post" action="orderAction_pay"> -->
            <table class="buy">
                <tbody>
                <tr class="buytitle">
                    <td colspan="2" >补充您的邮件地址和联系人基本信息</td>
                </tr>
                <tr>
                    <td class="a_r"><label for="username">收件人：</label></td>
                    <td><input type="text" name="username" id="username" value="${exitUser.username }"/>
                </tr>
                <tr>
                    <td class="a_r"><label for="address">地&nbsp;&nbsp;&nbsp;址： </label></td>
                    <td id="selectPlace">
                        <input type="text" name="address" id="address"  value="${exitUser.addr }"/>
                        <!-- <a href="javascript:openWindow()" class="b">请点击填写地址</a> -->
                    </td>
                </tr>
                <tr>
                    <td class="a_r"><label for="tel">电&nbsp;&nbsp;&nbsp;话：</label></td>
                    <td><input type="text" name="phone" id="phone"  value="${exitUser.phone }"/></td>
                </tr>
                <tr>
                    <td class="h65">&nbsp;</td>
                    <td><input class="imginput" type="image" src="images/submit.gif"/></td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
    <iframe id="footer" src="user/footer.htm" width="980" height="150" frameborder="0" scrolling="no"></iframe>
    </div>
  </body>
</html>
