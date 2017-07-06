package com.mmong.service;

import com.mmong.vo.GroupMember;

public interface GroupMemberService {
	/**
	 * 소모임에 소속된 모임멤버 추가시키기
	 * @param groupMember
	 * 작성자 : 이주현 
	 */
	int insertGroupMember(GroupMember groupMember);
}
