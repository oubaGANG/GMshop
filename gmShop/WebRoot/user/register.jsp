<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
 <script type="text/JavaScript" src="js/func.js"></script>
    <script src="js/jquery.js"></script>
    <script src="js/jquery.validate.js"></script>
    <script src="jedate/jedate.js"></script>
    <script>
        $(function () {
            $('#form1').validate({
                //失去焦点时触发
                onfocusout: function(element){
                    $(element).valid();
                },
                //验证规则
                rules:{
                	name:{
                        required: true,
                        minlength: 2
                    },
                    username:{
                        required: true,
                        minlength: 2,
                        	/* ajax验证用户名是否存在 */
                        remote:{
                        	 url: "user_findByName.action", 
                        	 type:"post",
                        	 data:{
                        	 	username:function() {
  								 return $("#sname2").val();
   								}
                        	 }
                        }
                    },
                    password:{
                        required: true,
                        minlength: 3
                    },
                    password1:{
                        required: true,
                        equalTo: "#password"
                    },
                    email:{
                        required: true,
                        email: true
                    }
                },
                //错误信息
                messages:{
                	name:{
                        required: "请输入姓名",
                        minlength:"姓名至少为两个字符"
                    },
                    username: {
                        required: "请输入登录账号",
                        minlength: "登录账号至少为两个字符",
                        remote:$.format("该登录账号已存在！")
                    },
                    password: {
                        required: "请输入密码",
                        minlength: "密码长度不能小于 3 "
                    },
                    password1:{
                        required: "请再次输入密码",
                        equalTo: "两次密码输入不一致"
                    },
                    email:{
                        required: "请输入邮箱",
                        email: "邮箱格式不正确"
                    }
                }
            })
          
        })
    </script>
</head>
<body>
<div id="container">
	<iframe id="header" src="user/header.jsp" width="980" height="136" frameborder="0" scrolling="no"></iframe>
    <form id="form1" method="post" action="user_regist.action">
    <table class="reg" cellspacing="0px" cellpadding="0px" >
      <tbody >

            <tr>
                <td class="a_r w15p"><label for="fname">名字：</label></td>
                <td class="w500"><input name="name" id="fname" type="text"/></td>
                <td class="protocol" rowspan="11">
                    <h4><img src="images/read.gif" alt="alt" />阅读贵美网服务协议 </h4>
        	<textarea name="textarea" cols="35" rows="15">欢迎阅读服务条款协议，本协议阐述之条款和条件适用于您使用Gmgw.com网站的各种工具和服务。

  本服务协议双方为贵美与贵美网用户，本服务协议具有合同效力。
  贵美的权利和义务
    1.贵美有义务在现有技术上维护整个网上交易平台的正常运行，并努力提升和改进技术，使用户网上交易活动的顺利。
    2.对用户在注册使用贵美网上交易平台中所遇到的与交易或注册有关的问题及反映的情况，贵美应及时作出回复。
    3.对于在贵美网网上交易平台上的不当行为或其它任何贵美认为应当终止服务的情况，贵美有权随时作出删除相关信息、终止服务提供等处理，而无须征得用户的同意。
    4.因网上交易平台的特殊性，贵美没有义务对所有用户的注册资料、所有的交易行为以及与交易有关的其他事项进行事先审查。
				  </textarea>
                </td>
            </tr>

            <tr>
                <td class="a_r" ><label for="sname2">登录账号：</label></td>
                <td><input name="username" id="sname2" type="text" value=""/></td>
            </tr>
            <tr>
                <td class="a_r"><label for="pass">密码：</label></td>
                <td><input name="password" id="password" type="password" /></td>
            </tr>
            <tr>
                <td class="a_r"><label for="password1">再次输入密码：</label></td>
                <td><input name="password1" id="password1" type="password" /></td>
            </tr>
            <tr>
                <td class="a_r"><label for="email">电子邮箱：</label></td>
                <td><input name="email" id="email" type="email" /></td>
            </tr>
              <tr>
                <td class="a_r"><label for="addr">地址：</label></td>
                <td><input name="addr" id="addr" /></td>
            </tr>
             <tr>
                <td class="a_r"><label for="addr">电话：</label></td>
                <td><input name="phone" id="phone" /></td>
            </tr>
            <tr>
                <td class="a_r"><label for="gender">性别：</label></td>
                <td>
                    <input name="gender" id="gender" class="b0" type="radio" value="男" checked="checked" />
                    <img src="images/Male.gif" alt="alt" />男&nbsp;
                    <input name="gender" class="b0" type="radio" value="女" />
                    <img src="images/Female.gif" alt="alt" />女

                </td>
            </tr>
            <tr>
                <td class="a_r"><label for="hobby">爱好：</label></td>
                <td>
                    <input class="b0" type="checkbox" name="hobby" id="hobby" value="checkbox" />&nbsp;运动&nbsp;&nbsp;
                    <input class="b0" type="checkbox" name="hobby2" value="checkbox" />&nbsp;聊天&nbsp;&nbsp;
                    <input class="b0" type="checkbox" name="hobby3" value="checkbox" />&nbsp;玩游戏

                </td>
            </tr>
            <tr>
                <td class="a_r"><label for="nYear">出生日期：</label></td>
                <td class="datep">
                    <input name="nYear" id="nYear" type="text" class="datainp" value="" readonly/>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="pl150"><input type="image" name="submit" class="b0" src="images/submit.gif" />
                <input type="reset" value="" style="width:80px;height:34px;background: url(images/reset.gif) no-repeat"/>
                </td>
            </tr>

      </tbody>
    </table>	
    </form>		
		<iframe id="footer" src="user/footer.htm" width="980" height="150" frameborder="0" scrolling="no"></iframe>
	</div><!--container	end-->
<script>
    jeDate({
        dateCell:"#nYear",
        format:"YYYY年MM月DD日",
        isinitVal:true,
        isTime:true, //isClear:false,
        minDate:"1965-01-01",
        okfun:function(val){alert(val)}
    })

</script>
</body>

