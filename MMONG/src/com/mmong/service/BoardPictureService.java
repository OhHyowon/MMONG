package com.mmong.service;

import java.util.List;

import com.mmong.vo.BoardPicture;
/**
 * 자유게시판 이미지 서비스 입니다.
 * @author YR
 *
 */
public interface BoardPictureService {
	/**
	 * 이미지 등록하는 메소드
	 * @param boardPicture
	 * 작성자 : 강여림
	 */
	public void insertBP(BoardPicture boardPicture);
	/**
	 * 이미지 삭제하는 메소드
	 * @param boardNo
	 * 작성자 : 강여림
	 */
	public void deleteBPByBoardNo(int boardNo);
	/**
	 * 해당 게시판에 등록된 이미지 조회하는 메소드
	 * @param boardNo
	 * @return
	 * 작성자 : 강여림
	 */
	public List<BoardPicture> selectBPByBoardNo(int boardNo);
	
}
