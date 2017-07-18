package com.mmong.dao;

import com.mmong.vo.Administrator;
import com.mmong.vo.Member;

public interface AdministratorDao {

	/**
	 * 한명의 관리자 데이터를 register하는 메소드
	 * 
	 * @param administrator
	 * @return
	 */
	int insertAdministrator(Administrator administrator);
	
	/**
	 * 매개변수로 받은 Administrator 객체와 일치하는 관리자의 나머지 값들을 update 하는 메소드
	 * 
	 * @param administrator
	 * @return
	 */
	int updateAdministrator(Administrator administrator);

	/**
	 * 매개변수로 받은 administratorId와 일치하는 administrator data를 select하는 메소드
	 * 
	 * @param administratorId
	 * @return
	 */
	Administrator searchAdministratorById(String administratorId);
	
	/**
	* 관리자 핸드폰 번호로 중복번호 조회하는 메소드
	* @param adminPhone
	* @return 찾은 관리자 수 : 있으면 1, 없으면 0
	*/
	int checkAdminPhone(String adminPhone);

	/**
	 * 회원 이메일로 중복 조회하는 메소드
	 * @param memberEmail
	 * @return 찾은 회원 수 : 있으면 1, 없으면 0
	 */
	int checkAdminEmail(String adminEmail);
	


	
	
	
	
}
