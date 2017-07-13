package com.mmong.service;

import java.util.List;
import java.util.Map;

import com.mmong.vo.AdministratorNotice;

public interface AdministratorNoticeService {

	
	/**
	 * 하나의 공지사항을 추가하는 메소드
	 * @param administratorNotice : 추가할 하나의 공지사항 게시글
	 * 
	 */
	void insertAdminNotice(AdministratorNotice adminNotice);
	
	/**
	 * 공지사항 수정하는 메소드
	 * @param newData 
	 * @throws AdminNoticeNotFoundException
	 */
	void updateAdminNotice(AdministratorNotice newData);
	
	/**
	 * 공지사항 번호를 받아서 삭제하는 메소드
	 * @param adminNoticeNo : 공지사항 번호 (PK)
	 * @throws AdminNoticeNotFoundException
	 */
	void deleteAdminNotice(int adminNoticeNo);
	
	/**
	 * 공지사항 번호를 받아서 조회하는 메소드
	 * @param adminNoticeNo : 공지사항 번호 (PK)
	 * @return 
	 * @throws AdminNoticeNotFoundException
	 */
	AdministratorNotice viewAdminNoticeByNo(int adminNoticeNo);
	
	/**
	 * 공지사항 제목을 받아서 공지사항 글 검색
	 * @param adminNoticeTitle
	 */
	List<AdministratorNotice> selectAdminNoticeListByTitle(String adminNoticeTitle);
	
	/**
	 * 공지사항 내용을 받아서 공지사항 글 검색
	 * @param adminNoticeContent
	 */
	List<AdministratorNotice> selectAdminNoticeListByContent(String adminNoticeContent);
	
	/**
	 * 공지사항 목록 조회
	 * @return 공지사항 게시글들 리턴
	 */
	List<AdministratorNotice> selectAdminNoticeList();
	
	
	//페이징
	/**
	 * page 기준으로 관리자 공지사항들을 조회하는 메소드.
	 * @param page 보려는 페이지
	 * @return Map 내에 그 페이지에서 보여줄 공지사항들을 담은 List와 PaingBean 객체를 리턴
	 */
	Map<String, Object> selectAdminNoticeListPaging(int page);
	
	
	
	
	
	
}









