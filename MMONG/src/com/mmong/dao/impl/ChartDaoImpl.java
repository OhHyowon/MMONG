package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.ChartDao;
import com.mmong.vo.Chart;

@Repository
public class ChartDaoImpl implements ChartDao{
	
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.chartMapper."+id;
	}
	
	/**
	 * 	임시 진료기록 등록
	 */
	@Override
	public int insertChart(Chart chart) {
		
		return session.insert(makeSqlId("insertChart"),chart);
	}
	
	/**
	 * 	진료기록 추가 및 업데이트
	 */
	@Override
	public void updateChart(Map map) {
	
		session.update(makeSqlId("updateChart"),map);
	}
	
	/**
	 * 	진료기록 삭제
	 */
	@Override
	public void deleteChart(Map map){
		session.delete(makeSqlId("deleteChart"),map);
	}
	
	/**
	 *  no와 writer로 진료기록 조회
	 */
	@Override
	public Chart selectChartByNoAndWriter(Map map) {
		
		return session.selectOne(makeSqlId("selectChartByNoAndWriter"),map);
	}
	
	/**
	 *  id로 진료기록 조회
	 */
	@Override
	public List<Chart> selectChartByWriter(String id) {
		
		return session.selectList(makeSqlId("selectChartByWriter"),id);
	}


}
