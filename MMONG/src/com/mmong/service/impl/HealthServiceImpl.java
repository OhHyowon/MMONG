package com.mmong.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.HealthDao;
import com.mmong.service.HealthService;
import com.mmong.vo.Health;

@Service
public class HealthServiceImpl implements HealthService {
	
	@Autowired
	private HealthDao dao;
	
	private HealthService service; 
	
	List<Health> list = new ArrayList<Health>();
	
	/**
	 * 	건강관리 등록
	 */
	@Override
	public void addHealthList(Health health) {
		
		dao.insertHealthList(health);
	}
	
	/**
	 * 	건강관리 삭제
	 */
	@Override
	public void deleteHealthByNo(int no) {
		dao.deleteHealthByNo(no);
	}
	
	/**
	 * 	건강관리 수정
	 */
	@Override
	public void updateHealthList(Health health) {
		
		dao.updateHealthList(health);
		
	}
	
	/**
	 * 	전체 건강관리 조회
	 */
	@Override
	public List<Health> selectByAllHealth() {
		
		return dao.selectByAllHealth();
	}
	
	/**
	 *  성별로 건강 정보 조회
	 */
	@Override
	public List<Health> selectByGender(char gen) {
		
		return dao.selectByGender(gen);
	}


	
}
