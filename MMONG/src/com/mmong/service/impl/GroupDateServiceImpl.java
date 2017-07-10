package com.mmong.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.impl.GroupDateDaoImpl;
import com.mmong.service.GroupDateService;
import com.mmong.vo.GroupDate;

@Service
public class GroupDateServiceImpl implements GroupDateService{
	@Autowired
	private GroupDateDaoImpl dao; // 완성되면 impl 떼고 dao로 변경하기
	
	public int insertGroupDate(GroupDate groupDate){
		dao.insertGroupDate(groupDate);
		int groupDateNo = groupDate.getNo();
		
		return groupDateNo;
	}
	
	public GroupDate selectGroupDate(int groupDateNo){
		return dao.selectGroupDate(groupDateNo);
	}
}
