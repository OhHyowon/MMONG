<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h3>고객 센터</h3>

<%-- ================고객센터페이지 소메뉴=================== --%>
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
<%-- ==============고객센터페이지 소메뉴================== --%>

<hr>













