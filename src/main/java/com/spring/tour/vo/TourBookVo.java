package com.spring.tour.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class TourBookVo {
	private int tour_book_number;
	private String user_id;
	private int service_number;
	private String service_name;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd",timezone = "Asia/Seoul")
	private Date tour_startdate;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd",timezone = "Asia/Seoul")
	private Date tour_enddate;
	private String payment_condition;
	private int total_price;
	private int point_useamount;
	private String coupon_usecondition;
	private String payment_method;
	private String bookername;
	private String bookerphone;
	public TourBookVo() {}
	public TourBookVo(int tour_book_number, String user_id, int service_number, String service_name,
			Date tour_startdate, Date tour_enddate, String payment_condition, int total_price, int point_useamount,
			String coupon_usecondition, String payment_method, String bookername, String bookerphone) {
		super();
		this.tour_book_number = tour_book_number;
		this.user_id = user_id;
		this.service_number = service_number;
		this.service_name = service_name;
		this.tour_startdate = tour_startdate;
		this.tour_enddate = tour_enddate;
		this.payment_condition = payment_condition;
		this.total_price = total_price;
		this.point_useamount = point_useamount;
		this.coupon_usecondition = coupon_usecondition;
		this.payment_method = payment_method;
		this.bookername = bookername;
		this.bookerphone = bookerphone;
	}
	public int getTour_book_number() {
		return tour_book_number;
	}
	public void setTour_book_number(int tour_book_number) {
		this.tour_book_number = tour_book_number;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getService_number() {
		return service_number;
	}
	public void setService_number(int service_number) {
		this.service_number = service_number;
	}
	public String getService_name() {
		return service_name;
	}
	public void setService_name(String service_name) {
		this.service_name = service_name;
	}
	public Date getTour_startdate() {
		return tour_startdate;
	}
	public void setTour_startdate(Date tour_startdate) {
		this.tour_startdate = tour_startdate;
	}
	public Date getTour_enddate() {
		return tour_enddate;
	}
	public void setTour_enddate(Date tour_enddate) {
		this.tour_enddate = tour_enddate;
	}
	public String getPayment_condition() {
		return payment_condition;
	}
	public void setPayment_condition(String payment_condition) {
		this.payment_condition = payment_condition;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getPoint_useamount() {
		return point_useamount;
	}
	public void setPoint_useamount(int point_useamount) {
		this.point_useamount = point_useamount;
	}
	public String getCoupon_usecondition() {
		return coupon_usecondition;
	}
	public void setCoupon_usecondition(String coupon_usecondition) {
		this.coupon_usecondition = coupon_usecondition;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	public String getBookername() {
		return bookername;
	}
	public void setBookername(String bookername) {
		this.bookername = bookername;
	}
	public String getBookerphone() {
		return bookerphone;
	}
	public void setBookerphone(String bookerphone) {
		this.bookerphone = bookerphone;
	}
}
