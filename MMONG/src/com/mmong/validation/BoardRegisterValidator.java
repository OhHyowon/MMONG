package com.mmong.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.mmong.vo.Board;

public class BoardRegisterValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Board.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		/*
		 필수 : title, content
		 체크 : 한 글자 이상
		 */
		
		Board board=(Board)target;
		
		if(board.getTitle()!=null&&board.getTitle().length()<1){
			errors.rejectValue("title","size","제목은 한글자 이상 입력해주세요.");
		}
		
		if(board.getContent()!=null&&board.getContent().length()<1){
			errors.rejectValue("content","size","내용은 한글자 이상 입력해주세요.");
		}
		
		
		
	}

}
