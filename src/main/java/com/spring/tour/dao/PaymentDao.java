package com.spring.tour.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.tour.vo.PaymentVo;


@Repository
public class PaymentDao {
	
	@Autowired
	private SqlSession sqlsession;
	
	private final String NAMESPACE= "com.spring.tour.mapper.PayMapper";
	
	public PaymentVo getUserInfo(String user_id) {
		return sqlsession.selectOne(NAMESPACE+".getUserInfo",user_id);		
	}
	
	// 투어 관련
	public int insertTourBook(HashMap<String, Object> map) {
		return sqlsession.insert(NAMESPACE+".insertTourBook",map);
	}
	
	public int insertTourBookOption(HashMap<String, Object> map) {
		return sqlsession.insert(NAMESPACE+".insertTourBookOption",map);
	}
	
	public int tourBookMax() {
		return sqlsession.selectOne(NAMESPACE+".tourBookMax");
	}
	
	// 숙박 관련 
	public int insertAccomBook(HashMap<String, Object> map) {
		return sqlsession.insert(NAMESPACE+".insertAccomBook",map);
	}
	
	public int insertVisitorInfo(HashMap<String, Object> map) {
		return sqlsession.insert(NAMESPACE+".insertVisitorInfo",map);
	}
	
	public int AccomBookMax() {
		return sqlsession.selectOne(NAMESPACE+".AccomBookMax");
	}
	
	
	//공통 부분 
	public int updatePoint(HashMap<String, Object> map) {
		return sqlsession.update(NAMESPACE+".updatePoint", map);
	}
	public int pointPlus(HashMap<String, Object> map) {
		return sqlsession.update(NAMESPACE+".pointPlus", map);
	}
	public int updateCoupon(HashMap<String, Object> map) {
		return sqlsession.update(NAMESPACE+".updateCoupon", map);
	}
	public int updateTicket(HashMap<String, Object> map) {
		return sqlsession.update(NAMESPACE+".updateTicket", map);
	}
	public int getAccomTotal(String user_id) {
		return sqlsession.selectOne(NAMESPACE+".accomTotal", user_id);
	}
	public int getTourTotal(String user_id) {
		return sqlsession.selectOne(NAMESPACE+".tourTotal", user_id);
	}
	public int changeGrade(HashMap<String, Object> map) {
		return sqlsession.update(NAMESPACE+".changeGrade", map);
	}
}
	
	
	
	
	
	
