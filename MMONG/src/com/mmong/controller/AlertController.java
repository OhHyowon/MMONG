package com.mmong.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.AlertService;
import com.mmong.vo.Alert;
import com.mmong.vo.Group;
import com.mmong.vo.GroupMember;
import com.mmong.vo.Member;

@Controller
@RequestMapping("/alert/")
public class AlertController {
	@Autowired
	private AlertService alertService;
	
	/**
	 * 로그인한 사용자의 안읽은 알람개수를 세는 handler method
	 * @param memberId
	 * @return
	 */

	@RequestMapping("countAlert.do")
	@ResponseBody
	public String countAlert(){
		if(SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")){ //로그인 안 한 사용자는 myGroup을 없이 전달 
			return "";
		}else{
			List authList = (List)SecurityContextHolder.getContext().getAuthentication().getAuthorities(); //로그인한 사용자 권한정보 리스트
			String au = String.valueOf(authList.get(0)); 

			if(au.equals("ROLE_1")){//로그인한 사용자가 회원
				Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				int cnt = alertService.countUnreadAlert(member.getMemberId());
				return String.valueOf(cnt);				
			}else{//로그인한 사용자가 관리자
				List myGroup = new ArrayList(); //빈 myGroup 전달
				return "";
			}			
		}
	}
	
	/**
	 * 전체 알람리스트 뿌리는 handler method
	 * @return
	 */
	@RequestMapping("showAllalert.do")
	@ResponseBody
	public List<Alert> showAllAlert(){
		if(SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")){ //로그인 안 한 사용자는 myGroup을 없이 전달 
			return null;
		}else{
			Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			List<Alert> allAlert = alertService.selectAllAlert(member.getMemberId());
			return allAlert;
		}

	}
	
	@RequestMapping("updateState.do")
	@ResponseBody
	public String updateState(String alertNo){
		int alertNoInt = Integer.parseInt(alertNo);
		Alert alert = alertService.searchAlertByNo(alertNoInt);
		alert.setState(1); //상태값 읽음으로 변경 
		int cnt = alertService.updateAlertStateByNo(alert);
		return String.valueOf(cnt);
	}
}
