<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
</head>
<body>
<jsp:include page="/index.do"/>
<h2>게시물 등록 form</h2>


<form action="/MMONG/group/board/register.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return confirm('등록하시겠습니까?');">
제목 : <input type="text" name="title"><span class="error"><form:errors path="board.title" deilimiter="&nbsp;&nbsp;"/></span><br>
내용 : <br>
<textarea rows='20' cols='100' name="content">${param.content }</textarea><span class="error"><form:errors path="board.title" deilimiter="&nbsp;&nbsp;"/></span><br>
<input type="file" name="upImage" multiple><br>
<input type="submit" value="등록"> <input type="button" value="취소" onclick="location.href='/MMONG/group/board/allBoardList.do'"/>
</form>

</body>
</html>