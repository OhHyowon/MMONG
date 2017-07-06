package com.mmong.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mmong.service.impl.BoardPictureServiceImpl;
import com.mmong.service.impl.BoardServiceImpl;
import com.mmong.service.impl.ReplyServiceImpl;
import com.mmong.validation.ReplyRegisterValidator;
import com.mmong.vo.Board;
import com.mmong.vo.BoardPicture;
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
	
	@RequestMapping("register")
	public String insertReply(@ModelAttribute Reply reply, BindingResult errors,
											@RequestParam int boardNo,
											HttpServletRequest request,
											HttpSession session,
											ModelMap map){
		
		ReplyRegisterValidator validator = new ReplyRegisterValidator();
		validator.validate(reply, errors);
		if(errors.hasErrors()){
			
			Board board = boardService.selectBoard(boardNo);
			int hit=board.getHit();
			hit++; // 조횟수 올리기
			board.setHit(hit);
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

			
			map.addAttribute("replyList", replyList);
			map.addAttribute("nameList", nameList);
			map.addAttribute("board", board);
			map.addAttribute("boardNickname", boardNickname);
		
			return "content/group/board/board_view";
		}
		
		/*
		 * 로그인 수정 필요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		 */
		String loginId="duflalrjdi"; // test되는 동안에 쓸 로그인 아이디 

		Date date = new Date();
		
		reply.setMemberId(loginId);
		reply.setReplyDate(date);
		reply.setBoardNo(boardNo);
		
		replyService.insertReply(reply);
	
		
		List<Reply> replyList =replyService.selectReplyByBoardNo(boardNo); // 게시물번호로 댓글 가져오기
		Board board = boardService.selectBoard(boardNo);
		
		map.addAttribute("replyList", replyList);
		map.addAttribute("board", board);
		
		return "redirect:/group/board/board_view.do?boardNo="+boardNo;
	}
	
	
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

			
			map.addAttribute("replyList", replyList);
			map.addAttribute("nameList", nameList);
			map.addAttribute("board", board);
			map.addAttribute("boardNickname", boardNickname);
		
			return "content/group/board/board_view";
		}
		
		/*
		 *  로그인 수정 필요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		 */
		String loginId="duflalrjdi"; // test되는 동안에 쓸 로그인 아이디 

		Date date = new Date(); // 수정된 시간
		
		reply.setMemberId(loginId);
		reply.setReplyDate(date);
		reply.setBoardNo(boardNo);

		replyService.updateReply(reply);
		
		List<Reply> replyList =replyService.selectReplyByBoardNo(boardNo); // 게시물번호로 댓글 가져오기
		Board board = boardService.selectBoard(boardNo);
		
		map.addAttribute("replyList", replyList);
		map.addAttribute("board", board);
		
		return "redirect:/group/board/board_view.do?boardNo="+boardNo;
	}
	
	
	@RequestMapping("deleteReply")
	public String deleteReply(@RequestParam int replyNo,
											@RequestParam int boardNo){
		
		
		
		System.out.println("deleteReply 컨트롤러 들어옴");
		
		System.out.println("리플넘버,보드넘버"+replyNo+"/"+boardNo);
		return "1";
	}
}
