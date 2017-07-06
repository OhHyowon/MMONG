package com.mmong.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.ReplyDao;
import com.mmong.service.ReplyService;
import com.mmong.vo.Reply;
@Service
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyDao dao;
	
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
}
