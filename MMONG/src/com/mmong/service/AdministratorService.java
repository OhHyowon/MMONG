package com.mmong.service;


import com.mmong.vo.Administrator;

public interface AdministratorService {

	/**
	 * 한명의 관리자 추가하는 메소드
	 *  - 기존 저장된 관리자와 같은 ID의 관리자는 추가하지 않는다. (ID중복검사) 
	 * @param administrator : 추가할 한명의 관리자정보. 관리자의 type이 Administrator이므로 매개변수로 Administrator 선언.
	 * @throws DuplicatedIdException 등록하려는 관리자 아이디가 이미 등록되 있는 경우 발생
	 * 
	 */
	void insertAdministrator(Administrator administrator);

	/**
	 * 관리자정보를 수정(변경) 하는 메소드. (기존관리자의 일부 정보를 변경.)
	 * - 단 수정할 관리자가 없으면 없다고 caller에게 알려준다.
	 * @param newData 변경할 관리자 정보. id값으로 관리자를 찾아서 나머지 정보를 수정. 
	 * 호출한 쪽(caller) 변경할 instance변수의 값은 변경할 값으로 나머지는 기존값을 넣어 Administrator객체를 만들어 전달. 
	 * @throws AdministratorNotFoundException 수정할 관리자가 등록되 있지 않은 경우 발생
	 * 
	 */
	void updateAdministrator(Administrator newData);

	/**
	* 저장된 관리자중 매개변수의 id를 가진 관리자를 찾아 주는 메소드.
	* @param id 찾을 관리자의 ID
	* @return 조회한 관리자 객체를 리턴. 단 찾는 ID의 관리자이 없으면 null(없어요)를 리턴한다.
	 * @throws AdministratorNotFoundException 
	* 
	*/
	Administrator searchAdministratorById(String adminId);
	
	/**
	 * 관리자 핸드폰 번호로 중복번호 조회하는 메소드
	 * @param adminPhone
	 * @return 찾은 관리자 수 : 있으면 1, 없으면 0
	 */
	int checkAdminPhone(String adminPhone);
	
	/**
	 * 관리자 이메일로 승인메일 코드일치 조회하는 메소드
	 * @param adminEmail
	 * @return 찾은 관리자 수 : 있으면 1, 없으면 0
	 */
	int checkAdminEmail(String adminEmail);
	
	
}
