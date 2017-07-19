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

import com.mmong.service.AlertService;
import com.mmong.service.CalendarService;
import com.mmong.service.GroupDateService;
import com.mmong.service.GroupMemberService;
import com.mmong.validation.GroupDateValidator;
import com.mmong.vo.Alert;
import com.mmong.vo.Calendar;
import com.mmong.vo.GroupDate;
import com.mmong.vo.GroupMember;
import com.mmong.vo.MeetMember;
import com.mmong.vo.Member;

@Controller
@RequestMapping("group/groupDate/")
public class GroupDateController{
	@Autowired
	private GroupDateService groupDateService;
	@Autowired
	private GroupMemberService groupMemberService;	
	
	@Autowired
	private CalendarService calendarService;
	@Autowired
	private AlertService alertService;
	
	/***
	 * 일정 등록하는 handler method
	 * @param groupDate
	 * @param errors
	 * @param session
	 * @param map
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("register")
	public String groupDateInsert(@ModelAttribute GroupDate groupDate, BindingResult errors,
													HttpSession session,ModelMap map){
		
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
	
		int groupNo=(int) session.getAttribute("groupNo"); // session에 있는 groupNo 가져옴
		
		GroupDateValidator vaildator=new GroupDateValidator();
		vaildator.validate(groupDate, errors);
		if(errors.hasErrors()){
			return "group/groupDate/groupDate_form.tiles";
		}
	
		groupDate.setMemberId(memberId); // 로그인한 사람이 일정 등록자
		groupDate.setGroupNo(groupNo); // 세션에서 받은 groupNo 
		
		int memberNo=groupDateService.selectMemberNo(memberId,groupNo);
		int groupDateNo=groupDateService.insertGroupDate(groupDate); // 등록한 일정 No
		groupDateService.insertMeetMember(new MeetMember(groupDateNo, memberNo)); //일정 만든 사람이 최초 일정 참여자
		
		//*** 달력에 자동 입력
		Calendar calendar = new Calendar(0, groupDate.getTitle(), groupDate.getPlace(), 2, groupDate.getGroupDate(), groupDate.getGroupDate(), 0, "", groupDateNo, memberId);
		calendarService.insertSchedule(calendar);
		
		return "redirect:/group/groupDate/allGroupDateList.do"; // 일정 등록되면 일정 목록 페이지로 바뀜
	}

	/***
	 * 하나의 일정 상세보기 handler method
	 * @param groupDateNo
	 * @param session
	 * @param map
	 * @return
	 * 작성자 : 강여림
	 */
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
		
