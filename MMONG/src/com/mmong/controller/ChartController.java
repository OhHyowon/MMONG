package com.mmong.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mmong.service.CalendarService;
import com.mmong.service.impl.ChartServiceImpl;
import com.mmong.service.impl.HealthServiceImpl;
import com.mmong.vo.Calendar;
import com.mmong.vo.Chart;
import com.mmong.vo.Member;

@Controller
@RequestMapping("/chart/")
public class ChartController {
	@Autowired
	private HealthServiceImpl service;

	@Autowired
	private ChartServiceImpl service2;
	
	@Autowired
	private CalendarService calendarService;
	
	// 체크박스로 누른 전체 진료기록 조회
	@RequestMapping("chartlist")
	@ResponseBody
	public List chartList(@RequestParam List<Integer> checkedList){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
		List<Chart> list = new ArrayList<Chart>();
		
		String writer = member.getMemberId();	// 여기다가 member.getWriter 넣을것 일단 테스트 
		HashMap<String,Object> map = new HashMap<>();
		
		Chart chart = new Chart();
		
		for(int i=0; i<checkedList.size();i++){
		map.put("writer",writer);
		map.put("no", checkedList.get(i));
		chart = service2.selectChartByNoAndWriter(map);
		
		// 선택한 건강기록에 댓글이 없는거 걸러내기
		if(chart != null){
			list.add(chart);
			}
		}
		return list;
	}
	
	// 이름으로만 조회 (체크박스 없이 전체차트 조회 눌렀을때)
	@RequestMapping("selectChartByWriter")
	@ResponseBody
	public List selectChartByWriter(){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		List<Chart> list = new ArrayList<Chart>();
		
		String writer = member.getMemberId();
		
		Chart chart = new Chart();
		
		list = service2.selectChartByWriter(writer);
		
		return list;
	}
	
	// 건강기록 눌렀을때 진료기록 조회
	@RequestMapping("chartSelect")
	@ResponseBody
	public Chart selectChartByNo(@RequestParam int chartNo){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Chart chart = new Chart();
		HashMap<String,Object> map = new HashMap<>();

		map.put("no", chartNo);
		map.put("writer", member.getMemberId());
		
		chart = service2.selectChartByNoAndWriter(map);
		
		return chart;
	}
	
	// 진료기록 등록
	@RequestMapping("chartInsert")
	@ResponseBody
	public Chart insertChartList(@RequestParam String chartContent, 
								@RequestParam int chartNo, 
								@RequestParam @DateTimeFormat(pattern="yyyy-MM-dd") Date chartDate){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		HashMap<String,Object> map = new HashMap<>();
		
		Chart chart = new Chart(0,chartDate,member.getMemberId(),chartContent,chartNo);
		
		service2.insertChart(chart);

		//*** 달력에 자동 입력
		Calendar calendar = new Calendar(0, chartContent.substring(0, 4), chartContent, 1, chartDate, chartDate, 0, "", 0, member.getMemberId());
		calendarService.insertSchedule(calendar);
		
		
		map.put("no", chartNo);
		map.put("writer", member.getMemberId());
		
		chart = service2.selectChartByNoAndWriter(map);

		return chart;
	
	}
	
	// 진료기록 삭제
	@RequestMapping("chartDelete")
	@ResponseBody
	public void deleteChart(@RequestParam int chartNo){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		HashMap<String,Object> map = new HashMap<>();
		Date date = new Date();
		
		map.put("writer", member.getMemberId());
		map.put("no", chartNo);
		
		service2.deleteChart(map);
	}
	
	// 진료기록 수정
	@RequestMapping("chartModify")
	@ResponseBody
	public void modifyChart(@RequestParam int healthNo, String content,
							@RequestParam @DateTimeFormat(pattern="yyyy-MM-dd") Date chartDate){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		HashMap<String,Object> map = new HashMap<>();
		
		map.put("writer", member.getMemberId());
		map.put("no", healthNo);
		map.put("date", chartDate);
		map.put("content", content);
		
		service2.updateChart(map);
		
	}
}
