package com.mmong.service.impl;

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

}
