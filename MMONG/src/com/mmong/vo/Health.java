package com.mmong.vo;

import java.io.Serializable;


public class Health implements Serializable {

	private int no;
	private String content;
	private String done;
	private String gender;
	

	private int chartNo;
	private Chart chart;
	
	public Health() {}

	public Health(int no, String content, String done, String gender, int chartNo, Chart chart) {
		super();
		this.no = no;
		this.content = content;
		this.done = done;
		this.gender = gender;
		this.chartNo = chartNo;
		this.chart = chart;
	}

	public Health(int no, String content, String done, String gender, int chartNo) {
		super();
		this.no = no;
		this.content = content;
		this.done = done;
		this.gender = gender;
		this.chartNo = chartNo;
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

	public String getDone() {
		return done;
	}

	public void setDone(String done) {
		this.done = done;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getChartNo() {
		return chartNo;
	}

	public void setChartNo(int chartNo) {
		this.chartNo = chartNo;
	}

	public Chart getChart() {
		return chart;
	}

	public void setChart(Chart chart) {
		this.chart = chart;
	}

	@Override
	public String toString() {
		return "Health [no=" + no + ", content=" + content + ", done=" + done + ", gender=" + gender + ", chartNo="
				+ chartNo + ", chart=" + chart + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((chart == null) ? 0 : chart.hashCode());
		result = prime * result + chartNo;
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((done == null) ? 0 : done.hashCode());
		result = prime * result + ((gender == null) ? 0 : gender.hashCode());
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
		Health other = (Health) obj;
		if (chart == null) {
			if (other.chart != null)
				return false;
		} else if (!chart.equals(other.chart))
			return false;
		if (chartNo != other.chartNo)
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (done == null) {
			if (other.done != null)
				return false;
		} else if (!done.equals(other.done))
			return false;
		if (gender == null) {
			if (other.gender != null)
				return false;
		} else if (!gender.equals(other.gender))
			return false;
		if (no != other.no)
			return false;
		return true;
	}
	
	
	

	
}
