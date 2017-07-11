package com.mmong.service;

import com.mmong.vo.User;

public interface UserService {
	/**
	 * 한명의 사용자를 추가하는 메소드
	 * @param user : 추가할 사용자. 기존 저장된 회원과 같은 id의 회원은 추가하지 않음 
	 */
	void registerUser(User user);
	
	/**
	 * 사용자 id로 사용자를 조회하는 메소드
	 * @param userId
	 * @return 찾은 사용자
	 */
	User searchUserByUserId(String userId);
	
	
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

		
	//일반회원(member) 권한 변경
	//일반회원(member) 활동상태(1) -> 중지상태(4)
	/**
	* 일반회원 (member)의 권한을 '활동중지(4)'로 변경한다.
	* @param memberId
	* @return
	*/
	void changeAuthorityMemberToStop(String memberId);
	//1. 일반회원(member)의 권한 상태 조회(select)
	//2. 권한이 1이면 4로 변경(update)
	
	
	//일반회원(member) 활동상태(4) <- 중지상태(1)
	/**
	* 일반회원 (member)의 권한을 '일반회원(1)'로 변경한다.
	* @param memberId
	* @return
	*/
	void changeAuthorityMemberToRun(String memberId);
	//1. 일반회원(member)의 권한 상태 조회(select)
	//2. 권한이 4이면 1로 변경(update)
	
	//관리자(administrator) enable 1 -> 0
	/**
	* 관리자(administrator)의 enable을 0으로 변경해서 접근을 막는다.
	* @param adminId
	*/
	void changeAdminEnableToZero(String adminId);	
		
	///////////////////////////////////////////////////////////////////
	/**
	 * 관리자ID로 중복 ID 조회하는 메소드
	 * @param adminId
	 * @return 찾은 관리자 수 : 있으면 1, 없으면 0
	 */
	int checkUserId(String userId);
	
	///////////////////////////////////////////////////////////////////
	
		
	
	
	
	
}
