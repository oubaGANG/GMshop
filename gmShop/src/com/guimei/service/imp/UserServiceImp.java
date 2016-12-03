package com.guimei.service.imp;

import java.util.List;

import Utils.Page;

import com.guimei.dao.UserDao;
import com.guimei.domain.User;
import com.guimei.service.UserService;

public class UserServiceImp implements UserService {
	//注入dao
	private UserDao userDao;

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	//登录方法
	public User login(User user) {
		String hql="from User where username = ? and password = ?";
		List<User> list=userDao.findByHql(hql, user.getUsername(),user.getPassword());
				if(list != null && list.size() > 0){
					return list.get(0);
				}
				return null;
	}

	//检查用户名是否被注册
	public User findByName(String username) {
		String hql="from User where username = ?";
		List<User> list=userDao.findByHql(hql,username);
		if(list != null && list.size() > 0){
			return list.get(0);
		}
		return null;
	}

	//用户注册
	public void save(User user) {
		userDao.save(user);
		
	}

	//查询所有
	public Page findAll(User user, int page, int rows, String order, String sort) {
		
		return userDao.findByPage(user,page,rows,order,sort);
	}

	//增加用户
	public void add(User user) {
		userDao.save(user);
	}

	//修改用户
	public void edit(User user) {

			userDao.update(user);	
		
	}
	//删除一些用户
	public int delete(String ids) {
		int length=ids.split(",").length;
		String[] strIds = ids.split(",");
		try{
			String hql = "delete from User where uid in (";
			for(int i=0;i<strIds.length;i++){
				hql += strIds[i]+",";
			}
			hql = hql.substring(0,hql.length()-1);
			hql += ")";
			userDao.executeByHql(hql, null);
			return length;
		}catch(Exception e){
			return -1;
		}
	}
	//根据id查找用户
		public User findById(Integer uid) {
			
			return userDao.findById(uid);
		}

	
	
	
	
}
