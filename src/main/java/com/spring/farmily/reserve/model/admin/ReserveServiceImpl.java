package com.spring.farmily.reserve.model.admin;

import java.util.List;  

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.reserve.model.ReserveVO;
import com.spring.farmily.user.model.UserVO;

@Service("adminReserveService")
public class ReserveServiceImpl implements ReserveService {
	@Autowired
	private ReserveDao adminReserveDao;

	@Override
	public List<ReserveVO> getAdminReserveList(ReserveVO vo) {
		return adminReserveDao.getAdminReserveList(vo);
	}

	@Override
	public PageInfo getPageInfo(ReserveVO vo, int page, int limit) {
		int listCount = adminReserveDao.listCount(vo);
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
	public int adminModifyCount(ReserveVO vo) {
		return adminReserveDao.adminModifyCount(vo);
	}

	@Override
	public ReserveVO getAdminReserveDetail(int rcode) {
		return adminReserveDao.getAdminReserveDetail(rcode);
	}
	
	@Override
	public void getAdminReserveDelete(int rcode) {
		adminReserveDao.getAdminReserveDelete(rcode);
	}

	@Override
	public void reserveInsert(ReserveVO vo) {
		adminReserveDao.reserveInsert(vo);
	}
	
	@Override
	public List<ProductVO> getProductList(ProductVO vo) {
		return adminReserveDao.getProductList(vo);
	}
	
	@Override
	public List<UserVO> getUserList(UserVO vo) {
		return adminReserveDao.getUserList(vo);
	}
}
