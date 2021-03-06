package com.spring.tour.vo;

public class User_InfoVo {
	private String user_id;
	private String user_pass;
	private String user_name;
	private String user_grade;
	private String user_email;
	private String user_addr;
	private String user_phone;
	private String user_condition;
	private String user_point;
	
	public User_InfoVo() {}
	
	public User_InfoVo(String user_id, String user_pass, String user_name, String user_grade, String user_email,
			String user_addr, String user_phone, String user_condition, String user_point) {
		super();
		this.user_id = user_id;
		this.user_pass = user_pass;
		this.user_name = user_name;
		this.user_grade = user_grade;
		this.user_email = user_email;
		this.user_addr = user_addr;
		this.user_phone = user_phone;
		this.user_condition = user_condition;
		this.user_point = user_point;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pass() {
		return user_pass;
	}

	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_grade() {
		return user_grade;
	}

	public void setUser_grade(String user_grade) {
		this.user_grade = user_grade;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_addr() {
		return user_addr;
	}

	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_condition() {
		return user_condition;
	}

	public void setUser_condition(String user_condition) {
		this.user_condition = user_condition;
	}

	public String getUser_point() {
		return user_point;
	}

	public void setUser_point(String user_point) {
		this.user_point = user_point;
	}

	@Override
	public String toString() {
		return "User_InfoVo [user_id=" + user_id + ", user_pass=" + user_pass + ", user_name=" + user_name
				+ ", user_grade=" + user_grade + ", user_email=" + user_email + ", user_addr=" + user_addr
				+ ", user_phone=" + user_phone + ", user_condition=" + user_condition + ", user_point=" + user_point
				+ "]";
	}
	
}
