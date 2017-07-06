package com.mmong.vo;

import java.io.Serializable;

public class GroupMember implements Serializable {
	
	private int no;
	
	private int groupNo;
	private Group group;
	
	private String memberId;
	private Member member;

	public GroupMember(){}

	public GroupMember(int no, int groupNo, Group group, String memberId, Member member) {
		super();
		this.no = no;
		this.groupNo = groupNo;
		this.group = group;
		this.memberId = memberId;
		this.member = member;
	}

	public GroupMember(int no, int groupNo, String memberId) {
		super();
		this.no = no;
		this.groupNo = groupNo;
		this.memberId = memberId;
	}

	public GroupMember(int no, String memberId, Member member) {
		super();
		this.no = no;
		this.memberId = memberId;
		this.member = member;
	}

	public GroupMember(int no, int groupNo, Group group) {
		super();
		this.no = no;
		this.groupNo = groupNo;
		this.group = group;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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
		return "GroupMember [no=" + no + ", groupNo=" + groupNo + ", group=" + group + ", memberId=" + memberId
				+ ", member=" + member + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((group == null) ? 0 : group.hashCode());
		result = prime * result + groupNo;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
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
		GroupMember other = (GroupMember) obj;
		if (group == null) {
			if (other.group != null)
				return false;
		} else if (!group.equals(other.group))
			return false;
		if (groupNo != other.groupNo)
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
		return true;
	}
	
	
}
