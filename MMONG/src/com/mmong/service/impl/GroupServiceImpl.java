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

	public int insertGroup(Group group) {
		return groupDao.insertGroup(group);
	}

	@Override
	public Group selectMyGroupByNo(int no) {
		return groupDao.selectMyGroupByNo(no);
	}

}
