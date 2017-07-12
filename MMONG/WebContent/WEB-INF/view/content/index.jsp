<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<sec:authorize access="hasRole('ROLE_1')">
	<sec:authentication property="principal.memberId"/> 님 환영합니다.<br>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_0')">
	<sec:authentication property="principal.adminId"/> 님 환영합니다.<br>
</sec:authorize>


메인페이지입니다.
