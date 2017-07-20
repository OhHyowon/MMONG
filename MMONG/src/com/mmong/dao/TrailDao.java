package com.mmong.dao;

import java.util.List;

import com.mmong.vo.Trail;

public interface TrailDao {
	
	/**
	 * 산책로 등록하기
	 * @param trail
	 * @return
	 */
	int insertTrail(Trail trail);
	
	/**
	 * 산책로 수정하기
	 * @param trail
	 * @return
	 */
	int updateTrail(Trail trail);
	
	/**
	 * 산책로 삭제하기
	 * @param no
	 * @return
	 */
	int deleteTrailByNo(int no);
	
	/**
	 * NO로 산책로 조회
	 * @param no
	 * @return
	 */
	Trail searchTrailByNo(int no);
	
	/**
	 * 산책로 이름으로 산책로 조회
	 * @param title
	 * @return
	 */
	List<Trail> searchTrailByTitle(String title);
	
	/**
	 * 산책로 카테고리로 산책로 조회
	 * @param category
	 * @return
	 */
	List<Trail> searchTrailByCategory(String category);
	
	/**
	 * 산책로 경로 내용으로 산책로 조회
	 * @param content
	 * @return
	 */
	List<Trail> searchTrailByRouteContent(String routeContent);
}
