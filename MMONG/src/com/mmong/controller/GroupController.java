package com.mmong.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.BoardPictureService;
import com.mmong.service.BoardService;
import com.mmong.service.GroupDateService;
import com.mmong.service.GroupMemberService;
import com.mmong.service.GroupService;
import com.mmong.service.ReplyService;
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
	@Autowired
	private ReplyService replyService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private BoardPictureService BPService;
	@Autowired
	private GroupDateService groupDateService;
	
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
		return new ModelAndView("/WEB-INF/view/content/group/createGroup.jsp");
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
	public ModelAndView searchGroupByName(String groupName){
		List<Group> groupList = groupService.searchGroupByName(groupName); //이름으로 검색된 그룹들
		return new ModelAndView("group/searchGroup.tiles", "allGroup", groupList);
	}
	
	
	
	/**
	 * 소모임 번호로 소모임 삭제하는 handler method
	 * @param session
	 * @return
	 *  작성자 : 강여림
	 */
	@RequestMapping("deleteGroup")
	@ResponseBody
	public String deleteGroup(HttpSession session){
		int groupNo=(int) session.getAttribute("groupNo");		
		int count=groupMemberService.selectMemberIdCount(groupNo);
		
		if(count==1){
			replyService.deleteReplyByGroupNo(groupNo); // 리플 삭제
			List<Integer> boardNolist = boardService.selectBoardNoByGroupNo(groupNo); 
			for(int i =0; i<boardNolist.size(); i++){
				int boardNo=boardNolist.get(i);
				BPService.deleteBPByBoardNo(boardNo); // 게시판에 올렸던 사진들 삭제
			}
			boardService.deleteBoardByGroupNo(groupNo); // 게시판 삭제
			
			List<Integer> groupDateNoList=groupDateService.selectNoByGroupNo(groupNo); 
			for(int i=0; i<groupDateNoList.size(); i++){ 
				int groupDateNo=groupDateNoList.get(i); // 소모임에 등록된 일정번호 조회
				groupDateService.deleteMeetMemberByGroupDateNo(groupDateNo); // 일정 참여 멤버 삭제
			}
			groupDateService.deleteGroupDateByGroupNo(groupNo); // 일정 삭제
			groupService.deleteGroup(groupNo); // 소모임 삭제
			return "1"; // 삭제완료
		}else{
		return "2"; // 삭제불가
		}
	}
	/**
	 * 소모임 정보 그대로 가져오기
	 * @param session
	 * @param map
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("updateGroup1")
	public String updateGroup1(HttpSession session,ModelMap map){
		int groupNo=(int) session.getAttribute("groupNo");	
		Group group=groupService.selectMyGroupByNo(groupNo);
		
		map.put("group", group);
		return "/WEB-INF/view/content/group/updateGroup.jsp";
	}
	/**
	 * 가져온 소모임 정보 DB에 수정하기
	 * @param group
	 * @param errors
	 * @param session
	 * @return
	 * 작성자 : 강여림
	 */
	@RequestMapping("updateGroup2")
	@ResponseBody
	public String updateGroup2(@ModelAttribute Group group,
												HttpSession session){

		int groupNo=(int) session.getAttribute("groupNo");	
		Group group2=groupService.selectMyGroupByNo(groupNo);
		
		group2.setName(group.getName());
		group2.setContent(group.getContent());

		groupService.updateGroup(group2);
		
		return "1";
	}
}
