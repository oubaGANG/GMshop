package com.guimei.dao;

import org.springframework.orm.hibernate4.BaseDao;

import Utils.Page;

import com.guimei.domain.Product;

public interface ProductDao extends BaseDao<Product> {
	//查找所有商品
	Page findAllByPage(int page, int rows, String order, String sort,
			Product product, Integer cid, Integer csid);
	
	//-------------------ying------------------------
	//根据二级菜单查找商品并分页显示
	Page findByCsidByPage(int page, int rows,Integer csid);
	//根据一级菜单查找商品并分页显示
	Page findByCidByPage(int page, int rows,Integer cid);
}
