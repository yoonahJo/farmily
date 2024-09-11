package com.spring.farmily.pay.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("payService")
public class PayServiceImpl implements PayService {

    @Autowired
    private PayDao payDao;

    @Override
    public boolean insertPay(PayVO vo) {
        return payDao.insertPay(vo);
    }
    
    @Override
    public List<PayVO> getMyPayList(PayVO vo) {
        return payDao.getMyPayList(vo);
    } 
    
    @Override
	public PageInfo getPageInfo(PayVO vo, int page, int limit) {
		int listCount = payDao.listCount(vo);
        int maxPage = (int) Math.ceil((double) listCount / limit);
        int startPage = ((page - 1) / 5) * 5 + 1; // 페이지 블록 시작
        int endPage = Math.min(startPage + 5 - 1, maxPage); // 페이지 블록 끝

        PageInfo pageInfo = new PageInfo();
        pageInfo.setPage(page);
        pageInfo.setMaxPage(maxPage);
        pageInfo.setStartPage(startPage);
        pageInfo.setEndPage(endPage);
        pageInfo.setListCount(listCount);

        return pageInfo;
	}

	@Override
	public void getPayDelete(String merchant_uid) {
		payDao.getPayDelete(merchant_uid);
	}
	
	@Override
	public int getPageItemCount(int page, int limit, String paySearchKeyword) {
		return payDao.getPageItemCount(page, limit, paySearchKeyword);
	}


	@Override
    public List<PayVO> getMyPayListByMerchantUid(PayVO vo) {
            return payDao.getMyPayListByMerchantUid(vo);
	}
    
    @Override
    public List<PayVO> getMyPayListDetail(PayVO vo) {
        return payDao.getMyPayListDetail(vo);
    }
    
    @Override
    public Map<String, Boolean> getOrderStates(PayVO vo) {
        List<Map<String, String>> result = payDao.getOrderStates(vo);
        Map<String, Boolean> orderStates = new HashMap<>();

        for (Map<String, String> row : result) {
            String merchantUid = row.get("MERCHANT_UID");
            String status = row.get("STATUS");
            boolean allItemsDelivered = "배송완료".equals(status);
            orderStates.put(merchantUid, allItemsDelivered);
        }

        return orderStates;
    }

    @Override
    public void updateDeliveryState(int paycode) {
        payDao.updateDeliveryState(paycode);
    }
	
    
    
}