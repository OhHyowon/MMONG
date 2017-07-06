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
	int registerAdministrator(Administrator administrator);
	
	/**
	 * 매개변수로 받은 Administrator 객체의 id와 일치하는 관리자의 나머지 값들을 update 하는 메소드
	 * 
	 * @param administrator
	 * @return
	 */
	int updateAdministratorById(Administrator administrator);
	
	/**
	 * 매개변수로 받은 Administrator 객체의 id와 일치하는 관리자의 나머지 값들을 delete 하는 메소드
	 * 
	 * @param administratorId
	 * @return
	 */
	int deleteAdministratorById(String administratorId);
	
	/**
	 * 매개변수로 받은 administratorId와 일치하는 administrator data를 select하는 메소드
	 * 
	 * @param administratorId
	 * @return
	 */
	Administrator searchAdministratorById(String administratorId);
	

	
	//일반회원(member)을 조회 (select)
	Member searchMemberById(String membId);
	
	//일반회원(member)의 권한이 1이면 4로 변경 (update)
	int updateAuthorityMemberToStop(String memberId);
	
	//일반회원(member)의 권한이 4이면 1로 변경 (update)
	int updateAuthorityMemberToRun(String memberId);
	
	
	
	
	
	
	
	
	
	
	
	
}










