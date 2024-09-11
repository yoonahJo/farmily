package com.spring.farmily.reserve.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("reserveService")
public class ReserveServiceImpl implements ReserveService{
		@Autowired
		private ReserveDao reserveDao;
		
		public List<ReserveVO> getMyReserveList(ReserveVO vo, int offset, int pageSize) {
		    return reserveDao.getMyReserveList(vo, offset, pageSize);
		}
		
		@Override
		 public int getTotalCount(ReserveVO vo) {
		     return reserveDao.getTotalCount(vo); // DAO에서 호출
		    }
		
		@Override
		public int modifyCount(ReserveVO vo) {
			
			return reserveDao.modifyCount(vo);
		}
		
		@Override
		public int deleteReserve(ReserveVO vo) {
			
			return reserveDao.deleteReserve(vo);
		}
		
		@Override
		public int insertReserve(ReserveVO vo) {
			return reserveDao.insertReserve(vo);
		}
		
		@Override
		public boolean isProductInCart(ReserveVO vo) {
			
			return reserveDao.isProductInCart(vo);
		}
		
		@Override
		public int getRcode(ReserveVO vo) {
			
			return reserveDao.getRcode(vo);
		}
		
		@Override
		public int rstateUpdateReserve(ReserveVO vo) {
			
			return reserveDao.rstateUpdateReserve(vo);
		}
		
		@Override
		public void updateCountReserve(ReserveVO vo) {
			
			reserveDao.updateCountReserve(vo);
		}
	}
