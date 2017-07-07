package com.mmong.validation;

import org.springframework.validation.Errors;

import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.mmong.vo.Message;

public class SendMessageValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Message.class);
	}

	@Override
	public void validate(Object target, Errors errors) {

		/**에러에 따라 출력할 text적기*/
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "msgTitle", "제목을 입력하세요");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "msgContent", "내용을 입력하세요");

	}

}
