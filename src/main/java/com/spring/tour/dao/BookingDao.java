package com.spring.tour.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.tour.vo.AccomBookVo;

@Repository
public class BookingDao {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="com.spring.tour.mapper.BookingMapper";
	
	public List<AccomBookVo> accomBookList(HashMap<String, Object> accomMap){
		return sqlSession.selectList(NAMESPACE+".accomBookingList", accomMap);
	}
	public int accomCount(String user_id) {
		return sqlSession.selectOne(NAMESPACE+".accomBookingCount", user_id);
	}
}
