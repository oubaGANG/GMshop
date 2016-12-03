package com.guimei.service;

import java.util.List;

import Utils.Page;

import com.guimei.domain.Category;
import com.guimei.domain.Categorysecond;

public interface CategorysecondService {

	Page findAll(Categorysecond categorysecond, int page, int rows,
			String order, String sort, Integer cid);
	//添加
	void save(Categorysecond categorysecond);
	//查找数据中是否存在输入的二级菜单
	Categorysecond findByName(String csname);
	//更新二级菜单
	void update(Categorysecond categorysecond);
	int delete(String ids);
	//通过ajax查找所有二级菜单的名字
	List<Categorysecond> findAllName(Integer cid);
	//查找数据中是否存在输入的二级菜单
		Categorysecond findCate(Categorysecond categorysecond, String cname);
}
