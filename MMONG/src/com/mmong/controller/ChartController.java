package com.mmong.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mmong.service.impl.ChartServiceImpl;
import com.mmong.service.impl.HealthServiceImpl;
import com.mmong.vo.Chart;
import com.mmong.vo.Member;

@Controller
@RequestMapping("/chart/")
public class ChartController {
	@Autowired
	private HealthServiceImpl service;

	@Autowired
	private ChartServiceImpl service2;
	
	// 체크박스로 누른 전체 진료기록 조회
	@RequestMapping("chartlist")
	@ResponseBody
	public List chartList(@RequestParam List<Integer> checkedList){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
		List<Chart> list = new ArrayList<Chart>();
		
		String writer = member.getMemberId();	// 여기다가 member.getWriter 넣을것 일단 테스트 
		HashMap<String,Object> map = new HashMap<>();
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd"); 
		
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
	public void insertChartList(@RequestParam String chartContent, 
								@RequestParam int chartNo, 
								@RequestParam @DateTimeFormat(pattern="yyyy-MM-dd") Date chartDate){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		member.getMemberId();
		
		Chart chart = new Chart(0,chartDate,member.getMemberId(),chartContent,chartNo);
		
		service2.insertChart(chart);
	
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
