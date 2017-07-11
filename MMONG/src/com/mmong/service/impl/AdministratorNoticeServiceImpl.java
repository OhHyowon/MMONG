package com.mmong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.AdministratorNoticeDao;
import com.mmong.paging.util.PagingBean;
import com.mmong.service.AdministratorNoticeService;
import com.mmong.vo.AdministratorNotice;

@Service
public class AdministratorNoticeServiceImpl implements AdministratorNoticeService{

	@Autowired
	private AdministratorNoticeDao adminNoticeDao;
	
	//관리자 공지사항 글 등록
	@Override
	public void insertAdminNotice(AdministratorNotice adminNotice) {
		adminNoticeDao.insertAdminNotice(adminNotice);
	}

	@Override
	public void updateAdminNotice(AdministratorNotice newData) {
		adminNoticeDao.updateAdminNotice(newData);
	}

	@Override
	public void deleteAdminNotice(int adminNoticeNo)  {
		adminNoticeDao.deleteAdminNoticeByNo(adminNoticeNo);
	}

	@Override
	public AdministratorNotice viewAdminNoticeByNo(int adminNoticeNo){
		return adminNoticeDao.viewAdminNoticeByNo(adminNoticeNo);
	}

	@Override
	public List<AdministratorNotice> selectAdminNoticeListByTitle(String adminNoticeTitle){
		List<AdministratorNotice> list = adminNoticeDao.selectAdminNoticeListByTitle(adminNoticeTitle);
		return list;
	}

	@Override
	public List<AdministratorNotice> selectAdminNoticeListByContent(String adminNoticeContent){
		List<AdministratorNotice> list = adminNoticeDao.selectAdminNoticeListByContent(adminNoticeContent);	
		for(AdministratorNotice m : list){
			System.out.println(m);
		}
		return list;
	}

	@Override
	public List<AdministratorNotice> selectAdminNoticeList() {
		List<AdministratorNotice> list =  adminNoticeDao.selectAdminNoticeList();
		return list;
	}

	//페이징
	@Override
	public Map<String, Object> selectAdminNoticeListPaging(int page) {
		HashMap<String,Object> map = new HashMap<>();
		
		//1. PagingBean 객체 생성 -> Paging 계산 처리하는 객체. -> 보려는 페이지, 총 공지사항 갯수  
		int totalCount = adminNoticeDao.selectAdminNoticeCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		
		//2. page에 보여줄 공지사항 리스트.
		List<AdministratorNotice> list = adminNoticeDao.selectAdminNoticeListPaging(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
//		for(AdministratorNotice a : list){
//			System.out.println("점검--1 "+a);
//		}
		map.put("adminNoticeList", list);
		
		return map;
	}

	@Override
	public Map<String, Object> selectOptionNoitceList(int page, String option, String keyword) {
		HashMap<String,Object> map = new HashMap<>();getClass();
		
		//1. PagingBean 객체 생성 -> Paging 계산 처리하는 객체. -> 보려는 페이지, 총 공지사항 갯수  
		System.out.println("점검--1 페이지: "+page+" 옵션: "+option+" 키워드: "+keyword);
		int totalCount = adminNoticeDao.selectAdminNoticeOptionCount(option, keyword);
		System.out.println("점검--2 "+totalCount);
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		
		//2. page에 보여줄 공지사항 리스트.
		List<AdministratorNotice> list = adminNoticeDao.selectOptionNoticeListPaging(option, keyword, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		for(AdministratorNotice a : list){
			System.out.println("점검--1 "+a);
		}
		map.put("adminNoticeList", list);

		return map;
	}


	
	
	
	

}






