package com.mmong.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.MemberService;
import com.mmong.service.UserService;
import com.mmong.validation.MemberRegisterValidator;
import com.mmong.vo.Member;
import com.mmong.vo.User;

@Controller
@RequestMapping("/member/")
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired 
	private UserService userService;
	
	/**
	 * 회원가입 처리하는 handler method
	 * @param member
	 * @param errors
	 * @return
	 */
	@RequestMapping("registerMember")
	public ModelAndView registerMember(@ModelAttribute Member member, BindingResult errors) {		
		User user = new User(member.getMemberId(), member.getUser().getUserPwd(), "ROLE_1", 1);
			member.setUser(user);
			
		//요청 파라미터 검증
		MemberRegisterValidator validator = new MemberRegisterValidator();
		validator.validate(member, errors);
		if(errors.hasErrors()){
			return new ModelAndView("member/register_form.tiles");
		}
		
		//비즈니스 로직처리 - 회원 추가
		userService.registerUser(user);
		memberService.registerMember(member);
		//System.out.println("컨트롤러1"+user);
		return new ModelAndView("redirect:/member/searchByRegisterId.do", "memberId", user.getUserId());
	}
	
	/**
	 * 회원가입 시 아이디 중복확인하는 handler method
	 * @param memberId
	 * @return
	 */
	@RequestMapping("checkMemberId")
	@ResponseBody
	public String checkMemberId(@RequestParam(required=false) String memberId) {
		//요청 파라미터 검증
		
		//비즈니스 로직 처리 - 회원 조회
		int checkId = memberService.checkMemberId(memberId);
		//응답
		return String.valueOf(checkId);
	}
	
	/**
	 * 회원가입 시 회원 이메일 중복확인하는 handler method
	 * @param memberPhone
	 * @return
	 */
	@RequestMapping("checkMemberEmail")
	@ResponseBody
	public String checkMemberEmail(@RequestParam(required=false) String memberEmail1, String memberEmail2){
		String memberEmail = memberEmail1 +"@"+ memberEmail2;
		//요청파라미터 검증
		
		//비즈니스 로직 처리 - 회원 조회
		int checkEmail = memberService.checkMemberEmail(memberEmail);
		//응답
		return String.valueOf(checkEmail);
	}
	
	/**
	 * 회원가입 성공 페이지로 이동시키는 handler method
	 * @param memberId
	 * @return
	 */
	@RequestMapping("searchByRegisterId")
	public ModelAndView searchByRegisterId(@RequestParam(required=false) String memberId) {
		Member member = memberService.searchMemberById(memberId);
		return new ModelAndView("member/request_success.tiles", "member", member);
	}
	
	/**
	 * 회원 정보 조회 페이지로 이동시키는 handler method
	 * @param memberId
	 * @return
	 */
	@RequestMapping("mypage")
	public ModelAndView searchMemberInfoById(){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Member mem = memberService.searchMemberById(member.getMemberId());
		return new ModelAndView("member/mypage.tiles", "member", mem);
	}
	
	////////////////////////////회원정보 수정, 탈퇴 -이진우///////////////////////////////////////
	
	/** 
	 * mypage.jsp 에서 info_member_update_form.jsp로 이동시키는 handler method
	 * 
	 */
	 @RequestMapping("info_member_update_form")
	 public ModelAndView UpdateMemberForm(@RequestParam String memberId){
		Member member=null;
			member = memberService.searchMemberById(memberId);
			System.out.println(member);
		return new ModelAndView("member/info_member_update_form.tiles", "member", member);
	}
	  
	 /** 
	 * info_member_update_form.jsp에서 정보 수정 데이터를 입력 받아서 다시 mypage.jsp로 이동시키는 handler method
	 * @param member
	 * @return
	 */
	@RequestMapping("info_member_update")
	public ModelAndView updateAdminInfo(@ModelAttribute Member member, BindingResult errors){
		User user = new User(member.getMemberId(),member.getUser().getUserPwd(), member.getUser().getUserAuthority(), 1);
			userService.updateUser(user);
			
/*		//요청 파라미터 검증
		MemberRegisterValidator validator = new MemberRegisterValidator();		// validator 주석 해제하면 에러발생 'memberUser'
		validator.validate(member, errors);
		if(errors.hasErrors()){
			return new ModelAndView("member/register_form.tiles");
		}
	*/	
		//비즈니스 로직처리 - 회원 추가	
		Member newMember = new Member(member.getMemberId(),member.getMemberName(),member.getNickName(),
																	member.getMemberPhone(),member.getMemberEmail(),
																	member.getMemberAddress(),member.getMemberPicture(),user);
			memberService.updateMember(newMember);
			return new ModelAndView("member/mypage.tiles", "member", newMember);
	}
	
	/////////////////////// 삭제 미완성 -- 조인한게 걸림돌 --- 권한을 'ROLE_3'으로 수정  /////////////////
	
	
	
	
	//일반회원(member) 권한 변경하기(탈퇴처리)
	@RequestMapping("change_authority_member")
	public String MemberWithdrawal(@RequestParam String memberId){
			Member mem = null;
			String deleteEmail = UUID.randomUUID().toString().replaceAll("-", "");
			mem = memberService.searchMemberById(memberId);
			if(mem.getUser().getUserAuthority().equals("ROLE_1")){//권한이 'ROLE_1'인 경우 'ROLE_3'(탈퇴상태)로 바꾸기
				userService.changeAuthorityMemberToWithdrawal(memberId);
				Member deleteMem = new Member(mem.getMemberId(),"이름삭제","닉넴삭제","번호삭제", deleteEmail,"주소삭제","사진삭제");
				memberService.updateMember(deleteMem);
			}
			SecurityContextHolder.getContext().setAuthentication(null); // security에서 담당하는 session을 null으로 세팅하는 작업.   SecurityContextHolder는 system꺼라서 'new'하고 생성하지 않음.  
			return "member/byebye_greeting.tiles";
		}
	 
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
}














