package com.spring.farmily.product.model;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
    private String pcode;
    private String pname;
    private String ptype;
    private int price;    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date creDate;
    private String pimg; 
    private String des;
    private Date pregDate;
    private String quality;
    private String id;
    private String fname;  // 수정된 부분
    private String fnum;
    private String faddress;
    private String fzcode;
    private MultipartFile uploadFile; 
    private MultipartFile[] uploadFiles; // 다중 파일
    private String searchCondition;  
    private String searchKeyword;    
    private int limit;
    private int offset;
    private int page;
    private int pcount;
    private String pdelcheck;
    // 기존 Getter와 Setter 메소드
    
    public String getPdelcheck() {
		return pdelcheck;
	}
	public void setPdelcheck(String pdelcheck) {
		this.pdelcheck = pdelcheck;
	}
    
    public int getPcount() {
        return pcount;
    }
	public void setPcount(int pcount) {
        this.pcount = pcount;
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
    public MultipartFile[] getUploadFiles() {
        return uploadFiles;
    }
    public void setUploadFiles(MultipartFile[] uploadFiles) {
        this.uploadFiles = uploadFiles;
    }
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
    public String getPcode() {
        return pcode;
    }
    public void setPcode(String pcode) {
        this.pcode = pcode;
    }
    public String getPname() {
        return pname;
    }
    public void setPname(String pname) {
        this.pname = pname;
    }
    public String getPtype() {
        return ptype;
    }
    public void setPtype(String ptype) {
        this.ptype = ptype;
    }
    public int getPrice() {
        return price;
    }
    public void setPrice(int price) {
        this.price = price;
    }
    public Date getCreDate() {
        return creDate;
    }
    public void setCreDate(Date creDate) {
        this.creDate = creDate;
    }
    public String getPimg() {
        return pimg;
    }
    public void setPimg(String pimg) {
        this.pimg = pimg;
    }
    public String getDes() {
        return des;
    }
    public void setDes(String des) {
        this.des = des;
    }
    public Date getPregDate() {
        return pregDate;
    }
    public void setPregDate(Date pregDate) {
        this.pregDate = pregDate;
    }
    public String getQuality() {
        return quality;
    }
    public void setQuality(String quality) {
        this.quality = quality;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getFname() {  // 수정된 부분
        return fname;
    }
    public void setFname(String fname) {  // 수정된 부분
        this.fname = fname;
    }
    public String getFnum() {
        return fnum;
    }
    public void setFnum(String fnum) {
        this.fnum = fnum;
    }
    public String getFaddress() {
        return faddress;
    }
    public void setFaddress(String faddress) {
        this.faddress = faddress;
    }
    public String getFzcode() {
        return fzcode;
    }
    public void setFzcode(String fzcode) {
        this.fzcode = fzcode;
    }
    public MultipartFile getUploadFile() {
        return uploadFile;
    }
    public void setUploadFile(MultipartFile uploadFile) {
        this.uploadFile = uploadFile;
    }
}
