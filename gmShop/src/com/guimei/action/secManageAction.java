package com.guimei.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;

import Utils.Page;

import com.guimei.domain.Category;
import com.guimei.domain.Categorysecond;
import com.guimei.service.CategoryService;
import com.guimei.service.CategorysecondService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
/*
 * 后台二级菜单
 * */
public class secManageAction extends ActionSupport implements ModelDriven<Categorysecond> {
	//加入模型驱动
	private Categorysecond categorysecond=new Categorysecond(); 
	public Categorysecond getModel() {
		return categorysecond;
	}
	//注入一级service
	private CategoryService categoryService;
	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	//注入2级service
	private CategorysecondService categorysecondService;
	public void setCategorysecondService(CategorysecondService categorysecondService) {
		this.categorysecondService = categorysecondService;
	}
	private int rows;//每页记录数
	private int page;//当前页面
	private String order;//获取要排序的方式
	private String sort;//获取要排序的元素
	private Integer cid;//获取传来的一级菜单的cid
	private String cname;//获取一级菜单名字
	
	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

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
		Page pageBean= categorysecondService.findAll(categorysecond,page,rows,order,sort,cid);
	
		int total=pageBean.getTotalNums();//总记录数
		List<Categorysecond> list=pageBean.getList();//每条记录
		List jsonList=new ArrayList();
		for (int i = 0; i < list.size(); i++) {
			jsonList.add("{'csid':"+list.get(i).getCsid()+",'csname':'"+list.get(i).getCsname()+"','cid':'"+list.get(i).getCategory().getCname()+"'}");

		}

	 /*JsonConfig config = new JsonConfig();
			//除去emps属性,除去与一级菜单级联的属性（二级菜单的对象categoryseconds）
			  config.setExcludes(new String[]{"category","products"});
		String rows=JSONArray.fromObject(list,config).toString();//转为json		
*/		
		String rows=JSONArray.fromObject(jsonList).toString();//转为json	
		JSONObject jo=new JSONObject();
		//easyui需要从后台取到数据总个数，并且键值必须是total
		jo.put("total", total);
		//easyui需要从后台取到数据，并且键值必须是rows
		jo.put("rows", rows);
		ServletActionContext.getResponse().getWriter().print(jo);	
		return NONE;
	}
	//添加
	public String add() throws IOException{
		
		//查找数据中是否存在输入的二级菜单
		Categorysecond c=categorysecondService.findByName(categorysecond.getCsname());
		if(c!=null){
			//存在
			ServletActionContext.getResponse().getWriter().print("error");	
			return NONE;
		}
	
		//查找所在的一级菜单
		Category category=categoryService.findById(cid);

		categorysecond.setCategory(category);
		//添加到数据库
		categorysecondService.save(categorysecond);
		ServletActionContext.getResponse().getWriter().print("OK");	
		return NONE;
	}
	//更新二级菜单
	public String update() throws IOException{
		//查找数据中是否存在输入的二级菜单
		Categorysecond c=categorysecondService.findCate(categorysecond,cname);
		if(c!=null){
			//存在
			ServletActionContext.getResponse().getWriter().print("error");	
			return NONE;
		}
		System.out.println(cname+"******************************");
		//先查询一级菜单
		Category category=categoryService.findByName(cname);
		//保存一级菜单到二级菜单中
		categorysecond.setCategory(category);
		categorysecondService.update(categorysecond);
		ServletActionContext.getResponse().getWriter().print("1");	
		return NONE;
	}
	//删除一些二级菜单
	public String delSome() throws IOException{
		int num=categorysecondService.delete(ids);
		ServletActionContext.getResponse().getWriter().print(num);
		return NONE;
	}
	//通过ajax查找所有二级菜单的名字,根据一级菜单cid
	public String findAllName() throws IOException{
		//响应编码 解决json中乱码问题
		ServletActionContext.getResponse().setContentType("application/json;charset=utf-8");

		List<Categorysecond> list=categorysecondService.findAllName(cid);

		  JsonConfig config = new JsonConfig();
		//除去emps属性,除去与一级菜单级联的属性（二级菜单的对象categoryseconds）
		  config.setExcludes(new String[]{"category","products"});
		String json=JSONArray.fromObject(list,config).toString();//转为json		
		ServletActionContext.getResponse().getWriter().print(json);	 
		return NONE;
	}
}
