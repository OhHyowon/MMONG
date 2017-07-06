package com.mmong.vo;
import java.io.Serializable;

public class Administrator implements Serializable {
	private String adminName;
	private String adminPhone; //폰번호
	private String adminEmail;
	
	private String adminId;
	private User adminUser;
	
	public Administrator() {}
	public Administrator(String adminName, String adminPhone, String adminEmail, String adminId) {
		super();
		this.adminName = adminName;
		this.adminPhone = adminPhone;
		this.adminEmail = adminEmail;
		this.adminId = adminId;
	}
	public Administrator(String adminName, String adminPhone, String adminEmail, String adminId, User adminUser) {
		super();
		this.adminName = adminName;
		this.adminPhone = adminPhone;
		this.adminEmail = adminEmail;
		this.adminId = adminId;
		this.adminUser = adminUser;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminPhone() {
		return adminPhone;
	}
	public void setAdminPhone(String adminPhone) {
		this.adminPhone = adminPhone;
	}
	public String getAdminEmail() {
		return adminEmail;
	}
	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public User getAdminUser() {
		return adminUser;
	}
	public void setAdminUser(User adminUser) {
		this.adminUser = adminUser;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adminEmail == null) ? 0 : adminEmail.hashCode());
		result = prime * result + ((adminId == null) ? 0 : adminId.hashCode());
		result = prime * result + ((adminName == null) ? 0 : adminName.hashCode());
		result = prime * result + ((adminPhone == null) ? 0 : adminPhone.hashCode());
		result = prime * result + ((adminUser == null) ? 0 : adminUser.hashCode());
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
		Administrator other = (Administrator) obj;
		if (adminEmail == null) {
			if (other.adminEmail != null)
				return false;
		} else if (!adminEmail.equals(other.adminEmail))
			return false;
		if (adminId == null) {
			if (other.adminId != null)
				return false;
		} else if (!adminId.equals(other.adminId))
			return false;
		if (adminName == null) {
			if (other.adminName != null)
				return false;
		} else if (!adminName.equals(other.adminName))
			return false;
		if (adminPhone == null) {
			if (other.adminPhone != null)
				return false;
		} else if (!adminPhone.equals(other.adminPhone))
			return false;
		if (adminUser == null) {
			if (other.adminUser != null)
				return false;
		} else if (!adminUser.equals(other.adminUser))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Administrator [adminName=" + adminName + ", adminPhone=" + adminPhone + ", adminEmail=" + adminEmail
				+ ", adminId=" + adminId + ", adminUser=" + adminUser + "]";
	}

	
	
}
