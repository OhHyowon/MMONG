<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

</script>
</head>
<body>
<h3>소모임 페이지</h3>

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
</ul>
<%-- =======================menu 영역 끝=================== --%>


<hr>


<%-- =======================대menu 영역 =================== --%>
<ul>
	<li><a href="/MMONG/group/mygroup.do">소모임</a></li>
</ul>	
<%-- ======================대menu 영역 끝=================== --%>	


<hr>


<%-- ================소모임 페이지 소메뉴=================== --%>
<ul>	
	<%-- 회원메뉴 --%>
	<sec:authorize access="hasRole('ROLE_1')"> <!-- 소모임 메뉴로 들어왔을 때 기본 메뉴 : 없으면 권한없음 메시지 -->
		<li><a href="/MMONG/group/mygroup.do">나의 소모임
	</sec:authorize>
	
	 <!-- 소모임 찾기 메뉴 : searchGroup.jsp로 가기 -->
		<li><a href="/MMONG/group/mygroup.do">소모임 찾기
</ul>
<%-- ==============소모임 페이지 소메뉴 끝================== --%>



<!-- 나의 소모임 뿌리기 -->


<!-- 소모임 추가 버튼 -->
<button type="button" onclick="window.open('/MMONG/group/createGroup.do', '소모임 만들기', 'top=100px, left=100px, height=500px, width=800px')">소모임 만들기</button>







<script type="text/javascript">
	function logout(){
		document.getElementById("logoutForm").submit();
	}
</script>
<form id="logoutForm" action="/MMONG/logout.do" method="post" style="display:none">
<sec:csrfInput/>
</form>

</body>
</html>