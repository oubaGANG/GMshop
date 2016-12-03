package com.guimei.dao;

import org.springframework.orm.hibernate4.BaseDao;

import Utils.Page;

import com.guimei.domain.Orders;

public interface OrdersDao extends BaseDao<Orders> {
	//查找所有订单
	Page findAllByPage(int page, int rows, String order, String sort,
			Orders orders);

}
