package com.mmong.vo;
import java.io.Serializable;

public class Member implements Serializable {
	
	private String memberId;
	private String memberName;
	private String nickName;
	private String memberPhone;
	private String memberEmail;
	private String memberAddress;
	private String memberPicture;
	
	private User memberUser;
	
	public Member(){}

	public Member(String memberId, String memberName, String nickName, String memberPhone, String memberEmail,
			String memberAddress, String memberPicture, User memberUser) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.nickName = nickName;
		this.memberPhone = memberPhone;
		this.memberEmail = memberEmail;
		this.memberAddress = memberAddress;
		this.memberPicture = memberPicture;
		this.memberUser = memberUser;
	}

	public Member(String memberId, String memberName, String nickName, String memberPhone, String memberEmail,
			String memberAddress, String memberPicture) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.nickName = nickName;
		this.memberPhone = memberPhone;
		this.memberEmail = memberEmail;
		this.memberAddress = memberAddress;
		this.memberPicture = memberPicture;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memberAddress == null) ? 0 : memberAddress.hashCode());
		result = prime * result + ((memberEmail == null) ? 0 : memberEmail.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((memberName == null) ? 0 : memberName.hashCode());
		result = prime * result + ((memberPhone == null) ? 0 : memberPhone.hashCode());
		result = prime * result + ((memberPicture == null) ? 0 : memberPicture.hashCode());
		result = prime * result + ((memberUser == null) ? 0 : memberUser.hashCode());
		result = prime * result + ((nickName == null) ? 0 : nickName.hashCode());
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
		Member other = (Member) obj;
		if (memberAddress == null) {
			if (other.memberAddress != null)
				return false;
		} else if (!memberAddress.equals(other.memberAddress))
			return false;
		if (memberEmail == null) {
			if (other.memberEmail != null)
				return false;
		} else if (!memberEmail.equals(other.memberEmail))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (memberName == null) {
			if (other.memberName != null)
				return false;
		} else if (!memberName.equals(other.memberName))
			return false;
		if (memberPhone == null) {
			if (other.memberPhone != null)
				return false;
		} else if (!memberPhone.equals(other.memberPhone))
			return false;
		if (memberPicture == null) {
			if (other.memberPicture != null)
				return false;
		} else if (!memberPicture.equals(other.memberPicture))
			return false;
		if (memberUser == null) {
			if (other.memberUser != null)
				return false;
		} else if (!memberUser.equals(other.memberUser))
			return false;
		if (nickName == null) {
			if (other.nickName != null)
				return false;
		} else if (!nickName.equals(other.nickName))
			return false;
		return true;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getMemberPhone() {
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public String getMemberAddress() {
		return memberAddress;
	}

	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}

	public String getMemberPicture() {
		return memberPicture;
	}

	public void setMemberPicture(String memberPicture) {
		this.memberPicture = memberPicture;
	}

	public User getMemberUser() {
		return memberUser;
	}

	public void setMemberUser(User memberUser) {
		this.memberUser = memberUser;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberName=" + memberName + ", nickName=" + nickName
				+ ", memberPhone=" + memberPhone + ", memberEmail=" + memberEmail + ", memberAddress=" + memberAddress
				+ ", memberPicture=" + memberPicture + ", memberUser=" + memberUser + "]";
	}
	
	
}
