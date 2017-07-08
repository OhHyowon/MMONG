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

	//관리자 공지사항 페이징
	@Override
	public List<AdministratorNotice> selectAdminNoticeListPaging(int beginNoticeNo, int endNoticeNo) {
		HashMap<String, Integer> param = new HashMap<>();
		param.put("beginNoticeNum", beginNoticeNo);
		param.put("endNoticeNum", endNoticeNo);
		return session.selectList(makeSql("selectAdminNoticeListPaging"), param);
	}

	//관리자 공지사항 페이징-2
	@Override
	public int selectAdminNoticeCount() {
		return session.selectOne(makeSql("selectAdminNoticeCount"));
	}

	
	
	
}

