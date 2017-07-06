package com.mmong.vo;

import java.io.Serializable;
import java.util.Date;

public class Board implements Serializable {
	
	private int no;
	private String title;
	private String content;
	private Date boardDate;
	private int hit;
	private String memberId;
	private int replyCount;
	
	private int groupNo;
	private Group group;
	private Member member;
	
	public Board(){}

	public Board(int no, String title, String content, Date boardDate, int hit, String memberId, int replyCount,
			int groupNo, Group group, Member member) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.boardDate = boardDate;
		this.hit = hit;
		this.memberId = memberId;
		this.replyCount = replyCount;
		this.groupNo = groupNo;
		this.group = group;
		this.member = member;
	}

	public Board(int no, String title, String content, Date boardDate, int hit, String memberId, int replyCount,
			int groupNo, Group group) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.boardDate = boardDate;
		this.hit = hit;
		this.memberId = memberId;
		this.replyCount = replyCount;
		this.groupNo = groupNo;
		this.group = group;
	}

	public Board(int no, String title, String content, Date boardDate, int hit, String memberId, int replyCount,
			int groupNo) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.boardDate = boardDate;
		this.hit = hit;
		this.memberId = memberId;
		this.replyCount = replyCount;
		this.groupNo = groupNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardDate == null) ? 0 : boardDate.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((group == null) ? 0 : group.hashCode());
		result = prime * result + groupNo;
		result = prime * result + hit;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
		result = prime * result + replyCount;
		result = prime * result + ((title == null) ? 0 : title.hashCode());
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
		Board other = (Board) obj;
		if (boardDate == null) {
			if (other.boardDate != null)
				return false;
		} else if (!boardDate.equals(other.boardDate))
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (group == null) {
			if (other.group != null)
				return false;
		} else if (!group.equals(other.group))
			return false;
		if (groupNo != other.groupNo)
			return false;
		if (hit != other.hit)
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
		if (replyCount != other.replyCount)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Board [no=" + no + ", title=" + title + ", content=" + content + ", boardDate=" + boardDate + ", hit="
				+ hit + ", memberId=" + memberId + ", replyCount=" + replyCount + ", groupNo=" + groupNo + ", group="
				+ group + ", member=" + member + "]";
	}
	
	
	
	

}