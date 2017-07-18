package com.mmong.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import com.mmong.service.impl.BoardPictureServiceImpl;
import com.mmong.service.impl.BoardServiceImpl;
import com.mmong.service.impl.ReplyServiceImpl;
import com.mmong.validation.ReplyRegisterValidator;
import com.mmong.vo.Board;
import com.mmong.vo.BoardPicture;
import com.mmong.vo.Member;
import com.mmong.vo.Reply;

@Controller
@RequestMapping("group/reply/")
public class ReplyController {

	@Autowired
	private ReplyServiceImpl replyService; // 완성되면 Impl말고 service로 바꾸기
	@Autowired
	private BoardServiceImpl boardService;
	@Autowired
	private BoardPictureServiceImpl BPService;
	
	/*리플 등록*/
	@RequestMapping("register")
	public String insertReply(@ModelAttribute Reply reply, BindingResult errors,
											@RequestParam int boardNo,
											HttpServletRequest request,
											HttpSession session,
											ModelMap map){
		int groupNo=(int) session.getAttribute("groupNo");
		ReplyRegisterValidator validator = new ReplyRegisterValidator();
		validator.validate(reply, errors);
		
		if(errors.hasErrors()){
			Board board = boardService.selectBoard(boardNo);
			boardService.updateBoard(board);
			board=boardService.selectBoard(boardNo);

			List<BoardPicture> bP = BPService.selectBPByBoardNo(boardNo);
			ArrayList<String> nameList = new ArrayList<>();  // 업로드 된 파일명 저장할 list

			for(int i =0; i<bP.size(); i++){
				nameList.add(bP.get(i).getRoute()); 
			}
		
			String memberId=board.getMemberId(); // 게시판 쓴 사람의 Id
			String boardNickname=boardService.selectNickNameByMemberId(memberId, boardNo);
			List<Reply> replyList = replyService.selectReplyByBoardNo(boardNo); 
			
			int replyNo;
			ArrayList<String> replyNickname=new ArrayList<>();
			for(int i =0; i<replyList.size(); i++){
				replyNo=replyList.get(i).getNo();
				String replyMemberId=replyService.selectMemberId(replyNo); // 리플 쓴 사람의 Id
				replyNickname.add(replyService.selectNickNameByNo(replyNo, replyMemberId));
			}

			map.addAttribute("replyNickname",replyNickname);
			map.addAttribute("replyList", replyList);
			map.addAttribute("nameList", nameList);
			map.addAttribute("board", board);
			map.addAttribute("boardNickname", boardNickname);
		
			return "group/board/board_view.tiles";
		}
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId=member.getMemberId();

		Date date = new Date();
		
		reply.setGroupNo(groupNo);
		reply.setMemberId(loginId);
		reply.setReplyDate(date);
		reply.setBoardNo(boardNo);
		
		replyService.insertReply(reply);
	
		List<Reply> replyList =replyService.selectReplyByBoardNo(boardNo); // 게시물번호로 댓글 가져오기
		Board board = boardService.selectBoard(boardNo);
		
		int replyNo;
		ArrayList<String> replyNickname=new ArrayList<>();
		for(int i =0; i<replyList.size(); i++){
			replyNo=replyList.get(i).getNo();
			String replyMemberId=replyService.selectMemberId(replyNo); // 리플 쓴 사람의 Id
			replyNickname.add(replyService.selectNickNameByNo(replyNo, replyMemberId));
		}
		
		map.addAttribute("replyNickname",replyNickname);
		map.addAttribute("replyList", replyList);
		map.addAttribute("board", board);
		
		return "redirect:/group/board/board_view.do?boardNo="+boardNo;
	}
	
