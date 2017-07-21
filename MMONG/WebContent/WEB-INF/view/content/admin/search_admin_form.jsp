<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style type="text/css">
#content {
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	display: -webkit-flex; -webkit-align-item; center;
	-webkit-justify-content: center;
}
</style>
<script type="text/javascript">
	window.onload = function() {
		$("#total_div").css("min-height",
				(document.body.scrollHeight - 38.4) + "px");
	}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			관리자 찾기 폼
		</h3>

	<sec:authorize access="hasRole('ROLE_0')">
		<div class="btn-group btn-group-justified" style="margin-top:50px; margin-bottom:30px;">
			<div class="btn-group">
					<button class="btn btn-theme" type="button" onclick="location.href='/MMONG/admin/register_form.do' ">관리자 등록</button>&nbsp;
			</div>
			<div class="btn-group">	
					<button class="btn btn-theme" type="button" onclick="location.href='/MMONG/admin/search_admin_form.do' ">관리자 찾기</button>&nbsp;
			</div>
			<div class="btn-group">	
					<button class="btn btn-theme" type="button" onclick="location.href='/MMONG/admin/search_member_form.do' ">회원 찾기</button>&nbsp;
			</div>
		</div>
	</sec:authorize>		
			
		<div id="content">
			<form action="/MMONG/admin/searchAdmindById.do" method="post">
				<table>
					<tr>
						<th>관리자 ID&nbsp;</th>
						<td><input type="text" name="adminId"
							value="${param.adminId }">&nbsp;</td>
						<td><input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input class="btn btn-default btn-sm"
							type="submit" value="조회"></td>
					</tr>
				</table>
			</form>
		</div>
	</section>
</div>