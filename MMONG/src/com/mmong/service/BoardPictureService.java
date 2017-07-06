package com.mmong.service;

import java.util.List;

import com.mmong.vo.BoardPicture;
/**
 * 자유게시판 이미지 서비스 입니다.
 * @author YR
 *
 */
public interface BoardPictureService {

	public void insertBP(BoardPicture boardPicture);
	
	public void deleteBPByBoardNo(int boardNo);
	
	public List<BoardPicture> selectBPByBoardNo(int boardNo);
	
}
