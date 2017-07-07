<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>보낸 쪽지 내용 보기</h2>

<table>
	<tr><td>보낸이</td><td>${requestScope.message.receiveId }(${requestScope.message.member.nickName })</td></tr>
	<tr><td>받은 시간</td><td>${requestScope.message.messageDate }</td></tr>
	<tr><td>제목</td><td>${requestScope.message.title }</td></tr>
	<tr><td>내용</td><td>${requestScope.message.content }</td></tr>
</table>

<input type="button" value="확인" onclick="javascript:history.back(-1)">

</body>
</html>