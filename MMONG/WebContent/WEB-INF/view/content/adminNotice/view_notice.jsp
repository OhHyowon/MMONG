<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>공지사항 상세조회 페이지</h2>
<table>
			<tr>
				 <th>공지사항 번호: </th>
                <td>${requestScope.adminNotice.no }</td>
			</tr>
			<tr>
				<th>작성일: </th>
                <td><fmt:formatDate value="${requestScope.adminNotice.adminDate }" pattern="yyyy-MM-dd"/></td>
			</tr>
        	<tr>
                <th>작성자: </th>
                <td>${requestScope.adminNotice.administrator.adminId}"</td>
            </tr>
            <tr>
                <th>제목: </th>
                <td>${requestScope.adminNotice.title}</td>
            </tr>
            <tr>
                <th>내용: </th>
                <td>${requestScope.adminNotice.content}</td>
            </tr>
         </tbody>
         <tbody>
</table>
<table>
	<sec:authorize access="hasRole('ROLE_0')">
            <tr>
		            <form action="/MMONG/adminNotice/updateAdminNotice_form.do" method="post">
						<input type="hidden" name="adminNoticeNo" value="${requestScope.adminNotice.no }"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="submit" value="수정">
					</form>
            </tr>
            <tr>
				<form action="/MMONG/adminNotice/deleteAdminNotice.do" method="post">
						<input type="hidden" name="adminNoticeNo" value="${requestScope.adminNotice.no }"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="submit" value="삭제">
				</form>
            </tr>
	</sec:authorize>
</table>


<input type="button" value="메인페이지" onclick="location.href='/MMONG/index.do' ">
<input type="button" value="목록" onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do' ">


</body>
</html>