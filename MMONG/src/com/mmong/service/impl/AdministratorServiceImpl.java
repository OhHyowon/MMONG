package com.mmong.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.AdministratorDao;
import com.mmong.service.AdministratorService;
import com.mmong.vo.Administrator;


@Service
public class AdministratorServiceImpl implements AdministratorService {

	@Autowired 
	private AdministratorDao adminDao;
	
	//관리자 등록 하는 메소드
	@Override
	public void insertAdministrator(Administrator administrator) {
		adminDao.insertAdministrator(administrator);
	}

	@Override
	public void updateAdministrator(Administrator newData){	
		adminDao.updateAdministrator(newData);
	}


	@Override
	public Administrator searchAdministratorById(String adminId) {
		return adminDao.searchAdministratorById(adminId);
	}
	
	@Override
	public int checkAdminPhone(String adminPhone) {
		return adminDao.checkAdminPhone(adminPhone);
	}
	
	
	
	
}












