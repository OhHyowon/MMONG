<%@ page contentType="text/html;charset=UTF-8"%>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 검색한 관리자 정보 조회
		</h3>
관리자 ID : ${requestScope.administrator.adminId }<br>
권한 : ${requestScope.administrator.user.userAuthority}<br>
이름 : ${requestScope.administrator.adminName}<br>
전화번호 : ${requestScope.administrator.adminPhone }<br>
이메일 : ${requestScope.administrator.adminEmail }<br>
enable : ${requestScope.administrator.user.userEnable}<br>

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


</section>















