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
	 * userId의 사용자의 권한 조회 ( ROLE_0: 관리자, ROLE_1: 개인회원, ROLE_2:정지된 회원, ROLE_3:탈퇴한 회원)
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
	
	
	////////////////////////////////////////////////////////
	
	/**
	 * 사용자 정보 수정처리
	 * @param user
	 * @return
	 */
	int updateUser(User user);	
	
	//사용자(관리자/회원)의 활동 정지를 위한 권한 변경
	/**
	* 관리자(administrator) 활동상태(ROLE_0) -> 중지상태 (ROLE_2),
	* 일반회원(member) 활동상태(ROLE_1) -> 중지상태(ROLE_2)
	* @param userId
	* @return
	* 작성자 : 이진우
	*/
	int updateUserAuthorityToStop(String userId);
	
	/**
	 * 관리자(administrator) 활동상태(ROLE_0) <- 중지상태 (ROLE_2)
	 * @param adminId
	 * @return
	 * 작성자 : 이진우
	 */
	int updateAuthorityAdminToRun(String adminId);
	
	/**
	* 일반회원(member) 활동상태(ROLE_1) <- 중지상태(ROLE_2)
	* @param memberId
	* @return
	* 작성자 : 이진우
	*/
	int updateAuthorityMemberToRun(String memberId);	
	
	/**
	 * 사용자(관리자/회원) 탈퇴시 회원의 authority를 'ROLE_3' 상태로 변경
	 * @param userId
	 * @return
	 * 작성자 : 이진우
	 */
	int updateUserAuthorityToWithdrawal(String userId);
	
	/**
	 * 관리자ID로 중복 ID 조회하는 메소드
	 * @param userId
	 * @return 찾은 관리자 수 : 있으면 1, 없으면 0
	 * 작성자 : 이진우
	 */
	int checkUserId(String userId);
	
	////////////////////////////////////////////////////////
			
			
	
}
