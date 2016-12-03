<%@ page language="java" import="java.util.*,com.guimei.domain.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>贵美商城——购物车</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 	<link rel="stylesheet"	type="text/css"	href="css/global.css"	/>
 	<link rel="stylesheet"	type="text/css"	href="css/layout.css"	/>
 <script type="text/JavaScript" defer="true">
		function openWindow(){
    var address=window.showModalDialog("address.htm","","dialogWidth=340px;dialogHeight=270px");
	  document.getElementById("address").value=address;	
		}
  function priceCalc(){
  	var oTr=document.getElementById("priceTable").getElementsByTagName("tr");
  	/**
  	* 因为priceTable从第三个tr开始出现价格列表，倒数第一行结束，所以i=2，i<trObject.length-1
  	* fSum为折扣后总价
  	* fTotal为原总价
  	*/
    var fSum=0;
    var fTotal=0;
		var j=1;
  	for (var i=2;i<oTr.length-1;i++){
  	  var oTd=oTr[i].getElementsByTagName("td");
  	  var fPrice=parseFloat(oTd[j].getElementsByTagName("span")[0].innerHTML.substring(1));
			var nCount=parseInt(oTd[j+3].getElementsByTagName("input")[0].value);
			var fRealPrice=fPrice*parseInt(oTd[j+2].getElementsByTagName("span")[0].innerHTML)/100;
  	  fSum  +=fRealPrice*nCount;
			fTotal+=fPrice*nCount;
  	  //oTd[j+1].getElementsByTagName("span")[0].innerHTML='￥'+formatFloat(fRealPrice);
      }  	 
    //oTr[oTr.length-1].getElementsByTagName("td")[1].innerHTML='￥'+formatFloat(fSum);
    //oTr[oTr.length-1].getElementsByTagName("td")[2].innerHTML='你共节省：￥'+formatFloat(fTotal-fSum);
  	}
  	function remove(oThis){
  		oFather=oThis.parentNode;
  		oFather.parentNode.parentNode.removeChild(oFather.parentNode);
  		priceCalc();
		}
//	window.onload=priceCalc();
</script>
</head>
<body>
<div id="container">
	<iframe id="header" src="user/header.jsp" width="980" height="136" frameborder="0" scrolling="no"></iframe>
    <div class="buy">
			<h4><img src="images/mycart.gif" alt="alt" /> <a href="#">全场运费一律2元</a> <a href="#" class="b" onclick="JavaScript:window.open('calc.htm','计算器','width=200,height=200,toolbar=no,scrollbars=no,menubar=no,screenX=100,screenY=100')">简易计算器</a></h4>
     <form action="orderAction_show" method="post">
      <table class="buy" cellpadding="0" cellspacing="0">
    	<tbody id="priceTable">
			<tr class="buytitle"><td colspan="6" class="b">确认商品价格与交易条件</td></tr>
      <tr>
        <td class="w364 b">&nbsp;&nbsp;&nbsp;&nbsp;商品名</td>
        <td class="w100 b">图片</td>
        <td class="w100 b">价格</td>
        <td class="w100 b">数量</td>
        <td class="w81 b">删除</td>
      </tr>
      <c:forEach items="${carListProduct }" var="pro">
      <%double total=0.0; 
      List<Cartitem> list=(List<Cartitem>)session.getAttribute("carListProduct");
      for(Cartitem pro:list)
      {
      	total=total+pro.getProduct().getPrice();
      }
      session.setAttribute("total", total);
      %>
      <tr class="h26 blue">
        <td><a href="info.htm" title="简.奥斯汀全集（DVD-9）（赠BBC产品目录...">&nbsp;&nbsp;&nbsp;&nbsp;${pro.product.pname }</a></td>
       	<td><img src="${pageContext.request.contextPath}/${pro.product.image}" style="width: 50px;height: 40px;"/></td>
        <td><span class="c9">${pro.product.price }</span></td>
        <td><input onchange="priceCalc()" name="${pro.product.pid }" type="text" value="${pro.count }" maxlength="4" size="3"/></td>
        <td><a href="product_del?pid=${pro.product.pid }">删除</a></td>
        
      </tr>
      </c:forEach>
      <tr class="h26">
        <td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="catlist.htm">继续挑选商品</a></td>
        <%-- <td class="a_c" colspan="2" id="sum" class="pl58">￥${total }</td> --%>
      </tr>
    </tbody>
  	</table>
        <div class="car_buttom">
            <a href="" id="clear">清空购物车</a>
           <input type="submit" value="购买"/>
        </div>
     </form>
   </div>
		<iframe id="footer" src="user/footer.htm" width="980" height="150" frameborder="0" scrolling="no"></iframe>
	</div><!--container	end-->
</body>