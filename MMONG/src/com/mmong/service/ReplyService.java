package com.mmong.service;

import java.util.HashMap;
import java.util.List;

import com.mmong.vo.Reply;
/**
 * 댓글 서비스 입니다.
 * @author YR
 *
 */
public interface ReplyService {
	/**
	 * 댓글 등록하는 메소드
	 * @param reply
	 * @return
	 * 작성자 : 강여림
	 */
	public int insertReply(Reply reply);
	/**
	 * 해당 게시판의 댓글들 조회하는 메소드 
	 * @param boardNo
	 * @return
	 * 작성자 : 강여림
	 */
	public List<Reply> selectReplyByBoardNo(int boardNo);
	/**
	 * 댓글 번호와 멤버 아이디가 같을 때 닉네임 조회하는 메소드
	 * @param replyNo
	 * @param memberId
	 * @return
	 * 작성자 : 강여림
	 */
	public String selectNickNameByNo(int replyNo, String memberId);
	/**
	 * 댓글 작성자 조회하는 메소드
	 * @param replyNo
	 * @return
	 * 작성자 : 강여림
	 */
	public String selectMemberId(int replyNo);
	/**
	 * 해당 게시물에 댓글 갯수 조회하는 메소드
	 * @param boardNo
	 * @return
	 * 작성자 : 강여림
	 */
	public int selectReplyCount(int boardNo);
	/**
	 * 댓글 수정하는 메소드
	 * @param reply
	 * 작성자 : 강여림
	 */
	public void updateReply(Reply reply);
	/**
	 * 댓글 삭제하는 메소드
	 * @param replyNo
	 * @param memberId
	 * 작성자 : 강여림
	 */
	public void deleteReply(int replyNo,String memberId);
	/**
	 * 게시물 삭제시 해당 게시물의 댓글들 전체 삭제하는 메소드
	 * @param boardNo
	 * 작성자 : 강여림
	 */
	public void deleteReplyByBoardNo(int boardNo);
	/**
	 * 내가 쓴 댓글 조회하는 메소드
	 * @param page
	 * @param memberId
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object>selectMyReply(int page,String memberId);
}
