package com.mmong.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mmong.service.impl.ChartServiceImpl;
import com.mmong.service.impl.HealthServiceImpl;
import com.mmong.validation.HealthValidator;
import com.mmong.vo.Chart;
import com.mmong.vo.Health;
import com.mmong.vo.Member;

@Controller
@RequestMapping("/health/")
public class HealthController {

	@Autowired
	private HealthServiceImpl service;

	@Autowired
	private ChartServiceImpl service2;

	@RequestMapping("regist")
	public String registHealthList(@ModelAttribute Health health, BindingResult errors,HttpServletRequest request) {
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		HealthValidator validator = new HealthValidator();
		
		validator.validate(health, errors);
		if(errors.hasErrors()){
			return "content/health/healthlist_regist";
		}
		
		String content = request.getParameter("content");
		String gender = request.getParameter("gender");
		
		Health health2 = new Health(2,content,0,gender);
		
		service.addHealthList(health2);
		
		
		return "content/health/success";
	}
	
	@RequestMapping("modify")
	public String modifyHealthList(HttpServletRequest request){
		
		
		
		return "content/health/success";
	}
	
	@RequestMapping("healthlist")
	@ResponseBody
	public List healthList(@RequestParam String gender) {
	
		List<Health> list = new ArrayList<Health>();
		
		char gen = gender.charAt(0);
		
		if(gen=='d'){
		 list = service.selectByAllHealth();
		}else{
		list = service.selectByGender(gen);
		}
		
		return list;
	}
	
	@RequestMapping("deleteHealth")
	@ResponseBody
	public String deleteHealth(@RequestParam List<Integer> checkedList){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		for(int i=0; i<checkedList.size(); i++){
			service.deleteHealthByNo(checkedList.get(i));
		}
		
		return "1";
	}
}
