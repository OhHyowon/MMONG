package com.mmong.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;

import com.mmong.service.impl.BoardPictureServiceImpl;
import com.mmong.service.impl.BoardServiceImpl;
import com.mmong.service.impl.ReplyServiceImpl;
import com.mmong.validation.BoardRegisterValidator;
import com.mmong.vo.Board;
import com.mmong.vo.BoardPicture;
import com.mmong.vo.Member;
import com.mmong.vo.Reply;

@Controller
@RequestMapping("group/board/")
public class BoardController {
	@Autowired
	private BoardServiceImpl boardService; // 완성되면 Impl말고 service로 바꾸기
	@Autowired
	private BoardPictureServiceImpl BPService; // 완성되면 Impl말고 service로 바꾸기
	@Autowired
	private ReplyServiceImpl replyService;
	
	
	/* 게시물 등록 */
	@RequestMapping("register")
	public String registerBoard(@RequestParam List<MultipartFile> upImage, 
											@ModelAttribute Board board, BindingResult errors, 
											HttpServletRequest request, HttpSession session, 
											ModelMap map) throws Exception {
		
		BoardRegisterValidator validator = new BoardRegisterValidator();
		validator.validate(board, errors);
		if (errors.hasErrors()) {
			return "content/group/board/board_form";
		}
		
		int groupNo=(int) session.getAttribute("groupNo");
		
		String destDir = request.getServletContext().getRealPath("/up_image"); // 진짜경로

		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		 
		// 시퀀스로 들어갈 no=0, 처음 들어갈 조횟수 hit=0
		Date date = new Date();

		board.setHit(0);
		board.setBoardDate(date);
		board.setMemberId(memberId);
		board.setGroupNo(groupNo);
		
		int boardNo = boardService.insertBoard(board); // 등록한 게시글 No 가져오기
		
		String nickname = boardService.selectNickNameByMemberId(memberId, boardNo);
		// 등록한 게시글의 nickname 가져오기
		
		ArrayList<String> nameList = new ArrayList<>(); // 업로드 된 파일명 저장할 list

		BoardPicture boardPicture = new BoardPicture();

		for (int i = 0; i < upImage.size(); i++) {
			MultipartFile mFile = upImage.get(i);
			if (mFile != null && !mFile.isEmpty()) {
				nameList.add(mFile.getOriginalFilename());
				mFile.transferTo(new File(destDir, mFile.getOriginalFilename()));
			}
		}
		
		for (int i = 0; i < nameList.size(); i++) {
			boardPicture.setNo(0);
			boardPicture.setBoardNo(board.getNo());
			boardPicture.setRoute(nameList.get(i));
			BPService.insertBP(boardPicture); // 업로드한 이미지 수만큼 등록됨
		}

		board = boardService.selectBoard(boardNo); // 등록된 no로 게시물 가져오기
		
		map.addAttribute("nameList", nameList);
		map.addAttribute("nickname", nickname);
		map.addAttribute("groupNo", groupNo);

		
		return "redirect:/group/board/board_view.do?boardNo="+boardNo;
	}

	/* 게시물 그대로 받아오기 */
	@RequestMapping("boardUpdate1")
	public String updateBoard1(@RequestParam String[] nameList, @RequestParam int boardNo, HttpServletRequest request,
			ModelMap map) {
		
		if (nameList.length == 0) { 
			Board board = boardService.selectBoard(boardNo);

			map.addAttribute("board", board);
			return "content/group/board/board_update";
		}

		Board board = boardService.selectBoard(boardNo);

		map.addAttribute("nameList", nameList);
		map.addAttribute("board", board);

		return "content/group/board/board_update";
	}

	/* 게시물 수정 -2 수정된 글 DB에 넣기 */
	@RequestMapping("boardUpdate2")
	public String updateBoard2(@RequestParam List<MultipartFile> upImage,
															@ModelAttribute Board board, BindingResult errors,
															@RequestParam String imgCheck,
															HttpServletRequest request,
															ModelMap map) throws Exception{
		
		
		BoardRegisterValidator validator=new BoardRegisterValidator();
		validator.validate(board,errors);
		if(errors.hasErrors()){
			return "content/group/board/board_update";
		}

		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		String memberId=member.getMemberId();
		
		String destDir=request.getServletContext().getRealPath("/up_image"); // 진짜경로
		
		Date date=new Date(); // 수정된 시간=등록시간
		
		board.setBoardDate(date);
		board.setMemberId(memberId); 
		int boardNo=board.getNo();
		
		boardService.updateBoard(board); // DB에 수정된 글 넣기

		// 등록한 게시글의 nickname 가져오기
		String nickname=boardService.selectNickNameByMemberId(memberId,boardNo);
		
		ArrayList<String> nameList=new ArrayList<>(); // 업로드 된 파일명 저장할 list
		BoardPicture boardPicture = new BoardPicture();
	
	
		if(imgCheck.equals("same")){ // 기존 이미지 그대로 사용

			List<BoardPicture> BP = BPService.selectBPByBoardNo(boardNo);
			for(int i =0; i<BP.size(); i++){
				nameList.add(BP.get(i).getRoute()); 
			}
		}else if(imgCheck.equals("update")){ // 이미지 수정 
			
			BPService.deleteBPByBoardNo(boardNo); // 기존DB에 있는 route삭제
			for(int i=0; i<upImage.size(); i++){
				MultipartFile mFile=upImage.get(i);
				if(mFile!=null&&!mFile.isEmpty()){
					nameList.add(mFile.getOriginalFilename());
					mFile.transferTo(new File(destDir,mFile.getOriginalFilename()));
				}
			}
			for(int i=0; i<nameList.size(); i++){
				boardPicture.setNo(0);
				boardPicture.setBoardNo(boardNo);
				boardPicture.setRoute(nameList.get(i));
				BPService.insertBP(boardPicture); // 업로드한 이미지 수 만큼 수정됨
			}
		}else if(imgCheck.equals("delete")){ // 이미지 삭제
			BPService.deleteBPByBoardNo(boardNo);
		}
		
		board=boardService.selectBoard(boardNo); // 등록된 no로 수정된 게시물 가져오기
		
		map.addAttribute("nameList", nameList);
		map.addAttribute("nickname", nickname);
		
		return "content/group/board/board_view";
	}
	
