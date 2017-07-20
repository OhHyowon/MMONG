package com.mmong.vo;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Calendar implements Serializable {
	private int no ;
	private String title; // 제목
 	private String content; // 메모
	private int type; // 일정 구분
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private Date startDate; // 시작 일시
	@DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm")
	private Date endDate; //종료 일시
	private int emotion; // 기분
	private String picture; // 사진 업로드
	private int groupDateNo; // 소모임 일정 no
	private int healthNo; // 건강기록 no (에 대한 진료기록)
	
	private String memberId;
	private Member member;
	
	public Calendar(){}

	public Calendar(int no, String title, String content, int type, Date startDate, Date endDate, int emotion,
			String picture, int groupDateNo, int healthNo, String memberId) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.type = type;
		this.startDate = startDate;
		this.endDate = endDate;
		this.emotion = emotion;
		this.picture = picture;
		this.groupDateNo = groupDateNo;
		this.healthNo = healthNo;
		this.memberId = memberId;
	}

	public Calendar(int no, String title, String content, int type, Date startDate, Date endDate, int emotion,
			String picture, int groupDateNo, int healthNo, String memberId, Member member) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.type = type;
		this.startDate = startDate;
		this.endDate = endDate;
		this.emotion = emotion;
		this.picture = picture;
		this.groupDateNo = groupDateNo;
		this.healthNo = healthNo;
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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

	public int getGroupDateNo() {
		return groupDateNo;
	}

	public void setGroupDateNo(int groupDateNo) {
		this.groupDateNo = groupDateNo;
	}

	public int getHealthNo() {
		return healthNo;
	}

	public void setHealthNo(int healthNo) {
		this.healthNo = healthNo;
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
		result = prime * result + emotion;
		result = prime * result + ((endDate == null) ? 0 : endDate.hashCode());
		result = prime * result + groupDateNo;
		result = prime * result + healthNo;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
		result = prime * result + ((picture == null) ? 0 : picture.hashCode());
		result = prime * result + ((startDate == null) ? 0 : startDate.hashCode());
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
		if (endDate == null) {
			if (other.endDate != null)
				return false;
		} else if (!endDate.equals(other.endDate))
			return false;
		if (groupDateNo != other.groupDateNo)
			return false;
		if (healthNo != other.healthNo)
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
		if (startDate == null) {
			if (other.startDate != null)
				return false;
		} else if (!startDate.equals(other.startDate))
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

	@Override
	public String toString() {
		return "Calendar [no=" + no + ", title=" + title + ", content=" + content + ", type=" + type + ", startDate="
				+ startDate + ", endDate=" + endDate + ", emotion=" + emotion + ", picture=" + picture
				+ ", groupDateNo=" + groupDateNo + ", healthNo=" + healthNo + ", memberId=" + memberId + ", member="
				+ member + "]";
	}

}
