<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>공지사항 수정 폼</h2>
<form action="/MMONG/adminNotice/updateAdminNotice.do" method="post">
		<table>
			<tr>
                <td>작성자: </td>
                <td><input type="text" value="${requestScope.adminNotice.administrator.adminId}" name="adminId" /></td>
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
				<input type="submit" value="저장">
				<input type="reset" value="초기화">
			</tr>
		</table>
	</form>
	<input type="button" value="목록 " onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do'"/>
</body>
</html>