package com.mmong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.GroupMemberService;
import com.mmong.vo.GroupMember;
import com.mmong.vo.Member;

@Controller
@RequestMapping("/groupMember/")
@SessionAttributes("groupNo")
public class GroupMemberController {
	@Autowired
	private GroupMemberService groupMemberService;
	
	/**
	 * 소모임에 소속된 모임멤버 추가시키는 handler method
	 * @param groupMember
	 * @return
	 * 작성자 : 이주현
	 */
	@RequestMapping("insertGroupMember")
	@ResponseBody
	public String insertGroup(@ModelAttribute GroupMember groupMember){
		groupMemberService.insertGroupMember(groupMember);
		return "가입완료";
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
					return new ModelAndView("/content/group/groupMember/groupMemberList", "groupMemberList", groupMemberList);
				}
			}
			return new ModelAndView("/content/group/groupMember/groupMemberList", "groupMemberList", null); //아니면 빈 리스트 넘김
		}else{//로그인한 사용자가 관리자
			return new ModelAndView("/content/group/groupMember/groupMemberList", "groupMemberList", groupMemberList);
		}
		
	}
}
