package com.mmong.service;

import java.util.HashMap;

import com.mmong.vo.Board;
/**
 * 게시판 서비스
 * @author YR
 *
 */
public interface BoardService {

	public int insertBoard(Board board);
	
	public Board selectBoard(int boardNo);
	
	public int updateBoard(Board board);
	
	public Board selectNickNameByMemberId(String memberId,int boardNo);
	
	public void deleteBoard(int boardNo,String memberId);
	
	public HashMap<String,Object> selectAllBoard(int page);
	
	public HashMap<String,Object> selectOption(int page, String option, String key);
	
	
	
	
	
	
}
