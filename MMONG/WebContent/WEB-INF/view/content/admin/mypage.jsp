<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>관리자 마이 페이지
		</h3>
 
관리자 ID : <sec:authentication property="principal.adminId"/><br>
권한 : ${requestScope.administrator.user.userAuthority}<br>
이름 : ${requestScope.administrator.adminName}<br>
전화번호 : ${requestScope.administrator.adminPhone }<br>
이메일 : ${requestScope.administrator.adminEmail }<br>
enable : ${requestScope.administrator.user.userEnable}<br>


<a href="/MMONG/index.do" >메인페이지</a>&nbsp;

<form action="/MMONG/admin/info_admin_update_form.do" method="post">
	<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="관리자 정보 수정하기">
</form>
<br>

<<<<<<< HEAD
</section>
=======
 
>>>>>>> a537eee2acff70d4c6aeb31463ac59d50205a4a0
