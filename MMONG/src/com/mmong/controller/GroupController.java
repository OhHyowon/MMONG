package com.mmong.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.GroupMemberService;
import com.mmong.service.GroupService;
import com.mmong.vo.Group;
import com.mmong.vo.GroupMember;

@Controller
@RequestMapping("/group/")
public class GroupController {
	@Autowired
	private GroupService groupService;
	@Autowired
	private GroupMemberService groupMemberService;
	
	/**
	 * 소모임 대메뉴 여는 handler method - 처음 화면은 '나의 소모임' 소메뉴 열림
	 * @param userId
	 * @return
	 * 작성자 : 이주현
	 */
	@RequestMapping("mygroup")
	public ModelAndView searchMyGroupById(@RequestParam(required=false) String userId){
		///내가 소속된 소모임 뿌리는 로직 추가 필요
		return new ModelAndView("/content/group/mygroup");
	}
	
	/**
	 * 소모임 등록 팝업페이지 여는 handler method
	 * @param 
	 * @return
	 * 작성자 : 이주현
	 */
	@RequestMapping("createGroup")
	public ModelAndView openCreateGroupWindow(){
		return new ModelAndView("/content/group/createGroup");
	}
	
	/**
	 * 모임장이 소모임 추가하는 handler method
	 * @param group
	 * @return
	 * 작성자 : 이주현
	 */
	@RequestMapping(value="insertGroup", produces="text/html;charset=utf-8")
	@ResponseBody
	public String insertGroup(@ModelAttribute Group group){
		System.out.println(group);
		groupService.insertGroup(group);
		
		//해당 소모임에 소속될 그룹멤버도 추가 
		GroupMember groupMember = new GroupMember(0, group.getNo(), group.getLeader());
		System.out.println(groupMember);
		groupMemberService.insertGroupMember(groupMember);
		
		return "가입완료";
	}
}
