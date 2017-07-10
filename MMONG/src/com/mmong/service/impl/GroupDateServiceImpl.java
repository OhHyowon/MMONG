package com.mmong.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.impl.GroupDateDaoImpl;
import com.mmong.service.GroupDateService;
import com.mmong.vo.GroupDate;
import com.mmong.vo.MeetMember;

@Service
public class GroupDateServiceImpl implements GroupDateService{
	@Autowired
	private GroupDateDaoImpl dao; // 완성되면 impl 떼고 dao로 변경하기
	
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
}
