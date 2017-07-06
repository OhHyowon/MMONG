package com.mmong.vo;

import java.io.Serializable;

public class WeatherMessage implements Serializable{

	private int no;
	private String content;
	
	public WeatherMessage() {}
	public WeatherMessage(int no, String content) {
		super();
		this.no = no;
		this.content = content;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
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
		WeatherMessage other = (WeatherMessage) obj;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (no != other.no)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "WeatherMessage [no=" + no + ", content=" + content + "]";
	}
	
	
	
	
	
}
