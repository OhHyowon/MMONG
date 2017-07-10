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

}
