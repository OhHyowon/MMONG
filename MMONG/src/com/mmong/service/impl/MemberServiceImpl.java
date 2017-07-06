package com.mmong.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mmong.dao.MemberDao;
import com.mmong.service.MemberService;
import com.mmong.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao memDao;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public void registerMember(Member member){
		memDao.registerMember(member);
	}

	@Override
	public Member searchMemberById(String id) {
		return memDao.searchMemberById(id);
	}

	@Override
	public int checkMemberId(String memberId) {
		return memDao.checkMemberId(memberId);
	}

	@Override
	public int checkMemberPhone(String memberPhone) {
		return memDao.checkMemberPhone(memberPhone);
	}

}
