package com.guimei.service;

import Utils.Page;

import com.guimei.domain.User;

public interface UserService {
	//登录方法
	User login(User user);
	//检查用户名是否被注册
	User findByName(String username);
	//用户注册
	void save(User user);
	//查询所有
	Page findAll(User user, int page, int rows, String order, String sort);
	//增加用户
	void add(User user);
	//修改用户
	void edit(User user);
	//删除一些用户
	int delete(String ids);
	//根据id查找用户
		User findById(Integer uid);

}
