package com.mmong.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mmong.dao.UserDao;
import com.mmong.service.UserService;
import com.mmong.vo.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public void registerUser(User user){
		user.setUserPwd(passwordEncoder.encode(user.getUserPwd())); //패스워드 인코딩처리
		userDao.registerUser(user);
	}

	@Override
	public User searchUserByUserId(String userId) {
		return null;
	}

}
