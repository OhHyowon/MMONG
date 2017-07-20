package com.mmong.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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

	// 건강 기록 등록
	@RequestMapping("regist")
	public String registHealthList(@ModelAttribute Health health, BindingResult errors,HttpServletRequest request) {
		
		HealthValidator validator = new HealthValidator();
		
		validator.validate(health, errors);
		if(errors.hasErrors()){
			return "/WEB-INF/view/content/health/healthlist_regist.jsp";
		}
		
		String content = request.getParameter("content");
		String gender = request.getParameter("gender");
		
		
		Health health2 = new Health(54,content,gender);
		
		service.addHealthList(health2);
		
		
		return "/WEB-INF/view/content/health/success.jsp";
	}
	
	// 건강기록 뿌려주기
	@RequestMapping("healthlist")
	@ResponseBody
	public List healthList(@RequestParam String gender) {
	
		List<Health> list = new ArrayList<Health>(); 
		
		
		char gen = gender.charAt(0);
		
		// 전체 목록과 성별로 찾아서 조회하는걸 구분해 준다.
		if(gen=='d'){	// 전체목록 조회 라디오 버튼을 눌렀을떄 
		 list = service.selectByAllHealth();	// 전체조회
		}else{	// 전체목록 제외한 다른애들 라디오 버튼을 눌렀을떄
		list = service.selectByGender(gen);	// 성별 집어넣어서 DB에서 꺼내오자
		}
		
		return list;
	}
	
	// 건강기록 삭제
	@RequestMapping("deleteHealth")
	@ResponseBody
	public String deleteHealth(@RequestParam List<Integer> checkedList){
			
		// 여러개 삭제해줄경우도 있으니 list로 담은거 for문 돌려서 삭제함
		for(int i=0; i<checkedList.size(); i++){
			service.deleteHealthByNo(checkedList.get(i));
		}
		
		return "1";
	}
	
	// 건강기록 수정 1
	@RequestMapping("updateHealth")
	public String healthUpdate(HttpServletRequest request){
		
		HashMap<String,Object> map = new HashMap<>();
		String String_no = request.getParameter("no");
		String content = request.getParameter("content");
						
		map.put("no", String_no);	
		map.put("content", content);
		
		// 위에 건강기록 수정 
		service.updateHealthList(map);
		
		return "/WEB-INF/view/content/health/success.jsp";
	}
}
