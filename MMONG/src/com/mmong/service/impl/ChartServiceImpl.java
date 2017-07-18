package com.mmong.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mmong.dao.ChartDao;
import com.mmong.service.ChartService;
import com.mmong.vo.Chart;

@Service
public class ChartServiceImpl implements ChartService{
	
	@Autowired
	private ChartDao dao;
	
	private ChartService service;
	
	/**
	 * 	진료기록 추가 (임시로 건강기록 만들때 같이 만들어줌)
	 */
	@Override
	public int insertChart(Chart chart) {
		
		
		return dao.insertChart(chart);
	}
	
	/**
	 * 	실질적인 진료기록 추가와 업데이트
	 */
	@Override
	public void updateChart(Map map) {

		dao.updateChart(map);
	}
	
	/**
	 * 	진료기록 삭제
	 */
	@Override
	public void deleteChart(Map map) {
		dao.deleteChart(map);
	}
	
	/**
	 * 	no랑 writer로 진료기록 조회
	 */
	@Override
	public Chart selectChartByNoAndWriter(Map map) {
		
		return dao.selectChartByNoAndWriter(map);
	}
	
	/**
	 *  id로 진료기록 추가
	 */
	@Override
	public List<Chart> selectChartByWriter(String id) {
		
		return dao.selectChartByWriter(id);
	}

	
}
