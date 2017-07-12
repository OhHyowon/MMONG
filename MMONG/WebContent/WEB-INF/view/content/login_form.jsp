<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
.error{
	font-size : 8px;
	color : red;
}
</style>

<h3>로그인 페이지</h3>

<form action="/MMONG/login.do" method="post">
	<sec:csrfInput/>
	<label for="id">ID</label>
	<input type="text" id="userId" name="userId" value="${param.userId }">
	<label for="password">패스워드</label>
	<input type="password" id="userPwd" name="userPwd" value="${param.userPwd }">
	<button type="submit">로그인</button>
	<sec:csrfInput/>
</form>

<c:if test="${not empty param.errorMessage}">
	<div class="error">
		${param.errorMessage }
	</div>
</c:if>
