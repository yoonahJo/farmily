package com.spring.farmily.reserve.model.admin;

import java.util.List;  

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.reserve.model.ReserveVO;
import com.spring.farmily.user.model.UserVO;


public interface ReserveService {
	List<ReserveVO> getAdminReserveList(ReserveVO vo);
	public int adminModifyCount(ReserveVO vo);
	ReserveVO getAdminReserveDetail(int rcode);
	void getAdminReserveDelete(int rcode);
	void reserveInsert(ReserveVO vo);
	
	List<ProductVO> getProductList(ProductVO vo);
	List<UserVO> getUserList(UserVO vo);
	PageInfo getPageInfo(ReserveVO vo, int page, int limit);
}
