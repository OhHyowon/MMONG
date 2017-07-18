package com.mmong.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.BoardDao;
import com.mmong.dao.ReplyDao;
import com.mmong.paging.util.PagingBean;
import com.mmong.service.ReplyService;
import com.mmong.vo.Reply;
@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyDao dao;
	@Autowired
	private BoardDao boardDao;
	
	
	public int insertReply(Reply reply){	
		return dao.insertReply(reply);
	}
	
	public List<Reply> selectReplyByBoardNo(int boardNo){
		return dao.selectReplyByBoardNo(boardNo);
	}
	
	public String selectNickNameByNo(int replyNo, String memberId){
		return dao.selectNickNameByNo(replyNo,memberId);
	}
	
	public String selectMemberId(int replyNo){
		return dao.selectMemberId(replyNo);
	}
	
	public int selectReplyCount(int boardNo){
		return dao.selectReplyCount(boardNo);
	}
	
	public void updateReply(Reply reply){
		dao.updateReply(reply);
	}
	
	public void deleteReply(int replyNo,String memberId){
		dao.deleteReply(replyNo,memberId);
	}
	
	public void deleteReplyByBoardNo(int boardNo){
		dao.deleteReplyByBoardNo(boardNo);
	}
	
	public HashMap<String,Object>selectMyReply(int page,String memberId, int groupNo){
		HashMap<String,Object> map= new HashMap<>();
		
		int totalCount = dao.selectMyReplyCount(memberId,groupNo);
		PagingBean pageBean = new PagingBean(totalCount,page);
		List<Reply> myReplyList=dao.selectMyReply(pageBean.getBeginItemInPage(),pageBean.getEndItemInPage(),memberId,groupNo);	
		List<String> boardTitle=new ArrayList<>();
		List<Integer> boardNoList=new ArrayList<>();
		
		
		for(int i=0; i<myReplyList.size(); i++){
			int boardNo=myReplyList.get(i).getBoardNo();
			String content=boardDao.selectBoardTitle(boardNo);
			
			boardNoList.add(boardNo);
			boardTitle.add(content);
		}
		
		map.put("boardNoList", boardNoList);
		map.put("boardTitle", boardTitle);
		map.put("pageBean",pageBean);
		map.put("myReplyList", myReplyList);
		
		return map;
	}
	
	public void deleteReplyByGroupNo(int groupNo){
		dao.deleteReplyByGroupNo(groupNo);
	}
}
