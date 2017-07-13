package com.mmong.service;

import java.util.Map;

import com.mmong.vo.Chart;

public interface ChartService {
	
	
	// 임시 진료기록 만들기
	public int insertChart(Chart chart);
	
	// 실질적인 진료기록 추가와 업데이트
	public void updateChart(Map map);
	
	// 진료기록 삭제
	public void deleteChart(Map map); 
	
	// no랑 writer로 진료기록 조회
	public Chart selectChartByNoAndWriter(Map map);
}
