package com.guimei.action;

import java.util.List;

import com.guimei.domain.Category;
import com.guimei.domain.Product;
import com.guimei.service.CategoryService;
import com.guimei.service.ProductService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class IndexAction extends ActionSupport{
	// 注入一级分类的Service:
	private CategoryService categoryService;
	//注入商品Service
	private ProductService productService;
	
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	/**
	 * 执行的访问首页的方法:
	 */
	public String execute() throws Exception {
		// 查询所有一级分类集合
		List<Category> cList = categoryService.findAll();		
		// 将一级分类存入到Session的范围:
		ActionContext.getContext().getSession().put("cList", cList);
		// 查询热门商品:
		List<Product> hList = productService.findHot();
		// 保存到值栈中:
		ActionContext.getContext().getValueStack().set("hList", hList);
		return "index";
	}
}
