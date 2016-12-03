package com.guimei.action;

import java.io.IOException;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;

import Utils.Page;

import com.guimei.domain.Category;

import com.guimei.service.CategoryService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
/*
 * 一级菜单后台管理
 * */
public class firManageAction extends ActionSupport implements ModelDriven<Category> {
	//模型驱动
	private Category category=new Category();
	public Category getModel() {
		return category;
	}
	//注入service
	private CategoryService categoryService;
	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
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
	//ajax查找所有的一级菜单的名称
	public String findAllName() throws IOException{
		//响应编码 解决json中乱码问题
		ServletActionContext.getResponse().setContentType("application/json;charset=utf-8");
		List<Category> list=categoryService.findAllName();
		  JsonConfig config = new JsonConfig();
		//除去emps属性,除去与一级菜单级联的属性（二级菜单的对象categoryseconds）
		  config.setExcludes(new String[]{"categoryseconds"});
		String json=JSONArray.fromObject(list,config).toString();//转为json		
		ServletActionContext.getResponse().getWriter().print(json);	 
	
	
		return NONE;
	}
	//查询所有
	public String findAll() throws IOException{
		ServletActionContext.getResponse().setContentType("application/json;charset=utf-8");//响应编码
		Page pageBean= categoryService.ManFindAll(category,page,rows,order,sort);
	
		int total=pageBean.getTotalNums();//总记录数
		List list=pageBean.getList();//每条记录
		JsonConfig config = new JsonConfig();
		//除去emps属性,除去与一级菜单级联的属性（二级菜单的对象categoryseconds）
		  config.setExcludes(new String[]{"categoryseconds"});
	String rows=JSONArray.fromObject(list,config).toString();//转为json		
		JSONObject jo=new JSONObject();
		//easyui需要从后台取到数据总个数，并且键值必须是total
		jo.put("total", total);
		//easyui需要从后台取到数据，并且键值必须是rows
		jo.put("rows", rows);
		ServletActionContext.getResponse().getWriter().print(jo);	
		return NONE;
	}
	//增加一级菜单
		public String add() throws IOException{
			//先查找是否存在相同的一级菜单
			Category c=categoryService.findByName(category.getCname());
			if(c!=null){
				//数据库已经存在一级菜单
				ServletActionContext.getResponse().getWriter().print("error");
				return NONE;
			}
			categoryService.add(category);
			ServletActionContext.getResponse().getWriter().print(1);
			return NONE;
		}
		//修改一级菜单
		public String edit() throws IOException{
			//先查找是否存在相同的一级菜单
			Category c=categoryService.findByName(category.getCname());
			if(c!=null){
				//数据库已经存在一级菜单
				ServletActionContext.getResponse().getWriter().print("error");
				return NONE;
			}
			categoryService.edit(category);
			ServletActionContext.getResponse().getWriter().print(1);
			return NONE;
		}
		//删除一些一级菜单
		public String delSome() throws IOException{
			int num=categoryService.delete(ids);
			ServletActionContext.getResponse().getWriter().print(num);
			return NONE;
		}
}
