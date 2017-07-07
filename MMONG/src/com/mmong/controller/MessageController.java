package com.mmong.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mmong.service.MessageService;
import com.mmong.validation.ReplyMessageValidator;
import com.mmong.validation.SendMessageValidator;
import com.mmong.vo.Member;
import com.mmong.vo.Message;

@Controller
@RequestMapping("/message/")
public class MessageController {

	@Autowired
	private MessageService service;
	
	/**
	 * 쪽지보내기
	 * @param mess
	 * @param errors
	 * @param session
	 * @return
	 */
	@RequestMapping("insert")
	public ModelAndView insertMessage(@ModelAttribute Message mess, BindingResult errors){
		
		Date date = new Date();
		//String receiveId = "b1b2b3b4";   ////대체될 줄!!!!!!!!!
		String receiveId = "wngus0424";   ////대체될 줄!!!!!!!!!

		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String sendId = member.getMemberId();   

		
		Message message = new Message(0, date, mess.getTitle(), mess.getContent(), 0, sendId, receiveId);
		
		SendMessageValidator valid = new SendMessageValidator();
		valid.validate(message, errors);
		
		if(errors.hasErrors()){
			return new ModelAndView("/content/message/sendMessage");
		}

		service.insertMessage(message);
		
		RedirectView rv = new RedirectView("/MMONG/message/sendSuccess.do");
		rv.setExposeModelAttributes(false);
		
		return new ModelAndView(rv);
	}
	
	/**
	 * 받은 쪽지 목록 - session 통해서 memberId 받는다.
	 * @return
	 */
	@RequestMapping("selectReceiveMsg")
	public String selectReceiveMsg(ModelMap map, @RequestParam(value="page", defaultValue="1") String reqPage){

		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String receiveId = member.getMemberId();
	
		int page = 1;
		page = Integer.parseInt(reqPage);
		
	
		Map<String, Object> pagebeanMap = service.selectReceiveMsg(receiveId, page);
		
		map.addAttribute("receiveList", pagebeanMap.get("list"));
		map.addAttribute("pageBean", pagebeanMap.get("pageBean"));
		
		return "content/message/selectReceiveMsgList";
	}
	
	/**
	 * 보낸 쪽지 목록
	 * @param session
	 * @param map
	 * @param reqPage
	 * @return
	 */
	@RequestMapping("selectSendMsg")
	public String selectSendMsg(ModelMap map, @RequestParam(value="page", defaultValue="1") String reqPage){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String sendId = member.getMemberId();
	
		int page = 1;
		page = Integer.parseInt(reqPage);
		
		Map<String, Object> pagebeanMap = service.selectSendMsg(sendId, page);
		
		map.addAttribute("sendList", pagebeanMap.get("list"));
		map.addAttribute("pageBean", pagebeanMap.get("pageBean"));
		
		return "content/message/selectSendMsgList";
	}
	
	
	/**
	 * 메세지 삭제하기
	 * @param no
	 * @return
	 */
	@RequestMapping("deleteMsg")
	@ResponseBody
	public String deleteMsg(@RequestParam List no){

		List<Object> msgNo = new ArrayList<Object>();
		for(int i=1; i<no.size(); i++){
			msgNo.add(no.get(i));
		}

		if(no.get(0).equals("sendList")){ //보낸 쪽지함에서 삭제를 눌렀을 때
			service.deleteSendMessage(msgNo);
		}else if(no.get(0).equals("receiveList")){ //받은 쪽지함에서 삭제를 눌렀을 때
			service.deleteReceiveMessage(msgNo);
		}
		
		return "1";
	}
	
	/**
	 * 받은 쪽지 조회
	 * @param no
	 * @return
	 */
	@RequestMapping("viewReceiveMsg")
	public String viewReceiveMsg(@RequestParam int no, ModelMap map){
		
		service.updateMsgState(no);
		Message message = service.viewReceiveMsg(no);
		
		map.addAttribute("message", message);
		return "content/message/viewReceiveMsg";
	}
	
