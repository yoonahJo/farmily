package com.spring.farmily.pay.model.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.farmily.pay.model.PayVO;

@Service
public class APayServicelmpl implements APayService {

    @Autowired
    private APayDao apayDao;

    @Override
    public List<PayVO> getPayList(String searchType, String searchField, int limit, int offset) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchField", searchField);
        params.put("limit", limit);
        params.put("offset", offset);
        return apayDao.getPayList(params);
    }

    @Override
    public List<PayVO> getPayList(String searchType, String searchField) {
        // 기본 호출 시 페이징 없이 호출되는 경우
        return getPayList(searchType, searchField, 10, 0); // 기본값으로 페이징 처리
    }

    @Override
    public int getTotalCount(String searchType, String searchField) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchField", searchField);
        return apayDao.getTotalCount(params);
    }

    @Override
    public int updatePay(PayVO vo) {
        return apayDao.updatePay(vo);
    }

    @Override
    public PayVO getPayDetail(String paycode) {
        return apayDao.getPayDetail(paycode);
    }
}
