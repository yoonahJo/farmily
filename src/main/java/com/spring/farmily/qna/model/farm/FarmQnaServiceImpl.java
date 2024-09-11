package com.spring.farmily.qna.model.farm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.farmily.qna.model.QnaVO;

@Service
public class FarmQnaServiceImpl implements FarmQnaService {

    @Autowired
    private FarmQnaDao farmQnaDao;

    @Override
    public List<QnaVO> getMyQna(QnaVO vo) {
        return farmQnaDao.getMyQnaList(vo);
    }

    @Override
    public QnaVO getQnaByCode(int qcode) {
        return farmQnaDao.getQnaByCode(qcode);
    }

    @Override
    public void insertQna(QnaVO vo) {
        farmQnaDao.insertQna(vo);
    }

    @Override
    public void updateQna(QnaVO vo) {
        farmQnaDao.updateQna(vo);
    }

    @Override
    public void deleteQna(int qcode) {
        farmQnaDao.deleteQna(qcode);
    }

    @Override
    public void updateRating(QnaVO vo) {
        farmQnaDao.updateRating(vo);
    }

    @Override
    public List<QnaVO> getQnaByPage(QnaVO vo, int page, int limit) {
        int offset = (page - 1) * limit; // 페이징을 위한 offset 계산
        vo.setOffset(offset);
        vo.setLimit(limit);
        return farmQnaDao.getQnaByPage(vo);
    }

    @Override
    public int getQnaCount(QnaVO vo) {
        return farmQnaDao.getQnaCount(vo);
    }
}