	/*리플 수정*/
	@RequestMapping("replyUpdate")
	public String replyUpadate(@ModelAttribute Reply reply, BindingResult errors,
											HttpServletRequest request,
											HttpSession session,
											ModelMap map){
	
		int boardNo=reply.getBoardNo();
		
		ReplyRegisterValidator validator = new ReplyRegisterValidator();
		validator.validate(reply, errors);
		if(errors.hasErrors()){
			
			Board board=boardService.selectBoard(boardNo);

			List<BoardPicture> bP = BPService.selectBPByBoardNo(boardNo);
			ArrayList<String> nameList = new ArrayList<>();  // 업로드 된 파일명 저장할 list

			for(int i =0; i<bP.size(); i++){
				nameList.add(bP.get(i).getRoute()); 
			}

			String memberId=board.getMemberId(); // 게시판 쓴 사람의 Id
			
			String boardNickname=boardService.selectNickNameByMemberId(memberId, boardNo);
			
			List<Reply> replyList = replyService.selectReplyByBoardNo(boardNo); 
			
			int replyNo;
			ArrayList<String> replyNickname=new ArrayList<>();
			for(int i =0; i<replyList.size(); i++){
				replyNo=replyList.get(i).getNo();
				String replyMemberId=replyService.selectMemberId(replyNo); // 리플 쓴 사람의 Id
				replyNickname.add(replyService.selectNickNameByNo(replyNo, replyMemberId));
			}

			map.addAttribute("replyNickname",replyNickname);
			map.addAttribute("replyList", replyList);
			map.addAttribute("nameList", nameList);
			map.addAttribute("board", board);
			map.addAttribute("boardNickname", boardNickname);
		
			return "group/board/board_view.tiles";
		}
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String loginId=member.getMemberId();

		Date date = new Date(); // 수정된 시간
		
		reply.setMemberId(loginId);
		reply.setReplyDate(date);
		reply.setBoardNo(boardNo);

		replyService.updateReply(reply);
		
		List<Reply> replyList =replyService.selectReplyByBoardNo(boardNo); // 게시물번호로 댓글 가져오기
		Board board = boardService.selectBoard(boardNo);
		
		int replyNo;
		ArrayList<String> replyNickname=new ArrayList<>();
		for(int i =0; i<replyList.size(); i++){
			replyNo=replyList.get(i).getNo();
			String replyMemberId=replyService.selectMemberId(replyNo); // 리플 쓴 사람의 Id
			replyNickname.add(replyService.selectNickNameByNo(replyNo, replyMemberId));
		}

		map.addAttribute("replyNickname",replyNickname);
		map.addAttribute("replyList", replyList);
		map.addAttribute("board", board);
		
		return "redirect:/group/board/board_view.do?boardNo="+boardNo;
	}
	
	/*리플 삭제*/
	@RequestMapping("deleteReply")
	@ResponseBody
	public String deleteReply(@RequestParam int replyNo){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		replyService.deleteReply(replyNo,memberId);
		
		return "1";
	}
	
	/*내가 쓴 리플 목록*/
	@RequestMapping("myReplyList")
	public String  selectMyReply(@RequestParam(value="page", defaultValue="1")int page,HttpSession session,ModelMap map){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		int groupNo=(int) session.getAttribute("groupNo");
		
		HashMap<String,Object> pagingMap=null;
		
		pagingMap=replyService.selectMyReply(page,memberId,groupNo);
		
		map.addAttribute("boardNoList", pagingMap.get("boardNoList"));
		map.addAttribute("boardTitle", pagingMap.get("boardTitle"));
		map.addAttribute("myReplyList", pagingMap.get("myReplyList"));
		map.addAttribute("pageBean", pagingMap.get("pageBean"));
		
		return "group/board/reply_mine.tiles";
	}
	
	/*내가 쓴 리플 선택 삭제*/
	@RequestMapping("deleteMyReplyList")
	@ResponseBody
	public String deleteMyReplyList(@RequestParam List<Integer> replyNoList){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		
		int replyNo;
		
		for(int i =0; i<replyNoList.size(); i++){
			replyNo=replyNoList.get(i);
			replyService.deleteReply(replyNo, memberId);
		}
		
		return "1";
	}
}
