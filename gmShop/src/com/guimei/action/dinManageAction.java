package com.guimei.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.struts2.ServletActionContext;

import Utils.Page;

import com.guimei.domain.Orders;
import com.guimei.domain.User;
import com.guimei.service.OrdersService;
import com.guimei.service.UserService;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class dinManageAction extends ActionSupport implements ModelDriven<Orders> {
	
	private Orders orders=new Orders();
	public Orders getModel() {	
		return  orders;
	}
	private OrdersService ordersService;
	public void setOrdersService(OrdersService ordersService) {
		this.ordersService = ordersService;
	}
	private UserService userService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	private int rows;//每页记录数
	private int page;//当前页面
	private String order;//获取要排序的方式
	private String sort;//获取要排序的元素
	private Integer uid;//用户id
	

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
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

		//查找所有订单
		public String findAll() throws IOException{
			ServletActionContext.getResponse().setContentType("application/json;charset=utf-8");//响应编码
			
			Page pageBean= ordersService.findAll(page,rows,order,sort,orders);
			
			int total=pageBean.getTotalNums();//总记录数
			List<Orders> list=pageBean.getList();//每条记录
			List jsonList=new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				jsonList.add("{'oid':"+list.get(i).getOid()+",'total':'"+list.get(i).getTotal()+"','state':'"+list.get(i).getState()
						+"','name':'"+list.get(i).getName()+"','phone':'"+list.get(i).getPhone()+"','addr':'"+list.get(i).getAddr()
						+"','uid':'"+list.get(i).getUser().getUid()+"','ordertime':'"+list.get(i).getOrdertime()+"'}");

			}
		/*	JsonConfig config = new JsonConfig();
			//除去emps属性,除去与级联的属性
				  config.setExcludes(new String[]{"user","orderitems"});
			String rows=JSONArray.fromObject(list,config).toString();//转为json		*/
			String rows=JSONArray.fromObject(jsonList).toString();//转为json	
			JSONObject jo=new JSONObject();
				//easyui需要从后台取到数据总个数，并且键值必须是total
				jo.put("total", total);
				//easyui需要从后台取到数据，并且键值必须是rows
				jo.put("rows", rows);
				ServletActionContext.getResponse().getWriter().print(jo);	
				return NONE;
			}
		//编辑订单
		public String update() throws IOException{

			
			//先查找再保存
			User u=userService.findById(uid);
			orders.setUser(u);
			ordersService.update(orders);
			ServletActionContext.getResponse().getWriter().print("1");	
			return NONE;
		}
		//发货
		public String sendGoods() throws IOException{
			//先查找
			orders=ordersService.findById(orders.getOid());
			//更改状态3(发货)
			orders.setState(3);
			//保存
			ordersService.update(orders);
			ServletActionContext.getResponse().getWriter().print("ok");	
			return NONE;
		}
}
