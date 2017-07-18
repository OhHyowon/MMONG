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

import com.mmong.service.AdministratorService;
import com.mmong.service.MemberService;
import com.mmong.service.UserService;
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
	@Autowired	
	private MemberService memberService;
	
	
	


/////////////// 이하 완료////////////////
	
	//info_member.jsp(회원 정보)로 가기 위한 컨트롤러
	@RequestMapping("searchMemberById")
	public ModelAndView searchMemberById(@RequestParam String memberId){
		Member member = null;
			member = memberService.searchMemberById(memberId);
			if(member==null){
				return new ModelAndView("redirect:/admin/nullmemberId.do", "memberId", memberId);
			}
		return new ModelAndView("admin/info_member.tiles","member", member);
	}
	
	//searchMemberById 한 id가 없을 경우(null) 없다고 search_member_form.jsp로 이동시켜 알려주는 컨트롤러
	@RequestMapping("nullmemberId")
	public ModelAndView nullMemberId(@RequestParam String memberId){
		return new ModelAndView("admin/search_member_null.tiles","memberId",memberId);
	}
	
	
	
	//일반회원(member) 권한 변경하기
	@RequestMapping("changeMemberAuthority")
	public ModelAndView changeMemberAuthority(String memberId) {
		Member mem = null;
		mem = memberService.searchMemberById(memberId);
		
		if(mem.getUser().getUserAuthority().equals("ROLE_1")){//권한이 'ROLE_1'인 경우, 활동 정지 시킬때
			userService.changeUserAuthorityToStop(mem.getMemberId());
		}else{//권한이 'ROLE_2'인 경우, 활동 재개 시킬때
			userService.changeMemberAuthorityToRun(mem.getMemberId());
		}
		
		String memId=mem.getMemberId();
		return new ModelAndView("redirect:/admin/searchMemberById.do","memberId", memId);
	}

	//(info_admin.jsp)에서 관리자 권한 변경하고 다시 (info_admin.jsp)로 이동하기 위한 컨트롤러
	@RequestMapping("changeAdminAuthority")
	public ModelAndView changeAdminAuthority(@RequestParam String adminId){
		Administrator stopAdmin=null;
		stopAdmin = adminService.searchAdministratorById(adminId);
		
		if(stopAdmin.getUser().getUserAuthority().equals("ROLE_0")){//권한이 'ROLE_0'인 경우, 활동 정지 시킬때
			userService.changeUserAuthorityToStop(stopAdmin.getAdminId());
		}else{//권한이 'ROLE_2'인 경우, 관리자활동 재개 시킬때
			userService.changeAdminAuthorityToRun(stopAdmin.getAdminId());
		}
			
		String changeAdminId = stopAdmin.getAdminId();
		return new ModelAndView("redirect:/admin/searchAdmindById.do", "adminId", changeAdminId);
	}
	
	//register_form.jsp (관리자 등록 폼)에서 register_success.jsp(관리자 등록 성공)으로 이동하기 위한 컨트롤러
	//관리자 등록 처리
	@RequestMapping("register_success")
	public ModelAndView RegisterAdminSuccess(@ModelAttribute Administrator admin, BindingResult errors){
		User user = new User(admin.getAdminId(), admin.getUser().getUserPwd(), "ROLE_0", 1);
			admin.setUser(user);
			
		//1. 요청파라미터 검증
//		AdministratorRegisterValidator validator = new AdministratorRegisterValidator();
//		validator.validate(admin, errors);
//		if(errors.hasErrors()){
//			return  new ModelAndView("admin/register_form.tiles");
//		}
		//2.관리자 등록처리
		userService.registerUser(user);
		//Administrator의 vo에 user 속성 추가하는 작업
		adminService.insertAdministrator(admin);
		//3. 응답
		// 리다이렉트로 보내고 싶을때는 컨틀롤러로 바로 보낼수 없다.
		// 		-> 다시한번 컨트롤러를 불러서 이동한다.
		return new ModelAndView("redirect:/admin/gotoRegisterSuccess.do", "adminId", admin.getAdminId());
	}
		
	/**
	 * 관리자 등록시 아이디 중복확인하는 handler method
	 * @param adminId
	 * @return
	 */
	@RequestMapping("checkAdminId")
	@ResponseBody
	public String checkAdminId(@RequestParam(required=false) String adminId){
		//요청 파라미터 검증
		
		//비즈니스 로직 처리 - 회원 조회
		int checkId =userService.checkUserId(adminId);
		//응답
		System.out.println(checkId);
		return String.valueOf(checkId);
	}
	
	/**
	 * 관리자등록시 회원 핸드폰번호 중복확인하는 handler method
	 * @param adminPhone
	 * @return
	 */
	@RequestMapping("checkAdminPhone")
	@ResponseBody
	public String checkMemberPhone(@RequestParam(required=false) String adminPhone){
		//요청파라미터 검증
		
		//비즈니스 로직 처리 - 관리자 번호조회
		int checkPhone = adminService.checkAdminPhone(adminPhone);
		//응답
		return String.valueOf(checkPhone);
	}
	
	/**
	 * 회원가입 시 회원 이메일 중복확인하는 handler method
	 * @param memberPhone
	 * @return
	 */
	@RequestMapping("checkAdminEmail")
	@ResponseBody
	public String checkAdminEmail(@RequestParam(required=false) String adminEmail1, String adminEmail2){
		String adminEmail = adminEmail1 +"@"+ adminEmail2;
		//요청파라미터 검증
		
		//비즈니스 로직 처리 - 회원 조회
		int checkEmail = adminService.checkAdminEmail(adminEmail);
		//응답
		return String.valueOf(checkEmail);
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
			if(admin == null){
				return new ModelAndView("redirect:/admin/nullAdminId.do","adminId",adminId);
			}else{
				return new ModelAndView("admin/info_admin.tiles","administrator", admin);
			}
	}
	
	//searchAdminById 한 id가 없을 경우(null) 없다고 search_admin_form.jsp로 이동시켜주는 컨트롤러
	@RequestMapping("nullAdminId")
	public ModelAndView nullAdminId(@RequestParam String adminId){
		return new ModelAndView("admin/search_admin_null.tiles","adminId",adminId);
	}
	
	
	//(info_admin.jsp)에서 정보 수정하기(info_admin_update_form.jsp)로 이동하기 위한 컨트롤러
	@RequestMapping("info_admin_update_form")
	public ModelAndView updateAdminForm(@RequestParam String adminId){
		Administrator admin=null;
			admin = adminService.searchAdministratorById(adminId);
		return new ModelAndView("admin/info_admin_update_form.tiles", "administrator", admin);
	}
	
	//(info_admin_update_form.jsp)에서 (mypage.jsp)로 이동하기 위한 컨트롤러					//관리자 enable 변경을 위한 업테이트 결과페이지는 무엇으로 할것인지
	@RequestMapping("info_admin")
	public ModelAndView updateAdminInfo(@ModelAttribute Administrator admin, BindingResult errors){
		User user = new User(admin.getAdminId(),admin.getUser().getUserPwd(), admin.getUser().getUserAuthority(), 1);
			admin.setUser(user);
			userService.updateUser(user);
			System.out.println("점검---1 "+user);
//		//1. 요청파라미터 검증
//		AdministratorRegisterValidator validator = new AdministratorRegisterValidator();   //validator 쓰면 에러발생 'adminUser'
//		System.out.println("점검---2 "+validator);
//		validator.validate(admin, errors);
//		System.out.println("점검---4 "+admin);
//		if(errors.hasErrors()){
//			return  new ModelAndView("redirect:/admin/info_admin_update_form.do?adminId="+admin.getAdminId());
//		}	
		
		Administrator newAdmin = new Administrator(admin.getAdminName(),admin.getAdminPhone(), admin.getAdminEmail(),admin.getAdminId(),user);
			adminService.updateAdministrator(newAdmin);
		return new ModelAndView("admin/mypage.tiles", "administrator", newAdmin);
	}
	
	/**
	 * 관리자 정보 조회 페이지로 이동시키는 handler method
	 * @param 
	 * @return
	 */
	@RequestMapping("mypage")
	public ModelAndView AdminMypage(){
		Administrator admin = (Administrator)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Administrator ad = adminService.searchAdministratorById(admin.getAdminId());
		return new ModelAndView("admin/mypage.tiles", "administrator", ad);
	}
	
	//관리자탈퇴('ROLE_3')로 권한변경
	@RequestMapping("adminWithdrawal")
	public String adminWithdrawal(@RequestParam String adminId){
		Administrator admin = null;
			String deleteEmail = UUID.randomUUID().toString().replaceAll("-", "");
			
			System.out.println("컨트롤러 1- "+adminId);
			admin = adminService.searchAdministratorById(adminId);
			if(admin.getUser().getUserAuthority().equals("ROLE_0")){//권한이 'ROLE_0'인 경우 'ROLE_3'(탈퇴상태)로 바꾸기
				userService.changeUserAuthorityToWithdrawal(admin.getAdminId());
				System.out.println("컨트롤러 2- "+admin);
				Administrator deleteAdmin = new Administrator("이름삭제","번호삭제", deleteEmail, admin.getAdminId());
				System.out.println("컨트롤러 3- "+deleteAdmin);
				adminService.updateAdministrator(deleteAdmin);
			}
			SecurityContextHolder.getContext().setAuthentication(null); // security에서 담당하는 session을 null으로 세팅하는 작업.   SecurityContextHolder는 system꺼라서 'new'하고 생성하지 않음.  
			return "admin/byebye_greeting.tiles";
		}
	 
	
}
