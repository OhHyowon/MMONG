package com.mmong.service;

import com.mmong.vo.Group;

public interface GroupService {
	/**
	 * 소모임을 하나 생성하는 메소드 
	 * @param group
	 * 작성자 : 이주현 
	 */
	int insertGroup(Group group);
}
