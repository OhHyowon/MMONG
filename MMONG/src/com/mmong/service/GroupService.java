package com.mmong.service;

import java.util.List;

import com.mmong.vo.Group;

public interface GroupService {
	/**
	 * 소모임을 하나 생성하는 메소드 
	 * @param group
	 * 작성자 : 이주현 
	 */
	int insertGroup(Group group);
	
	/**
	 * 소모임 No로 소모임을 조회하는 메소드
	 * @param no
	 * @return select된 소모임 
	 * 작성자 : 이주현 
	 */
	Group selectMyGroupByNo(int no);
	
	/**
	 * 전체 소모임 조회하는 메소드
	 * @return 소모임 리스트
	 * 작성자 : 이주현
	 */
	List<Group> selectAllGroup();

	/**
	 * 이름으로 소모임 조회하는 메소드
	 * @param groupName
	 * @return 소모임 리스트
	 * 작성자 : 이주현
	 */
	List<Group> searchGroupByName(String groupName);
	/**
	 * 모임장 변경하는 메소드
	 * @param groupNo
	 * @param newLeader
	 * 작성자 : 강여림
	 */
	void updateLeader(int groupNo, String newLeader);
	/**
	 * 모임 삭제하는 메소드
	 * @param groupNo
	 * 작성자 : 강여림
	 */
	void deleteGroup(int groupNo);
	/**
	 * 모임 수정하는 메소드
	 * @param group
	 * 작성자 : 강여림
	 */
	void updateGroup(Group group);
}