	/**
	 * 보낸 쪽지 조회
	 * @param no
	 * @param map
	 * @return
	 */
	@RequestMapping("viewSendMsg")
	public String viewSendMsg(@RequestParam int no, ModelMap map){
		
		Message message = service.viewSendMsg(no);
		
		map.addAttribute("message", message);
		
		return "content/message/viewSendMsg";
	}
	
	/**
	 * 받은 쪽지 view -> 답장보내기 jsp 이동 중간 거치는 컨트롤러 - 보낼 사람의 Id와 닉네임 가져오기
	 * @param no
	 * @return
	 */
	@RequestMapping("selectMsgIdNick")
	public String selectMsgIdNick(@RequestParam int no, ModelMap map){
		
		Message message = service.selectMsgIdNick(no);

		map.addAttribute("message", message);
		map.addAttribute("no", no);
		return "content/message/replyMessage";
	}
	
	/**
	 * 답장 보내기
	 * @return
	 */
	@RequestMapping("reply")
	public ModelAndView reply(@ModelAttribute("mess") Message mess, BindingResult errors, ModelMap map, @RequestParam String receiveId, @RequestParam int no){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Date date = new Date();
		String sendId = member.getMemberId(); 
		
		Message message = new Message(0, date, mess.getTitle(), mess.getContent(), 0, sendId, receiveId);

		ReplyMessageValidator valid = new ReplyMessageValidator();
		valid.validate(message, errors);

		if(errors.hasErrors()){
			Message msg = service.selectMsgIdNick(no);
			map.addAttribute("message", msg);
			map.addAttribute("no", no);
			return new ModelAndView("/content/message/replyMessage");
		}
		
		service.insertMessage(message);
		
		RedirectView rv = new RedirectView("/MMONG/message/sendSuccess.do");
		rv.setExposeModelAttributes(false);
		
		return new ModelAndView(rv);
	}
	
	/**
	 * 보낸 쪽지함에서 쪽지 검색하기
	 * @param searchOpt
	 * @param search
	 * @param session
	 * @param map
	 * @param reqPage
	 * @return
	 */
	@RequestMapping("searchSendMsg")
	public String searchSendMsg(@RequestParam String searchOpt, @RequestParam String search, ModelMap map, @RequestParam(value="page", defaultValue="1") String reqPage){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String sendId = member.getMemberId();
	
		int page = 1;
		page = Integer.parseInt(reqPage);
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("id", sendId);
		hashMap.put("searchOpt", searchOpt);
		hashMap.put("search", search);
		
		Map<String, Object> pagebeanMap = service.searchSendMsg(hashMap, page);
		
		map.addAttribute("searchSendList", pagebeanMap.get("list"));
		map.addAttribute("pageBean", pagebeanMap.get("pageBean"));
		map.addAttribute("search_opt", searchOpt);
		map.addAttribute("search_txt", search);
		
		return "content/message/searchSendMsgResult"; 
	}
	
	/**
	 * 받은 쪽지함에서 쪽지 검색하기
	 * @param searchOpt
	 * @param search
	 * @param session
	 * @param map
	 * @param reqPage
	 * @return
	 */
	@RequestMapping("searchReceiveMsg")
	public String searchReceiveMsg(@RequestParam String searchOpt, @RequestParam String search, ModelMap map, @RequestParam(value="page", defaultValue="1") String reqPage){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String receiveId = member.getMemberId();
	
		int page = 1;
		page = Integer.parseInt(reqPage);
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("id", receiveId);
		hashMap.put("searchOpt", searchOpt);
		hashMap.put("search", search);
		
		Map<String, Object> pagebeanMap = service.searchReceiveMsg(hashMap, page);
		
		map.addAttribute("searchReceiveList", pagebeanMap.get("list"));
		map.addAttribute("pageBean", pagebeanMap.get("pageBean"));
		map.addAttribute("search_opt", searchOpt);
		map.addAttribute("search_txt", search);
		
		return  "content/message/searchReceiveMsgResult"; 
	}
}
