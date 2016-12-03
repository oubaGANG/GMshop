package org.springframework.orm.hibernate4;

import java.io.Serializable;
import java.util.List;

import Utils.Page;



@SuppressWarnings("rawtypes")
public interface BaseDao<T> {
	Serializable save(T instance);
	void delete(T instance);
	void update(T instance);
	void saveOrUpdate(T instance);
	T findById(Serializable id);
	List findAll();
	List findByProperty(String propertyName, Object value);
	Object uniqueResult(final String hql,final Object... paras);
	List findByHql(String hql,Object... paras);
	Integer executeByHql(final String hql,final Object... paras);
	List findByHqlInCache(final String hql,final Object... paras);
	List findPage(final String hql,final int maxResult,final int firstResult,final Object... paras);
	List findBySQLQuery(final String sql,final Object... paras);
	Page getPageReady(int currentPage,final String hql,int limit);
}
