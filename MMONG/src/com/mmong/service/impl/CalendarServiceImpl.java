package com.mmong.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.CalendarDao;
import com.mmong.service.CalendarService;
import com.mmong.vo.Calendar;
import com.mmong.vo.Member;

@Service
public class CalendarServiceImpl implements CalendarService{
	
	@Autowired
	private CalendarDao dao;

	@Override
	public void insertSchedule(Calendar calendar) {
		dao.insertSchedule(calendar);
	}

	@Override
	public List<Calendar> selectSchedule(String memberId) {
		return dao.selectSchedule(memberId);
	}

	@Override
	public Calendar viewSchedule(int eventNo) {
		return dao.viewSchedule(eventNo);
	}

	@Override
	public void deleteSchedule(int no) {
		dao.deleteSchedule(no);
	}

	@Override
	public void updateSchedule(Calendar calendar) {
		System.out.println("service");
		System.out.println(calendar);
		dao.updateSchedule(calendar);
	}

}
