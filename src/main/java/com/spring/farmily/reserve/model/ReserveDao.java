package com.spring.farmily.reserve.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReserveDao {

		@Autowired
		private SqlSessionTemplate mybatis;

		public List<ReserveVO> getMyReserveList(ReserveVO vo, int offset, int pageSize) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("id", vo.getId());  // ReserveVO의 id를 직접 매핑
	        params.put("offset", offset);
	        params.put("pageSize", pageSize);

	        return mybatis.selectList("ReserveDAO.getMyReserveList", params);
	    }
		
		public int getTotalCount(ReserveVO vo) {
			return mybatis.selectOne("ReserveDAO.getTotalCount", vo);
		}
		
		
		public int modifyCount(ReserveVO vo) {
			return mybatis.update("ReserveDAO.modifyCount", vo);
		}
		
		public int deleteReserve(ReserveVO vo) {
			return mybatis.update("ReserveDAO.deleteReserve", vo);
		}
		
		public int insertReserve(ReserveVO vo) {
			return mybatis.insert("ReserveDAO.insertReserve", vo);
		}
		
		public boolean isProductInCart(ReserveVO vo) {
	        Integer count = mybatis.selectOne("ReserveDAO.isProductInCart", vo);
	        return count != null && count > 0;
	    }
		
		public int getRcode(ReserveVO vo) {
			return mybatis.selectOne("ReserveDAO.getRcode", vo);
		}
		
		public int rstateUpdateReserve(ReserveVO vo) {
			return mybatis.update("ReserveDAO.rstateUpdateReserve", vo);
		}
		
		public void updateCountReserve(ReserveVO vo) {
			mybatis.update("ReserveDAO.updateCountReserve", vo);
		}
		
	}
