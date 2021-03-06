package com.mmong.dao;

import java.util.List;

import com.mmong.vo.Group;

public interface GroupDao {
	/**
	 * 소모임을 하나 생성하는 메소드 
	 * @param group
	 * 작성자 : 이주현 
	 */
	int insertGroup(Group group);
	
	/**
	 * 해당 no의 소모임을 조회하는 메소드
	 * @param no
	 * @return
	 * 작성자 : 이주현 
	 */
	Group selectMyGroupByNo(int no);
	
	/**
	 * 전체 소모임을 조회하는 메소드
	 * @return
	 * 작성자 : 이주현
	 */
	List<Group> selectAllGroup();
	
	/**
	 * 이름으로 소모임 조회하는 메소드
	 * @param groupName
	 * @return
	 * 작성자 : 이주현
	 */
	List<Group> searchGroupByName(String groupName);
	/**
	 * 모임장 변경
	 * @param groupNo
	 * @param newLeader
	 * 작성자 : 강여림
	 */
	void updateLeader(int groupNo, String newLeader);
	/**
	 * 모임 번호로 모임 삭제하기
	 * @param groupNo
	 * 작성자 : 강여림
	 */
	void deleteGroup(int groupNo);
	/**
	 * 모임 수정
	 * @param group
	 * 작성자 : 강여림
	 */
	void updateGroup(Group group);
}
