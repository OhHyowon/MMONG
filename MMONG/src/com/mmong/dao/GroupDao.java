package com.mmong.dao;

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
}
