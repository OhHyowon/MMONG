<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>관리자 마이페이지</h2>
관리자 ID : ${requestScope.administrator.adminId }<br>
패스워드 : ${requestScope.administrator.adminUser.userPwd }<br>
권한 : ${requestScope.administrator.adminUser.userAuthority}<br>
이름 : ${requestScope.administrator.adminName}<br>
전화번호 : ${requestScope.administrator.adminPhone }<br>
이메일 : ${requestScope.administrator.adminEmail }<br>
enable : ${requestScope.administrator.adminUser.userEnable}<br>

<a href="/MMONG/index.do">메인페이지</a>

<form action="/MMONG/admin/info_admin_update_form.do" method="post">
	<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="관리자 정보 수정하기">
</form>
<br>

<form action="/MMONG/admin/changeEnable.do" method="post">
	<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="관리자 enable 변경">	
</form>



</body>
</html>

















