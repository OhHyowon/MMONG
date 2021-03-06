package com.mmong.service;

import java.util.List;

import com.mmong.vo.Member;

public interface MemberService {
	/**
	 * 한명의 회원을 추가하는 메소드
	 * @param member : 추가할 회원의 회원정보. 기존 저장된 회원과 같은 id의 회원은 추가하지 않음 
	 */
	void registerMember(Member member);
	
	/**
	 * 한명의 회원의 정보를 수정하는 메소드
	 * @param member : 수정 할 회원의 회원정보. 
	 */
	void updateMember(Member member);
	
	/**
	 * 한명의 회원을 삭제하는 메소드
	 * @param memberId  : 삭제 할 회원의 아이디
	 */
	void deleteMemberById(String memberId);
	
	/**
	 * 회원아이디로 회원을 조회하는 메소드
	 * @param id : Member객체 안에 있는 User안의 memberId로 조회
	 * @return
	 */
	Member searchMemberById(String id);
	
	/**
	 * 해당 아이디가 포함된 여러 멤버아이디를 조회하는 메소드
	 * @param id : Member객체 안에 있는 User안의 memberId로 조회
	 * @return
	 */
	List<Member> searchManyMemberById(String id);
	
	/**
	 * 회원ID로 중복 ID 조회하는 메소드
	 * @param memberId
	 * @return 찾은 회원 수 : 있으면 1, 없으면 0
	 */
	int checkMemberId(String memberId);

	/**
	 * 회원 이메일 중복확인하는 메소드
	 * @param memberEmail
	 * @return 찾은 회원 수 : 있으면 1, 없으면 0
	 */	
	int checkMemberEmail(String memberEmail);
	
	/**
	 * 회원 전화번호 중복확인하는 메소드
	 * @param memberPhone
	 * @return 찾은 번호가 : 있으면 1, 없으면 0
	 */
	int checkMemberPhone(String memberPhone);

}
