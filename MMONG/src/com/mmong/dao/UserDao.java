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
	
	
	////////////////////////////////////////////////////////
	
	/**
	 * 사용자 정보 수정처리
	 * @param user
	 * @return
	 */
	int updateUser(User user);	
	
	
	//일반회원(member)의 권한이 'ROLE_1' 이면 'ROLE_2'로 변경 (update)
	/**
	* 일반회원(member)의 권한이  'ROLE_1'이면 'ROLE_2'로 변경 (update)
	* @param memberId
	* @return
	* 작성자 : 이진우
	*/
	int updateAuthorityMemberToStop(String memberId);
	
	//일반회원(member)의 권한이 'ROLE_2'이면 'ROLE_1'로 변경 (update)
	/**
	* 일반회원(member)의 권한이 'ROLE_2'이면 'ROLE_1'로 변경 (update)
	* @param memberId
	* @return
	* 작성자 : 이진우
	*/
	int updateAuthorityMemberToRun(String memberId);	
	
	
	/**
	 * 관리자(administrator)의 enable이 1 이면 0으로 변경한다
	 * 필요 이유: 관리자 공지사항 게시글 보존을 위해 관리자 삭제 대신 필요
	 * @param adminId
	 * @return
	 * 작성자 : 이진우
	 */
	int updateAdministratorEnableToZero(String adminId);
	
	
	/**
	* 관리자ID로 중복 ID 조회하는 메소드
	* @param adminId
	* @return 찾은 관리자 수 : 있으면 1, 없으면 0
	*/
	int checkUserId(String userId);
	
	
	////////////////////////////////////////////////////////
			
			
	
}
