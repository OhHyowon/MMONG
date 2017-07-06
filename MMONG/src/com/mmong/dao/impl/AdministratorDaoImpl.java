package com.mmong.dao.impl;

import java.util.List;

import org.apache.catalina.Manager;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.AdministratorDao;
import com.mmong.vo.Administrator;
import com.mmong.vo.Member;


@Repository
public class AdministratorDaoImpl implements AdministratorDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "com.mmong.config.mapper.administratorMapper."+tagId;
	}
	
	@Override
	public int registerAdministrator(Administrator administrator) {
		return session.insert(makeSql("registerAdministrator"), administrator);
	}

	@Override
	public int updateAdministratorById(Administrator administrator) {
		return session.update(makeSql("updateAdministratorById"), administrator);
	}

	@Override
	public int deleteAdministratorById(String administratorId) {
		return session.delete(makeSql("deleteAdministratorById"), administratorId);
	}
	
	@Override
	public Administrator searchAdministratorById(String administratorId) {
		return session.selectOne(makeSql("searchAdministratorById"), administratorId);
	}

////////////////////////테스트 완료 /////////////////////////////////
	@Override
	public Member searchMemberById(String memberId) {
		return session.selectOne(makeSql("searchMemberById"), memberId);
	}

	@Override
	public int updateAuthorityMemberToStop(String memberId) {
		return session.update(makeSql("updateAuthorityMemberToStop"), memberId);
	}

	@Override
	public int updateAuthorityMemberToRun(String memberId) {
		return session.update(makeSql("updateAuthorityMemberToRun"), memberId);
	}



}		
















