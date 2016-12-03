package com.guimei.action;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.guimei.domain.User;
import com.guimei.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
/*
 * 用户action
 * */
public class UserAction extends ActionSupport implements ModelDriven<User>{
	//	创建用户对象
	private User user=new User();
	public User getModel() {
		return user;
	}
	//注入service
	private UserService userService;
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	//登录方法
	public String login(){

		User exitUser=userService.login(user);
		if(exitUser!=null){
			//用户存在，将用户的信息存入到session中
			HttpSession session= ServletActionContext.getRequest().getSession();
			session.setAttribute("exitUser",exitUser);
			return "loginSucc";
		}
		else{
			//登录失败
			this.addActionError("登录失败:用户名或密码错误!!!");
			return "loginFalse";
		}
		
	} 
	//用户注册
	public String regist(){	
		user.setnYear(ServletActionContext.getRequest().getParameter("nYear"));
		userService.save(user);
		return "registSucc";
	}
	//检查用户名是否被注册
	public String findByName() throws IOException{
		User exitUser=userService.findByName(user.getUsername());
		if(exitUser!=null){
			//用户存在，
			ServletActionContext.getResponse().getWriter().print("false");
			//页面不跳转
			return NONE;	
		}
		else{
			//登录成功
			ServletActionContext.getResponse().getWriter().print("true");
			return NONE;	
		}
		
		
	
	}
}
