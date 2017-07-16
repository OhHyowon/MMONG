package com.mmong.service;

import java.util.List;

import com.mmong.vo.Health;

public interface HealthService {
	
	// 건강관리 등록
	public void addHealthList(Health health);
	
	// 건강관리 수정
	public void updateHealthList(Health health); 
	
	// 건강관리 삭제
	public void deleteHealthByNo(int no);
	
	// 전체 건강관리 조회
	public List<Health> selectByAllHealth();
	
	// 성별로 건강정보 조회
	public List<Health> selectByGender(char gen);
}
