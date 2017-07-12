package com.mmong.vo;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.mmong.util.DateJSONSerializer;

public class Chart implements Serializable {

	private int no;
	@JsonSerialize(using=DateJSONSerializer.class)
	private Date time;
	private String writer;
	private String content;
	
	private int healthNo;
	private Health health;
	
	public Chart(){}

	public Chart(int no, Date time, String writer, String content, int healthNo, Health health) {
		super();
		this.no = no;
		this.time = time;
		this.writer = writer;
		this.content = content;
		this.healthNo = healthNo;
		this.health = health;
	}

	public Chart(int no, Date time, String writer, String content, int healthNo) {
		super();
		this.no = no;
		this.time = time;
		this.writer = writer;
		this.content = content;
		this.healthNo = healthNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getHealthNo() {
		return healthNo;
	}

	public void setHealthNo(int healthNo) {
		this.healthNo = healthNo;
	}

	public Health getHealth() {
		return health;
	}

	public void setHealth(Health health) {
		this.health = health;
	}

	@Override
	public String toString() {
		return "Chart [no=" + no + ", time=" + time + ", writer=" + writer + ", content=" + content + ", healthNo="
				+ healthNo + ", health=" + health + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((health == null) ? 0 : health.hashCode());
		result = prime * result + healthNo;
		result = prime * result + no;
		result = prime * result + ((time == null) ? 0 : time.hashCode());
		result = prime * result + ((writer == null) ? 0 : writer.hashCode());
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
		Chart other = (Chart) obj;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (health == null) {
			if (other.health != null)
				return false;
		} else if (!health.equals(other.health))
			return false;
		if (healthNo != other.healthNo)
			return false;
		if (no != other.no)
			return false;
		if (time == null) {
			if (other.time != null)
				return false;
		} else if (!time.equals(other.time))
			return false;
		if (writer == null) {
			if (other.writer != null)
				return false;
		} else if (!writer.equals(other.writer))
			return false;
		return true;
	}
	
	
}
