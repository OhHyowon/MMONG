package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.GroupDateDao;
import com.mmong.vo.GroupDate;
import com.mmong.vo.MeetMember;

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
	
	public int selectMemberNo(String memberId, int groupNo){
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("memberId", memberId);
		map.put("groupNo", groupNo);
		
		return session.selectOne(makeSqlId("selectMemberNo"),memberId);
	}
	
	public void insertMeetMember(MeetMember mm){
		session.insert(makeSqlId("insertMeetMember"),mm);
	}
	
	public List<Integer>selectMeetMemberList(int groupDateNo){
		return session.selectList(makeSqlId("selectMeetMemberList"),groupDateNo);
	}
	
	public String selectMemberId(int memberNo){
		return session.selectOne(makeSqlId("selectMemberId"),memberNo);
	}
	
	public String selectNickname(String memberId){
		return session.selectOne(makeSqlId("selectNickname"),memberId);
	}
}
