package com.mmong.dao;

import java.util.List;

import com.mmong.vo.Calendar;
import com.mmong.vo.Member;

public interface CalendarDao {
	
	/**
	 * 일정 추가
	 * @param calendar
	 */
	int insertSchedule(Calendar calendar);

	/**
	 * 일정 조회
	 * @param memberId
	 * @return
	 */
	List<Calendar> selectSchedule(String memberId);
	
	/**
	 * 일정 상세 조회
	 * @param eventNo
	 * @return
	 */
	Calendar viewSchedule(int eventNo);
	
	/**
	 * 일정 삭제
	 * @param no
	 * @return
	 */
	void deleteSchedule(int no);
	
	/**
	 * 일정 수정
	 * @param calendar
	 */
	void updateSchedule(Calendar calendar);
}
