<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'proAdd.jsp' starting page</title>
    
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
  <style>
  body{font-size:16px}
	tr{height:40px;}
</style>
    	<form  method="post" id="proEditForm" enctype="multipart/form-data">
    	<input type="hidden" name="pid" value="${proList.pid}">
    &nbsp;
    <table cellSpacing="1" cellPadding="5" width="100%" align="center" bgColor="#eeeeee" style="border: 1px solid #8ba7e3" border="0">
        <tr>
            <td  align="center" bgColor="#afd1f3" colSpan="4"
                height="26">
                <strong><STRONG>修改商品</STRONG>
                </strong>
            </td>
        </tr>

        <tr>
            <td width="18%" align="center" bgColor="#f5fafe" >
                商品名称：
            </td>
            <td  bgColor="#ffffff">
                <input type="text" name="pname" id="pname" class="textbox easyui-validatebox"   
                 value="${proList.pname}" required="true" style="height:20px"/>
            </td>
            <td width="18%" align="center" bgColor="#f5fafe" >
                是否热门：
            </td>
            <td bgColor="#ffffff">
                <select name="isHot" class="easyui-combobox" style="width:50px">
                    <option value="1" <c:if test="${proList.isHot == 1 }">selected='selected'</c:if>>是</option>
                    <option value="0" <c:if test="${proList.isHot == 0 }">selected='selected'</c:if>>否</option>
                </select>
            </td>
        </tr>
        <tr>
            <td width="18%" align="center" bgColor="#f5fafe" >
                商城价格：
            </td>
            <td  bgColor="#ffffff">
                <input type="text" name="price" id="price" class="textbox easyui-validatebox" 
                value="${proList.price}" required="true" style="height:20px"/>
            </td>
          <td width="18%" align="center" bgColor="#f5fafe" >
                商品库存：
            </td>
            <td  bgColor="#ffffff">
                <input type="text" name="count" id="count" class="textbox easyui-validatebox"
                 value="${proList.count}" required="true" style="height:20px"/>
            </td>
        </tr>

        <tr>
            <td width="18%" align="center" bgColor="#f5fafe" >
                所属的一级分类：
            </td>
            <td  bgColor="#ffffff">
                <select name="categorysecond.category.cid" class="easyui-combobox" id="proEditCid" style="width:150px">

                </select>
            </td>
            <td width="18%" align="center" bgColor="#f5fafe" >
                所属的二级分类：
            </td>
            <td  bgColor="#ffffff">
                <select name="categorysecond.csid" class="easyui-combobox easyui-validatebox" required="true" id="proEditCsid" style="width:150px">
					
                </select>
            </td>
        </tr>
        <tr>
            <td width="18%" align="center" bgColor="#f5fafe" >
                商品描述：
            </td>
            <td  bgColor="#ffffff">
                <textarea name="pdesc" rows="5" cols="30">${proList.pdesc}</textarea>
            </td>
            <td width="18%" align="center" bgColor="#f5fafe" >
                出厂日期：
            </td>
            <td  bgColor="#ffffff">
                <input type="text" name="pdate" id="pdate" class="easyui-datebox"
                value="${proList.pdate}" style="width:100px">
            </td>
        </tr>
        <tr>
        	    <td width="18%" align="center" bgColor="#f5fafe" >
                商品图片：
            </td>
            <td  bgColor="#ffffff">
            	<img src="${proList.image}" style="width:100px;height:120px">
                <input type="file" name="upload" />
                <input type="hidden" name="image" value="${proList.image}"/>
            </td>
        </tr>
        <tr>
            <td  style="WIDTH: 100%" align="center"bgColor="#f5fafe" colSpan="4">
                <a class="easyui-linkbutton" iconCls="icon-proAdd" style="margin:0 5px;cursor: pointer" id="sub">保存</a>
				<a class="easyui-linkbutton" iconCls="icon-cancel" style="margin:0 5px;cursor: pointer" id="res"><input type="reset" value="重填" style="border:none"></a>
            </td>
        </tr>
    </table>
</form>
<div id="opt1" style="display: none">${proList.categorysecond.csid }</div>
<div id="opt2" style="display: none">${proList.categorysecond.category.cid }</div>
<script src="js/jquery-form.js"></script>
	<script>
	
		$(function(){
		
		//获取商品原来的cid和csid
	
	var nowCsid=$('#opt1').text()
	var nowCid=$('#opt2').text()
			//下拉列表点击时获取一级菜单的名字
	$('#proEditCid').combobox({
		url : 'firManage_findAllName.action',
		 valueField:'cid',   
		 textField:'cname',
		  editable: false, //不允许手动输入
		  onLoadSuccess: function () { //数据加载完毕事件
              var data = $('#proEditCid').combobox('getData');
			
                if (data.length > 0) {
					//默认选中
                    $('#proEditCid').combobox('select', data[nowCid-1].cid);
                       }
                        },
		//当一级菜单选择后，重新加载商品
		 onSelect: function(rec) {
			 $('#proEditCsname').combobox('clear');
			 var url = 'secManage_findAllName.action?cid='+rec.cid;
			 $('#proEditCsid').combobox('reload', url);
		 }
	})
	//二级菜单
	$('#proEditCsid').combobox({
		url : 'secManage_findAllName.action',
		 valueField:'csid',   
		 textField:'csname',
		  editable: false, //不允许手动输入
		  onLoadSuccess: function () { //数据加载完毕事件
              var data = $('#proEditCsid').combobox('getData');
			
                if (data.length > 0) {
					//默认选中
                    $('#proEditCsid').combobox('select', data[nowCsid-1].csid);
                       }
                        },
	})
	//验证表单
	$('#sub').click(function(){

		if($('#proEditCsid').combobox('getValue')==""){    	
         alert("请选择二级菜单")
         	return false;
        }else if(!$('#pname').validatebox('isValid')){
        	$('#pname').focus();  
        
        }else if(!$('#price').validatebox('isValid')){
        	$('#price').focus();  
        
        }else if(!$('#count').validatebox('isValid')){
        	$('#count').focus();  
        
        }
        
        else{       	
    		
        	  $('#proEditForm').ajaxSubmit({
        	  	type : 'POST',
   				url : 'proManage_edit.action',
   					data : $('form').serialize()+'&file='+$('input[name="upload"]').val(),
   				
   				success : function (data) {
				$.messager.alert('消息', "恭喜更改成功!!!", 'info');								
   			}
        	  })
        }
	})

	
	
		})
	</script>
</body>
</html>

