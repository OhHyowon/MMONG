package com.mmong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.GroupMemberService;
import com.mmong.service.GroupService;
import com.mmong.service.MemberService;
import com.mmong.service.impl.GroupDateServiceImpl;
import com.mmong.vo.GroupMember;
import com.mmong.vo.Member;

@Controller
@RequestMapping("/groupMember/")
@SessionAttributes("groupNo")
public class GroupMemberController {
	@Autowired
	private GroupMemberService groupMemberService;
	@Autowired
	private GroupService groupService;
	@Autowired
	private GroupDateServiceImpl groupDateService;
	@Autowired
	private MemberService memberService;
	
	/**
	 * 소모임에 소속된 모임멤버 추가시키는 handler method
	 * @param groupMember
	 * @return
	 * 작성자 : 이주현
	 */
	@RequestMapping("insertGroupMember")
	@ResponseBody
	public String insertGroup(@ModelAttribute GroupMember groupMember){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		int groupNo=groupMember.getGroupNo();
		String memberId=member.getMemberId();
		
		int count=groupMemberService.selectCountNoByIdAndNo(groupNo,memberId);
		
		if(count==1){
			return "2"; // 가입된 소모임에 본인이 count 되는것(중복)
		}else{
		groupMemberService.insertGroupMember(groupMember);
			return "1";
		}
	}
	
	/**
	 * 소모임No로 소모임에 소속된 멤버 조회하는 handler method
	 * @param session
	 * @return 참여목록 페이지 + 그룹멤버들
	 * 작성자 : 이주현
	 */
	@RequestMapping("searchGroupMember")
	public ModelAndView searchGroupMemberByGroupNo(HttpSession session){
		int groupNo = Integer.parseInt(session.getAttribute("groupNo").toString());
		List<GroupMember> groupMemberList = groupMemberService.searchGroupMemberByGroupNo(groupNo); //해당그룹의 모임멤버리스트
		
		List authList = (List)SecurityContextHolder.getContext().getAuthentication().getAuthorities(); //로그인한 사용자 권한정보 리스트
		String au = String.valueOf(authList.get(0)); 

		if(au.equals("ROLE_1")){//로그인한 사용자가 회원
			Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //로그인한 사용자의 회원객체
			for(GroupMember gm : groupMemberList){
				if(gm.getMemberId().equals(member.getMemberId())){//모임멤버리스트에 로그인한 사용자가 있으면 멤버리스트 넘기고		
					
					String leader=groupService.selectMyGroupByNo(groupNo).getLeader();
					
					ModelAndView mv = new ModelAndView();
					mv.setViewName("group/groupMember/groupMemberList.tiles");
					mv.addObject("groupMemberList",groupMemberList);
					mv.addObject("leader",leader);
					
					return mv;
				}
			}
			return new ModelAndView("group/groupMember/groupMemberList.tiles", "groupMemberList", null); //아니면 빈 리스트 넘김
		}else{//로그인한 사용자가 관리자
			return new ModelAndView("group/groupMember/groupMemberList.tiles", "groupMemberList", groupMemberList);
		}
	}
	/**
	 * 그룹장 변경하기 위해 리스트 뿌려주는 handler method
	 * @param session
	 * @param map
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("searchGroupMember2")
	public String  searchGroupMemberForPopUp(HttpSession session,ModelMap map){
		int groupNo = Integer.parseInt(session.getAttribute("groupNo").toString());
		List<GroupMember> groupMemberList = groupMemberService.searchGroupMemberByGroupNo(groupNo); 
		
		
		map.put("groupMemberList", groupMemberList);
	
		return "/WEB-INF/view/content/group/groupMember/groupLeaderChange.jsp";
	}
	/**
	 * 그룹장 변경 해주는 handler method
	 * @param session
	 * @param newLeader
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("LeaderChange")
	@ResponseBody
	public String LeaderChange(HttpSession session, String newLeader){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int groupNo = Integer.parseInt(session.getAttribute("groupNo").toString());
		String memberId= member.getMemberId();
				
		if(memberId.equals(newLeader)){
			return "2";  // 모임장과 새로운 리더의 아이디가 같을 때
		}
		groupService.updateLeader(groupNo,newLeader);
		return "1";
	}
	/**
	 * 모임 탈퇴시 일정 참가목록에서 제외 + 모임 탈퇴
	 * @param session
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("leaveGroup")
	@ResponseBody
	public String leaveGroupMember(HttpSession session){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int groupNo = Integer.parseInt(session.getAttribute("groupNo").toString());
		String memberId= member.getMemberId();
		
		int groupMemberNo=groupDateService.selectMemberNo(memberId, groupNo);
		groupDateService.deleteMeetMemberByGroupMemberNo(groupMemberNo);
		groupMemberService.deleteGroupMember(groupNo,memberId);
		
		return "1";
	}
	
	@RequestMapping("searchAllMember")
	@ResponseBody
	public List<Member> searchGroupMember(@RequestParam String memberId){
		System.out.println(memberId);
		List<Member> members = memberService.searchManyMemberById(memberId);
		System.out.println(members);
		return members;
	}
}
