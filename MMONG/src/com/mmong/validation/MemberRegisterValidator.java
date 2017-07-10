package com.mmong.validation;


import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.mmong.vo.Member;
import com.mmong.vo.User;

public class MemberRegisterValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Member.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Member member = (Member)target;
		
	
		//User객체 검증 
		User user = member.getUser();
		errors.pushNestedPath("memberUser");		
		try{
			//userId 필수 입력, 8글자 이상 12글자 이하
			//에러메세지 하나만 띄우기 위해 if-else if 사용
			if(member.getUser().getUserId()==null || member.getUser().getUserId().equals("")){
				errors.rejectValue("userId", "required");
			}else if(member.getUser().getUserId()!=null && (member.getUser().getUserId().length()<8)||member.getUser().getUserId().length()>12) {
				errors.rejectValue("userId", "size");
			}		
			//userPwd 필수입력, 8글자 이상 16글자 이하
			//에러메세지 하나만 띄우기 위해 if-else if 사용
			if(member.getUser().getUserPwd()==null || member.getUser().getUserPwd().equals("")) {
				errors.rejectValue("userPwd", "required");
			}else if(member.getUser().getUserPwd()!=null && (member.getUser().getUserPwd().length()<8)||member.getUser().getUserPwd().length()>16) {
				errors.rejectValue("userPwd", "size");
			}
		}finally{
			errors.popNestedPath();
		}

		
	}

}
