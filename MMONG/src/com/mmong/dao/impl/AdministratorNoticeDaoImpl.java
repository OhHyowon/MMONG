package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.AdministratorNoticeDao;
import com.mmong.vo.AdministratorNotice;

@Repository
public class AdministratorNoticeDaoImpl implements AdministratorNoticeDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "com.mmong.config.mapper.administratorNoticeMapper."+tagId;
	}
	
	@Override
	public int insertAdminNotice(AdministratorNotice adminNotice) {
		return session.insert(makeSql("insertAdminNotice"), adminNotice);
	}

	@Override
	public int updateAdminNotice(AdministratorNotice adminNotice) {
		return session.insert(makeSql("updateAdminNotice"), adminNotice);
	}

	@Override
	public int deleteAdminNoticeByNo(int adminNoticeNo) {
		return session.insert(makeSql("deleteAdminNoticeByNo"), adminNoticeNo);
	}

	@Override
	public AdministratorNotice viewAdminNoticeByNo(int adminNoticeNo) {
		return session.selectOne(makeSql("viewAdminNoticeByNo"), adminNoticeNo);
	}

	//관리자 공지사항 목록 조회
	@Override
	public List<AdministratorNotice> selectAdminNoticeList() {
		return session.selectList(makeSql("selectAdminNoticeList"));
	}

	//관리자 공지사항 제목 검색
	@Override
	public List<AdministratorNotice> selectAdminNoticeListByTitle(String title) {
		return session.selectList(makeSql("selectAdminNoticeListByTitle"), title);
	}

	//관리자 공지사항 내용 검색
	@Override
	public List<AdministratorNotice> selectAdminNoticeListByContent(String content) {
		return session.selectList(makeSql("selectAdminNoticeListByContent"),content);
	}


	//관리자 공지사항 페이징-1 (페이징의 대상이 될 게시물들의 총 갯수 조회)
	@Override
	public int selectAdminNoticeCount() {
		return session.selectOne(makeSql("selectAdminNoticeCount"));
	}
	
	//관리자 공지사항 페이징-2 (페이징 대상이 될 검색조건을 만족하는 게시물들의 총 갯수 조회)
	@Override
	public int selectAdminNoticeOptionCount(String option, String keyword) {
		HashMap<String,Object> param = new HashMap();
		param.put("option", option);
		param.put("keyword", keyword);
		return session.selectOne(makeSql("selectAdminNoticeOptionCount"), param);
	}
	

	//관리자 공지사항 페이징-3
	@Override
	public List<AdministratorNotice> selectAdminNoticeListPaging(int beginNoticeInPage, int endNoticeInPage) {
		HashMap<String, Object> param = new HashMap<>();
		param.put("beginNoticeInPage", beginNoticeInPage);
		param.put("endNoticeInPage", endNoticeInPage);
		return session.selectList(makeSql("selectAdminNoticeListPaging"), param);
	}

	//관리자 공지사항 페이징-4 (검색)
	@Override
	public List<AdministratorNotice> selectOptionNoticeListPaging(String option, String keyword, int beginNoticeInPage, int endNoticeInPage) {
		HashMap<String, Object> param = new HashMap<>();
		
		param.put("option", option);
		param.put("keyword", keyword);
		param.put("beginNoticeInPage", beginNoticeInPage);
		param.put("endNoticeInPage", endNoticeInPage);
		
		return session.selectList(makeSql("selectOptionNoticeListPaging"), param);
	}


	
}

