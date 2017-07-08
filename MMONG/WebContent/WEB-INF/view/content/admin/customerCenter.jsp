<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>고객센터</h2>

<%-- ========================menu 영역 =================== --%>
<ul>
	<%-- 비회원 메뉴 --%>
	<sec:authorize access="!isAuthenticated()">		
		<li><a href="/MMONG/login_form.do">로그인</a></li>
		<li><a href="/MMONG/member/register_form.do">회원가입</a></li>
	</sec:authorize>

	<%-- 회원메뉴 --%>
	<sec:authorize access="isAuthenticated()">
		<li><a href="javascript:logout()">로그아웃</a>
	</sec:authorize>	

	<%-- 회원 메뉴 : 개인회원 메뉴 /member로 시작 --%>
	<sec:authorize access="hasRole('ROLE_1')">
		<li><a href="/MMONG/member/mypage.do">회원 정보조회</a></li>
	</sec:authorize>
	
	<%-- 관리자 메뉴 : 관리자 메뉴 /admin으로 시작 --%>
	<sec:authorize access="hasRole('ROLE_0')">
		<li><a href="/MMONG/admin/searchMemberById.do">회원 정보조회</a></li>
	</sec:authorize>
	
	
</ul>
<%-- =======================menu 영역 끝=================== --%>


<hr>


<%-- =======================대menu 영역 =================== --%>
<ul>
	<li><a href="/MMONG/admin/customerCenter.do">고객센터</a></li>
</ul>	
<%-- ======================대menu 영역 끝=================== --%>	


<hr>


<%-- ================소모임 페이지 소메뉴=================== --%>
<ul>	

		
	<%-- 관리자메뉴 --%>
	<sec:authorize access="hasRole('ROLE_0')">
		<li> <a href="/MMONG/admin/register_form.do">관리자 등록</a></li>	
		<li><a href="/MMONG/admin/search_admin_form.do">관리자 찾기 폼</a></li>
		<li><a href="/MMONG/admin/search_member_form.do">회원(member) 찾기 폼</a></li>
	</sec:authorize>
		
		<%--공지사항 목록조회 메뉴 : selectAdminNoticeList.jsp로 가기 --%>
		<li><a href="/MMONG/adminNotice/selectAdminNoticeList.do">공지사항 목록 조회</a></li>
		
		
		
		
</ul>
<%-- ==============소모임 페이지 소메뉴 끝================== --%>

<hr>

</body>
</html>













