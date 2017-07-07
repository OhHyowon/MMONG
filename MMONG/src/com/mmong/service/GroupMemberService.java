package com.mmong.service;

import java.util.List;

import com.mmong.vo.GroupMember;

public interface GroupMemberService {
	/**
	 * 소모임에 소속된 모임멤버 추가시키기
	 * @param groupMember
	 * 작성자 : 이주현 
	 */
	int insertGroupMember(GroupMember groupMember);
	
	/**
	 * 내가 소속된 소모임을 찾기위해, 모임멤버 중에서 나(로그인한 사람)를 찾기
	 * @param memberId
	 * @return 소속된 소모임의 pk값을 가지고 있는 groupMember 객체 
	 * 작성자 : 이주현 
	 */
	List<GroupMember> selectMeById(String memberId);
}
