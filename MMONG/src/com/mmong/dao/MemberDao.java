package com.mmong.dao;

import com.mmong.vo.Member;

public interface MemberDao {

	/**
	 * 개인 회원 추가
	 * @param member
	 * @return
	 * 작성자 : 이주현
	 */
	int registerMember(Member member);
	
	/**
	 * 개인 회원정보 수정
	 * @param member
	 * @return
	 * 작성자 : 이진우
	 */
	int updateMember(Member member);
	
	/**
	 * 개인 회원 삭제
	 * @param member
	 * @return
	 * 작성자 : 이진우
	 */
	int deleteMemberById(String memberId);
	
	/**
	 * 개인 회원 조회
	 * @param memberId
	 * @return 해당 아이디의 Member 객체
	 * 작성자 : 이주현
	 */
	Member searchMemberById(String memberId);
	
	/**
	 * 회원ID로 중복 ID 조회하는 메소드
	 * @param memberId
	 * @return 찾은 회원 수 : 있으면 1, 없으면 0
	 */
	int checkMemberId(String memberId);

	/**
	 * 회원 핸드폰 번호로 중복번호 조회하는 메소드
	 * @param memberPhone
	 * @return 찾은 회원 수 : 있으면 1, 없으면 0
	 */
	int checkMemberPhone(String memberPhone);
}
