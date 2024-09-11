package com.spring.farmily.qna.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class QnaVO {
    private int qcode;               // 문의 고유 번호
    private String id;               // 문의자 및 답변자의 ID
    private String title;            // 문의 제목
    private String content;          // 문의 내용
    private Date postdate;           // 문의 작성 날짜
    private String rcontent;         // 답변 내용 (null 가능)
    private Date rpostdate;          // 답변 작성 날짜 (null 가능)
    private String status;           // 문의 상태 (미답변, 답변완료)
    private int rating;              // 답변 만족도 (별 5개 기준)
    private String image;
    private MultipartFile uploadFile;
    private String searchKeyword;    // 검색 키워드
    private String searchCondition;
    private int page;                // 현재 페이지 번호
    private int limit;               // 한 페이지에 보여줄 게시물 수
    private int offset;              // 페이징을 위한 오프셋
   
    
    
    
    

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public int getQcode() {
		return qcode;
	}
	public void setQcode(int qcode) {
		this.qcode = qcode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getPostdate() {
		return postdate;
	}
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public Date getRpostdate() {
		return rpostdate;
	}
	public void setRpostdate(Date rpostdate) {
		this.rpostdate = rpostdate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
    
    
}
