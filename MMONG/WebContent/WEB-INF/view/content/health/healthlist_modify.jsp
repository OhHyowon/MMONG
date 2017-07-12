<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/MMONG/health/modify.do?${_csrf.parameterName}=${_csrf.token}" method="post" onsubmit="return confirm('등록하시겠습니까?')">
건강 관리 정보<br>
<textarea rows="20" cols="70" name="content"></textarea><br>
<input type="submit" value="등록">
</form>
</body>
</html>