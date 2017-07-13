<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
 <script src="/MMONG/resource/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#imgCheck").on("click",function(){
		$("#file").empty();
	})
	$("#imgCheck2").on("click",function(){
		$("#file").empty();
		$("#file").append("<br><input type='file' id='upImage' name='upImage' multiple><br>");
	}); // end of imgCheck2
	$("#imgCheck3").on("click",function(){
		$("#file").empty();
	}); // end of imgCheck2
});
</script>

<h3>소모임 페이지 - 소모임 상세 페이지</h3>
<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
<ul>
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정 목록</a></li> <!-- 소모임 상세페이지 첫 화면 -->
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
	<li><a href="/MMONG/groupMember/searchGroupMember.do">참여 멤버 목록</a></li>
</ul>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>
<hr>

<h3>자유게시판 메뉴</h3>
<ul>
	<li><a href="/MMONG/group/board/board_form.do">게시글작성</a></li>
	<li><a href="/MMONG/group/board/myBoardList.do">내가 쓴 글 보기</a>
	<li><a href="/MMONG/group/reply/myReplyList.do">내가 쓴 댓글 보기</a>
</ul>


<h3>게시글 수정</h3>
<form action="/MMONG/group/board/boardUpdate2.do?${_csrf.parameterName}=${_csrf.token}&groupNo=${sessionScope.groupNo }" method="post" enctype="multipart/form-data" onsubmit="return confirm('수정하시겠습니까?');">
제목 : <input type="text" name="title" value="${requestScope.board.title }"><form:errors path="board.title" deilimiter="&nbsp;&nbsp;"/><br>
내용 : <br>
<textarea rows='20' cols='100' name="content">${requestScope.board.content }</textarea><br>
<form:errors path="board.content" deilimiter="&nbsp;&nbsp;"/><br>
<hr>
기존 사용된 이미지 : <br>
		<c:forEach items="${requestScope.nameList }" var="name">
			${name } <br>
		</c:forEach>
		
<input type="hidden" name="no" value="${requestScope.board.no }">
<label>기존 이미지 사용<input type="radio" id="imgCheck" name="imgCheck" value="same" checked></label>
<label>이미지 수정<input type="radio" id="imgCheck2" name="imgCheck" value="update"></label>
<label>이미지 삭제<input type="radio" id="imgCheck3" name="imgCheck" value="delete"></label><br>
<label id="file"></label>
<input type="submit" value="수정완료"> <input type="button" value="취소" onclick="javascript:history.back(-1)" />
</form>
