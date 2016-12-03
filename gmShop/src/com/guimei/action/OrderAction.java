package com.guimei.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import Utils.Page;

import com.guimei.domain.Cartitem;
import com.guimei.domain.Orderitem;
import com.guimei.domain.Orders;
import com.guimei.domain.User;
import com.guimei.service.OrdersService;
import com.guimei.service.OrderitemService;
import com.guimei.service.OrdersService;

public class OrderAction extends BaseAction{
	
	private OrdersService OrdersService;
	private OrderitemService orderitemService;
	
	
	public void setOrderitemService(OrderitemService orderitemService) {
		this.orderitemService = orderitemService;
	}

	public void setOrdersService(OrdersService OrdersService) {
		this.OrdersService = OrdersService;
	}

	@SuppressWarnings("unused")
	public String show() throws Exception {
		//获取购物车中的购物项集合
		List<Cartitem> list=(List<Cartitem>) request.getSession().getAttribute("carListProduct");
		for(Cartitem cartitem:list)
		{
			String count=request.getParameter(cartitem.getProduct().getPid().toString());
			cartitem.setCount(new Integer(count));
		}
		//存放订单项的集合
		List<Orderitem> orderitemlist=new ArrayList<Orderitem>();
		
		Orders orders=new Orders();
		User user=(User) request.getSession().getAttribute("exitUser");
		orders.setAddr(user.getAddr());
		orders.setName(user.getName());
		
		orders.setOrdertime(new Date());
		orders.setPhone(user.getPhone());
		orders.setState(1);
		orders.setUser(user);
		Set<Orderitem> set=new HashSet<Orderitem>();
		/*for(Cartitem cartitem:list)
		{
			Orderitem orderitem=new Orderitem();
			orderitem.setCount(cartitem.getCount());
			orderitem.setProduct(cartitem.getProduct());
			orderitem.setSubtotal(cartitem.getProduct().getPrice()*cartitem.getCount());
			set.add(orderitem);
			//orderitemlist.add(orderitem);
		}*/
		
		
		
		
		Double totalmoney=0.0;
		for(Cartitem cartitem:list)
		{
			Orderitem orderitem=new Orderitem();
			orderitem.setCount(cartitem.getCount());
			orderitem.setProduct(cartitem.getProduct());
			orderitem.setSubtotal(cartitem.getProduct().getPrice()*cartitem.getCount());
			orderitem.setOrders(orders);
			Double money=cartitem.getProduct().getPrice()*cartitem.getCount();
			orderitem.setSubtotal(money);
			orderitemlist.add(orderitem);
			totalmoney=totalmoney+money;
			orderitemService.save(orderitem);
			//System.out.println("在show方法中打印购物项的ID："+orderitem.getItemid());
			set.add(orderitem);
			
		}
		orders.setOrderitems(set);
		OrdersService.save(orders);
		Orders updOrders=OrdersService.findById(orders.getOid());
		updOrders.setTotal(totalmoney);
		//更新订单对象
		OrdersService.update(updOrders);	
		Orders updOrders1=OrdersService.findById(orders.getOid());
		request.setAttribute("orders", updOrders1);	
		return "show";
	}
	
	public String findAll() throws Exception {
		// TODO Auto-generated method stub
		String oid=request.getParameter("oid");
		//System.out.println("findAll()查询一个订单的所有订单项："+oid);
		Orders order=OrdersService.findById(new Integer(oid));
		//System.out.println("打印订单的名字:"+order.getName());
		//更新商品中订单的总价位
		Double total=0.0;
		for(Orderitem item:(Set<Orderitem>)order.getOrderitems())
		{
			total=total+item.getProduct().getPrice();
		}
		order.setTotal(total);
		OrdersService.update(order);
		request.setAttribute("orders",order);
		return "findAll";
	}
	
	public String pay() throws Exception {
		//System.out.println("进入了付款的方法");
		//获取要选中购买商品的ID  获取这些商品的订单ID
		//String[] itemids=request.getParameterValues("obj");
		
		//获取订单的ID
		String oid=request.getParameter("oid1");
		System.out.println("获取订单的ID："+oid);
		Orders order=OrdersService.findById(new Integer(oid));
		order.setState(2);
		OrdersService.update(order);
		//将那些没有支付但又没有删除掉的订单项，当该用户再次登录时 把这些商品放入购物车中
		return "pay";
	}
	//查询所有的订单
	public String selectAll() throws Exception {
		// TODO Auto-generated method stub
		/*List<Orders> orderList=OrdersService.findAll();
		request.setAttribute("orderList",orderList);*/
		/*for(Orders order:orderList)
		{
			for(Orderitem item:(Set<Orderitem>)order.getOrderitems())
			{
				System.out.println("获取商品图片的路径："+item.getProduct().getImage());
			}
		}*/
		int currPage=1;
		String currPage1=request.getParameter("page");
		
		if(currPage1!=null)
		{
			currPage=new Integer(currPage1);
		}
		Integer count=new Integer(OrdersService.uniqueResult().toString());
		//System.out.println("打印总的订单数："+count);
		request.setAttribute("count",count);
		List<Orders> list=OrdersService.findPage(5,(currPage-1)*5,null);
		Page page=new Page();
		page.setCurrentPage(currPage);
		page.setLimit(5);
		page.setList(list);
		page.setTotalNums(count);
		int pages=0;
		if(count%5==0)
		{
			pages=count/5;
		}
		else
		{
			pages=count/5+1;
		}
		page.setTotalPages(pages);
		request.setAttribute("page",page);
		return "selectAll";
	}
	
	
	public String delete() throws Exception {
		String oid=request.getParameter("oid");
		System.out.println("获取删除订单的ID:"+oid);
		Orders order=OrdersService.findById(new Integer(oid));
		OrdersService.delete(order);
		return "delete";
	}

}
