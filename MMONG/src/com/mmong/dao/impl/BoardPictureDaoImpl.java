package com.mmong.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.BoardPictureDao;
import com.mmong.vo.BoardPicture;
@Repository
public class BoardPictureDaoImpl implements BoardPictureDao{
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "kr.co.patch.config.mapper.boardMapper."+id;
	}
	
	public int insertBP(BoardPicture boardPicture){
		return session.insert(makeSqlId("insertBoardPicture"),boardPicture);
	}
	
	public void deleteBPByBoardNo(int boardNo){
		session.delete(makeSqlId("deleteBPByBoardNo"),boardNo);
	}
	
	public List<BoardPicture> selectBPByBoardNo(int boardNo){
		return session.selectList(makeSqlId("selectBPByBoardNo"),boardNo);
	}
}
