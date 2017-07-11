package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mmong.vo.Administrator;
import com.mmong.vo.User;

public class AdministratorRegisterValidator implements Validator  {

	@Override
	public boolean supports(Class<?> clazz) {
		return  clazz.isAssignableFrom(Administrator.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		/*
		 * 필수 : adminId, adminName, adminPhone, adminEamil
		 * 체크 : productId는 3글자 이상 10글자 미만
		 * 
		*/
		Administrator admin = (Administrator)target;
		
		//User객체 검증 
				User user = admin.getUser();
				errors.pushNestedPath("adminUser");		
				try{
				//userId 필수 입력, 8글자 이상 12글자 이하
					//에러메세지 하나만 띄우기 위해 if-else if 사용
					if(admin.getUser().getUserId()==null || admin.getUser().getUserId().equals("")){
						errors.rejectValue("userId", "required");
					}else if(admin.getUser().getUserId()!=null && (admin.getUser().getUserId().length()<8)||admin.getUser().getUserId().length()>12) {
						errors.rejectValue("userId", "size");
					}		
					
				//userPwd 필수입력, 8글자 이상 16글자 이하
					//에러메세지 하나만 띄우기 위해 if-else if 사용
					if(admin.getUser().getUserPwd()==null || admin.getUser().getUserPwd().equals("")) {
						errors.rejectValue("userPwd", "required");
					}else if(admin.getUser().getUserPwd()!=null && (admin.getUser().getUserPwd().length()<8)||admin.getUser().getUserPwd().length()>16) {
						errors.rejectValue("userPwd", "size");
					}
				}finally{
					errors.popNestedPath();
				}

				//adminPhone 글자수 체크
				if(admin.getAdminPhone()!=null &&(admin.getAdminPhone().length()<10||admin.getAdminPhone().length()>11)){
					errors.rejectValue("adminPhone", "size");
				}
				
				ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminName", "required");
				ValidationUtils.rejectIfEmptyOrWhitespace(errors, "adminEmail", "required");
		
		
	}
	
	
}
