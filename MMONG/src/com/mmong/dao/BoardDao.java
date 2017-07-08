package com.mmong.dao;

import java.util.List;

import com.mmong.vo.Board;
/**
 * 게시판 DAO 입니다
 * @author YR
 *
 */
public interface BoardDao {
	/**
	 * 게시판 등록
	 * @param board
	 * @return
	 */
	public int insertBoard(Board board);
	/**
	 *게시판 번호로 게시글 조회
	 * @param boardNo
	 * @return
	 */
	public Board selectBoardByNo(int boardNo);
	/**
	 * 게시글 수정
	 * @param board
	 * @return
	 */
	public int updateBoard(Board board);
	/**
	 * 게시글 번호와 작성자 이름으로 닉네임 조회
	 * @param memberId
	 * @param boardNo
	 * @return
	 */
	public String selectNickNameByMemberId(String memberId,int boardNo);
	/**
	 * 게시글 번호와 작성자 이름 확인 후 게시글 삭제
	 * @param boardNo
	 * @param memberId
	 */
	public void deleteBoard(int boardNo, String memberId);
	/**
	 * 전체 게시글 갯수 조회
	 * @return
	 */
	public int selectBoardCount();
	/**
	 * 전체 게시글 조회
	 * @param beginItemNo
	 * @param endItemNo
	 * @return
	 */
	public List<Board> selectAllBoard(int beginItemNo, int endItemNo);
	/**
	 * 검색된 게시글 조회
	 * @param option
	 * @param key
	 * @param beginItemNo
	 * @param endItemNo
	 * @return
	 */
	public List<Board> selectOption(String option, String key, int beginItemNo, int endItemNo);
	/**
	 * 내가 쓴 게시글의 전체 갯수 조회
	 * @return
	 */
	public int selectMyBoardCount(String memberId);
	/**
	 * 내가 쓴 게시글 목록 조회
	 * @param beginItemNo
	 * @param endItemNo
	 * @param memberId
	 * @return
	 */
	public List<Board> selectMyBoardList(int beginItemNo, int endItemNo,String memberId);
	/**
	 * 내가 쓴 게시물 검색해서 조회
	 * @param beginItemNo
	 * @param endItemNo
	 * @param option
	 * @param key
	 * @param memberId
	 * @return
	 */
	public List<Board>selectMyOption(int beginItemNo, int endItemNo,String option,String key,String memberId);
	/**
	 * boardNo으로 boardContent 조회
	 * @param boardNo
	 * @return
	 */
	public String selectBoardTitle(int boardNo);
}
