package com.spring.farmily.reserve.model.admin;

import java.util.List; 

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.farmily.product.model.ProductVO;
import com.spring.farmily.reserve.model.ReserveVO;
import com.spring.farmily.user.model.UserVO;

@Repository("adminReserveDao")
public class ReserveDao {

	@Autowired
	private SqlSessionTemplate mybatis;

	public List<ReserveVO> getAdminReserveList(ReserveVO vo) {
		System.out.println("===> mybatis로 getAdminReserveList() 기능 처리");
		return mybatis.selectList("ReserveDAO.getAdminReserveList", vo);
	}
	
	public int listCount(ReserveVO vo) {
		System.out.println("===> Mybatis로 listCount() 기능 처리");
		return mybatis.selectOne("ReserveDAO.listCount", vo);
	}

	public int adminModifyCount(ReserveVO vo) {
		System.out.println("===> mybatis로 adminModifyCount() 기능 처리");
		System.out.println("ReserveVO: " + vo.toString());
		return mybatis.update("ReserveDAO.adminModifyCount", vo);
	}

	public ReserveVO getAdminReserveDetail(int rcode) {
		System.out.println("===> mybatis로 getAdminReserveDetail() 기능 처리");
		return (ReserveVO) mybatis.selectOne("ReserveDAO.getAdminReserveDetail", rcode);
	}
	
	public int getAdminReserveDelete(int rcode) {
		System.out.println("===> mybatis로 getAdminReserveDelete() 기능 처리");
		return mybatis.update("ReserveDAO.getAdminReserveDelete", rcode);
	}

	public List<ProductVO> getProductList(ProductVO vo) {
		System.out.println("===> mybatis로 getProductList() 기능 처리");
		return mybatis.selectList("ReserveDAO.getProductList", vo);
	}

	public List<UserVO> getUserList(UserVO vo) {
		System.out.println("===> mybatis로 getUserList() 기능 처리");
		return mybatis.selectList("ReserveDAO.getUserList", vo);
	}

	public void reserveInsert(ReserveVO vo) {
		System.out.println("===> Mybatis로 reserveInsert() 기능 처리");
		mybatis.insert("ReserveDAO.reserveInsert", vo);
	}
}
