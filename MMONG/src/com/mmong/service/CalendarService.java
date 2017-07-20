package com.mmong.service;


import java.util.HashMap;
import java.util.List;

import com.mmong.vo.Calendar;
import com.mmong.vo.Member;

public interface CalendarService {

	/**
	 * 일정 추가
	 * @param calendar
	 */
	void insertSchedule(Calendar calendar);
	
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
	 */
	void deleteSchedule(int no);
	
	/**
	 * 일정 수정
	 * @param calendar
	 */
	void updateSchedule(Calendar calendar);
	
	/**
	 * 소모임 일정에 참여했다가 참여 취소 버튼을 눌렀을 때
	 * @param groupDateNo
	 * @param memberId
	 */
	void deleteGroupDate(int groupDateNo, String memberId);
	
	/**
	 * 소모임 일정이 일정 등록자에 의해 아예 삭제되었을 때
	 * @param groupDateNo
	 */
	void deleteFromGroup(int groupDateNo);
	
	/**
	 * 소모임 일정이 수정되었을 때
	 * @param calendar
	 */
	void updateFromGroup(Calendar calendar);
	
	/**
	 * 진료기록이 수정되었을 때
	 * @param calendar
	 */
	void updateFromChart(Calendar calendar);
	
	/**
	 * 진료기록이 삭제되었을 때
	 * @param map
	 */
	void deleteFromChart(HashMap<String,Object> map);
}
