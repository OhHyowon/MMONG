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
	 * 매개변수로 받은 id로 저장된 관리자정보를 삭제
	 * - 삭제할 ID의 관리자가 없으면 없다고 AdministratorNotFoundException 발생
	 * - list내에 매개변수의 id를 가진 administrator 객체를 remove
	 * @param id 삭제할 id.
	 * @throws AdministratorNotFoundException 삭제할 관리자가 없는 경우 발생ㅂ
	 * 
	 */
	void deleteAdministratorById(String adminId);
	
	/**
	* 저장된 관리자중 매개변수의 id를 가진 관리자를 찾아 주는 메소드.
	* @param id 찾을 관리자의 ID
	* @return 조회한 관리자 객체를 리턴. 단 찾는 ID의 관리자이 없으면 null(없어요)를 리턴한다.
	 * @throws AdministratorNotFoundException 
	* 
	*/
	Administrator searchAdministratorById(String adminId);
	
//
//			
//	//일반회원(member) 권한 변경
//		//일반회원(member) 활동상태(1) -> 중지상태(4)
//	/**
//	 * 일반회원 (member)의 권한을 '활동중지(4)'로 변경한다.
//	 * @param memberId
//	 * @return
//	 */
//		void changeAuthorityMemberToStop(String memberId);
//		//1. 일반회원(member)의 권한 상태 조회(select)
//		//2. 권한이 1이면 4로 변경(update)
//		
//		
//	//일반회원(member) 활동상태(4) <- 중지상태(1)
//	/**
//	 * 일반회원 (member)의 권한을 '일반회원(1)'로 변경한다.
//	 * @param memberId
//	 * @return
//	 */
//		void changeAuthorityMemberToRun(String memberId);
//		//1. 일반회원(member)의 권한 상태 조회(select)
//		//2. 권한이 4이면 1로 변경(update)
//	
//		
//		///////// 테스트 완료/////////
//		
}
