package com.guimei.service;

import java.util.List;

import Utils.Page;

import com.guimei.domain.Product;

public interface ProductService {
	// 查询热门商品:
	List<Product> findHot();
	//查找所有商品
	Page findAll(int page, int rows, String order, String sort,
			Product product, Integer cid, Integer csid);
	//通过pid查找商品
	Product findById(Integer pid);
	//增加商品
	void save(Product product);
	//删除一些商品
	int delete(String ids);
	//编辑商品
	void update(Product product);
	
	//---------------------ying-------------------
	//通过Csid查找商品
	Page findByCsid(Integer page,int rows,Integer csid);
	//通过cid查找商品
	Page findByCid(Integer page,int rows,Integer cid);

}
