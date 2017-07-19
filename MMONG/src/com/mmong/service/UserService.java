package com.mmong.service;

import com.mmong.vo.User;

public interface UserService {
	/**
	 * 한명의 사용자를 추가하는 메소드
	 * @param user : 추가할 사용자. 기존 저장된 회원과 같은 id의 회원은 추가하지 않음 
	 */
	void registerUser(User user);
	
///////////////////////////////////////////////////////////////////
	/**
	 * 매개변수로 사용자 id 를 받아서 사용자 정보 수정
	 * @param userId
	 */
	void updateUser(User user);
	/**
	 * 사용자 id로 사용자를 삭제하는 메소드
	 * @param userId
	 */
	void deleteUserByUserId(String userId);

		
	//사용자(관리자/회원) 권한 변경
	/**
	* 관리자(administrator) 활동상태(ROLE_0) -> 중지상태 (ROLE_2),
	* 일반회원(member) 활동상태(ROLE_1) -> 중지상태(ROLE_2)
	* @param memberId
	* @return
	*/
	void changeUserAuthorityToStop(String userId);
	
	/**
	 * 관리자(administrator) 활동상태(ROLE_0) <- 중지상태 (ROLE_2)
	 * @param userId
	 */
	void changeAdminAuthorityToRun(String adminId);
	
	/**
	* 일반회원(member) 활동상태(ROLE_1) <- 중지상태(ROLE_2)
	* @param memberId
	* @return
	*/
	void changeMemberAuthorityToRun(String userId);
	
	/**
	 * 사용자(관리자/회원) 탈퇴시 사용자의 권한을 ROLE_3(탈퇴상태)로 변경시킨다.
	 * @param userId
	 */
	void changeUserAuthorityToWithdrawal(String userId);
	
	
	////////////////////////////////////////////////////////////////////


	/**
	 * 관리자ID로 중복 ID 조회하는 메소드
	 * @param adminId
	 * @return 찾은 관리자 수 : 있으면 1, 없으면 0
	 */
	int checkUserId(String userId);
	
	///////////////////////////////////////////////////////////////////
	
		
	
	
	
	
}
