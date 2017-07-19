package com.mmong.dao.impl;

import java.util.HashMap;
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
	
	public int selectCountNoByIdAndNo(int groupNo, String memberId){
		HashMap<String,Object> map = new HashMap<>();
		map.put("groupNo", groupNo);
		map.put("memberId", memberId);
		
		return session.selectOne(makeSql("selectCountNoByIdAndNo"),map);
	}
	
	public int selectMemberIdCount(int groupNo){
		return session.selectOne(makeSql("selectMemberIdCount"),groupNo);
	}
	
	public void deleteGroupMember(int groupNo, String memberId){
		HashMap<String,Object> map = new HashMap<>();
		map.put("groupNo", groupNo);
		map.put("memberId", memberId);
		session.delete(makeSql("deleteGroupMember"),map);
	}

	@Override
	public GroupMember selectGroupMemberByNo(int no) {
		return session.selectOne(makeSql("selectGroupMemberByNo"), no);
	}

}
