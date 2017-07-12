package com.mmong.dao;

import java.util.List;

import com.mmong.vo.BoardPicture;
/**
 * 자유게시판 이미지 DAO입니다.
 * @author YR
 *
 */
public interface BoardPictureDao {

	/**
	 * 이미지&파일 등록하기
	 * @param boardPicture
	 * @return
	 * 작성자 : 강여림
	 */
	public int insertBP(BoardPicture boardPicture);
	/**
	 * 게시물번호에 따라 이미지 삭제하기
	 * @param boardNo
	 * 작성자 : 강여림
	 */
	public void deleteBPByBoardNo(int boardNo);
	/**
	 * 게시물 번호에 따라 이미지 조회하기
	 * @param boardNo
	 * @return
	 * 작성자 : 강여림
	 */
	public List<BoardPicture> selectBPByBoardNo(int boardNo);

	
}
