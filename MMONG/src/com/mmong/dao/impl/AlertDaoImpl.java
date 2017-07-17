package com.mmong.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.AlertDao;
import com.mmong.vo.Alert;

@Repository
public class AlertDaoImpl implements AlertDao {
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.alertMapper."+id;
	}
	@Override
	public int countUnreadAlert(String memberId) {
		return session.selectOne(makeSqlId("countUnreadAlert"), memberId);
	}
	
	@Override
	public List<Alert> selectAllAlert(String memberId) {
		return session.selectList(makeSqlId("selectAllAlert"), memberId);
	}
	
	@Override
	public Alert searchAlertByNo(int alertNo) {
		return session.selectOne(makeSqlId("searchAlertByNo"), alertNo);
	}
	
	@Override
	public int updateAlertStateByNo(Alert alert) {
		return session.update(makeSqlId("updateAlertStateByNo"), alert);
	}
	


}
