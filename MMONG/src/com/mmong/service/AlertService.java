package com.mmong.service;

import java.util.List;

import com.mmong.vo.Alert;

public interface AlertService {
	
	/**
	 * 해당 회원 아이디의 안읽은 알람 수 세는 메소드
	 * @param memberId
	 * @return
	 */
	int countUnreadAlert(String memberId);
	
	/**
	 * 해당 회원아이디의 알람 전체 조회하는 메소드
	 * @param memberId
	 * @return
	 */
	List<Alert> selectAllAlert(String memberId);

	/**
	 * no로 알람한개 조회하는 메소드
	 * @param alertNo
	 * @return
	 */
	Alert searchAlertByNo(int alertNo);
	
	/**
	 * 알람을 읽으면 읽음처리하는 메소드
	 * @param alertNo
	 * @return
	 */
	int updateAlertStateByNo(Alert alert);



}
