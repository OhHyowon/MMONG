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
		System.out.println("서비스 의 보드" +board);
		dao.insertBoard(board);
		int boardNo=board.getNo();
		
		System.out.println("서비스의 boardNo : "+boardNo);
		return boardNo;
	}
	
	public Board selectBoard(int boardNo){
		return dao.selectBoardByNo(boardNo);
	}
	
	public int updateBoard(Board board){
		return dao.updateBoard(board);
	}
	
	public Board selectNickNameByMemberId(String memberId,int boardNo){
		return dao.selectNickNameByMemberId(memberId,boardNo);
	}
	
	public void deleteBoard(int boardNo,String memberId){
		dao.deleteBoard(boardNo,memberId);
	}
	
	public HashMap<String,Object> selectAllBoard(int page){
		HashMap<String,Object> map= new HashMap<>();
		
		int totalCount = dao.selectBoardCount();
		
		PagingBean pageBean = new PagingBean(totalCount, page);
		List<Board> boardList = dao.selectAllBoard(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		List<String> nickNameList= new ArrayList<>();
		
		for(int i =0; i<boardList.size(); i++){
			String memberId=boardList.get(i).getMemberId();
			int boardNo=boardList.get(i).getNo();
		
			String nickname=selectNickNameByMemberId(memberId, boardNo).getMember().getNickName();
			nickNameList.add(nickname);
		}

		
		map.put("pageBean", pageBean);
		map.put("boardList",boardList);
		map.put("nickNameList", nickNameList);
		
		
		return map;
	}
	
	public HashMap<String,Object> selectOption(int page, String option, String key){
		HashMap<String,Object> map = new HashMap<>();
		int totalCount = dao.selectBoardCount();
		
		PagingBean pageBean = new PagingBean(totalCount,page);
		List<Board> boardList = dao.selectOption(option, key, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		List<String> nickNameList=null;
		
		for(int i =0; i<boardList.size(); i++){
			boardList.get(i).getMemberId();
			boardList.get(i).getNo();
			String nickname=selectNickNameByMemberId(boardList.get(i).getMemberId(),boardList.get(i).getNo()).getMember().getNickName();
			nickNameList.add(nickname);
		}

		map.put("pageBean", pageBean);
		map.put("boardList", boardList);
		map.put("nickNameList", nickNameList);
		
		return map;
	}
}
