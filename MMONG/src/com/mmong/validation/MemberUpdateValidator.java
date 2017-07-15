package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mmong.vo.Administrator;
import com.mmong.vo.Member;
import com.mmong.vo.User;

public class MemberUpdateValidator implements Validator  {

	@Override
	public boolean supports(Class<?> clazz) {
		return  clazz.isAssignableFrom(Administrator.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		/*
		 * 필수 : userPwd, memberPhone, memberEamil
		 * 체크 : userPwd는 8글자 이상 16글자 미만
		 * 
		*/
		Member member = (Member)target;
		
		//User객체 검증 
		User user = member.getUser();
		errors.pushNestedPath("memberUser");		
		try{
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
		
		//memberPhone 글자수 체크
		if(member.getMemberPhone()!=null &&(member.getMemberPhone().length()<10||member.getMemberPhone().length()>11)){
			errors.rejectValue("memberPhone", "size");
		}
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberEmail", "required");
		
		
	}

}
