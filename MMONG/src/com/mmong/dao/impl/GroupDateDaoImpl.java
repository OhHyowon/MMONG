package com.mmong.dao.impl;

import java.util.Date;
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
		System.out.println("groupDae DAO 들어옴");
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("memberId", memberId);
		map.put("groupNo", groupNo);
		
		return session.selectOne(makeSqlId("selectMemberNo"),map);
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
	
	public void deleteMeetmember(MeetMember mm){
		session.delete(makeSqlId("deleteMeetmember"),mm);;
	}
	
	public List<GroupDate> selectAllGroupDateList(int beginItemNo, int endItemNo, int groupNo){
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("beginItemNo", beginItemNo);
		map.put("endItemNo", endItemNo);
		map.put("groupNo", groupNo);
		
		return session.selectList(makeSqlId("selectAllGroupDateList"),map);
	}
	
	public int selectGroupDateCount (int groupNo){
		return session.selectOne(makeSqlId("selectGroupDateCount"),groupNo);
	}
	
	public int selectGroupDateOptionCount(int groupNo, String option, String key){
		HashMap<String,Object> map = new HashMap<>();
		map.put("groupNo",groupNo);
		map.put("option", option);
		map.put("key", key);
		
		return session.selectOne(makeSqlId("selectGroupDateOptionCount"),map);
	}
	
	public List<GroupDate> selectOptionGroupDate(int beginItemNo, int endItemNo, int groupNo, String option, String key){
		HashMap<String,Object> map = new HashMap<>();
		map.put("beginItemNo", beginItemNo);
		map.put("endItemNo", endItemNo);
		map.put("groupNo", groupNo);
		map.put("option", option);
		map.put("key", key);
		
		return session.selectList(makeSqlId("selectOptionGroupDate"),map);
	}
	
	public int selectGroupDateOptionCount2(int groupNo, String option, Date dateTime){
		HashMap<String,Object>map= new HashMap<>();
		map.put("groupNo",groupNo);
		map.put("option",option);
		map.put("dateTime",dateTime);
		
		return session.selectOne(makeSqlId("selectGroupDateOptionCount2"),map);
	}
	
	public List<GroupDate> selectOptionGroupDate2(int beginItemNo, int endItemNo,int groupNo, String option, Date dateTime){
		HashMap<String,Object> map = new HashMap<>();
		map.put("beginItemNo", beginItemNo);
		map.put("endItemNo", endItemNo);
		map.put("groupNo", groupNo);
		map.put("option", option);
		map.put("dateTime",dateTime);
		
		return session.selectList(makeSqlId("selectOptionGroupDate2"),map);
	}
	
	public void upDateGroupDate(GroupDate groupDate){
		session.update(makeSqlId("upDateGroupDate"),groupDate);
	}
	
	public void deleteGroupDate(int groupDateNo){
		session.delete(makeSqlId("deleteGroupDate"),groupDateNo);
	}
	
	public void deleteMeetMemberByGroupMemberNo(int groupMemberNo){
		session.delete(makeSqlId("deleteMeetMemberByGroupMemberNo"), groupMemberNo);
	}
}


