package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.CalendarDao;
import com.mmong.vo.Calendar;

@Repository
public class CalendarDaoImpl implements CalendarDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.calendarMapper."+id;
	}

	@Override
	public int insertSchedule(Calendar calendar) {
		return session.insert(makeSqlId("insertSchedule"), calendar);
	}

	@Override
	public List<Calendar> selectSchedule(String memberId) {
		return session.selectList(makeSqlId("selectSchedule"), memberId);
	}

	@Override
	public Calendar viewSchedule(int eventNo) {
		return session.selectOne(makeSqlId("viewSchedule"), eventNo);
	}

	@Override
	public void deleteSchedule(int no) {
		session.delete(makeSqlId("deleteSchedule"), no);
	}

	@Override
	public void updateSchedule(Calendar calendar) {
		session.update(makeSqlId("updateSchedule"), calendar);
	}

	@Override
	public void deleteGroupDate(int groupDateNo, String memberId) {
		HashMap<Object, Object> map = new HashMap<>();
		map.put("groupDateNo", groupDateNo);
		map.put("memberId", memberId);
		session.delete(makeSqlId("deleteGroupDate"), map);
	}

	@Override
	public void deleteFromGroup(int groupDateNo) {
		session.delete(makeSqlId("deleteFromGroup"), groupDateNo);
	}

	@Override
	public void updateFromGroup(Calendar calendar) {
		session.update(makeSqlId("updateFromGroup"), calendar);
	}
	
	
}
