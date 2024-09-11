package com.spring.farmily.order.model;

import java.util.List;

public interface OrderService {
	List<OrderProductVO> getOrderInfo(List<OrderProductVO> orders);
    List<OrderProductVO> getRcodeInfo(List<OrderProductVO> orders);
}