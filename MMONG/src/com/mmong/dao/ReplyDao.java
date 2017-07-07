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
	/**
	 * 댓글 수정
	 * @param replyNo
	 * @param reply
	 * @return
	 */
	public void updateReply(Reply reply);
	/**
	 * replyNo와 memberId가 같을 때  댓글 삭제
	 * @param replyNo
	 */
	public void deleteReply(int replyNo,String memberId);
	/**
	 * boardNo로 댓글 삭제
	 * @param boardNo
	 */
	public void deleteReplyByBoardNo(int boardNo);
	/**
	 * 내가 쓴 댓글 갯수 
	 * @param memberId
	 * @return
	 */
	public int selectMyReplyCount(String memberId);
	/**
	 * memberId로 내가 쓴 댓글 목록 가져오기
	 * @param memberId
	 * @return
	 */
	public List<Reply> selectMyReply(int beginItemNo, int endItemNo,String memberId);
}
