package com.mmong.security.provider;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.mmong.dao.AdministratorDao;
import com.mmong.dao.MemberDao;
import com.mmong.dao.UserDao;
import com.mmong.vo.Administrator;
import com.mmong.vo.Member;
import com.mmong.vo.User;

@Component
/*
 * Spring Security 컨테이너가 사용자 인증 처리(로그인 처리) 할때 호출할 클래스
 * 			=> AuthenticationProvider
 * 구현 : AuthenticationProvider 를 implements. 메소드 오버라이딩(authenticate())
 */

public class UserAuthenticationProvider implements AuthenticationProvider{
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private MemberDao memDao;
	@Autowired
	private AdministratorDao adminDao;

	
	@Autowired
	private PasswordEncoder encoder;
	
	
	
	//문자열을 암호화 - encode()
	//문자열과 암호화된 문자열을 비고 - matches(비교대상문자열, 암호화된문자열) : boolean
	
	/*Authentication : 인증/권한 정보를 가지는 객체 
			- 매개변수는 로그인 처리시 사용할 ID와 패스워드를 제공
			- 리턴 타입은 로그인처리 끝나고 로그인한 사용자의 정보를 담아 리턴할때 사용
		- 인증 실패 : Exception을 던지거나 return null 인 경우 스프링 시큐리티 컨테이너는 
																											인증실패로처리
	  GrantedAuthority - 권한정보 하나를 저장하는 객체.
	*/
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		//ID 체크
		String userId = authentication.getName();//사용자가 입력한 ID
		User user = userDao.searchUserByUserId(userId);
		if(user == null){ //없는 id => 로그인실패
			throw new UsernameNotFoundException("ID를 확인하세요");
		}
		//패스워드 체크
		String password = (String)authentication.getCredentials();//사용자가 입력한 패스워드.
		if(!encoder.matches(password, user.getUserPwd())){//틀린 패스워드
			throw new BadCredentialsException("패스워드를 확인하세요");
		}
		// ==> 인증 성공

		//SimpleGrantedAuthority - 권한정보를 문자열로 저장.
		List<SimpleGrantedAuthority> authList = new ArrayList<>();
		authList.add(new SimpleGrantedAuthority(user.getUserAuthority()));
		
		//인증한 사용자 정보(Principal), 패스워드, 인증된사용자의 권한을 넣어서 principal객체 리턴
		//인증한 사용자가 관리자이면 principal은 관리자 객체, 회원이면 회원 객체가 리턴됨
		if(user.getUserAuthority().equals("ROLE_1")){
			Member member = memDao.searchMemberById(userId);
			return new UsernamePasswordAuthenticationToken(member, null, authList);
		}else{ //user.getUserAuthority().equals("ROLE_0") 일때 
			Administrator admin = adminDao.searchAdministratorById(userId);
			return new UsernamePasswordAuthenticationToken(admin, null, authList);
		}
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.isAssignableFrom(UsernamePasswordAuthenticationToken.class);
	}

	
}









































