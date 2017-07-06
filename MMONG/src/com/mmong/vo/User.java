package com.mmong.vo;

import java.io.Serializable;

public class User implements Serializable {
	private String userId;
	private String userPwd;
	private String userAuthority;
	private int userEnable;
	
	public User() {}
	public User(String userId, String userPwd, String userAuthority, int userEnable) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userAuthority = userAuthority;
		this.userEnable = userEnable;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserAuthority() {
		return userAuthority;
	}

	public void setUserAuthority(String userAuthority) {
		this.userAuthority = userAuthority;
	}

	public int getUserEnable() {
		return userEnable;
	}

	public void setUserEnable(int userEnable) {
		this.userEnable = userEnable;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((userAuthority == null) ? 0 : userAuthority.hashCode());
		result = prime * result + userEnable;
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		result = prime * result + ((userPwd == null) ? 0 : userPwd.hashCode());
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
		User other = (User) obj;
		if (userAuthority == null) {
			if (other.userAuthority != null)
				return false;
		} else if (!userAuthority.equals(other.userAuthority))
			return false;
		if (userEnable != other.userEnable)
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		if (userPwd == null) {
			if (other.userPwd != null)
				return false;
		} else if (!userPwd.equals(other.userPwd))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userPwd=" + userPwd + ", userAuthority=" + userAuthority + ", userEnable="
				+ userEnable + "]";
	}



}
