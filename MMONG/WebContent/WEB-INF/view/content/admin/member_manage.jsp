<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<h2>회원관리</h2>

<sec:authorize access="hasRole('ROLE_0')">
	<a href="/MMONG/admin/register_form.do">관리자 등록</a>&nbsp;
	<a href="/MMONG/admin/search_member_form.do">회원 찾기 폼</a>&nbsp;
	<a href="/MMONG/admin/search_admin_form.do">관리자 찾기 폼</a>&nbsp;
</sec:authorize>



</body>
</html>