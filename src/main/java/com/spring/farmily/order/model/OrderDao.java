package com.spring.farmily.order.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDao {
    @Autowired
    private SqlSessionTemplate mybatis;

    public List<OrderProductVO> getOrderInfo(String pcode) {
        return mybatis.selectList("OrderDAO.getOrderInfo", pcode);
    }

    public List<OrderProductVO> getRcodeInfo(int rcode) {
        return mybatis.selectList("OrderDAO.getRcodeInfo", rcode);
    }
}