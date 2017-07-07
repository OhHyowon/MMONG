package com.mmong.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.GroupDao;
import com.mmong.vo.Group;

@Repository
public class GroupDaoImpl implements GroupDao {

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String id){
		return "com.mmong.config.mapper.groupMapper."+id;
	}

	@Override
	public int insertGroup(Group group) {
		return session.insert(makeSql("insertGroup"), group);
	}

	@Override
	public Group selectMyGroupByNo(int no) {
		return session.selectOne(makeSql("selectMyGroupByNo"), no);
	}

}
