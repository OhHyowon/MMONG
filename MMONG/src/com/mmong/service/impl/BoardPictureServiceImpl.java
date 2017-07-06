package com.mmong.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.BoardPictureDao;
import com.mmong.service.BoardPictureService;
import com.mmong.vo.BoardPicture;
@Service
public class BoardPictureServiceImpl implements BoardPictureService{
	@Autowired
	private BoardPictureDao dao;
	
	public void insertBP(BoardPicture boardPicture){
		dao.insertBP(boardPicture);
	}
	
	public void deleteBPByBoardNo(int boardNo){
		dao.deleteBPByBoardNo(boardNo);
	}
	
	public List<BoardPicture> selectBPByBoardNo(int boardNo){
		return dao.selectBPByBoardNo(boardNo);
	}
	
}
