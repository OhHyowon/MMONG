package com.mmong.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
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
import com.mmong.vo.Member;

@Controller
@RequestMapping("/group/")
public class GroupController {
	@Autowired
	private GroupService groupService;
	@Autowired
	private GroupMemberService groupMemberService;
	
	/**
	 * 소모임 대메뉴 여는 handler method
	 * @param userId
	 * @return
	 * 작성자 : 이주현
	 */
	@RequestMapping("mygroup")
	public ModelAndView searchMyGroupById(){
		if(SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")){ //로그인 안 한 사용자는 myGroup을 없이 전달 
			return new ModelAndView("/content/group/mygroup");
		}else{
			Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			List<GroupMember> gms = groupMemberService.selectMeById(member.getMemberId());
			List<Group> myGroup = new ArrayList();
			for(GroupMember gm : gms){
				myGroup.add(groupService.selectMyGroupByNo(gm.getGroupNo()));
			}
			return new ModelAndView("/content/group/mygroup", "myGroup", myGroup);
		}
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
		//로그인된 멤버가 그룹을 생성하는 경우이므로 로그인된 아이디를 리더로 설정 
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		group.setLeader(member.getMemberId());
		//그룹 추가
		groupService.insertGroup(group);		
		//해당 소모임에 소속될 그룹멤버도 추가 
		GroupMember groupMember = new GroupMember(0, group.getNo(), group.getLeader());
		groupMember.setGroup(group);
		groupMember.setMember(member);
		groupMemberService.insertGroupMember(groupMember);		
		return "가입완료";
	}

	/**
	 * 선택된 소모임No로 소모임찾아서, 소모임 상세페이지로 이동시키는 handler method
	 * @param groupNo
	 * @return 소모임 상세페이지
	 * 작성자 : 이주현
	 */
	@RequestMapping("myGroupDetail")
	public ModelAndView searchMyGroupDetailById(String groupNo){
		Group selectedGroup = groupService.selectMyGroupByNo(Integer.parseInt(groupNo));		
		return new ModelAndView("/content/group/myGroupDetail", "group", selectedGroup);
	}
}
