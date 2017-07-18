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
	private ChartServiceImpl service2;
	
	// 전체 진료기록 조회
	@RequestMapping("chartlist")
	@ResponseBody
	public List chartList(@RequestParam List<Integer> checkedList){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
		List<Chart> list = new ArrayList<Chart>();
		
		String writer = member.getMemberId();	// 접속해 있는 Id
		HashMap<String,Object> map = new HashMap<>();	// DB에 넣을 값들 map생성
		
		Chart chart = new Chart(); // service에서 리턴 받을 값 만들어줌
		
		for(int i=0; i<checkedList.size();i++){	// 돌려서 차트 list를 만들자
		map.put("writer",writer); // 비교할 id
		map.put("no", checkedList.get(i));	// 해당 건강기록에 대한 진료기록 뽑을 no
		chart = service2.selectChartByNoAndWriter(map); // 글 번호와 id를 이용하여 진료기록을 불러온다.
		
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
		
		String writer = member.getMemberId();	//이름으로 조회하기위한 값 변수에 저장
		
		list = service2.selectChartByWriter(writer);
		
		return list;
	}
	
	// 건강기록 눌렀을때 진료기록 조회
	@RequestMapping("chartSelect")
	@ResponseBody
	public Chart selectChartByNo(@RequestParam int chartNo){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Chart chart = new Chart();	// 리턴해주기위한 chart객체 생성
		HashMap<String,Object> map = new HashMap<>();
		
		// Mapper에 식별값들을 넣어주자
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
		
		Chart chart = new Chart(0,chartDate,member.getMemberId(),chartContent,chartNo);	// 생성할 객체를 만들어주자
		
		service2.insertChart(chart); // 위에꺼 객체 DB에 넣자.
		
		// 넣은 객체를 리턴해주기 위한 여정
		map.put("no", chartNo);
		map.put("writer", member.getMemberId());
		
		// no와 id를 이용해서 지금 등록한 객체 조회
		chart = service2.selectChartByNoAndWriter(map);

		return chart;
	
	}
	
	// 진료기록 삭제
	@RequestMapping("chartDelete")
	@ResponseBody
	public void deleteChart(@RequestParam int chartNo){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		HashMap<String,Object> map = new HashMap<>();
		
		//삭제할 애 no와 id로 찾자
		map.put("writer", member.getMemberId());
		map.put("no", chartNo);
		
		// db에서 삭제해주자  
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
