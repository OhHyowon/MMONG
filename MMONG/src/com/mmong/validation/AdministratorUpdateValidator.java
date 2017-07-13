package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.mmong.vo.Administrator;

public class AdministratorUpdateValidator implements Validator  {

	@Override
	public boolean supports(Class<?> clazz) {
		return  clazz.isAssignableFrom(Administrator.class);
	}

	@Override
	public void validate(Object target, Errors error) {
		// TODO Auto-generated method stub
		
	}

}
