package com.guimei.domain;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Product entity. @author MyEclipse Persistence Tools
 */

public class Product implements java.io.Serializable {

	// Fields

	private Integer pid;
	private Categorysecond categorysecond;
	private String pname;
	private Double price;
	private String image;
	private String pdesc;
	private Integer isHot;
	private String pdate;
	private Integer count;
	private Set orderitems = new HashSet(0);

	// Constructors

	/** default constructor */
	public Product() {
	}



	// Property accessors

	public Integer getPid() {
		return this.pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Categorysecond getCategorysecond() {
		return this.categorysecond;
	}

	public void setCategorysecond(Categorysecond categorysecond) {
		this.categorysecond = categorysecond;
	}

	public String getPname() {
		return this.pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	

	public Double getPrice() {
		return price;
	}



	public void setPrice(Double price) {
		this.price = price;
	}



	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPdesc() {
		return this.pdesc;
	}

	public void setPdesc(String pdesc) {
		this.pdesc = pdesc;
	}

	public Integer getIsHot() {
		return this.isHot;
	}

	public void setIsHot(Integer isHot) {
		this.isHot = isHot;
	}



	public String getPdate() {
		return pdate;
	}



	public void setPdate(String pdate) {
		this.pdate = pdate;
	}



	public Set getOrderitems() {
		return this.orderitems;
	}

	public void setOrderitems(Set orderitems) {
		this.orderitems = orderitems;
	}



	public Integer getCount() {
		return count;
	}



	public void setCount(Integer count) {
		this.count = count;
	}

	
}