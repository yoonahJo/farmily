package com.spring.farmily.qna.model.admin;

import java.util.List;

import com.spring.farmily.qna.model.QnaVO;

public interface AdminQnaService {
	
	public List<QnaVO> getAllQna(QnaVO vo, int page, int limit);
	public QnaVO getQnaByCode(int qcode);
	int getAllQnaCount(QnaVO vo);
	public void insertReply(QnaVO vo);
	 void deleteReply(int qcode); //답변삭제
	 void deleteQna(int qcode);         // Q&A 삭제
}
