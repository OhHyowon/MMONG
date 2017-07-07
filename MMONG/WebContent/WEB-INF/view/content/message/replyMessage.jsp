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
<h2>답장보내기</h2>


<form action="/MMONG/message/reply.do?receiveId=${requestScope.message.sendId }&no=${requestScope.no }" method="post">
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 	
	<table>
	<tr>
		<th>받는이</th>
		<td>
			${requestScope.message.sendId }(${requestScope.message.member.nickName })
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title"  value="${param.title }"><span class="error"><form:errors path="mess.title"/></span></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><input type="text" name="content" value="${param.content }"><span class="error"><form:errors path="mess.content"/></span></td>
	</tr>
</table>
	<input type="submit" value="전송">
	<input type="button" value="취소" onclick="location.href='/MMONG/message/viewReceiveMsg.do?no=${requestScope.no }'">
</form>
 
</body>
</html>