package com.guimei.service.imp;

import java.util.List;

import com.guimei.dao.AdminDao;
import com.guimei.domain.Adminuser;
import com.guimei.domain.User;
import com.guimei.service.AdminService;

public class AdminServiceImp implements AdminService {
	//×¢Èëdao 
	private AdminDao adminDao;

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	//µÇÂ¼
	public Adminuser login(Adminuser adminuser) {
		String hql="from Adminuser where username = ? and password = ?";
		List<Adminuser> list=adminDao.findByHql(hql, adminuser.getUsername(),adminuser.getPassword());
				if(list != null && list.size() > 0){
					return list.get(0);
				}
				return null;
	}
	
}
