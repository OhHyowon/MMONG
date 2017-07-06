package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.mmong.vo.Reply;

public class ReplyRegisterValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return clazz.isAssignableFrom(Reply.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		/*
		 * 필수 : content
		 * 체크 : 한 글자 이상 
		 */
		
		Reply reply = (Reply)target;
		
		if(reply.getContent()!=null&&reply.getContent().length()<1){
			errors.rejectValue("content", "size", "내용은 한 글자 이상 입력해주세요");
		}
		
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors,"content","내용은 한 글자 이상 입력해주세요");
		
	}

}
