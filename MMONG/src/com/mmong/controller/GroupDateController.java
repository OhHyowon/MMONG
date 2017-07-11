package com.mmong.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@ResponseBody
	public String insertMeetMember(HttpSession session){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		
		int groupNo= (int) session.getAttribute("groupNo");
		int groupDateNo=(int) session.getAttribute("groupDateNo");
		
		int memberNo=groupDateService.selectMemberNo(memberId,groupNo);
		
		MeetMember MM = new MeetMember(groupDateNo,memberNo);
		groupDateService.insertMeetMember(MM);
		
		return "1";
	}
	
	@RequestMapping("cancelMeet")
	@ResponseBody
	public String deleteMeetmember(HttpSession session){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		int groupDateNo=(int) session.getAttribute("groupDateNo");
		int groupNo= (int) session.getAttribute("groupNo");

		int memberNo=groupDateService.selectMemberNo(memberId,groupNo);
		
		MeetMember MM = new MeetMember(groupDateNo, memberNo);
		groupDateService.deleteMeetmember(MM);
		
		return "1";
	}
	
	@RequestMapping("allGroupDateList")
	public String allGroupDateList(@RequestParam(value="page", defaultValue="1")int page, 
													@RequestParam (value="option", defaultValue="1")String option, 
													@RequestParam  (value="key", defaultValue="1")String key,
													HttpSession session, ModelMap map){
		
		
		
		HashMap<String,Object> pagingMap=null;

		int groupNo=(int) session.getAttribute("groupNo");
		
		if(option.equals("1")){
			pagingMap=groupDateService.selectAllGroupDateList(page,groupNo);
		}else if(option.equals("dateTime")){
			try {
				Date dateTime = new SimpleDateFormat("yyyy-MM-dd").parse(key);
				pagingMap=groupDateService.selectGroupDateOption2(page,groupNo,dateTime,option);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else{
			pagingMap=groupDateService.selectGroupDateOption(page,groupNo,key,option);
		}
		
		
	/*	if(option.equals("1")){
			pagingMap=groupDateService.selectAllGroupDateList(page,groupNo);
		}else{
			pagingMap=groupDateService.selectGroupDateOption(page,groupNo,option,key);
		}*/
		
		map.addAttribute("groupNo", groupNo);
		map.addAttribute("groupDateList", pagingMap.get("groupDateList"));
		map.addAttribute("pageBean", pagingMap.get("pageBean"));
		
		return "content/group/groupDate/groupDate_list";
	}
	
	/* update - 1 일정 그대로 받아오기*/
	@RequestMapping("updateGroupDate1")
	public String updateGroupDate1(@RequestParam int groupDateNo,ModelMap map){
		
		System.out.println("수정1"+groupDateNo);
		
		GroupDate groupDate=groupDateService.selectGroupDate(groupDateNo);
		map.addAttribute("groupDate", groupDate);
		
		return "content/group/groupDate/groupDate_update";
	}
	
	/* update - 2 수정 된 일정 DB에 넣기*/
	@RequestMapping("updateGroupDate2")
	public String updateGroupDate2(@ModelAttribute GroupDate groupDate, BindingResult errors ){
		
		System.out.println("수정2 "+groupDate);
		
		GroupDateValidator vaildator=new GroupDateValidator();
		vaildator.validate(groupDate, errors);
		if(errors.hasErrors()){
			return "content/group/groupDate/groupDate_update";
		}
		
		groupDateService.upDateGroupDate(groupDate); // DB에 수정된 일정 넣기
		
		return "/content/group/groupDate/groupDate_view";
	}
	
	@RequestMapping("groupDateDelete")
	@ResponseBody
	public String groupDateDelete(HttpSession session){
		int groupDateNo=(int) session.getAttribute("groupDateNo");
		
		groupDateService.deleteGroupDate(groupDateNo);
		
		return "1";
	}
}
