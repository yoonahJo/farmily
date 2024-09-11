package com.spring.farmily.qna.model.admin;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.farmily.qna.model.QnaVO;


@Repository
public class AdminQnaDao {
	
	@Autowired
    private SqlSessionTemplate mybatis;

    public List<QnaVO> getQnaList(QnaVO vo) {
        return mybatis.selectList("qnaDao.getQnaList", vo);
    }

    
    public QnaVO getQnaByCode(int qcode) {
        return mybatis.selectOne("qnaDao.getQnaByCode", qcode);
    }
    

    public void updateQnaReply(QnaVO vo) {
        mybatis.update("qnaDao.updateQnaReply", vo);
    }
    public void deleteReply(int qcode) {
        mybatis.update("qnaDao.deleteReply", qcode);
    }
    public int getAllQnaCount(QnaVO vo) {
        return mybatis.selectOne("qnaDao.getAllQnaCount", vo);
    }
    public void deleteQna(int qcode) {
        mybatis.delete("qnaDao.deleteQna", qcode);
    }

    
}
	

