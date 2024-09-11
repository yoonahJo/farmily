package com.spring.farmily.qna.model.farm;

import java.util.List;
import com.spring.farmily.qna.model.QnaVO;

public interface FarmQnaService {
    List<QnaVO> getMyQna(QnaVO vo);    // Q&A 리스트 가져오기
    QnaVO getQnaByCode(int qcode);     // Q&A 상세 조회
    void insertQna(QnaVO vo);          // Q&A 등록
    void updateQna(QnaVO vo);          // Q&A 수정
    void deleteQna(int qcode);         // Q&A 삭제
    void updateRating(QnaVO vo);       // 답변 평가 업데이트
    List<QnaVO> getQnaByPage(QnaVO vo, int page, int limit); // 페이징된 Q&A 리스트 가져오기
    int getQnaCount(QnaVO vo);         // Q&A 수 카운트
}