package com.spring.farmily.user.model;

import java.util.Date;

public class SocialVO {
	private String id;
	private String sns_id;
	private String sns_type;
	private String sns_name;
	private Date sns_connect_date;
	private String email;
	private char gender;
	private String birth;
	private String birthday;
	private String birthyear;
	private String mobile;
	private char role;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getSns_id() {
		return sns_id;
	}
	
	public void setSns_id(String sns_id) {
		this.sns_id = sns_id;
	}
	
	public String getSns_type() {
		return sns_type;
	}
	
	public void setSns_type(String sns_type) {
		this.sns_type = sns_type;
	}
	
	public String getSns_name() {
		return sns_name;
	}
	public void setSns_name(String sns_name) {
		this.sns_name = sns_name;
	}
	
	public Date getSns_connect_date() {
		return sns_connect_date;
	}
	
	public void setSns_connect_date(Date sns_connect_date) {
		this.sns_connect_date = sns_connect_date;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	
	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public String getBirth() {
		return birth;
	}
	
	public void setBirth(String birth) {
		this.birth = birth;
	}
	
	public String getBirthday() {
		return birthday;
	}
	
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getBirthyear() {
		return birthyear;
	}
	
	public void setBirthyear(String birthyear) {
		this.birthyear = birthyear;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	public char getRole() {
		return role;
	}
	
	public void setRole(char role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "SocialVO [id=" + id + ", sns_id=" + sns_id + ", sns_type=" + sns_type + ", sns_name=" + sns_name
				+ ", sns_connect_date=" + sns_connect_date + ", email=" + email + ", gender=" + gender + ", birth="
				+ birth + ", birthday=" + birthday + ", birthyear=" + birthyear + ", mobile=" + mobile + ", role="
				+ role + "]";
	}
	
	
	
}
