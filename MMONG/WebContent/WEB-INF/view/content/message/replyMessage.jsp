<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>답장보내기</h2>

<form action="/MMONG/message/reply.do?receiveId=${requestScope.message.sendId }" method="post">
	<table>
	<tr>
		<th>받는이</th>
		<td>
			${requestScope.message.sendId }(${requestScope.message.member.nickName })
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
			<input type="button" value="취소">
		</td>
	</tr>
</table>
</form>
 
</body>
</html>