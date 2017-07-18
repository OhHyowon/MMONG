<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<style type="text/css">
#view-detail{
  top:0;right:0;bottom:0;left:0;
  display:flex;
  align-items:center;
  justify-content:center;
 
  display:-webkit-flex;
  -webkit-align-item;center;
  -webkit-justify-content:center;
}
#view-menu{
	text-align: center;
}
form{
	display: inline;
}


</style>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>관리자 마이페이지
		</h3>
 
<div id="view-detail">
<table>
<tr>
	<th>관리자 ID : </th>
	<td>${requestScope.administrator.adminId }</td>
<tr>
<tr>
	<th>권한 : </th>
	<td>${requestScope.administrator.user.userAuthority}</td>
<tr>
 <tr>
	<th>이름 : </th>
	<td>${requestScope.administrator.adminName}</td>
<tr>
<tr>
	<th>전화번호 : </th>
	<td>${requestScope.administrator.adminPhone }</td>
<tr>
<tr>
	<th>이메일 : </th>
	<td>${requestScope.administrator.adminEmail }</td>
<tr>
</table>
</div>
<div id="view-menu">
	<form action="/MMONG/admin/info_admin_update_form.do" method="post">
				<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input class="btn btn-default btn-sm" type="submit" value="관리자 정보 수정하기">
	</form>&nbsp;
	<form action="/MMONG/admin/adminWithdrawal.do" method="post">
				<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"/>">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input class="btn btn-default btn-sm" type="submit" value="관리자 탈퇴">
	</form>
</div>
</section>
