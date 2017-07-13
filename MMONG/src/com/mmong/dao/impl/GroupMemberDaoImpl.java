package com.mmong.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.GroupMemberDao;
import com.mmong.vo.GroupMember;

@Repository
public class GroupMemberDaoImpl implements GroupMemberDao {
	
	@Autowired 
	private SqlSessionTemplate session;
	
	private String makeSql(String id){
		return "com.mmong.config.mapper.groupMemberMapper."+id;
	}
	
	@Override
	public int insertGroupMember(GroupMember groupMember) {
		return session.insert(makeSql("insertGroupMember"), groupMember);
	}

	@Override
	public List<GroupMember> selectMeById(String memberId) {
		return session.selectList(makeSql("selectMeById"), memberId);
	}

	@Override
	public List<GroupMember> searchGroupMemberByGroupNo(int groupNo) {
		return session.selectList(makeSql("searchGroupMemberByGroupNo"), groupNo);
	}

}
