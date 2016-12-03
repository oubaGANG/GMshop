<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.guimei.domain.Adminuser" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'main.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/head.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js" ></script>
</head>
<%
		Adminuser adminuser=(Adminuser)request.getSession().getAttribute("adExit");
		if(adminuser==null){
			request.getSession().setAttribute("info", "您还没有登录，迷瞪个脸！！！");
			response.sendRedirect(request.getContextPath()+"/AdminLogin.jsp");
		}
%>
<body class="easyui-layout">

<div data-options="region:'north',title:'header',split:false,noheader:true" style="height:100px;">
    <div id="head">
    <div id="log">您好， ${adExit.username}| <a href="adminManage_quit.action">退出</a></div>
        </div>
</div>
<div data-options="region:'south',title:'footer',split:false,noheader:true" style="height:40px;line-height:40px;text-align:center;font-size: 16px">
    &copy;信息工程学院13级计科.
</div>
<div data-options="region:'west',title:'导航',split:false,iconCls:'icon-world'" style="width:200px;box-sizing: border-box;overflow: hidden">
    <div id="box" class="easyui-accordion" style="width:100%;height:100%;">
        <div title="一级菜单管理" class="nav_title">
            <p class="pmenu iconfont" data-url="firList"><span></span> <i>&#xe605</i><b>一级菜单列表</b></p>
        </div>
        <div title="二级菜单管理" class="nav_title">
            <p class="pmenu iconfont" data-url="SecList"><span></span> <i>&#xf0025</i><b>二级菜单列表</b></p>
	 		<p class="pmenu iconfont" data-url="SecAdd"><span></span> <i>&#xe697</i><b>二级菜单添加</b></p>
        </div>
        <div title="商品管理" class="nav_title">
            <p class="pmenu iconfont" data-url="proList"><span></span> <i>&#xe64c</i><b>商品列表</b></p>
            <p class="pmenu iconfont" data-url="proAdd"><span></span><i>&#xe6ab</i><b>新增商品</b></p>
        </div>
        <div title="订单管理" class="nav_title">
            <p class="pmenu iconfont" data-url="dinList"><span></span> <i>&#xe64c</i><b>订单列表</b></p>
        </div>
        <div title="用户管理" class="nav_title">
            <p class="pmenu iconfont" data-url="userList"><span></span><i>&#xe615</i><b>用户列表</b></p>
        </div>
    </div>
</div>
<div data-options="region:'center'" style="overflow:hidden;">
    <div id="tabs">
        <div title="起始页" iconCls="icon-house" style="padding:0 10px;display:block;">
            欢迎来到超市后台管理系统！
        </div>
    </div>
</div>
</body>
</html>