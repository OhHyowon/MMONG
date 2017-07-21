package com.mmong.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.TrailDao;
import com.mmong.vo.Trail;

@Repository
public class TrailDaoImpl implements TrailDao {

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String id) {
		return "com.mmong.config.mapper.trailMapper."+id;
	}
	
	@Override
	public int insertTrail(Trail trail) {
		return session.insert(makeSql("insertTrail"), trail);
	}

	@Override
	public int updateTrail(Trail trail) {
		return session.update(makeSql("updateTrail"), trail);
	}

	@Override
	public int deleteTrailByNo(int no) {
		return session.delete(makeSql("deleteTrailByNo"), no);
	}

	@Override
	public Trail searchTrailByNo(int no) {
		return session.selectOne(makeSql("searchTrailByNo"), no);
	}
	
	@Override
	public List<Trail> searchTrailByTitle(String title) {
		return session.selectList(makeSql("searchTrailByTitle"), title);
	}

	@Override
	public List<Trail> searchTrailByCategory(String category) {
		return session.selectList(makeSql("searchTrailByCategory"), category);
	}

	@Override
	public List<Trail> searchTrailByRouteContent(String routeContent) {
		return session.selectList(makeSql("searchTrailByRouteContent"), routeContent);
	}

	@Override
	public List<Trail> searchTrailMine(String memberId) {
		return session.selectList(makeSql("searchTrailMine"), memberId);
	}
}
