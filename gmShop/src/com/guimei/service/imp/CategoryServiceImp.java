package com.guimei.service.imp;

import java.util.List;

import Utils.Page;

import com.guimei.dao.CategoryDao;
import com.guimei.domain.Category;
import com.guimei.service.CategoryService;

public class CategoryServiceImp implements CategoryService {
//注入dao
	private CategoryDao categoryDao;
	
	public void setCategoryDao(CategoryDao categoryDao) {
		this.categoryDao = categoryDao;
	}

	// 查询所有一级分类集合
	public List<Category> findAll() {
		
		return categoryDao.findAll();
	}

	//ajax查找所有的一级菜单的名称
	public List findAllName() {
		
		return categoryDao.findAll();
	}

	//查找所在的一级菜单
	public Category findById(Integer cid) {
		
		return categoryDao.findById(cid);
	}

	@Override
	public Category findByName(String cname) {
		List<Category> list=categoryDao.findByProperty("cname", cname);
		if(list != null && list.size() > 0){
			return list.get(0);
		}
		return null;
	}
	//后台管理查询所有
		public Page ManFindAll(Category category, int page, int rows, String order,
				String sort) {
			
			return categoryDao.ManFindAll(category,page,rows,order,sort);
		}

		//增加一级菜单
		public void add(Category category) {
			categoryDao.save(category);
		}

		//修改一级菜单
		public void edit(Category category) {
			categoryDao.update(category);;
			
		}

		//删除一级菜单
		public int delete(String ids) {
			int length=ids.split(",").length;
			String[] strIds = ids.split(",");
			String hql = "delete from Category where cid in (";
			for(int i=0;i<strIds.length;i++){
				hql += strIds[i]+",";
			}
			hql = hql.substring(0,hql.length()-1);
			hql += ")";
			System.out.println(hql);
			categoryDao.executeByHql(hql, null);
			return length;
		}

}
