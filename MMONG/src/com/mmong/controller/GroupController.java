package com.mmong.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mmong.service.GroupService;
import com.mmong.vo.Group;

@Controller
@RequestMapping("/group/")
public class GroupController {
	@Autowired
	private GroupService groupService;
	
	@RequestMapping("mygroup")
	public ModelAndView searchMyGroupById(@RequestParam(required=false) String userId){
		//내가 소속된 소모임 뿌리는 로직
		return new ModelAndView("/content/group/mygroup");
	}
	
	public ModelAndView insertGroup(@ModelAttribute Group group){
		groupService.insertGroup(group);
		return new ModelAndView("");
	}
}
