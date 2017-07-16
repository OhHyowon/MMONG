package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.HealthDao;
import com.mmong.vo.Health;

@Repository
public class HealthDaoImpl implements HealthDao{
	
	@Autowired
	private SqlSessionTemplate session;
	
	/**
	 * mapper 경로 설정
	 */
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.healthMapper."+id;
	}
	
	/**
	 *  건강관리 정보 등록
	 */
	@Override
	public int insertHealthList(Health health) {
		
		return session.insert(makeSqlId("insertHealthList"),health);
	}
	
	/**
	 * 	건강관리 정보 삭제
	 */
	@Override
	public void deleteHealthByNo(int no) {
		
		session.delete(makeSqlId("deleteHealthByNo"),no);
	}
	
	/**
	 * 	건강관리 정보 수정
	 */
	@Override
	public int updateHealthList(Health	health){
		
		return session.update(makeSqlId("updateHealthList"),health);
	}
	
	/**
	 * 전체 건강관리 조회
	 */
	public List<Health> selectByAllHealth(){
		
		return session.selectList(makeSqlId("selectByAllHealth"));
	}
	/**
	 * 	성별로 건강기록 조회
	 */
	@Override
	public List<Health> selectByGender(char gen) {
		
		HashMap<String,Object> map = new HashMap<>();
		map.put("gen", gen);
		
		return session.selectList(makeSqlId("selectByGender"),map);
	}


}
