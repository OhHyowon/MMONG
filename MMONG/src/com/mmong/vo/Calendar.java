package com.mmong.vo;

import java.io.Serializable;

public class Calendar implements Serializable {
	private int no ;
	private String title;
	private String content;
	private int type;
	private int secret;
	private int emotion;
	private String picture;
	
	private String memberId;
	private Member member;
	
	public Calendar(){}
	
	public Calendar(int no, String title, String content, int type, int secret, int emotion, String picture,
			String memberId) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.type = type;
		this.secret = secret;
		this.emotion = emotion;
		this.picture = picture;
		this.memberId = memberId;
	}
	
	public Calendar(int no, String title, String content, int type, int secret, int emotion, String picture,
			String memberId, Member member) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.type = type;
		this.secret = secret;
		this.emotion = emotion;
		this.picture = picture;
		this.memberId = memberId;
		this.member = member;
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

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getSecret() {
		return secret;
	}

	public void setSecret(int secret) {
		this.secret = secret;
	}

	public int getEmotion() {
		return emotion;
	}

	public void setEmotion(int emotion) {
		this.emotion = emotion;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
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
	public String toString() {
		return "Calendar [no=" + no + ", title=" + title + ", content=" + content + ", type=" + type + ", secret="
				+ secret + ", emotion=" + emotion + ", picture=" + picture + ", memberId=" + memberId + ", member="
				+ member + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + emotion;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
		result = prime * result + ((picture == null) ? 0 : picture.hashCode());
		result = prime * result + secret;
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + type;
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
		Calendar other = (Calendar) obj;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (emotion != other.emotion)
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
		if (picture == null) {
			if (other.picture != null)
				return false;
		} else if (!picture.equals(other.picture))
			return false;
		if (secret != other.secret)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (type != other.type)
			return false;
		return true;
	}
	
	
	
	

}
