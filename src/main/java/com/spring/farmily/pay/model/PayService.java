package com.spring.farmily.pay.model;

import java.util.List;
import java.util.Map;

public interface PayService {
	public boolean insertPay(PayVO vo);
	List<PayVO> getMyPayList(PayVO vo);
	PageInfo getPageInfo(PayVO vo, int page, int limit);
	public void getPayDelete(String merchant_uid);
	
	List<PayVO> getMyPayListByMerchantUid(PayVO vo);
	List<PayVO> getMyPayListDetail(PayVO vo);
	public Map<String, Boolean> getOrderStates(PayVO vo);
	public int getPageItemCount(int page, int limit, String paySearchKeyword);
	void updateDeliveryState(int paycode); 
}
