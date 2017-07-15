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
	
	//일반회원(member) 활동(ROLE_1) -> 정지(ROLE_2)
	@Override
	public void changeAuthorityMemberToStop(String memberId) {
		Member mem = null;
		//1. 일반회원의 권한상태 조회(select)
		mem = memberDao.searchMemberById(memberId);
		if(mem.getUser().getUserAuthority().equals("ROLE_1")){
			userDao.updateAuthorityMemberToStop(mem.getMemberId());
		}
		//throw new SameAuthorityExceptionStop(String.format("이미 활동정지된 회원 입니다."));
	}
	
	//일반회원(member) 정지 -> 활동
	@Override
	public void changeAuthorityMemberToRun(String memberId) {
		Member mem = null;
		//1. 일반회원의 권한상태 조회(select)
		mem = memberDao.searchMemberById(memberId);
		if(mem.getUser().getUserAuthority().equals("ROLE_2")){
			userDao.updateAuthorityMemberToRun(mem.getMemberId());
		}
		//throw new SameAuthorityExceptionStop(String.format("이미 활동중인 회원 입니다."));
	}
	
	//관리자 enable 1 -> 0
	@Override
	public void changeAdminEnableToZero(String adminId) {
		Administrator admin = null;
		admin = adminDao.searchAdministratorById(adminId);
		if(admin.getUser().getUserEnable()==1){
			userDao.updateUserEnableToZero(admin.getAdminId());
		}
	}
		
	////////////////////////////////////////////////////////////////////////
	
	//회원 enable 1 -> 0
	@Override
	public void changeMemberEnableToZero(String memberId) {
		Member member = null;
		member = memberDao.searchMemberById(memberId);
		if(member.getUser().getUserEnable()==1){
			userDao.updateUserEnableToZero(member.getMemberId());
		}
	}
	
	//'회원 탈퇴하기' 이것과 위의 'changeMemberEnableToZero'메소드 중 택1
	@Override
	public void changeAuthorityMemberToWithdrawal(String memberId) {
		Member member = null;
		member = memberDao.searchMemberById(memberId);
		if(member.getUser().getUserAuthority().equals("ROLE_1")){
			userDao.updateUserAuthorityToWithdrawal(member.getMemberId());
		}
	}

	//회원가입시 아이디 중복검사 위해 필요
	@Override
	public int checkUserId(String userId) {
		return userDao.checkUserId(userId);
	}

		
	////////////////////////////////////////////////////////////////////////
	
	
	
	
	
}
