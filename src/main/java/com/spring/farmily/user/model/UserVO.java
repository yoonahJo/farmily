package com.spring.farmily.user.model;

import java.sql.Date;

public class UserVO {
	private String id;
	private String password;
	private String newpassword;
	private String uname;
	private String birth;
	private String email;
	private String phone;
	private String uaddress;
	private String uzcode;
	private char role;
	private char gender;
	private Date regdate;
	private String fname;
	private String fnum;
	private String faddress;
	private String fzcode;
	private String usercode;
	private String userSearchCondition;
	private String userSearchKeyword;
	
	
	
	public String getUserSearchCondition() {
		return userSearchCondition;
	}
	public void setUserSearchCondition(String userSearchCondition) {
		this.userSearchCondition = userSearchCondition;
	}
	public String getUserSearchKeyword() {
		return userSearchKeyword;
	}
	public void setUserSearchKeyword(String userSearchKeyword) {
		this.userSearchKeyword = userSearchKeyword;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getNewpassword() {
		return newpassword;
	}
	
	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}
	
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUaddress() {
		return uaddress;
	}
	public void setUaddress(String uaddress) {
		this.uaddress = uaddress;
	}
	public String getUzcode() {
		return uzcode;
	}
	public void setUzcode(String uzcode) {
		this.uzcode = uzcode;
	}
	public char getRole() {
		return role;
	}
	public void setRole(char role) {
		this.role = role;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
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
	
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", password=" + password + ", uname=" + uname + ", birth=" + birth + ", email="
				+ email + ", phone=" + phone + ", uaddress=" + uaddress + ", uzcode=" + uzcode + ", role=" + role
				+ ", gender=" + gender + ", regdate=" + regdate + ", fname=" + fname + ", fnum=" + fnum + ", faddress="
				+ faddress + ", fzcode=" + fzcode + ", usercode=" + usercode + "]";
	}
	
}