	/*게시글 삭제*/
	@RequestMapping("boardDelete")
	@ResponseBody
	public String deleteBoard(@RequestParam int boardNo,
												HttpServletRequest request,
												HttpSession session){
		
	
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		

		Board board=boardService.selectBoard(boardNo);

		if(board.getMemberId().equals(memberId)){
			replyService.deleteReplyByBoardNo(boardNo);
			BPService.deleteBPByBoardNo(boardNo);
			boardService.deleteBoard(boardNo, memberId);
		}
		
		return "1";
	}
	
	/*게시글 조회*/
	@RequestMapping("board_view")
	public String boardView(int boardNo,ModelMap map){

		Board board = boardService.selectBoard(boardNo);
		int hit=board.getHit();
		hit++; // 조횟수 올리기
		board.setHit(hit);
		
		boardService.updateBoard(board);
			
		board=boardService.selectBoard(boardNo);
		
		// 사진 찾기
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
		map.addAttribute("replyNickname", replyNickname);
		
		return "content/group/board/board_view";
	}
	
	/*게시글 목록*/
	@RequestMapping("allBoardList")
	public String showAllBoardList(@RequestParam(value="page", defaultValue="1")int page, 
													@RequestParam (value="option", defaultValue="1")String option, 
													@RequestParam  (value="key", defaultValue="1")String key, 
													HttpSession session,
													ModelMap map) {
		
		HashMap<String,Object> pagingMap =null;
		
		
		int groupNo=(int) session.getAttribute("groupNo");
		
		if(option.equals("1")){ // option 선택을 안했을 때
			pagingMap=boardService.selectAllBoard(page,groupNo); 
		}else{ // option 선택했을 때
			pagingMap=boardService.selectOption(page,option,key,groupNo);
		}
		
		
		
		map.addAttribute("groupNo", groupNo);
		map.addAttribute("nickNameList", pagingMap.get("nickNameList"));
		map.addAttribute("boardList", pagingMap.get("boardList"));
		map.addAttribute("pageBean", pagingMap.get("pageBean"));
	
		return "content/group/board/board_list";
	}
	
	/*내가 쓴 게시글 목록*/
	@RequestMapping("myBoardList")
	public String myBoardList(@RequestParam(value="page", defaultValue="1")int page, 
											@RequestParam (value="option", defaultValue="1")String option, 
											@RequestParam  (value="key", defaultValue="1")String key, 
											HttpSession session,
											ModelMap map){
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		
		int groupNo=(int) session.getAttribute("groupNo");
		
		HashMap<String,Object> pagingMap=null;
		
		if(option.equals("1")){
			pagingMap=boardService.selectMyBoardList(page,memberId,groupNo);			
		}else{
			pagingMap=boardService.selectMyOption(page, option, key,memberId,groupNo);
		}

		map.addAttribute("groupNo", groupNo);
		map.addAttribute("myBoardList", pagingMap.get("myBoardList"));
		map.addAttribute("pageBean", pagingMap.get("pageBean"));
		
		return "content/group/board/board_mine";
	}
	
	/*내가 쓴 게시글 목록 중 선택 삭제*/
	@RequestMapping(value="deleteMyBoardList",produces="html/text;charset=UTF-8;" )
	@ResponseBody
	public String deleteMyboardList(@RequestParam List<Integer> boardNoList){
	
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memberId=member.getMemberId();
		
		int boardNo;
		
		for(int i =0; i<boardNoList.size(); i++){
			boardNo=boardNoList.get(i);
			replyService.deleteReplyByBoardNo(boardNo);
			BPService.deleteBPByBoardNo(boardNo);
			boardService.deleteBoard(boardNo, memberId);
			}
	
		return "1";
	}
	



}
