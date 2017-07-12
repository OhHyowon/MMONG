package com.mmong.dao;

import java.util.List;

import com.mmong.vo.AdministratorNotice;

public interface AdministratorNoticeDao {

	//공지사항 등록
	/**
	 * 하나의 게시글 데이터를 insert하는 메소드
	 * @param adNotice
	 * @return
	 */
	int insertAdminNotice(AdministratorNotice adminNotice);
	
	//공지사항 수정
	/**
	 * 매개변수로 받은 AdministratorNotice 객체와 일치하는 게시글의 나머지 값들을 update 하는 메소드
	 * @param adNotice
	 * @return
	 */
	int updateAdminNotice(AdministratorNotice adminNotice);
	
	//공지사항 삭제
	/**
	 * 매개변수로 받은 AdministratorNotice 객체와 일치하는 게시글의 나머지 값들을 delete 하는 메소드
	 * @param adNotice
	 * @return
	 */
	int deleteAdminNoticeByNo(int adminNoticeNo);
	
	//공지사항 조회
	/**
	 * 매개변수로 받은 공지사항 번호(pk)로 한 개의 공지사항 글 상세정보를 조회한다.
	 *   - 내용 : 글 번호, 글 제목, 글 내용, 작성일
	 * @param adNotice
	 * @return
	 */
	AdministratorNotice viewAdminNoticeByNo(int adminNoticeNo);
	
	// 공지사항 목록 조회
	/**
	 * 공지사항 글 목록을 보여준다.
	 * @param adNotice
	 * @return
	 */
	List<AdministratorNotice> selectAdminNoticeList();
	
	
	//공지사항 검색
	/**
	 * 게시글의 제목으로 관리자 공지사항을 select 하는 메소드
	 * 제목에 들어가는 단어가 겹치는 경우가 있으므로 List로 리턴
	 * @param title
	 * @return
	 */
	List<AdministratorNotice> selectAdminNoticeListByTitle(String title);
	
	/**
	 * 게시글의 내용으로 관리자 공지사항을 select 하는 메소드
	 * 내용에 들어가는 단어가 겹치는 경우가 있으므로 List로 리턴
	 * @param content
	 * @return
	 */
	List<AdministratorNotice>selectAdminNoticeListByContent(String content);
	
	
	//페이징처리된 전체 공지사항 목록 조회
	/**
	 * 공지사항 페이징 처리하기 위한 메소드
	 * @param beginNoticeInPage  	 보려는 페이지의 시작 adminNotice 번호
	 * @param endNoticeInPage 		 보려는 페이지의 마지막 adminNotice 번호
	 * @return
	 */
	List<AdministratorNotice> selectAdminNoticeListPaging(int beginNoticeInPage, int endNoticeInPage);
	
	/**
	 * 
	 * @param option		옵션 검색 조건
	 * @param keyword	검색할 키워드
	 * @param beginNoticeInPage		보려는 페이지의 시작 adminNotice 번호
	 * @param endNoticeInPage		보려는 페이지의 마지막 adminNotice 번호
	 * @return
	 */
	List<AdministratorNotice> selectOptionNoticeListPaging(String option, String keyword, int  beginNoticeInPage, int endNoticeInPage);
	
	/**
	 * administrator_notice의 총 공지사항 수를 조회
	 * @return 총 공지사항 갯수
	 */
	int selectAdminNoticeCount();
	
	/**
	 * administrator_notice의 총 공지사항 중 옵션 검색 수 조회
	 * @return
	 */
	int selectAdminNoticeOptionCount(String option, String keyword);


	
	
	
	
	
}























