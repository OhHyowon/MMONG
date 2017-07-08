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
	


	
	
	
	
	
	
	
	
	
	
	
}










