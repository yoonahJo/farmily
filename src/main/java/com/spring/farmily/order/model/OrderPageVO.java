package com.spring.farmily.order.model;

import java.util.List;

public class OrderPageVO {
	private List<OrderProductVO> orders;
	
	public List<OrderProductVO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderProductVO> orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "OrderPageVO [orders=" + orders + "]";
	}

	public void setPcode(String pcode) {
		// TODO Auto-generated method stub
		
	}
}