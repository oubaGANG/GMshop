package com.guimei.dao;

import org.springframework.orm.hibernate4.BaseDao;

import Utils.Page;

import com.guimei.domain.User;

public interface UserDao extends BaseDao<User>{
	//²éÑ¯ËùÓĞ
	Page findByPage(User user, int page, int rows, String order, String sort);

}
