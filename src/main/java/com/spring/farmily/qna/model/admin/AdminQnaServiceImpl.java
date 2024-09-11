package com.spring.farmily.qna.model.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.farmily.qna.model.QnaVO;

@Service
public class AdminQnaServiceImpl implements AdminQnaService{
	
	@Autowired
	private AdminQnaDao adminQnaDao;

	@Override
	public List<QnaVO> getAllQna(QnaVO vo, int page, int limit) {
		int offset = (page - 1) * limit;
	    vo.setLimit(limit);
	    vo.setOffset(offset);
		return adminQnaDao.getQnaList(vo);
	}

	
	@Override
	public QnaVO getQnaByCode(int qcode) {
	    return adminQnaDao.getQnaByCode(qcode);
	}
	

	
	public void insertReply(QnaVO vo) {
		adminQnaDao.updateQnaReply(vo);
	}
	 @Override
	    public void deleteReply(int qcode) {
		 adminQnaDao.deleteReply(qcode);
	    }


@Override
	public int getAllQnaCount(QnaVO vo) {
		// TODO Auto-generated method stub
		return adminQnaDao.getAllQnaCount(vo);
	}
	 
@Override
public void deleteQna(int qcode) {
    adminQnaDao.deleteQna(qcode);
}

	 
}
