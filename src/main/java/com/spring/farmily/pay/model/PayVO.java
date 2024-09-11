package com.spring.farmily.pay.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PayVO {
	private int paycode;
	private String id;
	private String code;
	private int rcode;
	private String imp_uid;
	private String merchant_uid;
	private String name;
	private int amount;
	private int quantity;
	private String buyer_name;
	private String buyer_email;
	private String buyer_tel;
	private String buyer_addr;
	private String buyer_postcode;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date paydate;
	private String dstate;
	private String rstate;
	private String pay_method;
	private String fnum;
	private String pimg;
	private int unitPrice;
	private Date baesongdate;
    private String paydelcheck;
	private String paySearchKeyword;
	private int offset;
	private int limit;
	private int page;
	private String searchCondition; 
    private String searchKeyword;
    private String fname;
    
    
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
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
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPaycode() {
		return paycode;
	}
	public void setPaycode(int paycode) {
		this.paycode = paycode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getRcode() {
		return rcode;
	}
	public void setRcode(int rcode) {
		this.rcode = rcode;
	}
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public String getMerchant_uid() {
		return merchant_uid;
	}
	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getBuyer_name() {
		return buyer_name;
	}
	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}
	public String getBuyer_email() {
		return buyer_email;
	}
	public void setBuyer_email(String buyer_email) {
		this.buyer_email = buyer_email;
	}
	public String getBuyer_tel() {
		return buyer_tel;
	}
	public void setBuyer_tel(String buyer_tel) {
		this.buyer_tel = buyer_tel;
	}
	public String getBuyer_addr() {
		return buyer_addr;
	}
	public void setBuyer_addr(String buyer_addr) {
		this.buyer_addr = buyer_addr;
	}
	public String getBuyer_postcode() {
		return buyer_postcode;
	}
	public void setBuyer_postcode(String buyer_postcode) {
		this.buyer_postcode = buyer_postcode;
	}
	public Date getPaydate() {
		return paydate;
	}
	public void setPaydate(Date paydate) {
		this.paydate = paydate;
	}
	public String getDstate() {
		return dstate;
	}
	public void setDstate(String dstate) {
		this.dstate = dstate;
	}
	public String getRstate() {
		return rstate;
	}
	public void setRstate(String rstate) {
		this.rstate = rstate;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getFnum() {
		return fnum;
	}
	public void setFnum(String fnum) {
		this.fnum = fnum;
	}
	public String getPimg() {
		return pimg;
	}
	public void setPimg(String pimg) {
		this.pimg = pimg;
	}
	public int getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}
	public Date getBaesongdate() {
		return baesongdate;
	}
	public void setBaesongdate(Date baesongdate) {
		this.baesongdate = baesongdate;
	}
	public String getPaydelcheck() {
		return paydelcheck;
	}
	public void setPaydelcheck(String paydelcheck) {
		this.paydelcheck = paydelcheck;
	}
	public String getPaySearchKeyword() {
		return paySearchKeyword;
	}
	public void setPaySearchKeyword(String paySearchKeyword) {
		this.paySearchKeyword = paySearchKeyword;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}

	
}