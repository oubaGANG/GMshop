package org.springframework.orm.hibernate4;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;

import Utils.Page;

/**
 * Dao的基类，封装了绝大多数的数据库操作
 * 放在org.springframework.orm.hibernate4下的目的是为了调用HibernateTemplate的protected方法
 */
@SuppressWarnings(value={"rawtypes","unchecked"})
public abstract class BaseDaoImpl<T> implements BaseDao<T> {
	private Class<T> entityClass;
	protected HibernateTemplate hibernateTemplate;
	
	public BaseDaoImpl() {
		//当该类被继承时，它的子类需要初始化T，通过该代码获取T的类型
		entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];		 
    }
	
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	
	public Serializable save(T instance) {
		return this.hibernateTemplate.save(instance);
	}
	
	public void delete(T instance) {
		this.hibernateTemplate.delete(instance);
	}
	
	public void update(T instance) {
		this.hibernateTemplate.update(instance);
	}
	
	public void saveOrUpdate(T instance){
		//瞬时态则save，游离态则update
		hibernateTemplate.saveOrUpdate(instance);
	};
	
	public T findById(Serializable id){
		T instance = hibernateTemplate.get(entityClass, id);
		return instance;		
	}
	
	/**
	 * 根据HQL查询，支持单值查询，如使用聚合函数查询
	 */
	public List findByHql(String hql,Object... paras) {	
		 return hibernateTemplate.find(hql, paras);
	}
	
	/**
	 * 根据HQL进行增删改，支持单值查询，如使用聚合函数查询
	 * 插入操作只支持INSERT INTO ... SELECT ...形式,不支持INSERT INTO ... VALUES ...形式
	 * @return 受影响的行数
	 */
	public Integer executeByHql(final String hql,final Object... paras) {			
		return this.hibernateTemplate.executeWithNativeSession(new HibernateCallback<Integer>() {
			public Integer doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				hibernateTemplate.prepareQuery(query);
				if (paras != null) {
					for (int i = 0; i < paras.length; i++) {
						query.setParameter(i, paras[i]);
					}
				}
				return query.executeUpdate();
			}
		});
	}
	
	/**
	 * 根据HQL使用查询缓存进行查询
	 */	
	public List findByHqlInCache(final String hql,final Object... paras) {		
		return hibernateTemplate.executeWithNativeSession(new HibernateCallback<List>() {
			public List doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);				
				hibernateTemplate.prepareQuery(query);
				query.setCacheable(true);
				if (paras != null) {
					for (int i = 0; i < paras.length; i++) {
						query.setParameter(i, paras[i]);
					}
				}
				return query.list();
			}
		});
	}
	
	/**
	 * 查询数据库中的所有对象
	 */
	public List findAll(){
		String hql = "from "+this.entityClass.getSimpleName();
		List list = hibernateTemplate.find(hql);
		return list;
	};
	
	/**
	 * 根据属性查找
	 */
	public List findByProperty(String propertyName, Object value){
		String hql = "from "+this.entityClass.getSimpleName()+" where "+propertyName+"=?";
		List list = hibernateTemplate.find(hql,value);
		return list;
	}	
	
	/**
	 * 单值查询
	 */
	public Object uniqueResult(final String hql,final Object... paras) {
		return hibernateTemplate.executeWithNativeSession(new HibernateCallback<Object>() {
			public Object doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				hibernateTemplate.prepareQuery(query);
				if (paras != null) {
					for (int i = 0; i < paras.length; i++) {
						query.setParameter(i, paras[i]);
					}
				}
				return query.uniqueResult();
			}
		});
	}
	
	/**
	 * 分页查询，记录的下标从0开始
	 */
	public List findPage(final String hql,final int maxResult,final int firstResult,final Object... paras) {
		return hibernateTemplate.executeWithNativeSession(new HibernateCallback<List>() {
			public List doInHibernate(Session session){
				Query query = session.createQuery(hql);
				hibernateTemplate.prepareQuery(query);
				query.setMaxResults(maxResult);
				query.setFirstResult(firstResult);
				if(paras != null){
					for(int i = 0;i<paras.length;i++){
						query.setParameter(i, paras[i]);
					}
				}
				return query.list();
			}
		});
	}	

	/**
	 * 使用本地sql语句进行查询，在报表查询、复杂查询时可能用到
	 */
	public List findBySQLQuery(final String sql,final Object... paras) {
		return hibernateTemplate.executeWithNativeSession(new HibernateCallback<List>() {
			public List doInHibernate(Session session){
				SQLQuery query = session.createSQLQuery(sql);				
				if(paras != null){
					for(int i = 0;i<paras.length;i++){
						query.setParameter(i, paras[i]);
					}
				}
				return query.list();
			}
		});
	}
	
	/**
	 * 根据当前页码和条件hql查询当前页显示的page对象
	 */
	public Page getPageReady(int currentPage,String hql,int limit) {
		Page page = new Page();
		page.setLimit(limit);
		String countHql = "select count(*) "+hql;
		System.out.println(countHql);
		page.setTotalNums(((Long)this.uniqueResult(countHql,null)).intValue());
		int totalPages = (page.getTotalNums() % page.getLimit())==0? 
				page.getTotalNums() / page.getLimit() : (page.getTotalNums() / page.getLimit())+1;
		System.out.println(totalPages);
		page.setTotalPages(totalPages);
		if(currentPage < 1 || currentPage == 0){
			currentPage = 1;
		}else if(currentPage > totalPages){
			currentPage = totalPages;
		}
		int firstResult = (currentPage-1) *page.getLimit();
		page.setCurrentPage(currentPage);
		List list = findPage(hql, page.getLimit(), firstResult,null);
		page.setList(list);
		return page;
	}
	
}
