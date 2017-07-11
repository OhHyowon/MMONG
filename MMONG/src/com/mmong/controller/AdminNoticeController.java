package com.mmong.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.AdministratorNoticeService;
import com.mmong.vo.AdministratorNotice;

@Controller
@RequestMapping("/adminNotice/")
public class AdminNoticeController {

	@Autowired
	private AdministratorNoticeService adminNoticeService;
	
	
	//관리자 공지사항 페이징
	@RequestMapping("allAdminNoticeList")
	public String showAllAdminNoticeList(@RequestParam(value="page", defaultValue="1")int page, 
//																@RequestParam (value="option", defaultValue="1")String option, 
//																@RequestParam  (value="key", defaultValue="1")String key, 
																ModelMap map) {
				
				
			Map<String, Object> pagingMap =null;
			
			//2. 비지니스 로직 처리 - Model 호춛
			
//			if(option.equals("1")){ // option 선택을 안했을 때
			pagingMap = adminNoticeService.selectAdminNoticeListPaging(page); 
//			}else{ // option 선택했을 때
//				pagingMap=adminNoticeService.selectOption(page,option,key);
//			}
			
			//3. 응답 - View 호출
//			map.addAttribute("nickNameList", pagingMap.get("nickNameList"));
			map.addAttribute("adminNoticeList", pagingMap.get("adminNoticeList"));
			map.addAttribute("pageBean", pagingMap.get("pageBean"));

			return "adminNotice/selectAdminNoticeList.tiles";
	}
	
	
	

	
	/////// 이하 테스트 완료////////////
	
	
	//관리자 공지사항 글 하나 조회
	@RequestMapping("viewAdminNotice")
	public ModelAndView viewAdminNotice(@RequestParam int adminNoticeNo){
		AdministratorNotice adNo = adminNoticeService.viewAdminNoticeByNo(adminNoticeNo);
		return new ModelAndView("adminNotice/view_notice.tiles", "adminNotice", adNo);
	}
	
	//관리자 공지사항 목록 조회
	@RequestMapping("selectAdminNoticeList")
	public ModelAndView selectNoticeList(@ModelAttribute AdministratorNotice adminNotice){
		
		List<AdministratorNotice> adminNoticeList = null;
		adminNoticeList = adminNoticeService.selectAdminNoticeList();
//			for(AdministratorNotice man : adminNoticeList){
//			System.out.println(man);
//			}
//			System.out.println("공지사항 목록 조회");
	
		return new ModelAndView("adminNotice/selectAdminNoticeList.tiles","adminNoticeList", adminNoticeList);
	}
	
	//관리자 공지사항 등록
	@RequestMapping("insertAdminNotice")
	public ModelAndView insertAdminNotice (@ModelAttribute AdministratorNotice adminNotice){
		adminNotice.setAdminDate(new Date());
		adminNoticeService.insertAdminNotice(adminNotice);
		int adminNoticeNo = adminNotice.getNo();
		return new ModelAndView("redirect:/adminNotice/viewAdminNotice.do","adminNoticeNo", adminNoticeNo);
	}
	
	//관리자 공지사항 삭제
	@RequestMapping("deleteAdminNotice")
	public ModelAndView deleteAdminNotice(@RequestParam int adminNoticeNo){
			adminNoticeService.deleteAdminNotice(adminNoticeNo);
		List<AdministratorNotice> adminNoticeList = null;
		adminNoticeList = adminNoticeService.selectAdminNoticeList();
		return new ModelAndView("adminNotice/selectAdminNoticeList.tiles","adminNoticeList", adminNoticeList);
	}
		
	
	//게시물 하나 조회에서 수정 폼으로 이동
	@RequestMapping("updateAdminNotice_form")
	public ModelAndView updateAdminNoticeForm(@RequestParam int adminNoticeNo){
		AdministratorNotice adNotice = null;
			adNotice = adminNoticeService.viewAdminNoticeByNo(adminNoticeNo);
		return new ModelAndView("adminNotice/updateAdminNotice_form.tiles","adminNotice", adNotice);
	}
	
	//관리자 공지사항 수정 폼(updateAdminNotice_form.jsp)에서 수정 완료후 다시 하나 조회(view_notice.jsp)로 이동
	@RequestMapping("updateAdminNotice")
	public ModelAndView updateAdminNotice(@ModelAttribute AdministratorNotice newAdminNotice){
		adminNoticeService.updateAdminNotice(newAdminNotice);
		int newAdminNoticeNo = newAdminNotice.getNo();
		return new ModelAndView("redirect:/adminNotice/viewAdminNotice.do","adminNoticeNo",newAdminNoticeNo);
	}
		
	
	//공지사항 검색 (제목 or 내용)
	@RequestMapping("selectAdminNoticeByKeyword")
	public ModelAndView selectAdminNoticeByKeyword(@RequestParam("option")String option, @RequestParam("keyword")String keyword){
		List<AdministratorNotice> adminNoticeListByKeyword = null;
		
		if(option.equals("제목")){
			adminNoticeListByKeyword = adminNoticeService.selectAdminNoticeListByTitle(keyword);
//			for(AdministratorNotice man : adminNoticeListByKeyword){
//			System.out.println(man);
//			}
//			System.out.println("공지사항 제목 검색 조회");
		}else if(option.equals("내용")){
			adminNoticeListByKeyword = adminNoticeService.selectAdminNoticeListByContent(keyword);
//			for(AdministratorNotice man : adminNoticeListByKeyword){
//			System.out.println(man);
//			}
//			System.out.println("공지사항 내용 검색 조회");
		}
		return new ModelAndView("adminNotice/selectAdminNoticeList.tiles","adminNoticeList", adminNoticeListByKeyword);
	}
	
	
	
	
	
	
	
}



















