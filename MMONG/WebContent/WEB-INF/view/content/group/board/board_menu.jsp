<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<h3>자유게시판 메뉴</h3>
<ul>
	<sec:authorize access="hasRole('ROLE_1')">
	  <li><a href="/MMONG/group/board/board_form.do">자유게시판 글쓰기</a></li>
	  <li><a href="/MMONG/group/board/allBoardList.do">자유게시판 글목록</a></li>
	  <li><a href="/MMONG/group/board/myBoardList.do">내가 쓴 글목록</a></li>
	  <li><a href="/MMONG/group/reply/myReplyList.do">내가 쓴 댓글목록</a></li>
	 </sec:authorize>
</ul>
<hr>
