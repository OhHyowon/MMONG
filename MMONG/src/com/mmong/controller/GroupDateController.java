package com.mmong.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mmong.service.impl.GroupDateServiceImpl;
import com.mmong.validation.GroupDateValidator;
import com.mmong.vo.GroupDate;
import com.mmong.vo.Member;

@Controller
@RequestMapping("group/groupDate/")
public class GroupDateController{
	@Autowired
	private GroupDateServiceImpl groupDateService;
	
	
	/*일정 등록*/
	@RequestMapping("register")
	public String groupDateInsert(@ModelAttribute GroupDate groupDate, BindingResult errors,
													HttpSession session,ModelMap map){
		
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
	
		int groupNo=(int) session.getAttribute("groupNo");
		
		GroupDateValidator vaildator=new GroupDateValidator();
		vaildator.validate(groupDate, errors);
		if(errors.hasErrors()){
			return "group/groupDate/groupDate_form.tiles";
		}
	
		groupDate.setMemberId(memberId); // 로그인한 사람이 일정 등록자
		groupDate.setGroupNo(groupNo); // 세션에서 받은 groupNo 
		
		int groupDateNo=groupDateService.insertGroupDate(groupDate); // 등록한 일정 No
		
		return "redirect:/group/groupDate/groupDateView.do?groupDateNo="+groupDateNo; // 완성되면 일정 상세보기 페이지로 바꾸기
	}
	
	@RequestMapping("groupDateView")
	public String selectGroupDate(int groupDateNo, ModelMap map){
		
		System.out.println("상세보기 컨트롤러");
		
		GroupDate groupDate = groupDateService.selectGroupDate(groupDateNo);
		
		map.addAttribute("groupDate", groupDate);
		
		return "group/groupDate/groupDate_view.tiles";
	}
}
