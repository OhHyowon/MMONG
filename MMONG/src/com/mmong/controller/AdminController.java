package com.mmong.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.AdministratorService;
import com.mmong.service.MemberService;
import com.mmong.service.UserService;
import com.mmong.validation.AdministratorRegisterValidator;
import com.mmong.vo.Administrator;
import com.mmong.vo.Member;
import com.mmong.vo.User;


@Controller
@RequestMapping("/admin/")   //Handler(Controller)
public class AdminController {

	@Autowired
	private AdministratorService adminService;
	@Autowired
	private UserService userService;
	@Autowired	MemberService memberService;
	
	
	
	
	
	
	
	
	//info_member.jsp(회원 정보)로 가기 위한 컨트롤러
	@RequestMapping("searchMemberById")
	public ModelAndView HospitalInfo(@RequestParam String memberId){
		Member member = null;
			member = memberService.searchMemberById(memberId);
		return new ModelAndView("admin/info_member.tiles","member", member);
	}
	
	//일반회원(member) 권한 변경하기
	@RequestMapping("changeAuthorityMember")
	public ModelAndView changeAuthorityMember(String memberId) {
		Member mem = null;
																											System.out.println("점검---1 -> "+memberId);
		mem = memberService.searchMemberById(memberId);
																											System.out.println("점검---2 -> "+mem);
		
		if(mem.getUser().getUserAuthority().equals("ROLE_1")){//권한이 'ROLE_1'인 경우, 활동 정지 시킬때
																											System.out.println("점검---3 -> "+mem.getUser().getUserAuthority());
			userService.changeAuthorityMemberToStop(mem.getMemberId());
																											System.out.println("점검---4 -> "+mem.getUser().getUserAuthority());
			
		}else{//권한이 'ROLE_2'인 경우, 활동 재개 시킬때
																											System.out.println("점검---5 -> "+mem.getUser().getUserAuthority());
			userService.changeAuthorityMemberToRun(mem.getMemberId());
																											System.out.println("점검---6 -> "+mem.getUser().getUserAuthority());
		}
		
																											System.out.println("점검---7 -> "+mem);
																											System.out.println("점검---8 -> "+mem.getUser().getUserAuthority());
		
		String memId=mem.getMemberId();
																											System.out.println("점검---9 -> "+memId);
		return new ModelAndView("redirect:/admin/searchMemberById.do","memberId", memId);
	}
	

	
/////////////// 이하 완료////////////////
	
	//register_form.jsp (관리자 등록 폼)에서 register_success.jsp(관리자 등록 성공)으로 이동하기 위한 컨트롤러
	//관리자 등록 처리
	@RequestMapping("register_success")
	public ModelAndView RegisterAdminSuccess(@ModelAttribute Administrator admin, BindingResult errors){
		User user = new User(admin.getAdminId(), admin.getUser().getUserPwd(), "ROLE_0", 1);
		admin.setUser(user);
		//1. 요청파라미터 검증
		AdministratorRegisterValidator validator = new AdministratorRegisterValidator();
		validator.validate(admin, errors);
		if(errors.hasErrors()){
			return  new ModelAndView("admin/register_form.tiles");
		}
		
		//2.관리자 등록처리
		userService.registerUser(user);
		//Administrator의 vo에 user 속성 추가하는 작업
		adminService.insertAdministrator(admin);
		
		//3. 응답
		// 리다이렉트로 보내고 싶을때는 컨틀롤러로 바로 보낼수 없다.
		// 		-> 다시한번 컨트롤러를 불러서 이동한다.
		return new ModelAndView("redirect:/admin/gotoRegisterSuccess.do", "adminId", admin.getAdminId());
	}
		
	//register_form.jsp에서 register_success.jsp로 가기위한 컨트롤러
	@RequestMapping("gotoRegisterSuccess")
	public ModelAndView gotoRegisterSuccess(@RequestParam String adminId){
		Administrator admin = null;
			admin = adminService.searchAdministratorById(adminId);
		return new  ModelAndView("admin/register_success.tiles","administrator", admin);
	}
	
	//info_admin.jsp(관리자 정보)로 가기 위한 컨트롤러
	@RequestMapping("searchAdmindById")
	public ModelAndView AdminInfo(@RequestParam String adminId){
		Administrator admin = null;
			admin = adminService.searchAdministratorById(adminId);
		return new ModelAndView("admin/info_admin.tiles","administrator", admin);
	}
	
	//(info_admin.jsp)에서 정보 수정하기(info_admin_update_form.jsp)로 이동하기 위한 컨트롤러
	@RequestMapping("info_admin_update_form")
	public ModelAndView UpdateAdminForm(@RequestParam String adminId){
		
		Administrator admin=null;
			admin = adminService.searchAdministratorById(adminId);
		return new ModelAndView("admin/info_admin_update_form.tiles", "administrator", admin);
	}
	
	//(info_admin_update_form.jsp)에서 (info_admin.jsp)로 이동하기 위한 컨트롤러
	@RequestMapping("info_admin")
	public ModelAndView updateAdminInfo(@ModelAttribute Administrator admin){
		User user = new User(admin.getAdminId(),admin.getUser().getUserPwd(), admin.getUser().getUserAuthority(), 1);
			userService.updateUser(user);
		Administrator newAdmin = new Administrator(admin.getAdminName(),admin.getAdminPhone(), admin.getAdminEmail(),admin.getAdminId(),user);
			adminService.updateAdministrator(newAdmin);
		return new ModelAndView("admin/info_admin.tiles", "administrator", newAdmin);
	}
	
	//(info_admin.jsp)에서 관리자 enable 0으로 바꾸고 다시 (info_admin.jsp)로 이동하기 위한 컨트롤러
	@RequestMapping("changeEnable")
	public ModelAndView changeAdminEnableToZero(@RequestParam String adminId){
		
		Administrator OutAdmin=null;
		OutAdmin = adminService.searchAdministratorById(adminId);
			userService.changeAdminEnableToZero(OutAdmin.getAdminId());
			
		return new ModelAndView("redirect:/admin/searchAdmindById.do", "adminId", OutAdmin.getAdminId());
	}
	
	
	
	
	
}





















