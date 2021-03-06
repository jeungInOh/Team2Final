package com.spring.tour.vo;

public class AccomInfoVo {
	private int accom_info_number;
	private int accom_service_number;
	private String accom_info_content;
	private String accom_how;
	private String accom_rule;
	private String accom_chekinfo;
	private String facility;
	private String conven;
	public AccomInfoVo() {}
	
	public AccomInfoVo(int accom_info_number, int accom_service_number, String accom_info_content, String accom_how,
			String accom_rule, String accom_chekinfo, String facility, String conven) {
		super();
		this.accom_info_number = accom_info_number;
		this.accom_service_number = accom_service_number;
		this.accom_info_content = accom_info_content;
		this.accom_how = accom_how;
		this.accom_rule = accom_rule;
		this.accom_chekinfo = accom_chekinfo;
		this.facility = facility;
		this.conven = conven;
	}

	public int getAccom_info_number() {
		return accom_info_number;
	}
	public void setAccom_info_number(int accom_info_number) {
		this.accom_info_number = accom_info_number;
	}
	public int getAccom_service_number() {
		return accom_service_number;
	}
	public void setAccom_service_number(int accom_service_number) {
		this.accom_service_number = accom_service_number;
	}
	public String getAccom_info_content() {
		return accom_info_content;
	}
	public void setAccom_info_content(String accom_info_content) {
		this.accom_info_content = accom_info_content;
	}
	public String getAccom_how() {
		return accom_how;
	}
	public void setAccom_how(String accom_how) {
		this.accom_how = accom_how;
	}
	public String getAccom_rule() {
		return accom_rule;
	}
	public void setAccom_rule(String accom_rule) {
		this.accom_rule = accom_rule;
	}
	public String getAccom_chekinfo() {
		return accom_chekinfo;
	}
	public void setAccom_chekinfo(String accom_chekinfo) {
		this.accom_chekinfo = accom_chekinfo;
	}
	public String getFacility() {
		return facility;
	}
	public void setFacility(String facility) {
		this.facility = facility;
	}
	public String getConven() {
		return conven;
	}
	public void setConven(String conven) {
		this.conven = conven;
	}
}
