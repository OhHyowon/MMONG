package com.mmong.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.GroupDao;
import com.mmong.service.GroupService;
import com.mmong.vo.Group;

@Service
public class GroupServiceImpl implements GroupService {
	@Autowired
	private GroupDao groupDao;
	
	/**
	 * 소모임을 하나 생성하는 메소드 
	 * @param group
	 * @return 
	 * 작성자 : 이주현 
	 */
	public int insertGroup(Group group) {
		return groupDao.insertGroup(group);
	}

}
