package com.mmong.dao;

import com.mmong.vo.GroupMember;

public interface GroupMemberDao {
	/**
	 * 소모임에 소모임멤버를 하나 추가하기
	 */
	int insertGroupMember(GroupMember groupMember);
}
