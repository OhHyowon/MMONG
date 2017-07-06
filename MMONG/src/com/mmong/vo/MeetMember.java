package com.mmong.vo;

import java.io.Serializable;

public class MeetMember implements Serializable{
	
	private int groupDateNo;
	private int groupMemberNo;
	
	private GroupMember groupMember;
	private GroupDate groupDate;
	
	public MeetMember(){}
	
	public MeetMember(int groupDateNo, int groupMemberNo, GroupMember groupMember, GroupDate groupDate) {
		super();
		this.groupDateNo = groupDateNo;
		this.groupMemberNo = groupMemberNo;
		this.groupMember = groupMember;
		this.groupDate = groupDate;
	}

	public MeetMember(int groupDateNo, int groupMemberNo, GroupDate groupDate) {
		super();
		this.groupDateNo = groupDateNo;
		this.groupMemberNo = groupMemberNo;
		this.groupDate = groupDate;
	}

	public MeetMember(int groupDateNo, int groupMemberNo, GroupMember groupMember) {
		super();
		this.groupDateNo = groupDateNo;
		this.groupMemberNo = groupMemberNo;
		this.groupMember = groupMember;
	}

	public int getGroupDateNo() {
		return groupDateNo;
	}

	public void setGroupDateNo(int groupDateNo) {
		this.groupDateNo = groupDateNo;
	}

	public int getGroupMemberNo() {
		return groupMemberNo;
	}

	public void setGroupMemberNo(int groupMemberNo) {
		this.groupMemberNo = groupMemberNo;
	}

	public GroupMember getGroupMember() {
		return groupMember;
	}

	public void setGroupMember(GroupMember groupMember) {
		this.groupMember = groupMember;
	}

	public GroupDate getGroupDate() {
		return groupDate;
	}

	public void setGroupDate(GroupDate groupDate) {
		this.groupDate = groupDate;
	}

	@Override
	public String toString() {
		return "MeetMember [groupDateNo=" + groupDateNo + ", groupMemberNo=" + groupMemberNo + ", groupMember="
				+ groupMember + ", groupDate=" + groupDate + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((groupDate == null) ? 0 : groupDate.hashCode());
		result = prime * result + groupDateNo;
		result = prime * result + ((groupMember == null) ? 0 : groupMember.hashCode());
		result = prime * result + groupMemberNo;
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
		MeetMember other = (MeetMember) obj;
		if (groupDate == null) {
			if (other.groupDate != null)
				return false;
		} else if (!groupDate.equals(other.groupDate))
			return false;
		if (groupDateNo != other.groupDateNo)
			return false;
		if (groupMember == null) {
			if (other.groupMember != null)
				return false;
		} else if (!groupMember.equals(other.groupMember))
			return false;
		if (groupMemberNo != other.groupMemberNo)
			return false;
		return true;
	}
	
	
}
