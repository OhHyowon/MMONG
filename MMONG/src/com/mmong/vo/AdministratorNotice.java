package com.mmong.vo;

import java.io.Serializable;
import java.util.Date;

public class AdministratorNotice  implements Serializable {
	private int no;
	private String title;
	private String content;
	private Date adminDate;
	
	private String adminId;
	private Administrator administrator;
	
	public AdministratorNotice() {}

	public AdministratorNotice(int no, String title, String content, Date adminDate, String adminId) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.adminDate = adminDate;
		this.adminId = adminId;
	}

	public AdministratorNotice(int no, String title, String content, Date adminDate, String adminId,
			Administrator administrator) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.adminDate = adminDate;
		this.adminId = adminId;
		this.administrator = administrator;
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

	public Date getAdminDate() {
		return adminDate;
	}

	public void setAdminDate(Date adminDate) {
		this.adminDate = adminDate;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public Administrator getAdministrator() {
		return administrator;
	}

	public void setAdministrator(Administrator administrator) {
		this.administrator = administrator;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adminDate == null) ? 0 : adminDate.hashCode());
		result = prime * result + ((adminId == null) ? 0 : adminId.hashCode());
		result = prime * result + ((administrator == null) ? 0 : administrator.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + no;
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
		AdministratorNotice other = (AdministratorNotice) obj;
		if (adminDate == null) {
			if (other.adminDate != null)
				return false;
		} else if (!adminDate.equals(other.adminDate))
			return false;
		if (adminId == null) {
			if (other.adminId != null)
				return false;
		} else if (!adminId.equals(other.adminId))
			return false;
		if (administrator == null) {
			if (other.administrator != null)
				return false;
		} else if (!administrator.equals(other.administrator))
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (no != other.no)
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
		return "AdministratorNotice [no=" + no + ", title=" + title + ", content=" + content + ", adminDate="
				+ adminDate + ", adminId=" + adminId + ", administrator=" + administrator + "]";
	}
		
}
