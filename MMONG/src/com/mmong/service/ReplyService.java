package com.mmong.service;

import java.util.List;

import com.mmong.vo.Reply;
/**
 * 댓글 서비스 입니다.
 * @author YR
 *
 */
public interface ReplyService {

	public int insertReply(Reply reply);
	
	public List<Reply> selectReplyByBoardNo(int boardNo);
	
	public String selectNickNameByNo(int replyNo, String memberId);
	
	public String selectMemberId(int replyNo);
	
	public int selectReplyCount(int boardNo);
	
	public void updateReply(Reply reply);
	
}
