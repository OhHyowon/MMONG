package com.mmong.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.GroupDateDao;
import com.mmong.vo.GroupDate;

@Repository
public class GroupDateDaoImpl implements GroupDateDao{
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.groupDateMapper."+id;
	}
	
	public void insertGroupDate(GroupDate groupDate){
		session.insert(makeSqlId("insertGroupDate"),groupDate);
	}
	
	public GroupDate selectGroupDate(int groupDateNo){
		return session.selectOne(makeSqlId("selectGroupDate"),groupDateNo);
	}
}
