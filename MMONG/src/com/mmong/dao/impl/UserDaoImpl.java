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
	
}
