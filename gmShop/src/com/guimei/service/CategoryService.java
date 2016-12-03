package com.guimei.service;

import java.util.List;

import Utils.Page;

import com.guimei.domain.Category;

public interface CategoryService {
	// 查询所有一级分类集合
	List<Category> findAll();
	//ajax查找所有的一级菜单的名称
	List findAllName();
	//查找所在的一级菜单
	Category findById(Integer cid);
	//根据名字查找对应的一级菜单
	Category findByName(String cname);
	//后台管理查询所有
		Page ManFindAll(Category category, int page, int rows, String order,
				String sort);
		//增加一级菜单
		void add(Category category);
		//修改一级菜单
		void edit(Category category);
		//删除一级菜单
		int delete(String ids);
}
