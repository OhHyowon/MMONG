package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.BoardDao;
import com.mmong.vo.Board;
@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.boardMapper."+id;
	}
	
	public int insertBoard(Board board){
		return session.insert(makeSqlId("insertBoard"), board);
	}
	
	public Board selectBoardByNo(int boardNo){
		return session.selectOne(makeSqlId("selectBoardByNo"),boardNo);
	}
	
	public int updateBoard(Board board){
		return session.update(makeSqlId("updateBoard"),board);
	}
	
	public String selectNickNameByMemberId(String memberId,int boardNo){
		HashMap<String,Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("boardNo",boardNo);
		
		return session.selectOne(makeSqlId("selectNickNameByMemberId"),map);
	}
	
	public void deleteBoard(int boardNo, String memberId){
		HashMap<String,Object> map=new HashMap<>();
		map.put("boardNo", boardNo);
		map.put("memberId", memberId);
		
		session.delete(makeSqlId("deleteBoard"),map);
	}
	
	public int selectBoardCount(int groupNo){
	
		return session.selectOne(makeSqlId("selectBoardCount"),groupNo);
	}
	
	public List<Board> selectAllBoard(int beginItemNo, int endItemNo,int groupNo){
		HashMap<String,Object>map = new HashMap<>();
		
		map.put("beginItemNo",beginItemNo);
		map.put("endItemNo", endItemNo);
		map.put("groupNo", groupNo);
		
		return session.selectList(makeSqlId("selectAllBoard"),map);
	}
	
	public List<Board> selectOption(String option, String key, int beginItemNo, int endItemNo,int groupNo){		
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("groupNo", groupNo);
		map.put("beginItemNo", beginItemNo);
		map.put("endItemNo", endItemNo);
		map.put("option", option);
		map.put("key", key);
		
		return session.selectList(makeSqlId("selectOption"),map);
	}

	@Override
	public int selectMyBoardCount(String memberId,int groupNo) {
		HashMap <String,Object> map=new HashMap<>();
		
		map.put("memberId", memberId);
		map.put("groupNo",groupNo);
		
		return session.selectOne(makeSqlId("selectMyBoardCount"),map);
	}
	
	public List<Board> selectMyBoardList(int beginItemNo, int endItemNo,String memberId,int groupNo){
		HashMap<String,Object> map=new HashMap<>();
		
		map.put("beginItemNo",beginItemNo);
		map.put("endItemNo", endItemNo);
		map.put("memberId",memberId);
		map.put("groupNo", groupNo);
		
		return session.selectList(makeSqlId("selectMyBoardList"),map);
	}
	
	public List<Board>selectMyOption(int beginItemNo, int endItemNo,String option,String key,String memberId,int groupNo){
		HashMap<String,Object> map=new HashMap<>();
		
		map.put("beginItemNo", beginItemNo);
		map.put("endItemNo",endItemNo);
		map.put("memberId",memberId);
		map.put("option",option);
		map.put("key", key);
		map.put("groupNo", groupNo);
		
		return session.selectList(makeSqlId("selectMyOption"),map);
	}
	
	public String selectBoardTitle(int boardNo){
		return session.selectOne(makeSqlId("selectBoardTitle"),boardNo);
	}
	
	public int selectOptionCount(int groupNo, String option, String key){
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("option",option);
		map.put("key", key);
		map.put("groupNo", groupNo);
		
		return session.selectOne(makeSqlId("selectOptionCount"),map);
		
	}
	
	public List<Integer> selectBoardNoByGroupNo(int groupNo){
		return session.selectList(makeSqlId("selectBoardNoByGroupNo"),groupNo);
	}
	
	public void deleteBoardByGroupNo(int groupNo){
		session.delete(makeSqlId("deleteBoardByGroupNo"),groupNo);
	}
}
