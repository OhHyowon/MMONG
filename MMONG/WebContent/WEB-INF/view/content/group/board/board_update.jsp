<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/PatcH/resource/jquery/jquery-3.2.1.min.js"></script>
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
</head>
<body>

<jsp:include page="/group/board/board_menu.do"/>

<h2>게시글 수정</h2>
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

</body>
</html>