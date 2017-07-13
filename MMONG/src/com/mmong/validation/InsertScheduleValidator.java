package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mmong.vo.Calendar;

public class InsertScheduleValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Calendar.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		/**에러에 따라 출력할 text적기*/
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "scheduleTitle", "제목을 입력하세요");

	}

	
}
