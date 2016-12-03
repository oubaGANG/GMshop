package com.guimei.service;

import java.io.Serializable;

import com.guimei.domain.Orderitem;

public interface OrderitemService {
	public void save(Orderitem orderitem);
	public void delete(Orderitem instance);
	public Orderitem findById(Serializable id);
}
