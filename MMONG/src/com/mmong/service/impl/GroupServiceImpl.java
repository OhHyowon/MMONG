package com.mmong.service.impl;

import java.util.List;

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

	@Override
	public List<Group> selectAllGroup() {
		return groupDao.selectAllGroup();
	}

	@Override
	public List<Group> searchGroupByName(String groupName) {
		return groupDao.searchGroupByName(groupName);
	}

}
