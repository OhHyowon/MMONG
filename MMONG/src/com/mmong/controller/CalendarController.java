package com.mmong.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mmong.service.CalendarService;
import com.mmong.validation.InsertScheduleValidator;
import com.mmong.vo.Calendar;
import com.mmong.vo.Member;

@Controller
@RequestMapping("/calendar/")
public class CalendarController {

	@Autowired
	private CalendarService service;
	
	@RequestMapping("insert")
	public ModelAndView insertSchedule(@RequestParam MultipartFile upImage, @ModelAttribute Calendar calendar, BindingResult errors, HttpServletRequest request, ModelMap map){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId = member.getMemberId();
	
		String destDir = request.getServletContext().getRealPath("/up_image"); // 진짜경로
		if(upImage!=null && !upImage.isEmpty()){
			String fileName = upImage.getOriginalFilename();
			try {
				upImage.transferTo(new File(destDir, fileName));
			} catch (IllegalStateException e) { ///////////Exception 선언~~~필용오요요요요요요ㅛㅇ
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			calendar.setPicture(fileName);
			
		}
		
		calendar.setMemberId(memberId);
		
		InsertScheduleValidator valid = new InsertScheduleValidator();
		valid.validate(calendar, errors);
		
		if(errors.hasErrors()){
			map.addAttribute("insertInfo", calendar);
			return new ModelAndView("calendar/insertSchedule.tiles");
		}
		
		service.insertSchedule(calendar);
		
		RedirectView rv = new RedirectView("/MMONG/calendar/insertSuccess.do");
		rv.setExposeModelAttributes(false);
		
		return new ModelAndView(rv);
	}
	
	/**
	 * 달력 조회하기
	 * DB에서 가져오기
	 * @param map
	 * @return
	 */
	@RequestMapping("select")
	@ResponseBody
	public List<Calendar> selectSchedule(){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId = member.getMemberId();
		
		List<Calendar> list = service.selectSchedule(memberId);

		return list;
	}
	
	/**
	 * 일정 상세 조회
	 * @param map
	 * @param eventNo
	 * @return
	 */
	@RequestMapping("viewSchedule")
	public String viewSchedule(ModelMap map, @RequestParam int eventNo){
		
		Calendar eventInfo = service.viewSchedule(eventNo);
		map.addAttribute("eventInfo", eventInfo);
		
		return "calendar/viewSchedule.tiles";
	}

	/**
	 * 일정 삭제하기
	 * @param no
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public String deleteSchedule(@RequestParam int no){
		
		service.deleteSchedule(no);
		
		return "1";
	}
	
	/**
	 * 수정할 일정의 정보들 조회
	 * @param no
	 * @param map
	 * @return
	 */
	@RequestMapping("selectScheduleInfo")
	public String selectScheduleInfo(@RequestParam int no, ModelMap map){
		
		Calendar calendar = service.viewSchedule(no);
		map.addAttribute("updateInfo", calendar);
		
		return "calendar/updateSchedule.tiles";
	}
	
	/**
	 * 일정 수정
	 * @return
	 */
	@RequestMapping("update")
	public ModelAndView updateSchedule(@RequestParam int no, @RequestParam String savedImg,
			@RequestParam(value="delete", defaultValue="0") String delete, 
			@RequestPart(value = "upImage", required=false) MultipartFile upImage, 
			@ModelAttribute Calendar calendar, BindingResult errors, HttpServletRequest request, ModelMap map){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId = member.getMemberId();

		String destDir = request.getServletContext().getRealPath("/up_image"); // 진짜경로
		if(upImage!=null && !upImage.isEmpty()){ // 이미지를 수정했으면
			String fileName = upImage.getOriginalFilename();
			try {
				upImage.transferTo(new File(destDir, fileName));
			} catch (IllegalStateException e) { 
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			calendar.setPicture(fileName);
		}else if(delete.equals("1")){ //사진을 삭제
			calendar.setPicture(null);
		}else{ // 이미지를 수정&삭제하지 않았으면
			calendar.setPicture(savedImg);
		}
		
		calendar.setMemberId(memberId);
		calendar.setNo(no);

		InsertScheduleValidator valid = new InsertScheduleValidator();
		valid.validate(calendar, errors);
		
		if(errors.hasErrors()){
			map.addAttribute("updateInfo", calendar);
			return new ModelAndView("calendar/updateSchedule.tiles");
		}
		
		service.updateSchedule(calendar);
		
		RedirectView rv = new RedirectView("/MMONG/calendar/updateSuccess.do");
		rv.setExposeModelAttributes(false);
		
		return new ModelAndView(rv);
	}

}
