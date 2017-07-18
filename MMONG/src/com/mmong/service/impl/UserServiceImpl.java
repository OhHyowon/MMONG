package com.mmong.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mmong.dao.AdministratorDao;
import com.mmong.dao.MemberDao;
import com.mmong.dao.UserDao;
import com.mmong.service.UserService;
import com.mmong.vo.Administrator;
import com.mmong.vo.Member;
import com.mmong.vo.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private PasswordEncoder passwordEncoder;
	////////////////////////////////////////////
	@Autowired
	private AdministratorDao adminDao;
	@Autowired
	private MemberDao memberDao;
	////////////////////////////////////////////
		
		
	
	
	@Override
	public void registerUser(User user){
		user.setUserPwd(passwordEncoder.encode(user.getUserPwd())); //패스워드 인코딩처리
		userDao.registerUser(user);
	}

	////////////////////////////////////////////////////////////////////////

	@Override
	public void updateUser(User user) {
		user.setUserPwd(passwordEncoder.encode(user.getUserPwd())); //패스워드 인코딩처리
		userDao.updateUser(user);
	}

	@Override
	public void deleteUserByUserId(String userId) {
		userDao.deleteUserByUserId(userId);
	}
	
	//user(관리자/회원) authority -> 'ROLE_3'으로 변경
	@Override
	public void changeUserAuthorityToStop(String userId) {
		User user = null;
		//1. 일반회원의 권한상태 조회(select)
		user = userDao.searchUserByUserId(userId);
		if(user.getUserAuthority().equals("ROLE_0") || user.getUserAuthority().equals("ROLE_1") ){
			userDao.updateUserAuthorityToStop(user.getUserId());
		}
		//throw new SameAuthorityExceptionStop(String.format("이미 활동정지된 회원 입니다."));
	}
	
	//관리자 정지 -> 활동
	@Override
	public void changeAdminAuthorityToRun(String adminId) {
		Administrator admin = null;
		//1. 관리자의 권한 상태 조회(select)
		admin = adminDao.searchAdministratorById(adminId);
		if(admin.getUser().getUserAuthority().equals("ROLE_2")){
			userDao.updateAuthorityAdminToRun(adminId);
		}
	}

	//일반회원(member) 정지 -> 활동
	@Override
	public void changeMemberAuthorityToRun(String memberId) {
		Member mem = null;
		//1. 일반회원의 권한상태 조회(select)
		mem = memberDao.searchMemberById(memberId);
		if(mem.getUser().getUserAuthority().equals("ROLE_2")){
			userDao.updateAuthorityMemberToRun(mem.getMemberId());
		}
		//throw new SameAuthorityExceptionStop(String.format("이미 활동중인 회원 입니다."));
	}
	

		
	////////////////////////////////////////////////////////////////////////
	
	//'회원 탈퇴하기' 
	@Override
	public void changeUserAuthorityToWithdrawal(String userId) {
		User user = null;
		user = userDao.searchUserByUserId(userId);
		if(user.getUserAuthority().equals("ROLE_0") || user.getUserAuthority().equals("ROLE_1")){
			userDao.updateUserAuthorityToWithdrawal(user.getUserId());
		}
	}

	//회원가입시 아이디 중복검사 위해 필요
	@Override
	public int checkUserId(String userId) {
		return userDao.checkUserId(userId);
	}

		
	////////////////////////////////////////////////////////////////////////
	
	
	
	
	
}