		return "/WEB-INF/view/content/group/groupDate/groupDate_view.jsp";
	}
	
	/***
	 * 일정에 참여하는 멤버 등록하는 handler method
	 * @param session
	 * @return
	 * 작성자 : 강여림
	 */
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
		
		//*** 달력에 자동 입력
		GroupDate groupDateInfo = groupDateService.selectGroupDate(groupDateNo);
		Calendar calendar = new Calendar(0, groupDateInfo.getTitle(), groupDateInfo.getPlace(), 2, groupDateInfo.getGroupDate(), groupDateInfo.getGroupDate(), 0, "", groupDateNo, memberId);
		calendarService.insertSchedule(calendar);
		
		return "1";
	}
	/**
	 *	일정 참여 취소하는 handler method
	 * @param session
	 * @return
	 * 작성자 : 강여림
	 */
	
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
		
		//*** 달력에서 삭제
		calendarService.deleteGroupDate(groupDateNo, memberId);
		
		return "1";
	}
	/**
	 * 모든 일정 목록 보는handler method
	 * @param page
	 * @param option
	 * @param key
	 * @param session
	 * @param map
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("allGroupDateList")
	public String allGroupDateList(@RequestParam(value="page", defaultValue="1")int page,
													HttpSession session, ModelMap map){

		HashMap<String,Object> pagingMap=null;
		int groupNo=(int) session.getAttribute("groupNo");
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		// groupMember에 groupNo으로 조회했을 때 memberId가 본인이 있으면 1, 없으면 0
		int check=0;
		List<GroupMember> groupMemerList=groupMemberService.searchGroupMemberByGroupNo(groupNo);
		for(int i =0; i<groupMemerList.size();i++){
			String groupMemberId=groupMemerList.get(i).getMemberId();
			if(groupMemberId.equals(memberId)){
				check=1;
			}
		}
		pagingMap=groupDateService.selectAllGroupDateList(page,groupNo);
		map.addAttribute("check", check);
		map.addAttribute("groupNo", groupNo);
		map.addAttribute("groupDateList", pagingMap.get("groupDateList"));
		map.addAttribute("pageBean", pagingMap.get("pageBean"));

		
		return "group/groupDate/groupDate_list.tiles";
	}
	/**
	 * 검색했을 때의 일정 목록 보는 handler method
	 * @param page
	 * @param option
	 * @param key
	 * @param map
	 * @param session
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("allGroupDateListByKey")
	public String allGroupDateListByKey(@RequestParam(value="page", defaultValue="1")int page, 
															@RequestParam String option, 
															@RequestParam  (value="key", defaultValue="1")String key,
															ModelMap map,HttpSession session){
		
		HashMap<String,Object> pagingMap=null;
		int groupNo=(int) session.getAttribute("groupNo");
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		
		// groupMember에 groupNo으로 조회했을 때 memberId가 본인이 있으면 1, 없으면 0
		int check=0;
		List<GroupMember> groupMemerList=groupMemberService.searchGroupMemberByGroupNo(groupNo);
		for(int i =0; i<groupMemerList.size();i++){
			String groupMemberId=groupMemerList.get(i).getMemberId();
			if(groupMemberId.equals(memberId)){
				check=1;
			}
		}
		
		if(option.equals("dateTime")){
			Date dateTime;
			try {
				dateTime = new SimpleDateFormat("yyyy-MM-dd").parse(key);
				pagingMap=groupDateService.selectGroupDateOption2(page,groupNo,dateTime,option);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
			pagingMap=groupDateService.selectGroupDateOption(page,groupNo,option,key);
		}
		
		map.addAttribute("option", option);
		map.addAttribute("key", key);
		map.addAttribute("check", check);
		map.addAttribute("groupNo", groupNo);
		map.addAttribute("groupDateList", pagingMap.get("groupDateList"));
		map.addAttribute("pageBean", pagingMap.get("pageBean"));
	
		return "group/groupDate/groupDate_list_byKey.tiles";
	}
	
	/**
	 * 입력된 일정 그대로 받아오는 handler method
	 * @param groupDateNo
	 * @param map
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("updateGroupDate1")
	public String updateGroupDate1(@RequestParam int groupDateNo,ModelMap map){
				
		GroupDate groupDate=groupDateService.selectGroupDate(groupDateNo);
		map.addAttribute("groupDate", groupDate);
		map.addAttribute("groupDateNo", groupDateNo);
		
		return "/WEB-INF/view/content/group/groupDate/groupDate_update.jsp";
	}
	
	/**
	 * 수정된 일정 DB에 넣는 handler method
	 * @param groupDate
	 * @param errors
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("updateGroupDate2")
	public String updateGroupDate2(@RequestParam int groupDateNo,@ModelAttribute GroupDate groupDate, BindingResult errors, ModelMap map){
				
		GroupDateValidator vaildator=new GroupDateValidator();
		vaildator.validate(groupDate, errors);
		if(errors.hasErrors()){
			return "/WEB-INF/view/content/group/groupDate/groupDate_update.jsp";
		}
		
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
		
		
		GroupDate groupDate1=groupDateService.selectGroupDate(groupDateNo);
		
		groupDate1.setGroupDate(groupDate.getGroupDate());
		groupDate1.setPlace(groupDate.getPlace());
		groupDate1.setTitle(groupDate.getTitle());
		
		groupDateService.upDateGroupDate(groupDate1); // DB에 수정된 일정 넣기
		
		map.addAttribute("memberIdList", memberIdList);
		map.addAttribute("nickNameList", nickNameList);
		return "/group/groupDate/groupDateView.do?groupDateNo="+groupDateNo;
	}
	/**
	 * 일정 삭제하는 handler
	 * @param session
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("groupDateDelete")
	@ResponseBody
	public String groupDateDelete(HttpSession session){
		int groupDateNo=(int) session.getAttribute("groupDateNo");
		
		//일정 삭제 시 그 일정에 참가 신청했던 모든 회원들에게 알람 메시지 보내기 --이주현
		List meetMemberNos = groupDateService.selectMeetMemberList(groupDateNo);
		GroupMember groupMember; //모임에 참여하는 그룹멤버들 담을 변수 
		GroupDate groupDate = groupDateService.selectGroupDate(groupDateNo); //삭제될 모임일정 정보 가져옴	
		for(int i=0; i<meetMemberNos.size(); i++){
			groupMember = groupMemberService.selectGroupMemberByNo((int)meetMemberNos.get(i)); //meetMember의 no로 GroupMember를 찾음 
			alertService.insertAlert(new Alert(0, "모임 [ "+groupDate.getTitle()+" ] 이 취소되었습니다.", 0, 3, groupDate.getGroupNo(), groupMember.getMemberId()));
		}
		
		groupDateService.deleteMeetMemberByGroupDateNo(groupDateNo);
		groupDateService.deleteGroupDate(groupDateNo);

		//*** 일정 삭제시 그 일정에 참가신청했던 모든 회원들의 일정들을 calendar DB에서 삭제
		calendarService.deleteFromGroup(groupDateNo);
		
		return "1";
	}
}
