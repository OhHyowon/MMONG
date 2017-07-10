<%@page import="com.mmong.vo.GroupDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>일정 상세보기</h2>

<%-- 일정 상세보기 페이지가 열릴 때 마다 groupDateNo 세션에 저장 --%>
<%
	int groupDateNo = ((GroupDate)request.getAttribute("groupDate")).getNo();
	session.setAttribute("groupDateNo",groupDateNo);
%>
	<sec:authentication property="principal.memberId" var="loginId"/>
<table>
	<thead>
		<tr>일정이름</tr>
		<tr>
			<td>시간</td>
			<td>장소(지도)</td>
		</tr>
	</thead>
	<tbody>
		<tr>${requestScope.groupDate.title}</tr>
		<tr>
			<td><fmt:formatDate value="${requestScope.groupDate.groupDate}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td>${requestScope.groupDate.place }</td>
		</tr>
	</tbody>	
</table>
	
<hr>
<table>
<c:choose>
 		<c:when test="${empty requestScope.memberIdList}"> <%-- 멤버아이디가 없을 때 --%>
			<tr>일정 참여자 목록
				<li>일정 참여자가 없습니다!</li>
			</tr>
			<input type="button" value="참여 하기">
		</c:when> 
		
		
		<c:otherwise>
	<c:forEach items="${requestScope.memberIdList }" var="memberId" varStatus="idx">
			<c:choose>
			<c:when test="${memberId == loginId }"> <%-- 로그인된 아이디와 참여자 아이디가 같다면 --%>
				<tr>
					일정 참여자 목록
					<li>
					${requestScope.memberIdList }(${requestScope.nickNameList[idx.index] })
					</li>
				</tr>
			<input type="button" value="참여 취소">
			</c:when>
			
			<c:when test="${memberId != loginId }"> <%-- 로그인된 아이디와 참여자 아이디가 다르다면 --%>
				<tr>
					일정 참여자 목록
					<li>
					${requestScope.memberIdList }(${requestScope.nickNameList[idx.index] })
					</li>			
				</tr>
			<input type="button" value="참여 하기">
			</c:when>
			</c:choose>
			</c:forEach>
		</c:otherwise>
		
	</c:choose>

	
	

</table>

</body>
</html>