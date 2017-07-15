package com.mmong.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.UserDao;
import com.mmong.vo.User;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired
	private SqlSessionTemplate session;	
	
	private String makeSql(String id){
		return "com.MMONG.config.mapper.userMapper."+id;
	}
	
	@Override
	public int registerUser(User user) {
		return session.insert(makeSql("registerUser"), user);
	}

	@Override
	public User searchUserByUserId(String userId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSql("searchUserByUserId"), userId);
	}

	@Override
	public int searchAuthorityByUserId(String userId) {
		return session.selectOne(makeSql("searchAuthorityByUserId"), userId);
	}

	@Override
	public int updateUserByUserId(User user) {
		return session.update(makeSql("updateUserByUserId"), user);
	}
	
	@Override
	public int deleteUserByUserId(String userId) {
		return session.delete(makeSql("deleteUserByUserId"), userId);
	}
	
/////////////////////////////////////////////////
	@Override
	public int updateUser(User user) {
		return session.update(makeSql("updateUser"), user);
	}	
	
	@Override
	public int checkUserId(String userId) {
	return session.selectOne(makeSql("checkUserId"), userId);
	}

	@Override
	public int updateUserAuthorityToStop(String userId) {
		return session.update(makeSql("updateUserAuthorityToStop"), userId);
	}
	
	
	@Override
	public int updateAuthorityAdminToRun(String adminId) {
		return session.update(makeSql("updateAuthorityAdminToRun"), adminId);
	}

	@Override
	public int updateAuthorityMemberToRun(String memberId) {
		return session.update(makeSql("updateAuthorityMemberToRun"), memberId);
	}
	

	@Override
	public int updateUserAuthorityToWithdrawal(String userId) {
		return session.update(makeSql("updateUserAuthorityToWithdrawal"), userId);
	}
	
	/////////////////////////////////////////////////
	
		
	
	
	
	
}
