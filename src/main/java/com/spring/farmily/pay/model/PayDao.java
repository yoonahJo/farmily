package com.spring.farmily.pay.model;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class PayDao {

    @Autowired
    private SqlSessionTemplate mybatis;

    public boolean insertPay(PayVO vo) {
        int result = mybatis.insert("PayDAO.insertPay", vo);
        return result > 0; // 삽입된 행의 수가 0보다 크면 true 반환
    }
    
    public List<PayVO> getMyPayList(PayVO vo) {
		return mybatis.selectList("PayDAO.getMyPayList", vo);
	}
    
    public int listCount(PayVO vo) {
		return mybatis.selectOne("PayDAO.listCount", vo);
	}

	public int getPayDelete(String merchant_uid) {
		return mybatis.update("PayDAO.getPayDelete", merchant_uid);
	}
	
	public int getPageItemCount(int page, int limit, String paySearchKeyword) {
		Map<String, Object> params = new HashMap<>();
		params.put("page", page);
		params.put("limit", limit);
		params.put("paySearchKeyword", paySearchKeyword);
		return mybatis.selectOne("PayDAO.getPageItemCount", params);
	}

	
	public List<Map<String, String>> getOrderStates(PayVO vo) {
        System.out.println("===> mybatis로 getOrderStates() 기능 처리");
        return mybatis.selectList("PayDAO.getOrderStates", vo);
    }
	
	
	public List<PayVO> getMyPayListDetail(PayVO vo) {
		return mybatis.selectList("PayDAO.getMyPayListDetail", vo);
	}
    
    public List<PayVO> getMyPayListByMerchantUid(PayVO vo) {
		return mybatis.selectList("PayDAO.getMyPayListByMerchantUid", vo);
	}
    public void updateDeliveryState(int paycode) {
        mybatis.update("PayDAO.updateDelivery", paycode);
    }
}

