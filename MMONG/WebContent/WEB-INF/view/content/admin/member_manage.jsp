<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>회원관리
		</h3>


<sec:authorize access="hasRole('ROLE_0')">
	<a href="/MMONG/admin/register_form.do">관리자 등록</a>&nbsp;
	<a href="/MMONG/admin/search_admin_form.do">관리자 찾기</a>&nbsp;
	<a href="/MMONG/admin/search_member_form.do">회원 찾기</a>&nbsp;
</sec:authorize>



</section>