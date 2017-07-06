<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3> 개인 회원 마이페이지</h3>
 
 ID : <sec:authentication property="principal.userId"/> <br>
 이름 : ${requestScope.member.memberName }
</body>
</html>

