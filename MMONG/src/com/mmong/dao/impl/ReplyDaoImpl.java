package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.ReplyDao;
import com.mmong.vo.Reply;

@Repository
public class ReplyDaoImpl implements ReplyDao{
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.replyMapper."+id;
	}
	
	public int insertReply(Reply reply){
		return session.insert(makeSqlId("insertReply"),reply);
	}
	
	public List<Reply>selectReplyByBoardNo(int boardNo){
		return session.selectList(makeSqlId("selectReplyByBoardNo"),boardNo);
	}
	
	public String selectNickNameByNo(int replyNo, String memberId){
		HashMap<String,Object> map=new HashMap<>();
		
		map.put("replyNo", replyNo);
		map.put("memberId",memberId);
		
		return session.selectOne(makeSqlId("selectNickNameByNo"),map);
	}
	
	public String selectMemberId(int replyNo){
		return session.selectOne(makeSqlId("selectMemberId"),replyNo);
	}
	
	public int selectReplyCount(int boardNo){
		return session.selectOne(makeSqlId("selectReplyCount"),boardNo);
	}
	
	public void updateReply(Reply reply){
		session.update(makeSqlId("updateReply"),reply);
	}
	
	public void deleteReply(int replyNo,String memberId){
		HashMap<String,Object>map=new HashMap<>();
		
		map.put("replyNo", replyNo);
		map.put("memberId", memberId);
		session.delete(makeSqlId("deleteReply"),map);
	}
	
	public void deleteReplyByBoardNo(int boardNo){
		session.delete(makeSqlId("deleteReplyByBoardNo"),boardNo);
	}
	
	public int selectMyReplyCount(String memberId){
		return session.selectOne(makeSqlId("selectMyReplyCount"),memberId);
	}
	
	
	
	public List<Reply> selectMyReply(int beginItemNo, int endItemNo,String memberId){
		HashMap<String,Object> map=new HashMap<>();
		
		map.put("beginItemNo", beginItemNo);
		map.put("endItemNo", endItemNo);
		map.put("memberId", memberId);
		
		return session.selectList(makeSqlId("selectMyReply"),map);
	}
}
