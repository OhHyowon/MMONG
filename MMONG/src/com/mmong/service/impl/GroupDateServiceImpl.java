package com.mmong.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.GroupDateDao;
import com.mmong.paging.util.PagingBean;
import com.mmong.service.GroupDateService;
import com.mmong.vo.GroupDate;
import com.mmong.vo.MeetMember;

@Service
public class GroupDateServiceImpl implements GroupDateService{
	@Autowired
	private GroupDateDao dao;
	
	public int insertGroupDate(GroupDate groupDate){
		dao.insertGroupDate(groupDate);
		int groupDateNo = groupDate.getNo();
		
		return groupDateNo;
	}
	
	public GroupDate selectGroupDate(int groupDateNo){
		return dao.selectGroupDate(groupDateNo);
	}
	
	public int selectMemberNo(String memberId, int groupNo){
		return dao.selectMemberNo(memberId,groupNo);
	}
	
	public void insertMeetMember(MeetMember mm){
		dao.insertMeetMember(mm);
	}
	
	public List<Integer>selectMeetMemberList(int groupDateNo){
		return dao.selectMeetMemberList(groupDateNo);
	}
	
	public String selectMemberId(int memberNo){
		return dao.selectMemberId(memberNo);
	}
	
	public String selectNickname(String memberId){
		return dao.selectNickname(memberId);
	}
	
	public void deleteMeetmember(MeetMember mm){
		dao.deleteMeetmember(mm);
	}
	
	public HashMap<String,Object> selectAllGroupDateList (int page, int groupNo){
		HashMap<String,Object> map=new HashMap<>();
		
		int totalCount = dao.selectGroupDateCount(groupNo);

		PagingBean pageBean = new PagingBean(totalCount,page);
		List<GroupDate> groupDateList = dao.selectAllGroupDateList(pageBean.getBeginItemInPage(),pageBean.getEndItemInPage(),groupNo);
		
		map.put("pageBean", pageBean);
		map.put("groupDateList", groupDateList);
		
		
		return map;
	}
	
	public HashMap<String,Object>selectGroupDateOption(int page, int groupNo, String option, String key){
		HashMap<String,Object> map = new HashMap<>();
		int totalCount = dao.selectGroupDateOptionCount(groupNo,option,key);

		PagingBean pageBean = new PagingBean(totalCount, page);
		List<GroupDate> groupDateList = dao.selectOptionGroupDate(pageBean.getBeginItemInPage(),pageBean.getEndItemInPage(),groupNo,option,key);

		map.put("pageBean", pageBean);
		map.put("groupDateList", groupDateList);
		
		return map;
	}
	
	public HashMap<String,Object>selectGroupDateOption2(int page, int groupNo, Date dateTime, String option){
		HashMap<String,Object> map = new HashMap<>();
		int totalCount = dao.selectGroupDateOptionCount2(groupNo, option, dateTime);
		
		PagingBean pageBean = new PagingBean(totalCount,page);
		List<GroupDate> groupDateList= dao.selectOptionGroupDate2(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage(), groupNo, option, dateTime);
		
		
		map.put("pageBean", pageBean);
		map.put("groupDateList", groupDateList);
		
		return  map;
	}
	
	public void upDateGroupDate(GroupDate groupDate){
		dao.upDateGroupDate(groupDate);
	}
	
	public void deleteGroupDate(int groupDateNo){
		dao.deleteGroupDate(groupDateNo);
	}
	
	public void deleteMeetMemberByGroupMemberNo(int groupMemberNo){
		dao.deleteMeetMemberByGroupMemberNo(groupMemberNo);
	}

	@Override
	public List<Integer> selectNoByGroupNo(int groupNo) {
		return dao.selectNoByGroupNo(groupNo);
	}
	
	public void deleteGroupDateByGroupNo(int groupNo){
		dao.deleteGroupDateByGroupNo(groupNo);
	}

	@Override
	public void deleteMeetMemberByGroupDateNo(int groupDateNo) {
		dao.deleteMeetMemberByGroupDateNo(groupDateNo);
	}
}
