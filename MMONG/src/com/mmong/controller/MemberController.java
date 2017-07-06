package com.mmong.controller;

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
		User user = new User(member.getMemberId(), member.getMemberUser().getUserPwd(), "ROLE_1", 1);
		member.setMemberUser(user);
		
		//요청 파라미터 검증
		MemberRegisterValidator validator = new MemberRegisterValidator();
		validator.validate(member, errors);
		if(errors.hasErrors()){
			return new ModelAndView("content/member/register_form");
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
	 * 회원가입 시 회원 핸드폰번호 중복확인하는 handler method
	 * @param memberPhone
	 * @return
	 */
	@RequestMapping("checkMemberPhone")
	@ResponseBody
	public String checkMemberPhone(@RequestParam(required=false) String memberPhone){
		//요청파라미터 검증
		
		//비즈니스 로직 처리 - 회원 조회
		int checkPhone = memberService.checkMemberPhone(memberPhone);
		//응답
		return String.valueOf(checkPhone);
	}
	
	/**
	 * 회원가입 성공 페이지로 이동시키는 handler method
	 * @param memberId
	 * @return
	 */
	@RequestMapping("searchByRegisterId")
	public ModelAndView searchByRegisterId(@RequestParam(required=false) String memberId) {
		Member member = memberService.searchMemberById(memberId);
		return new ModelAndView("content/member/request_success", "member", member);
	}
	
	/**
	 * 회원 정보 조회 페이지로 이동시키는 handler method
	 * @param memberId
	 * @return
	 */
	@RequestMapping("mypage")
	public ModelAndView searchMemberInfoById(){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return new ModelAndView("content/member/mypage", "member", member);
	}
	
}
