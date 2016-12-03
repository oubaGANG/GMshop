package com.guimei.service.imp;

import java.util.List;

import Utils.Page;

import com.guimei.dao.ProductDao;
import com.guimei.domain.Product;
import com.guimei.service.ProductService;

public class ProductServiceImp implements ProductService {
//注入dao
	private ProductDao productDao;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	// 查询热门商品:
	public List<Product> findHot() {

		String hql="from Product where isHot=1 order by pdate desc";
		List list=productDao.findPage(hql,9,0,null);
		System.out.println(list.size()+"个数为:######################3");
		return list;
		
	}

	//查找所有商品
	public Page findAll(int page, int rows, String order, String sort,
			Product product, Integer cid, Integer csid) {
		
		return productDao.findAllByPage(page,rows,order,sort,product,cid,csid);
	}

	//通过pid查找商品
	public Product findById(Integer pid) {
		
		return productDao.findById(pid);
	}

	//增加商品
	public void save(Product product) {
		productDao.save(product);
	}

	//删除一些商品
	public int delete(String ids) {
		int length=ids.split(",").length;
		String[] strIds = ids.split(",");
		String hql = "delete from Product where pid in (";
		for(int i=0;i<strIds.length;i++){
			hql += strIds[i]+",";
		}
		hql = hql.substring(0,hql.length()-1);
		hql += ")";
		System.out.println(hql);
		productDao.executeByHql(hql, null);
		return length;
		
	}

	//编辑商品
	public void update(Product product) {
		productDao.saveOrUpdate(product);
	}

	
	//----------------------ying------------------
	//通过Csid查找商品
	@Override
	public Page findByCsid(Integer page,int rows,Integer csid) {
		// TODO Auto-generated method stub
		System.out.println("商品的二级菜单编号:"+csid);
		return productDao.findByCsidByPage(page, rows, csid);
		
	}

	@Override
	public Page findByCid(Integer page, int rows, Integer cid) {
		// TODO Auto-generated method stub
		System.out.println("in ProductServiceImp method findByCid()");
		return productDao.findByCidByPage(page, rows, cid);
	}

}
