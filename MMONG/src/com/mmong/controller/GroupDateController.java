package com.mmong.controller;

import java.util.ArrayList;
import java.util.List;

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
import com.mmong.vo.MeetMember;
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
			return "content/group/groupDate/groupDate_form";
		}
	
		groupDate.setMemberId(memberId); // 로그인한 사람이 일정 등록자
		groupDate.setGroupNo(groupNo); // 세션에서 받은 groupNo 
		
		int groupDateNo=groupDateService.insertGroupDate(groupDate); // 등록한 일정 No
		
		return "redirect:/group/groupDate/groupDateView.do?groupDateNo="+groupDateNo; // 완성되면 일정 상세보기 페이지로 바꾸기
	}
	
	@RequestMapping("groupDateView")
	public String selectGroupDate(int groupDateNo,HttpSession session, ModelMap map){
		/*int groupDateNo=(int) session.getAttribute("groupDateNo");*/
		GroupDate groupDate = groupDateService.selectGroupDate(groupDateNo);
		
		List<Integer> memberNoList=groupDateService.selectMeetMemberList(groupDateNo); // 참여자(memberNo) 목록 가져오기
		List<String> memberIdList=new ArrayList<>();  // id 담을 list
		List<String> nickNameList=new ArrayList<>(); // 닉네임 담을 list
		
		for(int i=0; i<memberNoList.size(); i++){  // 
			int memberNo=memberNoList.get(i);
			String memberId=groupDateService.selectMemberId(memberNo);
			memberIdList.add(memberId);
			String nickName=groupDateService.selectNickname(memberId);
			nickNameList.add(nickName);
		}
		
		map.addAttribute("memberIdList", memberIdList);
		map.addAttribute("nickNameList", nickNameList);
		map.addAttribute("groupDate", groupDate);
		
		return "content/group/groupDate/groupDate_view";
	}
	
	
	@RequestMapping("registerMeet")
	public String insertMeetMemner(HttpSession session){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		
		int groupNo= (int) session.getAttribute("groupNo");
		int groupDateNo=(int) session.getAttribute("groupDateNo");
		
		int memberNo=groupDateService.selectMemberNo(memberId,groupNo);
		
		MeetMember MM = new MeetMember(groupDateNo,memberNo);
		groupDateService.insertMeetMember(MM);
		
		return "group/groupDate/groupDateView.do?groupDateNo="+groupDateNo;
	}
}
