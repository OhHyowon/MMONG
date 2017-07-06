package com.mmong.dao;

import com.mmong.vo.User;

public interface UserDao {
	/**
	 * 사용자 등록 (회원가입 시)
	 * @param user
	 * @return
	 * 작성자 : 이주현
	 */
	int registerUser(User user);
	
	/**
	 * 인증가능 사용자(회원가입된 사용자) userId로 조회
	 * @param userId
	 * @return
	 */
	User searchUserByUserId(String userId);
	
	/**
	 * userId의 사용자의 권한 조회 ( 0: 관리자, 1: 개인회원, 2:승인전매니저, 3:승인된매니저, 4:활동중지회원 )
	 * @param userId
	 * @return
	 */
	int searchAuthorityByUserId(String userId);
		
	/**
	 * 사용자 정보 수정처리
	 * @param user
	 * @return
	 */
	int updateUserByUserId(User user);
	
	int deleteUserByUserId(String userId);
}
