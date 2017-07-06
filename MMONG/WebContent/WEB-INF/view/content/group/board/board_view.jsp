<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.error{
	font-size:.8em;
	color: red;
}
</style>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#BoardDeleteBtn").on("click",function(){
			confirm("삭제하시겠습니까?");
		$.ajax({
			url:"/MMONG/gourp/board/boardDelete.do",
			type:"post",
			data:"boardNo="+$("#boardNo").val(),
			dataType:"json",
			success:function(txt){
				if(txt=='1'){
				alert('삭제되었습니다.');   			<%-- 게시판 목록 완성 되면 LIST JSP로 바꾸기 --%>
				location.href="/MMONG/group/board/allBoardList.do"
				}else{
					alert('삭제실패');
				}
			}
		});
	}); // end of deleteBtn
	$('.updateBtn').on("click",function(){
		$(this).parent().parent().find("td:nth-child(6)").find("div").show();
		
	});
});

</script>
</head>
<body>
<jsp:include page="/index.do"/>

	<h2>게시글 보기</h2>
	<hr>
	<form action="/MMONG/group/board/boardUpdate1.do" method="post">
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
			<td>작성일자</td>
			<td><fmt:formatDate value="${requestScope.board.boardDate }" pattern="yyyy-MM-dd a hh:mm"/> </td>
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
			<td>조회수</td>
			<td>${requestScope.board.hit }</td>
		</tr>
	
	</table> <%-- 로그인된 아이디와 글쓴 아이디가 같을 때!!!! 
	sessionScope.member.member eq requestScope.board.memberId 
	--%>
	<input type="hidden" name=nameList value="${requestScope.nameList }">
	<input type="hidden" id="boardNo" name="boardNo" value="${requestScope.board.no}">
	<input type="submit" value="수정하기" >
	<input type="button" id="BoardDeleteBtn" value="삭제하기"/>
	</form>
	
<form action="/MMONG/group/reply/register.do" method="post">
	<input type="text" name="content">
	<input type="hidden" name="boardNo" value="${requestScope.board.no }">
	<input type="hidden" name="loginId" value="<sec:authentication property='principal.userId'/>"/>
	<input type="submit" value="댓글등록"><span class="error"><form:errors path="reply.content" deilimiter="&nbsp;&nbsp;"/></span>
	<br>
</form>

<table id="replyTable">

	<c:forEach items="${requestScope.replyList }" var="reply" varStatus="idx">
		
		<%-- 
		<c:choose>   로그인된 아이디와 댓글쓴 아이디가 같을 때
		
		<c:when test="${reply.memberId eq sessionScope.member.memberId }"> --%>
				<tr>
					<td>${reply.content} </td>
					<td>${reply.memberId }(${requestScope.replyNickname[idx.index] })</td>
					<td><fmt:formatDate value="${reply.replyDate }" pattern="yyyy-MM-dd a hh:mm"/></td>
					<td><input type="button" value="댓글수정" class="updateBtn"></td>
					<td><input type="button" id="replyDeleteBtn" value="댓글삭제"></td>
					<td>
						<div id="updateForm"  style="display:none" >
							<form action="/MMONG/group/reply/replyUpdate2.do" method="post" >
								<input type="hidden" name="replyNo" value="${reply.no }">
								<input type="hidden" name="boardNo" value="${request.board.no }">
								<input type="text" name="content" value="${reply.content} ">
								<input type="submit" value="수정완료"><span class="error"><form:errors path="reply.content" deilimiter="&nbsp;&nbsp;"/></span>
							</form>
						</div>
					</td>
					</tr>
			<%-- </c:when> --%>
		<%--	<c:otherwise>  로그인된 아이디와 댓글 쓴 아이디가 같지 않을 때
				<tr>
					<td>${reply.content }</td>
					<td>${reply.memberId }(${requestScope.nickname })</td>
					<td><fmt:formatDate value="${reply.replyDate }" pattern="yyyy-MM-dd a hh:mm"/></td>
					<td></td>
					<td></td>
				</tr>
			</c:otherwise>
		 </c:choose>  --%>
		 
	</c:forEach>
	
</table>




</body>
</html>