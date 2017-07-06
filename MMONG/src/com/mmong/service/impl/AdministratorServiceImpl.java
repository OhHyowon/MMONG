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
	public void insertAdministrator(Administrator administrator){
		adminDao.registerAdministrator(administrator);
	}

	@Override
	public void updateAdministrator(Administrator newData){
		adminDao.updateAdministratorById(newData);
	}

	@Override
	public void deleteAdministratorById(String adminId){
		adminDao.deleteAdministratorById(adminId);
	}

	@Override
	public Administrator searchAdministratorById(String adminId){
		return adminDao.searchAdministratorById(adminId);
	}
	

/*
	//일반회원(member) 활동 -> 정지
	@Override
	public void changeAuthorityMemberToStop(String memberId) {
		Member mem = null;
		//1. 일반회원의 권한상태 조회(select)
		mem = dao.searchMemberById(memberId);
//		if(mem.getMemberAuthority()==1){
			dao.updateAuthorityMemberToStop(memberId);
		}
		//throw new SameAuthorityExceptionStop(String.format("이미 활동정지된 회원 입니다."));
	}

	//일반회원(member) 정지 -> 활동
	@Override
	public void changeAuthorityMemberToRun(String memberId) {
		Member mem = null;
		//1. 일반회원의 권한상태 조회(select)
		mem = dao.searchMemberById(memberId);
//		if(mem.getMemberAuthority()==4){
			dao.updateAuthorityMemberToRun(memberId);
		}
		//throw new SameAuthorityExceptionStop(String.format("이미 활동중인 회원 입니다."));
	}

////////////////////////테스트 완료 /////////////////////////////////







*/
}












