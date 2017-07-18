package com.mmong.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.AdministratorDao;
import com.mmong.vo.Administrator;


@Repository
public class AdministratorDaoImpl implements AdministratorDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "com.mmong.config.mapper.administratorMapper."+tagId;
	}
	
	@Override
	public int insertAdministrator(Administrator administrator) {
		return session.insert(makeSql("insertAdministrator"), administrator);
	}

	@Override
	public int updateAdministrator(Administrator administrator) {
		return session.update(makeSql("updateAdministrator"), administrator);
	}

	@Override
	public Administrator searchAdministratorById(String administratorId) {
		return session.selectOne(makeSql("searchAdministratorById"), administratorId);
	}

	@Override
	public int checkAdminPhone(String adminPhone) {
		return session.selectOne(makeSql("checkAdminPhone"), adminPhone);
	}

	@Override
	public int checkAdminEmail(String AdminEmail) {
		return session.selectOne(makeSql("checkAdminEmail"), AdminEmail);
	}
	
	
	
	
	
}		
















