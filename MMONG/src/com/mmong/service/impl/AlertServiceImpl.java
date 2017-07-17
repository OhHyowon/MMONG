package com.mmong.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.AlertDao;
import com.mmong.service.AlertService;
import com.mmong.vo.Alert;

@Service
public class AlertServiceImpl implements AlertService {
	
	@Autowired
	AlertDao alertDao;
	
	@Override
	public int countUnreadAlert(String memberId) {
		return alertDao.countUnreadAlert(memberId);
	}

	@Override
	public List<Alert> selectAllAlert(String memberId) {
		return alertDao.selectAllAlert(memberId);
	}

	@Override
	public Alert searchAlertByNo(int alertNo) {
		return alertDao.searchAlertByNo(alertNo);
	}
	
	@Override
	public int updateAlertStateByNo(Alert alert) {
		return alertDao.updateAlertStateByNo(alert);
	}



}
