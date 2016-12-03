<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userList.jsp' starting page</title>
    
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
    	 <table id="SecList"></table>
    	 </div>
    </div>
  <!--   工具栏部分 -->
    <div id="sec_tool" style="padding:5px 0px 5px 40px;">	
   	<div>		
		一级菜单：<input name="cname" id="cname" style="width:150px;margin:10px 20px">	
		<!-- <select name="cname" id="cname" style="width:150px;margin:10px">
			<option value="">请选择</option>
		</select> -->
		二级菜单<input type="text" name="csname" class="textbox" style="margin:10px 0 10px 20px">
		<a class="easyui-linkbutton" iconCls="icon-search" onclick="obj3.search();" style='cursor: pointer'>查询</a>	
<div style="margin:10px 0 10px 40px">
<a class="easyui-linkbutton" iconCls="icon-add" style="margin:0 5px;cursor: pointer" onclick="obj3.add();">添加</a>
<a class="easyui-linkbutton" iconCls="icon-edit" style="margin:0 5px;cursor: pointer" onclick="obj3.edit();">修改</a>
<a class="easyui-linkbutton" iconCls="icon-remove" style="margin:0 5px;cursor: pointer" onclick="obj3.del();">删除</a>
<a class="easyui-linkbutton" iconCls="icon-save" style="margin:0 10px 0 50px;display:none;cursor: pointer" id="save" onclick="obj3.save();">保存</a>
<a class="easyui-linkbutton" iconCls="icon-redo" style="display:none;cursor: pointer" id="redo" onclick="obj3.redo();">取消编辑</a>	
</div>
</div>
</div>
<div id="addWin"></div>
<script src="js/SecList.js"></script>
  </body>
</html>
