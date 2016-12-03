package com.guimei.action;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.guimei.domain.Adminuser;
import com.guimei.domain.User;
import com.guimei.service.AdminService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class adminManageAction extends ActionSupport implements ModelDriven<Adminuser> {
	//注入模型驱动
	private Adminuser adminuser=new Adminuser();
	public Adminuser getModel() {
		return adminuser;
	}
	//注入service
	private AdminService adminService;
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	
	//登录
	public String login(){
		Adminuser adExit=adminService.login(adminuser);
		if(adExit!=null){
			//用户存在，将用户的信息存入到session中
			HttpSession session= ServletActionContext.getRequest().getSession();
			session.setAttribute("adExit",adExit);
			session.removeAttribute("info");
			return "loginSucc";
		}
		else{
			//登录失败
			this.addActionError("登录失败:用户名或密码错误!!!");
			return "loginFalse";
		}
	}
	//退出
	public String quit(){
		
		HttpSession session= ServletActionContext.getRequest().getSession();
		session.removeAttribute("adExit");
		this.addActionMessage("退出成功！！点击可重新登录");
		return "quit";
	}
}
