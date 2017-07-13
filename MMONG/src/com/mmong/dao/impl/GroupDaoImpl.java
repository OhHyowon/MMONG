package com.mmong.dao.impl;

import java.util.List;

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

	@Override
	public List<Group> selectAllGroup() {
		return session.selectList(makeSql("selectAllGroup"));
	}

	@Override
	public List<Group> searchGroupByName(String groupName) {
		return session.selectList(makeSql("searchGroupByName"), groupName);
	}

}
