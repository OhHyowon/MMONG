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
	
	public String selectNickNameByMemberId(String memberId,int boardNo);
	
	public void deleteBoard(int boardNo,String memberId);
	
	public HashMap<String,Object> selectAllBoard(int page,int groupNo);
	
	public HashMap<String,Object> selectOption(int page, String option, String key,int groupNo);
	
	public HashMap<String,Object> selectMyBoardList(int page,String memberId,int groupNo);
	
	public HashMap<String,Object> selectMyOption(int page,String option,String key,String memberId,int groupNo);
	
	
}
