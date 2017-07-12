package com.mmong.service;

import java.util.HashMap;

import com.mmong.vo.Board;
/**
 * 게시판 서비스입니다.
 * @author 강여림
 *
 */
public interface BoardService {
	/**
	 * 게시판 등록하기
	 * @param board
	 * @return
	 * 작성자 : 강여림
	 */
	public int insertBoard(Board board);
	/**
	 * boardNo으로 게시물 조회하기
	 * @param boardNo
	 * @return
	 * 작성자 : 강여림
	 */
	public Board selectBoard(int boardNo);
	/**
	 * 게시판 수정하기
	 * @param board
	 * @return
	 * 작성자 : 강여림
	 */
	public int updateBoard(Board board);
	/**
	 * 아이디와 게시물번호로 닉네임 가져오기
	 * @param memberId
	 * @param boardNo
	 * @return
	 * 작성자 : 강여림
	 */
	public String selectNickNameByMemberId(String memberId,int boardNo);
	/**
	 * 게시물번호와 작성자 아이디로 게시물 삭제하기
	 * @param boardNo
	 * @param memberId
	 * 작성자 : 강여림
	 */
	public void deleteBoard(int boardNo,String memberId);
	/**
	 * 전체 게시판 목록 조회하기
	 * @param page
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object> selectAllBoard(int page,int groupNo);
	/**
	 * 검색결과에 따른 게시판 목록 조회하기
	 * @param page
	 * @param option
	 * @param key
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object> selectOption(int page, String option, String key,int groupNo);
	/**
	 * 내가 쓴 게시판 목록 조회하기
	 * @param page
	 * @param memberId
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object> selectMyBoardList(int page,String memberId,int groupNo);
	/**
	 * 검색결과에 따른 내가 쓴 게시판 목록 조회하기
	 * @param page
	 * @param option
	 * @param key
	 * @param memberId
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object> selectMyOption(int page,String option,String key,String memberId,int groupNo);
	
	
}
