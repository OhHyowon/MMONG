package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mmong.vo.Administrator;
import com.mmong.vo.AdministratorNotice;

public class AdministratorNoticeValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return  clazz.isAssignableFrom(Administrator.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		/*
		 * 필수 : title, content
		*/
		
		AdministratorNotice adminNotice = (AdministratorNotice)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"title","required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "required");
		
		
		
		
		
		
		
	}

	
	
	
	
	
}








