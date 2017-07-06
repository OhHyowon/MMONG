<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<form action="/MMONG/login.do" method="post">
	<sec:csrfInput/>
	<label for="id">ID</label>
	<input type="text" id="userId" name="userId" value="${param.userId }">
	<label for="password">패스워드</label>
	<input type="password" id="userPwd" name="userPwd" value="${param.userPwd }">
	<button type="submit">로그인</button>
	<sec:csrfInput/>
</form>

	

</body>
</html>