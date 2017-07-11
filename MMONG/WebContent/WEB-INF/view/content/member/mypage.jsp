<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<h3>회원 마이페이지</h3>
 
 ID : <sec:authentication property="principal.memberId"/> <br>
 이름 : ${requestScope.member.memberName }

