package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mmong.vo.GroupDate;
import com.mmong.vo.Health;

public class HealthValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		
		return clazz.isAssignableFrom(Health.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		Health Health = (Health)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"content","required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "gender", "required");
		
	}

}
