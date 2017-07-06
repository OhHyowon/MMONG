package com.mmong.vo;

import java.io.Serializable;
import java.util.Date;

public class Reply implements Serializable{
	
	private int no;
	private String content;
	private Date replyDate;
	private String memberId;
	
	private int boardNo;
	private Board board;
	
	private Member member;
	
	public Reply() {}

	public Reply(int no, String content, Date replyDate, String memberId, int boardNo, Board board, Member member) {
		super();
		this.no = no;
		this.content = content;
		this.replyDate = replyDate;
		this.memberId = memberId;
		this.boardNo = boardNo;
		this.board = board;
		this.member = member;
	}

	public Reply(int no, String content, Date replyDate, String memberId, int boardNo, Board board) {
		super();
		this.no = no;
		this.content = content;
		this.replyDate = replyDate;
		this.memberId = memberId;
		this.boardNo = boardNo;
		this.board = board;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "Reply [no=" + no + ", content=" + content + ", replyDate=" + replyDate + ", memberId=" + memberId
				+ ", boardNo=" + boardNo + ", board=" + board + ", member=" + member + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((board == null) ? 0 : board.hashCode());
		result = prime * result + boardNo;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
		result = prime * result + ((replyDate == null) ? 0 : replyDate.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Reply other = (Reply) obj;
		if (board == null) {
			if (other.board != null)
				return false;
		} else if (!board.equals(other.board))
			return false;
		if (boardNo != other.boardNo)
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (member == null) {
			if (other.member != null)
				return false;
		} else if (!member.equals(other.member))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (no != other.no)
			return false;
		if (replyDate == null) {
			if (other.replyDate != null)
				return false;
		} else if (!replyDate.equals(other.replyDate))
			return false;
		return true;
	}

	
}
