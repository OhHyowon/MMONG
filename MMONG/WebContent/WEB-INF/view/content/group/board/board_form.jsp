<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
.error{
	color: red;
}
</style>
</head>
<body>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>게시물 등록
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


<div class="col-lg-10">
	<div class="form-panel">
		<h4 class="mb">글쓰기</h4>
		
<form action="/MMONG/group/board/register.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return confirm('등록하시겠습니까?');" class="form-horizontal style-form">
제목 : <input type="text" name="title" class="form-control"><span class="error"><form:errors path="board.title" deilimiter="&nbsp;&nbsp;"/></span><br>
내용 : <br>
<textarea rows='20' cols='100' name="content" class="form-control">${param.content }</textarea>
<span class="error"><form:errors path="board.title" deilimiter="&nbsp;&nbsp;"/></span><br>
<input class="btn btn-default btn-sm" type="file" name="upImage" multiple><br>
<div style="float:right; position:relative; bottom:30px">
<input class="btn btn-default btn-sm" type="submit" value="등록"> <input class="btn btn-default btn-sm" type="button" value="취소" onclick="location.href='/MMONG/group/board/allBoardList.do?gourpNo=${sessionScope.groupNo}'"/>
</div>
</form>
	</div>
</div>
</section>
