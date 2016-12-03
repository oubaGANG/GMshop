package com.guimei.service.imp;

import java.io.Serializable;
import java.util.List;

import Utils.Page;

import com.guimei.dao.OrdersDao;
import com.guimei.domain.Orders;
import com.guimei.service.OrdersService;

public class OrdersServiceImp implements OrdersService {
	private OrdersDao ordersDao;
	public void setOrdersDao(OrdersDao ordersDao) {
		this.ordersDao = ordersDao;
	}
	//查找所有订单
	public Page findAll(int page, int rows, String order, String sort,
			Orders orders) {
		
		return ordersDao.findAllByPage(page,rows,order,sort,orders);
	}
	//编辑订单
	public void update(Orders orders) {
		ordersDao.update(orders);
	}
	//根据id查找
	public Orders findById(Integer oid) {
	
		return ordersDao.findById(oid);
	}
	public void save(Orders orders) {
		// TODO Auto-generated method stub
		ordersDao.save(orders);
	}

	@Override
	public Orders findById(Serializable id) {
		// TODO Auto-generated method stub
		Orders order=ordersDao.findById(id);
		return order;
	}

	
	@Override
	public List<Orders> findAll() {
		// TODO Auto-generated method stub
		List<Orders> orderList=ordersDao.findAll();
		return orderList;
	}

	@Override
	public Object uniqueResult() {
		// TODO Auto-generated method stub
		String hql="select count(*) from Orders";
		Object count=ordersDao.uniqueResult(hql, null);
		return count;
	}

	@Override
	public List findPage(int maxResult, int firstResult,
			Object... paras) {
		// TODO Auto-generated method stub
		String hql="from Orders order by ordertime desc";
		List<Orders> list=ordersDao.findPage(hql, maxResult, firstResult,paras);
		
		return list;
	}

	@Override
	public void delete(Orders instance) {
		// TODO Auto-generated method stub
		ordersDao.delete(instance);
	}
}
