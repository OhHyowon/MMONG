<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>받은 쪽지 내용 보기</h2>

	<form action="/MMONG/message/selectMsgIdNick.do?no=${requestScope.message.no}" method="post">
		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		
		<table>
			<tr><td>보낸이</td><td>${requestScope.message.sendId }(${requestScope.message.member.nickName })</td></tr>
			<tr><td>받은 시간</td><td>${requestScope.message.messageDate }</td></tr>
			<tr><td>제목</td><td>${requestScope.message.title }</td></tr>
			<tr><td>내용</td><td>${requestScope.message.content }</td></tr>
		</table>
	
		<input type="submit" value="답장">
		<input type="button" value="확인" onclick="location.href='/MMONG/message/selectReceiveMsg.do'">
	</form>
</body>
</html>