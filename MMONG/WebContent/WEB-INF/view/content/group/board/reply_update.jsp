<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
 
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>댓글 수정
		</h3>
		
<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
<ul>
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정 목록</a></li> <!-- 소모임 상세페이지 첫 화면 -->
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
	<li><a href="/MMONG/groupMember/searchGroupMember.do">참여 멤버 목록</a></li>
</ul>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>
<hr>
	<a href="/MMONG/group/board/board_form.do">게시글작성</a> | 
	<a href="/MMONG/group/board/myBoardList.do">내가 쓴 글 보기</a> |
	<a href="/MMONG/group/reply/myReplyList.do">내가 쓴 댓글 보기</a> |


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
</section>
</div>