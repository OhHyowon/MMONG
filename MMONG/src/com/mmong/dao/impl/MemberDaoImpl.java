package com.mmong.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.MemberDao;
import com.mmong.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String id){
		return "com.mmong.config.mapper.memberMapper."+id;
	}
	
	@Override
	public int registerMember(Member member) {
		return session.insert(makeSql("registerMember"), member);
	}
	
	@Override
	public int updateMember(Member member) {
		return session.update(makeSql("updateMember"), member);
	}
	
	@Override
	public int deleteMemberById(String memberId) {
		return session.delete(makeSql("deleteMemberById"), memberId);
	}

	@Override
	public Member searchMemberById(String memberId) {
		return session.selectOne(makeSql("searchMemberById"), memberId);
	}

	@Override
	public int checkMemberId(String memberId) {
		return session.selectOne(makeSql("checkMemberId"), memberId);
	}

	@Override
	public int checkMemberPhone(String memberPhone) {
		return session.selectOne(makeSql("checkMemberPhone"), memberPhone);
	}
	
	@Override
	public int checkMemberEmail(String memberEmail) {
		return session.selectOne(makeSql("checkMemberEmail"), memberEmail);
	}

}
