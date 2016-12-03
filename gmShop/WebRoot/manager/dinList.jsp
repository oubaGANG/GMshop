<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'proList.jsp' starting page</title>
    
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
  <!-- 这两层div为了让表格自适应 -->
    <div class="easyui-layout"fit="true">
     <div region="center">
    	 <table id="dinList"></table>
    	 </div>
    </div>
  <!--   工具栏部分 -->
    <div id="din_tool" style="padding:5px 0px 5px 40px;">	
   	<div>		
		
		订单状态:<select name="state" class="textbox" style="width:150px;margin:10px">
			<option value="">请选择</option>
			<option value="1">未付款</option>
			<option value="2">已付款</option>
			<option value="3">已发货</option>
			<option value="4">订单完成</option>
		</select>
		订单者:<input type="text" class="textbox" name="name" style="width:110px;margin:0px 10px 0 5px">
	<a class="easyui-linkbutton" iconCls="icon-search" onclick="obj5.search();" style='cursor: pointer'>查询</a>	
		<a class="easyui-linkbutton" iconCls="icon-edit" style="margin:10px 10px 10px 180px;cursor: pointer" onclick="obj5.edit();">修改</a>	
	<a class="easyui-linkbutton" iconCls="icon-save" style="margin:10px 5px;cursor: pointer;display:none" id="save" onclick="obj5.save();">保存</a>
<a class="easyui-linkbutton" iconCls="icon-redo" style="cursor: pointer;margin:10px 5px;display:none" id="redo" onclick="obj5.redo();">取消编辑</a>	
</div>
</div>
<script src="js/dinList.js"></script>
  </body>
</html>
