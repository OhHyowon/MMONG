package com.mmong.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.Validator;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mmong.validation.GroupDateValidator;
import com.mmong.vo.GroupDate;

@Controller
@RequestMapping("group/groupDate/")
public class GroupDateController{

	
	public String groupDateInsert(@ModelAttribute GroupDate groupDate, BindingResult errors,
													HttpServletRequest request, HttpSession session){
		
		
		String memberId = "testId"; // test 되는 동안에 쓸 id
		/*
		 * 로그인 되면 memberId = session.getAttribute("memberId");
		 */
		
		GroupDateValidator vaildator=new GroupDateValidator();
		vaildator.validate(groupDate, errors);
		if(errors.hasErrors()){
			return "content/group/groupDate/groupDate_from";
		}
		
		
		
		
		
		
		return ""; // 완성되면 일정 상세보기 페이지로 바꾸기
	}
}
