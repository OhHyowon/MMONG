<%@ page contentType="text/html;charset=UTF-8"%>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 관리자 정보 수정하기
		</h3>

	<form action="/MMONG/admin/info_admin.do" method="post">
		<table>
			<tr>
				<td>ID :</td>
				<td><input type="text" name="adminId" readonly value="${requestScope.administrator.adminId}" style="background-color: #e2e2e2;"><br></td>
			</tr>
			<tr>
				<td>새 비밀번호 :</td>
				<td><input type="password" name="user.userPwd">
				<td>
			</tr>
			<tr>
				<td>새 비밀번호 확인 :</td>
				<td><input type="password" name="userPwd2"></td>
			</tr>
			<tr>
				<td>이름 :</td>
				<td><input type="text" name="adminName" readonly value="${requestScope.administrator.adminName}" style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<td>핸드폰번호 :<br> <font size="2em" color="green"> - 없이 숫자만 입력해주세요.</font>
				</td>
				<td><input type="number" name="adminPhone" value="${requestScope.administrator.adminPhone}"></td>
			</tr>
			<tr>
				<td>이메일 :</td>
				<td><input type="text" name="adminEmail" value="${requestScope.administrator.adminEmail}"></td>
			</tr>
			<tr>
				<td>권한 :</td>
				<td><input type="text" name="user.userAuthority" readonly value="${requestScope.administrator.user.userAuthority}" style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="submit" value="저장">
				<input type="reset" value="초기화">
			</tr>
		</table>
	</form>

	</section>