<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>쪽지 보내기</h2><hr>

<!-- 받는 아이디는 자유게시판에서 session scope를 통해 받아온다 -->
<form action="/MMONG/message/insert.do?userId=<sec:authentication property="principal.userId"/>" method="post">
	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	
	<table>
	<tr>
		<th>받는이</th>
		<td><!-- session scope를 통해 전달받은 id & nick -->
			받는이(이름)
			<%-- ${sessionScope.receiveId }(${sessionScope.receiveNick }) --%>
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
			<input type="button" value="취소" onclick="javascript:history.back(-1)">
		</td>
	</tr>
</table>
</form>
 
</body>
</html>