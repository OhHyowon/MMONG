<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 회원 마이페이지
		</h3>
 
<h3>회원 마이페이지</h3>
 
ID : <sec:authentication property="principal.memberId"/> <br>
이름 : ${requestScope.member.memberName } <br>
전화번호 : ${requestScope.member.memberPhone } <br>
이메일 : ${requestScope.member.memberEmail} <br>
주소 : ${requestScope.member.memberAddress} <br>
사진 : ${requestScope.member.memberPicture} <br>




<a href="/MMONG/index.do" >메인페이지</a>&nbsp;

<form action="/MMONG/member/info_member_update_form.do" method="post">
	<input type="hidden" name="memberId" value="${requestScope.member.memberId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="회원정보 수정">
</form>

<br>
<form action="/MMONG/member/change_authority_member.do" method="post">
	<input type="hidden" name="memberId" value="${requestScope.member.memberId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="회원탈퇴">
</form>
</section>
