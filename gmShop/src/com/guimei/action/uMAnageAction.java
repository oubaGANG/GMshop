package com.guimei.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;



import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import Utils.Page;

import com.guimei.domain.Adminuser;
import com.guimei.domain.User;
import com.guimei.service.UserService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class uMAnageAction extends ActionSupport implements ModelDriven<User> {
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
	private int rows;//每页记录数
	private int page;//当前页面
	private String order;//获取要排序的方式
	private String sort;//获取要排序的元素
	
	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

//接受传过来的要删除的id数组
	private String ids;	
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}

	//查询所有
	public String findAll() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json;charset=utf-8");//响应编码
		Page pageBean= userService.findAll(user,page,rows,order,sort);
	
		int total=pageBean.getTotalNums();//总记录数
		List list=pageBean.getList();//每条记录
		 JsonConfig config = new JsonConfig();
			//除去emps属性,除去与一级菜单级联的属性（二级菜单的对象categoryseconds）
			  config.setExcludes(new String[]{"orderses"});
			String rows=JSONArray.fromObject(list,config).toString();//转为json		
		JSONObject jo=new JSONObject();
		//easyui需要从后台取到数据总个数，并且键值必须是total
		jo.put("total", total);
		//easyui需要从后台取到数据，并且键值必须是rows
		jo.put("rows", rows);
		ServletActionContext.getResponse().getWriter().print(jo);	
		return NONE;
	}
	//增加用户
	public String add() throws IOException{
	
			//先查找是否存在相同的username(登录名不能相同)
			User u=userService.findByName(user.getUsername());
			if(u!=null){
				//数据库已经存在次登录名
				ServletActionContext.getResponse().getWriter().print("error");
				return NONE;
			}
		userService.add(user);
		ServletActionContext.getResponse().getWriter().print(1);
		return NONE;
	}

	//修改用户
	public String edit() throws IOException{		
		userService.edit(user);
		ServletActionContext.getResponse().getWriter().print(1);
		return NONE;
	
	}
	//删除一些用户
	public String delSome() throws IOException{
		int num=userService.delete(ids);
		if(num!=-1){
			ServletActionContext.getResponse().getWriter().print(num);
			return NONE;
		}
		ServletActionContext.getResponse().getWriter().print("err");
		return NONE;
	}
	
}
