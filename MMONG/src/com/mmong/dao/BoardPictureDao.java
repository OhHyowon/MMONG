package com.mmong.dao;

import java.util.List;

import com.mmong.vo.BoardPicture;
/**
 * 자유게시판 이미지 DAO입니다.
 * @author YR
 *
 */
public interface BoardPictureDao {

	
	public int insertBP(BoardPicture boardPicture);
	
	public void deleteBPByBoardNo(int boardNo);
	
	public List<BoardPicture> selectBPByBoardNo(int boardNo);

	
}
