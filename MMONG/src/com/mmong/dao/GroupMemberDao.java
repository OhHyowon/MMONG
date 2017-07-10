package com.mmong.dao;

import java.util.List;

import com.mmong.vo.GroupMember;

public interface GroupMemberDao {
	/**
	 * 소모임에 소모임멤버를 하나 추가하기
	 */
	int insertGroupMember(GroupMember groupMember);
	
	/**
	 * 내가 소속된 소모임을 찾기위해, 모임멤버 중에서 나(로그인한 사람)를 찾기
	 * @param memberId
	 * @return 소속된 소모임의 pk값을 가지고 있는 groupMember 객체 
	 * 작성자 : 이주현 
	 */
	List<GroupMember> selectMeById(String memberId);
	
	/**
	 * 소모임NO로 GroupMember객체들 select
	 * @param groupNo
	 * @return
	 * 작성자 : 이주현
	 */
	List<GroupMember> searchGroupMemberByGroupNo(int groupNo);
}
