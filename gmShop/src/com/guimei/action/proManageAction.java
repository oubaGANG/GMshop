package com.guimei.action;

import java.io.File;
import java.io.IOException;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import Utils.Page;

import com.guimei.domain.Product;
import com.guimei.service.ProductService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class proManageAction extends BaseAction implements
		ModelDriven<Product> {
private Product product=new Product();
	//模型驱动
	public Product getModel() {	
		return product;
	}
	//注入service
	private ProductService productService;
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}	
	private int rows;//每页记录数
	private int page;//当前页面
	private String order;//获取要排序的方式
	private String sort;//获取要排序的元素
	private Integer cid;//获取传来的一级菜单的cid
	private Integer csid;//获取传来的一级菜单的cid
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public Integer getCid() {
		return cid;
	}
	public void setCid(Integer cid) {
		this.cid = cid;
	}
	public Integer getCsid() {
		return csid;
	}
	public void setCsid(Integer csid) {
		this.csid = csid;
	}
	//接受传过来的要删除的id数组
	private String ids;	
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}	

	// 文件上传需要的三个属性:
	private File upload;
	private String uploadFileName;
	private String uploadContentType;

	public void setUpload(File upload) {
		this.upload = upload;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}	
	
	//查找所有商品
		public String findAll() throws IOException{
			ServletActionContext.getResponse().setContentType("application/json;charset=utf-8");//响应编码
			Page pageBean= productService.findAll(page,rows,order,sort,product,cid,csid);
		
			int total=pageBean.getTotalNums();//总记录数
			List list=pageBean.getList();//每条记录
		
			JsonConfig config = new JsonConfig();
			//除去emps属性,除去与一级菜单级联的属性（二级菜单的对象categoryseconds）
			  config.setExcludes(new String[]{"categorysecond","orderitems"});
		String rows=JSONArray.fromObject(list,config).toString();//转为json		
			JSONObject jo=new JSONObject();
			//easyui需要从后台取到数据总个数，并且键值必须是total
			jo.put("total", total);
			//easyui需要从后台取到数据，并且键值必须是rows
			jo.put("rows", rows);
			ServletActionContext.getResponse().getWriter().print(jo);	
			return NONE;
		}
		//增加商品
	public String add() throws IOException{
		
		if(upload != null){
	
			// 将商品图片上传到服务器上.
			// 获得上传图片的服务器端路径.
			String path = ServletActionContext.getServletContext().getRealPath(
					"/products");
			// 创建文件类型对象:
			File diskFile = new File(path + "//" + uploadFileName);
			// 文件上传:
			FileUtils.copyFile(upload, diskFile);
	
			product.setImage("products/" + uploadFileName);
		}

		productService.save(product);
		ServletActionContext.getResponse().getWriter().print("ok");	
		return NONE;
	}
	//通过pid查找商品
	public String findById(){
		Product proList=productService.findById(product.getPid());
	
		// 保存到值栈中:
		ActionContext.getContext().getValueStack().set("proList", proList);
		return "findSucc";
	}
	//删除一些商品
	public String delSome() throws IOException{
		int num=productService.delete(ids);
		ServletActionContext.getResponse().getWriter().print(num);
		return NONE;
	}
	//编辑商品
	public String edit() throws IOException{
		System.out.println(product.getImage()+"图片地址：******************");
		// 上传:
		if(upload != null){
			String delPath = ServletActionContext.getServletContext().getRealPath(
				"/" + product.getImage());
			File file = new File(delPath);
			file.delete();
			// 获得上传图片的服务器端路径.
			String path = ServletActionContext.getServletContext().getRealPath(
					"/products");
			// 创建文件类型对象:
			File diskFile = new File(path + "//" + uploadFileName);
			// 文件上传:
			FileUtils.copyFile(upload, diskFile);
				product.setImage("products/" + uploadFileName);
				}
	
		productService.update(product);	
		ServletActionContext.getResponse().getWriter().print("ok");
		return NONE;
	}
	/**
	 * ying 
	 */
	//根据二级菜单查询商品
	public String findByCsid(){
		System.out.println("in proManageAction method findByCsid()");
		this.rows=6;
		Page csidpro=productService.findByCsid(page,rows,csid);
		System.out.println("长度："+csidpro.getList().size());
		
		request.setAttribute("propage",csidpro);
		//将用户选择的二级菜单放入request中，用于jsp页面的判断
		request.setAttribute("option","twomenu");
		return "success";
	}
	
	//根据一级菜单查找商品
	public String findByCid(){
		System.out.println("in proManageAction method findByCid()");
		this.rows=6;
		System.out.println("cid:"+cid);
		Page cidpro=productService.findByCid(page,rows,cid);
		System.out.println("长度："+cidpro.getList().size());
		System.out.println("cid为:"+cid);
		request.setAttribute("propage",cidpro);
		//将用户选择的一级菜单放入request中，用于jsp页面的判断
		request.setAttribute("option","onemenu");
		return "success";
	}
}
