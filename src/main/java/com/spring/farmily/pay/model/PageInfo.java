package com.spring.farmily.pay.model;

public class PageInfo {
    
    private int page; // 현재페이지번호
    private int maxPage; // 총페이지끝번호
    private int startPage; // 현재페이징첫번호
    private int endPage; // 현재페이징마지막번호
    private int listCount; // 리스트수
    
    public int getPage() {
        return page;
    }
    
    public void setPage(int page) {
        this.page = page;
    }
    
    public int getMaxPage() {
        return maxPage;
    }
    
    public void setMaxPage(int maxPage) {
        this.maxPage = maxPage;
    }
    
    public int getStartPage() {
        return startPage;
    }
    
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
    
    public int getEndPage() {
        return endPage;
    }
    
    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }
    
    public int getListCount() {
        return listCount;
    }
    
    public void setListCount(int listCount) {
        this.listCount = listCount;
    }
}
