package com.mmong.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.GroupMemberDao;
import com.mmong.service.GroupMemberService;
import com.mmong.vo.GroupMember;

@Service
public class GroupMemberServiceImpl implements GroupMemberService {
	
	@Autowired
	private GroupMemberDao groupMemberDao;

	@Override
	public int insertGroupMember(GroupMember groupMember) {
		return groupMemberDao.insertGroupMember(groupMember);
	}

	@Override
	public List<GroupMember> selectMeById(String memberId) {
		return groupMemberDao.selectMeById(memberId);
	}

	@Override
	public List<GroupMember> searchGroupMemberByGroupNo(int groupNo) {
		return groupMemberDao.searchGroupMemberByGroupNo(groupNo);
	}

	public int selectCountNoByIdAndNo(int groupNo, String memberId){
		return groupMemberDao.selectCountNoByIdAndNo(groupNo,memberId);
	}
	
	public int selectMemberIdCount(int groupNo){
		return groupMemberDao.selectMemberIdCount(groupNo);
	}
	
	public void deleteGroupMember(int groupNo, String memberId){
		groupMemberDao.deleteGroupMember(groupNo,memberId);
	}
}
