package com.guimei.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * Category entity. @author MyEclipse Persistence Tools
 */

public class Category implements java.io.Serializable {

	// Fields

	private Integer cid;
	private String cname;
	private Set categoryseconds = new HashSet(0);

	// Constructors

	/** default constructor */
	public Category() {
	}

	

	// Property accessors

	public Integer getCid() {
		return this.cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public Set getCategoryseconds() {
		return this.categoryseconds;
	}

	public void setCategoryseconds(Set categoryseconds) {
		this.categoryseconds = categoryseconds;
	}

}