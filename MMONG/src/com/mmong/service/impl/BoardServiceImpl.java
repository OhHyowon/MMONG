package com.mmong.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.BoardDao;
import com.mmong.paging.util.PagingBean;
import com.mmong.service.BoardService;
import com.mmong.vo.Board;



@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDao dao;
	
	public int insertBoard(Board board){
		dao.insertBoard(board);
		int boardNo=board.getNo();
	
		return boardNo;
	}
	
	public Board selectBoard(int boardNo){
		return dao.selectBoardByNo(boardNo);
	}
	
	public int updateBoard(Board board){
		return dao.updateBoard(board);
	}
	
	public String selectNickNameByMemberId(String memberId,int boardNo){
		return dao.selectNickNameByMemberId(memberId,boardNo);
	}
	
	public void deleteBoard(int boardNo,String memberId){
		dao.deleteBoard(boardNo,memberId);
	}
	
	public HashMap<String,Object> selectAllBoard(int page,int groupNo){
		HashMap<String,Object> map= new HashMap<>();
		
		int totalCount = dao.selectBoardCount(groupNo);
		
		PagingBean pageBean = new PagingBean(totalCount, page);
		List<Board> boardList = dao.selectAllBoard(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage(),groupNo);
		List<String> nickNameList= new ArrayList<>();
		
		for(int i =0; i<boardList.size(); i++){
			String memberId=boardList.get(i).getMemberId();
			int boardNo=boardList.get(i).getNo();
			String nickname=selectNickNameByMemberId(memberId, boardNo);
			
			nickNameList.add(nickname);
		}

		
		map.put("pageBean", pageBean);
		map.put("boardList",boardList);
		map.put("nickNameList", nickNameList);
		
		
		return map;
	}
	
	public HashMap<String,Object> selectOption(int page, String option, String key,int groupNo){
		HashMap<String,Object> map = new HashMap<>();
		int totalCount = dao.selectOptionCount(groupNo,option,key);
		
		PagingBean pageBean = new PagingBean(totalCount,page);
		List<Board> boardList = dao.selectOption(option, key, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage(), groupNo);
		List<String> nickNameList=new ArrayList<>();
		
		for(int i =0; i<boardList.size(); i++){
			String memberId=boardList.get(i).getMemberId();
			int boardNo=boardList.get(i).getNo();
			
			String nickname=selectNickNameByMemberId(memberId, boardNo);
			
			nickNameList.add(i, nickname);
		}
		
		map.put("pageBean", pageBean);
		map.put("boardList", boardList);
		map.put("nickNameList", nickNameList);
		
		return map;
	}
	
	public HashMap<String,Object> selectMyBoardList(int page,String memberId,int groupNo){
		HashMap<String,Object> map = new HashMap<>();
		
		int totalCount = dao.selectMyBoardCount(memberId,groupNo);
		PagingBean pageBean = new PagingBean(totalCount, page);
		
		List<Board> myBoardList=dao.selectMyBoardList(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage(),memberId,groupNo);
		
		map.put("pageBean", pageBean);
		map.put("myBoardList", myBoardList);
		
		return map;
	}
	
	public HashMap<String,Object> selectMyOption(int page,String option,String key,String memberId,int groupNo){
		HashMap<String,Object> map=new HashMap<>();
		
		int totalCount = dao.selectMyBoardCount(memberId,groupNo);
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<Board> myBoardList=dao.selectMyOption(pageBean.getBeginItemInPage(),pageBean.getEndItemInPage(),option,key,memberId,groupNo);
		
		map.put("pageBean", pageBean);
		map.put("myBoardList", myBoardList);
		
		
		return map;
	}

	@Override
	public List<Integer> selectBoardNoByGroupNo(int groupNo) {
		List<Integer> list=dao.selectBoardNoByGroupNo(groupNo);
		return list;
	}
	
	public void deleteBoardByGroupNo(int groupNo){
		dao.deleteBoardByGroupNo(groupNo);
	}
}
