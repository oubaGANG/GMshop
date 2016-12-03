package com.guimei.action;

import com.guimei.domain.Orderitem;
import com.guimei.service.OrderitemService;

public class OrderitemAction extends BaseAction{
	private OrderitemService orderitemService;

	public void setOrderitemService(OrderitemService orderitemService) {
		this.orderitemService = orderitemService;
	}
	
	public String del() throws Exception {
		String itemid=request.getParameter("itemid");
		String oid=request.getParameter("oid");
		//System.out.println("拿到了订单的ID:"+oid);
		//System.out.println("进入订单项删除的方法:"+itemid);
		Orderitem item=orderitemService.findById(new Integer(itemid));
		orderitemService.delete(item);
		request.setAttribute("oid",oid);
		return "del";
	}

}
