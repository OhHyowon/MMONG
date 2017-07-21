package com.mmong.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.TrailDao;
import com.mmong.service.TrailService;
import com.mmong.vo.Trail;

@Service
public class TrailServiceImpl implements TrailService {

	@Autowired
	private TrailDao trailDao;
	
	@Override
	public void insertTrail(Trail trail) {
		trailDao.insertTrail(trail);
	}

	@Override
	public void updateTrail(Trail trail) {
		trailDao.updateTrail(trail);
	}

	@Override
	public void deleteTrailByNo(int no) {
		trailDao.deleteTrailByNo(no);
	}

	@Override
	public Trail searchTrailByNo(int no) {
		return trailDao.searchTrailByNo(no);
	}
	
	@Override
	public List<Trail> searchTrailByTitle(String title) {
		return trailDao.searchTrailByTitle(title);
	}

	@Override
	public List<Trail> searchTrailByCategory(String category) {
		return trailDao.searchTrailByCategory(category);
	}

	@Override
	public List<Trail> searchTrailByRouteContent(String routeContent) {
		return trailDao.searchTrailByRouteContent(routeContent);
	}

	@Override
	public List<Trail> searchTrailMine(String memberId) {
		return trailDao.searchTrailMine(memberId);
	}

}
