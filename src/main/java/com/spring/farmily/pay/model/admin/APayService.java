package com.spring.farmily.pay.model.admin;

import java.util.List;
import com.spring.farmily.pay.model.PayVO;

public interface APayService {
    List<PayVO> getPayList(String searchType, String searchField, int limit, int offset); // 페이징을 포함한 메서드
    List<PayVO> getPayList(String searchType, String searchField); // 기존 메서드
    int getTotalCount(String searchType, String searchField);
    int updatePay(PayVO vo);
    PayVO getPayDetail(String paycode);
}
