package com.mmong.vo;

import java.io.Serializable;
import java.util.Date;


public class Message implements Serializable {
	
	private int no;
	private Date messageDate;
	private String title;
	private String content;
	private int state;
	
	private String sendId;
	private String receiveId;
	private Member member;
	
	public Message(){}

	public Message(int no, Date messageDate, String title, String content, int state, String sendId, String receiveId,
			Member member) {
		super();
		this.no = no;
		this.messageDate = messageDate;
		this.title = title;
		this.content = content;
		this.state = state;
		this.sendId = sendId;
		this.receiveId = receiveId;
		this.member = member;
	}

	public Message(int no, Date messageDate, String title, String content, int state, String sendId, String receiveId) {
		super();
		this.no = no;
		this.messageDate = messageDate;
		this.title = title;
		this.content = content;
		this.state = state;
		this.sendId = sendId;
		this.receiveId = receiveId;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public Date getMessageDate() {
		return messageDate;
	}

	public void setMessageDate(Date messageDate) {
		this.messageDate = messageDate;
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

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getSendId() {
		return sendId;
	}

	public void setSendId(String sendId) {
		this.sendId = sendId;
	}

	public String getReceiveId() {
		return receiveId;
	}

	public void setReceiveId(String receiveId) {
		this.receiveId = receiveId;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "Message [no=" + no + ", messageDate=" + messageDate + ", title=" + title + ", content=" + content
				+ ", state=" + state + ", sendId=" + sendId + ", receiveId=" + receiveId + ", member=" + member + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((messageDate == null) ? 0 : messageDate.hashCode());
		result = prime * result + no;
		result = prime * result + ((receiveId == null) ? 0 : receiveId.hashCode());
		result = prime * result + ((sendId == null) ? 0 : sendId.hashCode());
		result = prime * result + state;
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
		Message other = (Message) obj;
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
		if (messageDate == null) {
			if (other.messageDate != null)
				return false;
		} else if (!messageDate.equals(other.messageDate))
			return false;
		if (no != other.no)
			return false;
		if (receiveId == null) {
			if (other.receiveId != null)
				return false;
		} else if (!receiveId.equals(other.receiveId))
			return false;
		if (sendId == null) {
			if (other.sendId != null)
				return false;
		} else if (!sendId.equals(other.sendId))
			return false;
		if (state != other.state)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}
	
	
	
}
