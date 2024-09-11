package com.spring.farmily.order.model;

public class OrderProductVO {
	
	private String pcode;
	private int pcount;
	private String pname;
	private int price;
	private String pimg;
	private String fname;
	private int totalprice;
	private int rcode;
	private String rdelcheck;
	
	
	
	
	public void initSaleTotal() {
	    if (this.pcount > 0 && this.price > 0) {
	        this.totalprice = this.price * this.pcount;
	    } else {
	        this.totalprice = 0;
	    }
	}


	public String getPcode() {
		return pcode;
	}



	public void setPcode(String pcode) {
		this.pcode = pcode;
	}



	public int getPcount() {
		return pcount;
	}



	public void setPcount(int pcount) {
		this.pcount = pcount;
	}



	public String getPname() {
		return pname;
	}



	public void setPname(String pname) {
		this.pname = pname;
	}



	public int getPrice() {
		return price;
	}



	public void setPrice(int price) {
		this.price = price;
	}



	public String getPimg() {
		return pimg;
	}



	public void setPimg(String pimg) {
		this.pimg = pimg;
	}



	public String getFname() {
		return fname;
	}



	public void setFname(String fname) {
		this.fname = fname;
	}



	public int getTotalprice() {
		return totalprice;
	}



	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}



	public int getRcode() {
		return rcode;
	}



	public void setRcode(int rcode) {
		this.rcode = rcode;
	}

	

	@Override
	public String toString() {
		return "OrderProductVO [pcode=" + pcode + ", pcount=" + pcount + ", pname=" + pname + ", price=" + price
				+ ", pimg=" + pimg + ", fname=" + fname + ", totalprice=" + totalprice + ", rcode=" + rcode
				+ ", rdelcheck=" + rdelcheck + "]";
	}


	public String getRdelcheck() {
		return rdelcheck;
	}


	public void setRdelcheck(String rdelcheck) {
		this.rdelcheck = rdelcheck;
	}

	
}