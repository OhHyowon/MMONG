package com.mmong.vo;

import java.io.Serializable;

public class Trail implements Serializable{
	private int no;
	private String category;
	private String route1;
	private String route2;
	private String route3;
	private String route4;
	private String route5;
	private String title;
	private String content;
	
	private String memberId;
	private Member member;
	
	public Trail() {}

	public Trail(int no, String category, String route1, String route2, String route3, String route4, String route5, String title, String content, String memberId, Member member) {
		super();
		this.no = no;
		this.category = category;
		this.route1 = route1;
		this.route2 = route2;
		this.route3 = route3;
		this.route4 = route4;
		this.route5 = route5;
		this.title = title;
		this.content = content;
		this.memberId = memberId;
		this.member = member;
	}

	public Trail(int no, String category, String route1, String route2, String route3, String route4, String route5,String title, String content, String memberId) {
		super();
		this.no = no;
		this.category = category;
		this.route1 = route1;
		this.route2 = route2;
		this.route3 = route3;
		this.route4 = route4;
		this.route5 = route5;
		this.title = title;
		this.content = content;
		this.memberId = memberId;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getRoute1() {
		return route1;
	}

	public void setRoute1(String route1) {
		this.route1 = route1;
	}

	public String getRoute2() {
		return route2;
	}

	public void setRoute2(String route2) {
		this.route2 = route2;
	}

	public String getRoute3() {
		return route3;
	}

	public void setRoute3(String route3) {
		this.route3 = route3;
	}

	public String getRoute4() {
		return route4;
	}

	public void setRoute4(String route4) {
		this.route4 = route4;
	}

	public String getRoute5() {
		return route5;
	}

	public void setRoute5(String route5) {
		this.route5 = route5;
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
		result = prime * result + ((category == null) ? 0 : category.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
		result = prime * result + ((route1 == null) ? 0 : route1.hashCode());
		result = prime * result + ((route2 == null) ? 0 : route2.hashCode());
		result = prime * result + ((route3 == null) ? 0 : route3.hashCode());
		result = prime * result + ((route4 == null) ? 0 : route4.hashCode());
		result = prime * result + ((route5 == null) ? 0 : route5.hashCode());
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
		Trail other = (Trail) obj;
		if (category == null) {
			if (other.category != null)
				return false;
		} else if (!category.equals(other.category))
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
		if (route1 == null) {
			if (other.route1 != null)
				return false;
		} else if (!route1.equals(other.route1))
			return false;
		if (route2 == null) {
			if (other.route2 != null)
				return false;
		} else if (!route2.equals(other.route2))
			return false;
		if (route3 == null) {
			if (other.route3 != null)
				return false;
		} else if (!route3.equals(other.route3))
			return false;
		if (route4 == null) {
			if (other.route4 != null)
				return false;
		} else if (!route4.equals(other.route4))
			return false;
		if (route5 == null) {
			if (other.route5 != null)
				return false;
		} else if (!route5.equals(other.route5))
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
		return "Trail [no=" + no + ", category=" + category + ", route1=" + route1 + ", route2=" + route2 + ", route3="
				+ route3 + ", route4=" + route4 + ", route5=" + route5 + ", title=" + title + ", content=" + content
				+ ", memberId=" + memberId + ", member=" + member + "]";
	}
	
	
}