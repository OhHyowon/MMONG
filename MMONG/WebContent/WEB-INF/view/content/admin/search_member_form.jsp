<%@ page contentType="text/html;charset=UTF-8"%>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 회원 찾기
		</h3>
<form action="/MMONG/admin/searchMemberById.do" method="post">
	<table>
		<tr>
			<th>회원 ID</th>
			<td><input type="text" name="memberId" value="${param.memberId }"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="submit" value="조회">
			</td>
		</tr>
	</table>
</form>
</section>
