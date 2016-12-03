package com.guimei.dao.imp;

import org.springframework.orm.hibernate4.BaseDaoImpl;

import Utils.Page;

import com.guimei.dao.CategorysecondDao;
import com.guimei.domain.Categorysecond;

public class CategorysecondDaoImp extends BaseDaoImpl<Categorysecond> implements CategorysecondDao{
	//查询所有
	public Page findByPage(Categorysecond categorysecond, int page, int rows,
			String order, String sort,Integer cid) {

		StringBuffer hql = new StringBuffer("from Categorysecond c where 1=1");
		//二级菜单名字
		if(categorysecond.getCsname()!=null&&!categorysecond.getCsname().equals("")){
			hql.append(" and c.csname like '%"+categorysecond.getCsname()+"%'");
		}
		//一级菜单的cid
		if(cid!=null&&!cid.equals("")){
			hql.append(" and c.category.cid="+cid);
		}
		
		//有排序条件
		if(sort!=null){
			hql.append(" ORDER BY "+sort+" "+order);
		}
		Page page2= this.getPageReady(page, hql.toString(),rows);
		return page2;
	}

}
