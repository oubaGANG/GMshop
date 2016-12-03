package com.guimei.dao.imp;

import org.springframework.orm.hibernate4.BaseDaoImpl;

import Utils.Page;

import com.guimei.dao.UserDao;
import com.guimei.domain.User;



public class UserDaoImp extends BaseDaoImpl<User> implements UserDao{

	//查询所有
	public Page findByPage(User user, int page, int rows, String order,
			String sort) {
		StringBuffer hql = new StringBuffer("from User where 1=1");
		//用户名字
		if(user.getName()!=null&&!user.getName().equals("")){
			hql.append(" and name like '%"+user.getName()+"%'");
		}
		//登录账号
		if(user.getUsername()!=null&&!user.getUsername().equals("")){
			hql.append(" and username like '%"+user.getUsername()+"%'");
		}
		//性别
		if(user.getGender()!=null&&!user.getGender().equals("")){
	
			hql.append(" and gender= '"+user.getGender()+"'");
		}
		//有排序条件
		if(sort!=null){
			hql.append(" ORDER BY "+sort+" "+order);
		}
		Page page2= this.getPageReady(page, hql.toString(),rows);
		return page2;
	}

}
