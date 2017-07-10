<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<ul>
	<sec:authorize access="hasRole('ROLE_1')">
	  <li><a href="/MMONG/group/board/board_form.do?groupNo=${sessionScope.groupNo }">자유게시판 글쓰기</a></li>
	  <li><a href="/MMONG/group/board/allBoardList.do?groupNo=${sessionScope.groupNo }">자유게시판 글목록</a></li>
	  <li><a href="/MMONG/group/board/myBoardList.do?groupNo=${sessionScope.groupNo }">내가 쓴 글목록</a></li>
	  <li><a href="/MMONG/group/reply/myReplyList.do?groupNo=${sessionScope.groupNo }">내가 쓴 댓글목록</a></li>
	 </sec:authorize>
</ul>
<hr>
<body>
	<table>
	
		<tr>
			<td>제목</td>
			<td>${requestScope.board.title }</td>
		</tr>
		<tr>
			<td>작성자(닉네임)</td>
			<td>${requestScope.board.memberId }(${requestScope.boardNickname })</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${requestScope.board.content }<br>
			<c:forEach items="${requestScope.nameList }" var="fileName">
				<img src="/MMONG/up_image/${fileName }" width="400px">
				<input type="hidden" name="nameList" value="${fileName }">
			</c:forEach></td>
		</tr>
		<tr>
			<td>작성일자</td>
			<td><fmt:formatDate value="${requestScope.board.boardDate }" pattern="yyyy-MM-dd a hh:mm"/> </td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${requestScope.board.hit }</td>
		</tr>
	</table> 
	
<table>
	<c:forEach items="${requestScope.replyList }" var="reply">
		<c:choose>
			<c:when test="${reply.no==requestScope.replyNo }">
			<tr>
				<td>
				<form action="/MMONG/group/reply/replyUpdate.do" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input type="hidden" name="replyNo" value="${reply.no }">
					<input type="hidden" name="boardNo" value="${requestScope.board.no }">
					<input type="hidden" name="memberId" value="${reply.memberId }">
					<input type="text" name="content" value="${reply.content }">
					<input type="submit" value="수정완료">
				</form>
				</td>
				<td>${reply.memberId }(${requestScope.replyNickname })</td>
				<td>${reply.replyDate }</td>
			</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td>${reply.content }</td>
					<td>${reply.memberId }(${reqeustScope.replyNickname })</td>
					<td>${reply.replyDate }</td>
				</tr>	
			</c:otherwise>
		</c:choose>
	</c:forEach>
</table>
