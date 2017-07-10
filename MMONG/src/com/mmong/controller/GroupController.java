package com.mmong.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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
			return new ModelAndView("group/mygroup.tiles");
		}else{
			List authList = (List)SecurityContextHolder.getContext().getAuthentication().getAuthorities(); //로그인한 사용자 권한정보 리스트
			String au = String.valueOf(authList.get(0)); 

			if(au.equals("ROLE_1")){//로그인한 사용자가 회원
				Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				List<GroupMember> gms = groupMemberService.selectMeById(member.getMemberId());
				List<Group> myGroup = new ArrayList();
				for(GroupMember gm : gms){
					myGroup.add(groupService.selectMyGroupByNo(gm.getGroupNo()));
				}
				return new ModelAndView("group/mygroup.tiles", "myGroup", myGroup);				
			}else{//로그인한 사용자가 관리자
				List myGroup = new ArrayList(); //빈 myGroup 전달
				return new ModelAndView("group/mygroup.tiles", "myGroup", myGroup);	
			}		
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
		return new ModelAndView("group/createGroup.tiles");
	}
	
	/**
	 * 모임장이 소모임 생성하는 handler method
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
	@RequestMapping("groupDetail")
	public ModelAndView searchMyGroupDetailById(String groupNo){
		Group selectedGroup = groupService.selectMyGroupByNo(Integer.parseInt(groupNo));		
		return new ModelAndView("group/groupDetail.tiles", "group", selectedGroup);
	}
	
	/**
	 * 소모임 페이지에서 소모임찾기/소모임전체조회 페이지로 이동시키는 handler method
	 * @return 소모임 전체 리스트
	 * 작성자 : 이주현
	 */
	@RequestMapping("searchGroup")
	public ModelAndView selectAllGroup(){
		List<Group> groupList = groupService.selectAllGroup();
		return new ModelAndView("group/searchGroup.tiles", "allGroup", groupList);
	}
	
	/**
	 * 소모임 이름으로 소모임 검색하는 handler method
	 * @param groupName
	 * @return 검색된 소모임 리스트
	 * 작성자 : 이주현
	 */
	@RequestMapping("searchGroupName")
	@ResponseBody
	public List<Group> searchGroupByName(String groupName){
		List<Group> selctedGroupByName = groupService.searchGroupByName(groupName);
		return selctedGroupByName;
	}
}
