package com.guimei.dao.imp;

import java.util.List;

import org.springframework.orm.hibernate4.BaseDaoImpl;

import Utils.Page;

import com.guimei.dao.ProductDao;
import com.guimei.domain.Product;

public class ProductDaoImp extends BaseDaoImpl<Product> implements ProductDao {
	//查找所有商品
	public Page findAllByPage(int page, int rows, String order, String sort,
			Product product, Integer cid, Integer csid) {
		StringBuffer hql = new StringBuffer("from Product p where 1=1");
	
		//一级菜单的cid
		if(cid!=null&&!cid.equals("")){
			hql.append(" and p.categorysecond.category.cid="+cid);
		}	
		//2级菜单的csid
		if(csid!=null&&!csid.equals("")){
	
			hql.append(" and p.categorysecond.csid="+csid);
		}
		//商品名字
		if(product.getPname()!=null&&!product.getPname().equals("")){
			hql.append(" and pname like '%"+product.getPname()+"%'");
		}
		//有排序条件
		if(sort!=null){
			hql.append(" ORDER BY "+sort+" "+order);
		}
		Page page2= this.getPageReady(page, hql.toString(),rows);

		return page2;
	}

	
	/**
	 * ying
	 */
	//根据二级菜单查找商品并分页显示
	@Override
	public Page findByCsidByPage(int page, int rows, Integer csid) {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Product p where 1=1");
		if(csid!=null&&!csid.equals("")){
			hql.append(" and p.categorysecond.csid="+csid);
		}
		Page p= this.getPageReady(page, hql.toString(),rows);
		return p;
	}

	//根据一级菜单查找商品并分页显示
	@Override
	public Page findByCidByPage(int page, int rows, Integer cid) {
		// TODO Auto-generated method stub
		Page p=new Page();
		String hql="from Product where categorysecond.csid in (select csid from Categorysecond where category.cid="+cid+")";
		p=this.getPageReady(page, hql, rows);
		return p;
	}
	
	

}
