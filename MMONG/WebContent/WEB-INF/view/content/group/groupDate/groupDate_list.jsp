<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
<style type="text/css">
a:link {
	/*방문하지 않은 링크 설정.*/
	text-decoration: none; /*밑줄 안나오도록 처리.*/
	color: green;
}

a:visited {
	/*방문한 링크 설정*/
	text-decoration: none;
	color: green;
}

a:hover {
	/*마우스 포인터가 올라간 시점의 설정.*/
	text-decoration: underline;
	color: red;
}

a:active {
	/*마우스를 링크에 클릭하는 시점*/
	color: blue;
}

table, td {
/* 	border: 1px solid gray; */
	width:auto;
/* 	text-align:center; */
}

table {
	border-collapse: collapse;
	width: 1000px;
}

td {
	padding: 10px;
	text-align:center;
}

</style>
<a href="/MMONG/group/groupDate/groupDate_form.do">일정 등록</a>

<h2>전체 일정 목록</h2>
<table>
	<thead>
		<tr>
			<td>일정이름</td>
			<td>장소</td>
			<td>시간</td>
			<td>상세보기</td>
		<tr>
	</thead>
	
	<c:forEach items="${requestScope.groupDateList }" var="groupDate">
	<tbody>
		<tr>
			<td><li>${groupDate.title }</td>
			<td>${groupDate.place }</td>
			<td><fmt:formatDate value="${groupDate.groupDate }" pattern="yyyy-MM-dd HH:mm" /></td>
			<td><input type="button" value="상세보기" onclick="location.href='/MMONG/group/groupDate/groupDateView.do?groupDateNo=${groupDate.no}'"></td>
		</tr>
	</tbody>
</c:forEach>
</table>

<%-- 검색 창 --%>
<form action="/MMONG/group/groupDate/allGroupDateList.do">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<select name="option">
			<option value="title">일정이름</option>
			<option value="place">장소</option>
			<option value="dateTime">날짜</option>
		</select>
			<input type="text" name="key" placeholder="날짜는 yyyy-mm-dd 입력"> 
			<input type="submit" value="검색">
</form>



<%-- ################### 페이징 ################ --%>

	<%-- 첫 페이지로 이동 --%>
	<p align="center">
		<a href="/MMONG/group/groupDate/allGroupDateList.do?page=1">첫 페이지</a>

		<%-- 이전 페이지 그룹 처리 --%>
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<%-- 이전 페이지 그룹이 있다면 isPreviousPageGroup() 호출 --%>
				<a
					href="/MMONG/group/groupDate/allGroupDateList.do?page=${requestScope.pageBean.beginPage - 1 }">◀</a>
			</c:when>
			<c:otherwise>
			◀
		</c:otherwise>
		</c:choose>

		<%-- 현재 page가 속한 page 그룹 내의 페이지들 링크 --%>
		<c:forEach begin="${requestScope.pageBean.beginPage }"
			end="${requestScope.pageBean.endPage }" var="page">
			<c:choose>
				<c:when test="${requestScope.pageBean.page != page }">
					<!-- 현재 페이지가 아니라면 -->
					<a href="/MMONG/group/groupDate/allGroupDateList.do?page=${page}">${page }&nbsp;&nbsp;</a>
				</c:when>
				<c:otherwise>
				[${page }]&nbsp;&nbsp;  <%-- &nbsp;는 공백을 나타냄 --%>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!-- 다음페이지 그룹으로 이동. 만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리 -->
		<c:choose>
			<c:when test="${requestScope.pageBean.nextPageGroup }">
				<%-- isNextPageGroup() 호출 --%>
				<a
					href="/MMONG/group/groupDate/allGroupDateList.do?page=${requestScope.pageBean.endPage + 1 }">▶</a>
				<%-- getEndPage()에서 리턴된 값 넣기 --%>
			</c:when>
			<c:otherwise>
			▶
		</c:otherwise>
		</c:choose>

		<!-- 마지막 페이지로 이동 -->
		<a href="/MMONG/group/groupDate/allGroupDateList.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>
	</p>







</body>
</html>