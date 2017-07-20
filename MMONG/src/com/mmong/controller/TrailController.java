package com.mmong.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.TrailService;
import com.mmong.vo.Member;
import com.mmong.vo.Trail;

@Controller
@RequestMapping("/trail/")
public class TrailController {
	@Autowired
	private TrailService trailService;
	
	@RequestMapping("insertTrail")
	public ModelAndView insertTrail(@ModelAttribute Trail trail, BindingResult errors) {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId = member.getMemberId();
		trail.setMemberId(memberId);
		
		trailService.insertTrail(trail);
		
		return new ModelAndView("redirect:/trail/searchTrailByNo.do", "no", trail.getNo());
	}
	
	@RequestMapping("searchTrailByNo")
	public ModelAndView searchTrailByNo(@RequestParam(required=false) int no) {
		Trail trail = trailService.searchTrailByNo(no);
		return new ModelAndView("map/search_trail_test.tiles", "trail", trail);
	}
	
	@RequestMapping("searchTrailByTitle")
	@ResponseBody
	public List<Trail> searchTrailByTitle(@RequestParam(required=false) String title) {
		List<Trail> trail = trailService.searchTrailByTitle(title);
		//return new ModelAndView("map/search_trail_test2.tiles", "trail", trail);

		return trail;
	}
	
	@RequestMapping("searchTrailByCategory")
	@ResponseBody
	public List<Trail> searchTrailByCategory(@RequestParam(required=false) String category) {
		List<Trail> trail = trailService.searchTrailByCategory(category);

		return trail;
	}
	
	@RequestMapping("searchTrailByRouteContent")
	@ResponseBody
	public List<Trail> searchTrailByRouteContent(@RequestParam(required=false) String routeContent) {
		List<Trail> trail = trailService.searchTrailByRouteContent(routeContent);

		return trail;
	}
	
	@RequestMapping("updateTrail")
	public ModelAndView updateTrail(@ModelAttribute Trail trail, BindingResult errors) {
		trailService.updateTrail(trail);
		
		return new ModelAndView("map/search_trail_test.tiles", "trail", trail);
	}
	
	@RequestMapping("deleteTrailByNo")
	@ResponseBody
	public String deleteTrailByNo(@RequestParam(required=false) int no) {
		trailService.deleteTrailByNo(no);
		
		return "success";
	}
}
