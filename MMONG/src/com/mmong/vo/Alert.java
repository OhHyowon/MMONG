package com.mmong.vo;

import java.io.Serializable;

public class Alert implements Serializable{

	private int no;
	private String content;
	private int state;
	
	private String memberId;
	private Member member;
	
	public Alert() {}
	
	public Alert(int no, String content, int state, String memberId) {
		super();
		this.no = no;
		this.content = content;
		this.state = state;
		this.memberId = memberId;
	}

	public Alert(int no, String content, int state, String memberId, Member member) {
		super();
		this.no = no;
		this.content = content;
		this.state = state;
		this.memberId = memberId;
		this.member = member;
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
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
		result = prime * result + state;
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
		Alert other = (Alert) obj;
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
		if (state != other.state)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Alert [no=" + no + ", content=" + content + ", state=" + state + ", memberId=" + memberId + ", member="
				+ member + "]";
	}
	
	
	
	
	
	
}
