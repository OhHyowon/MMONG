package com.mmong.service;

import java.util.List;

import com.mmong.vo.Trail;

public interface TrailService {
	
	/**
	 * 한 개의 산책로를 등록하는 메소드
	 * @param trail
	 */
	void insertTrail(Trail trail);
	
	/**
	 * 한 개의 산책로를 수정하는 메소드
	 * @param trail
	 */
	void updateTrail(Trail trail);
	
	/**
	 * 한 개의 산책로를 삭제하는 메소드
	 * @param no
	 */
	void deleteTrailByNo(int no);
	
	/**
	 * no로 산책로 조회하는 메소드
	 * @param no
	 * @return
	 */
	Trail searchTrailByNo(int no);
	
	/**
	 * title로 산책로 조회하는 메소드
	 * @param title
	 * @return
	 */
	List<Trail> searchTrailByTitle(String title);
	
	/**
	 * category로 산책로 조회하는 메소드
	 * @param category
	 * @return
	 */
	List<Trail> searchTrailByCategory(String category);
	
	/**
	 * route content로 산책로 조회하는 메소드
	 * @param routeContent
	 * @return
	 */
	List<Trail> searchTrailByRouteContent(String routeContent);
}
