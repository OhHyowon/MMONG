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
}
