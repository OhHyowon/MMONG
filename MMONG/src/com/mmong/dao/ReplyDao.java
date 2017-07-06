package com.mmong.dao;

import java.util.List;

import com.mmong.vo.Reply;
/**
 * 자유게시판의 댓글 DAO 입니다.
 * @author YR
 *
 */
public interface ReplyDao {
	/**
	 *  댓글 등록
	 * @param reply
	 * @return
	 */
	public int insertReply(Reply reply);
	/**
	 * 게시판번호로 댓글 리스트 조회
	 * @param boardNo
	 * @return
	 */
	public List<Reply>selectReplyByBoardNo(int boardNo);
	/**
	 * 댓글번호와 리플작성한 아이디로 닉네임 조회
	 * @param replyNo
	 * @param memberId
	 * @return
	 */
	public String selectNickNameByNo(int replyNo, String memberId);
	/**
	 * 댓글번호로 댓글 작성자 조회
	 * @param replyNo
	 * @return
	 */
	public String selectMemberId(int replyNo);
	/**
	 * 게시판 번호로 댓글 갯수 조회
	 * @param boardNo
	 * @return
	 */
	public int selectReplyCount(int boardNo);
	
	
}
