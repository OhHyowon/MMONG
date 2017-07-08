<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>관리자 등록 성공</h2>
관리자 ID : ${requestScope.administrator.adminId }<br>
이름 : ${requestScope.administrator.adminName}<br>
전화번호 : ${requestScope.administrator.adminPhone }<br>
이메일 : ${requestScope.administrator.adminEmail }<br>

<a href="/MMONG/index.do">메인페이지</a>

</body>
</html>