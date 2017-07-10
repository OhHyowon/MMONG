package com.mmong.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.GroupMemberService;
import com.mmong.vo.GroupMember;

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
		int groupNo = Integer.parseInt(session.getAttribute("groupNo").toString());		;
		List<GroupMember> groupMemberList = groupMemberService.searchGroupMemberByGroupNo(groupNo);
		return new ModelAndView("/content/group/groupMember/groupMemberList", "groupMemberList", groupMemberList);
	}
}
