package com.mmong.dao;

import java.util.List;

import com.mmong.vo.Health;

public interface HealthDao {
	
	/**
	 *  건강 관리 정보 등록
	 */
	int insertHealthList(Health health);
	
	/**
	 *  건강 관리 정보 삭제
	 */
	void deleteHealthByNo(int no);
	
	/**
	 * 	건강 관리 정보 수정
	 */
	int updateHealthList(Health health);
	
	/**
	 *	전체 건강 관리 조회 
	 */
	List<Health> selectByAllHealth();
	
	/**
	 * 	성별로 건강목록 조회
	 */
	List<Health> selectByGender(char gen);
}
