package com.spring.farmily.qna.model.farm;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.spring.farmily.qna.model.QnaVO;

@Repository
public class FarmQnaDao {

    @Autowired
    private SqlSessionTemplate mybatis;

    public List<QnaVO> getMyQnaList(QnaVO vo) {
        return mybatis.selectList("qnaDao.getMyQnaList", vo);
    }

    public QnaVO getQnaByCode(int qcode) {
        return mybatis.selectOne("qnaDao.getQnaByCode", qcode);
    }

    public void insertQna(QnaVO vo) {
        mybatis.insert("qnaDao.insertQna", vo);
    }

    public void updateQna(QnaVO vo) {
        mybatis.update("qnaDao.updateQna", vo);
    }

    public void deleteQna(int qcode) {
        mybatis.delete("qnaDao.deleteQna", qcode);
    }

    public void updateRating(QnaVO vo) {
        mybatis.update("qnaDao.updateRating", vo);
    }

    public List<QnaVO> getQnaByPage(QnaVO vo) {
        return mybatis.selectList("qnaDao.getQnaByPage", vo);
    }

    public int getQnaCount(QnaVO vo) {
        return mybatis.selectOne("qnaDao.getQnaCount", vo);
    }
}