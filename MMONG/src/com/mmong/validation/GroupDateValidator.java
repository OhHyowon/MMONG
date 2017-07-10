package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mmong.vo.GroupDate;

public class GroupDateValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(GroupDate.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		/*
		 * title 한글자 이상
		 */
		
		GroupDate groupDate = (GroupDate)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"title","size");
		
		if(groupDate.getGroupDate()==null){
			errors.rejectValue("groupDate", "required");
		}
		

	}	
}
