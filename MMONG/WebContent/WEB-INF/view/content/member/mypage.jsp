<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 회원 마이페이지
		</h3>
 
 ID : <sec:authentication property="principal.memberId"/> <br>
 이름 : ${requestScope.member.memberName }
 
 </section>

