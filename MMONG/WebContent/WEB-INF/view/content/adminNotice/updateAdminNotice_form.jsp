<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h3>공지사항 수정 폼</h3>
<form action="/MMONG/adminNotice/updateAdminNotice.do" method="post">
		<table>
			<tr>
                <td>작성자: </td>
                <td>&nbsp;<sec:authentication property="principal.adminId"/>
                	<input type="hidden" placeholder="작성자" name="adminId" value="<sec:authentication property="principal.adminId"/>"/></td>
            </tr>
			<tr>
				<td>제목 :</td>
				<td><input type="text" name="title" value="${requestScope.adminNotice.title}" ><br></td>
			</tr>
			<tr>
				<td>내용 :</td>
				<td><textarea cols="80" rows="10"  name="content" >${requestScope.adminNotice.content}</textarea></td>
			</tr>
			<tr> 
				<input type="hidden" name="no" value="${requestScope.adminNotice.no}"/><br>
				<input type="hidden" name="adminDate" value=<fmt:formatDate value="${requestScope.adminNotice.adminDate }" pattern="yyyy-MM-dd"/>/><br>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="submit" value="저장">&nbsp;
				<input type="reset" value="되돌리기">
			</tr>
		</table>
	</form>
	<input type="button" value="목록 " onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do'"/>