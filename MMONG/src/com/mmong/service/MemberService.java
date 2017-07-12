package com.mmong.service;

import com.mmong.vo.Member;

public interface MemberService {
	/**
	 * 한명의 회원을 추가하는 메소드
	 * @param member : 추가할 회원의 회원정보. 기존 저장된 회원과 같은 id의 회원은 추가하지 않음 
	 */
	void registerMember(Member member);
	
	/**
	 * 회원아이디로 회원을 조회하는 메소드
	 * @param id : Member객체 안에 있는 User안의 memberId로 조회
	 * @return
	 */
	Member searchMemberById(String id);
	
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
}
