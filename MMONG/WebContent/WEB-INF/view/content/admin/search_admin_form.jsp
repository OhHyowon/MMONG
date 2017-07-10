<%@ page contentType="text/html;charset=UTF-8"%>

<h3>관리자 찾기 폼</h3>
<form action="/MMONG/admin/searchAdmindById.do" method="post">
	<table>
		<tr>
			<th>관리자 ID</th>
			<td><input type="text" name="adminId" value="${param.adminId }"></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="submit" value="조회">
			</td>
		</tr>
	</table>
</form>
