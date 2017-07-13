<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

span, td, th{
	padding: 5px; 
}
span.error{
	font-size:small; /* 1em : 기본 크기의 1배수 크기 */
	color: red;
}

</style>

</head>
<body>
<h2>쪽지 보내기</h2><hr>

<!-- 받는 아이디는 자유게시판에서 session scope를 통해 받아온다 -->
<form action="/MMONG/message/insert.do?id=${requestScope.id }&nickname=${requestScope.nickname }" method="post">
	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	
	<table>
	<tr>
		<th>받는이</th>
		<td>
			${requestScope.id }(${requestScope.nickname })
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title"  value="${param.title }"><span class="error"><form:errors path="message.title"/></span></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><input type="text" name="content" value="${param.content }"><span class="error"><form:errors path="message.content"/></span></td>
	</tr>
	
	<tr>
		<td colspan="2">
			<input type="submit" value="전송">
			<input type="button" value="취소" onclick="location.href='/MMONG/message.do'">
		</td>
	</tr>
</table>
</form>
 
</body>
</html>