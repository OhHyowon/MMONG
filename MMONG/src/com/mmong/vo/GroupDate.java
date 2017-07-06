package com.mmong.vo;

import java.io.Serializable;
import java.util.Date;

public class GroupDate implements Serializable{
	
	private int no;
	private Date groupDate;
	private String place;
	
	private int groupNo;
	private Group group;
	
	public GroupDate() {}

	public GroupDate(int no, Date groupDate, String place, int groupNo, Group group) {
		super();
		this.no = no;
		this.groupDate = groupDate;
		this.place = place;
		this.groupNo = groupNo;
		this.group = group;
	}

	public GroupDate(int no, Date groupDate, String place, int groupNo) {
		super();
		this.no = no;
		this.groupDate = groupDate;
		this.place = place;
		this.groupNo = groupNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public Date getGroupDate() {
		return groupDate;
	}

	public void setGroupDate(Date groupDate) {
		this.groupDate = groupDate;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
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

	@Override
	public String toString() {
		return "GroupDate [no=" + no + ", groupDate=" + groupDate + ", place=" + place + ", groupNo=" + groupNo
				+ ", group=" + group + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((group == null) ? 0 : group.hashCode());
		result = prime * result + ((groupDate == null) ? 0 : groupDate.hashCode());
		result = prime * result + groupNo;
		result = prime * result + no;
		result = prime * result + ((place == null) ? 0 : place.hashCode());
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
		GroupDate other = (GroupDate) obj;
		if (group == null) {
			if (other.group != null)
				return false;
		} else if (!group.equals(other.group))
			return false;
		if (groupDate == null) {
			if (other.groupDate != null)
				return false;
		} else if (!groupDate.equals(other.groupDate))
			return false;
		if (groupNo != other.groupNo)
			return false;
		if (no != other.no)
			return false;
		if (place == null) {
			if (other.place != null)
				return false;
		} else if (!place.equals(other.place))
			return false;
		return true;
	}
	
	
}
