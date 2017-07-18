package com.mmong.dao;

import java.util.List;
import java.util.Map;

import com.mmong.vo.Chart;
import com.mmong.vo.Health;

public interface ChartDao {
	
	
	
	/**
	 * 	임시 진료기록 추가
	 */
	int insertChart(Chart chart);
	
	/**
	 *  진료기록 추가및 업데이트
	 */
	void updateChart(Map map);
	
	/**
	 *  진료기록 삭제
	 */
	void deleteChart(Map map);
	
	/**
	 * 	no랑 writer로 진료기록 조회
	 */
	Chart selectChartByNoAndWriter(Map map);
	
	/**
	 * 	id로 차트 조회
	 */
	List<Chart> selectChartByWriter(String id);
	
}
