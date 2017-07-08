<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>자유게시판 메뉴</h2>
<ul>
	<sec:authorize access="hasRole('ROLE_1')">
	  <li><a href="/MMONG/group/board/board_form.do">자유게시판 글쓰기</a></li>
	  <li><a href="/MMONG/group/board/allBoardList.do">자유게시판 글목록</a></li>
	  <li><a href="/MMONG/group/board/myBoardList.do">내가 쓴 글목록</a></li>
	  <li><a href="/MMONG/group/reply/myReplyList.do">내가 쓴 댓글목록</a></li>
	 </sec:authorize>
</ul>
<hr>
</body>
</html>