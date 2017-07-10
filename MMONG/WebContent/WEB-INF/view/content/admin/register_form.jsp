<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<h3>관리자 등록</h3>				<%-- value="${param. } 는 EL의 내장객체를 이용한 것 --%>
	<form action="/MMONG/admin/register_success.do" method="post">
		ID : <input type="text" name="adminId"  value="${param.adminId }"><span class="error"><form:errors path="administrator.adminUser.userId" delimiter="<br>"/></span><br>  
		비밀번호 : <input type="password" name="adminUser.userPwd" ><span class="error"><form:errors path="administrator.adminUser.userPwd" delimiter="<br>"/></span><br>
		이름 : <input type="text" name="adminName" value="${param.adminName}"><span class="error"><form:errors path="administrator.adminName" delimiter="<br>"/></span><br>
		핸드폰 번호 :  <input type="text" name="adminPhone" value="${param.adminPhone}"><span class="error"><form:errors path="administrator.adminPhone" delimiter="<br>"/></span><br>
						<!-- <select name="tel1">
									<option>선택</option>
									<option>010</option>
									<option>011</option>
									<option>016</option>
									<option>019</option>
							</select>
							 - <input type="text" name="tel2" size="1" maxlength="4"> - <input type="text" name="tel3" size="1" maxlength="4">  --><br>
		이메일 : <input type="text" name="adminEmail"  value="${param.adminEmail}"><span class="error"><form:errors path="administrator.adminEmail" delimiter="<br>"/></span><br><br>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="submit" value="등록하기">		 
	</form>

