package com.guimei.service.imp;

import java.io.Serializable;

import org.springframework.transaction.annotation.Transactional;

import com.guimei.dao.OrderitemDao;
import com.guimei.domain.Orderitem;
import com.guimei.service.OrderitemService;
@Transactional
public class OrderitemServiceImpl implements OrderitemService{
	private OrderitemDao orderitemDao;

	public void setOrderitemDao(OrderitemDao orderitemDao) {
		this.orderitemDao = orderitemDao;
	}

	@Override
	public void save(Orderitem orderitem) {
		// TODO Auto-generated method stub
		orderitemDao.save(orderitem);
	}

	@Override
	public void delete(Orderitem instance) {
		// TODO Auto-generated method stub
		orderitemDao.delete(instance);
	}

	@Override
	public Orderitem findById(Serializable id) {
		// TODO Auto-generated method stub
		Orderitem orderitem=orderitemDao.findById(id);
		return orderitem;
	}
	
	
}
