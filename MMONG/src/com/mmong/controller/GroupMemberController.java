package com.mmong.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mmong.service.GroupMemberService;
import com.mmong.vo.GroupMember;

@Controller
@RequestMapping("/groupMember/")
public class GroupMemberController {
	@Autowired
	private GroupMemberService groupMemberService;
	
	/**
	 * 소모임에 소속된 모임멤버 추가시키는 handler method
	 * @param groupMember
	 * @return
	 */
	@RequestMapping("insertGroupMember")
	@ResponseBody
	public String insertGroup(@ModelAttribute GroupMember groupMember){
		groupMemberService.insertGroupMember(groupMember);
		return "가입완료";
	}
}
