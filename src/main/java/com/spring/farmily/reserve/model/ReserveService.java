package com.spring.farmily.reserve.model;

import java.util.List;


public interface ReserveService {
	List<ReserveVO> getMyReserveList(ReserveVO vo, int offset, int pageSize);
	int getTotalCount(ReserveVO vo);
	public int modifyCount(ReserveVO vo);
	public int deleteReserve(ReserveVO vo);
	public int insertReserve(ReserveVO vo);
	public boolean isProductInCart(ReserveVO vo);
	public int getRcode(ReserveVO vo);
	public int rstateUpdateReserve(ReserveVO vo);
	void updateCountReserve(ReserveVO vo);
}
