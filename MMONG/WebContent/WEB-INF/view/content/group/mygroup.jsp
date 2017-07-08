<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	$(".myGroup").on("click", function(){
		$(this).parent().submit();
	})
});
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


<!-- 나의 소모임 뿌리기 -->
<p><b>나의 소모임</b></p>
<sec:authorize access="!isAuthenticated()">      
	로그인 해주세욥 <br>
</sec:authorize>
<sec:authorize access="isAuthenticated()">      
	<c:forEach var="myGroup" items="${myGroup }">
		<form id="groupInfo" action="/MMONG/group/myGroupDetail.do">
			<div class="myGroup" id="${myGroup.no }" style="border:1px solid; padding:10px; margin:10px; width:300px;">
				소모임 이름 : ${myGroup.name } <br>
				모임 설명 : ${myGroup.content }
			</div>
			<input type="hidden" name="groupNo" value="${myGroup.no }">
			<sec:csrfInput/>
		</form>
	</c:forEach>
</sec:authorize>

<br>

<!-- 소모임 찾기 버튼 -->
<input type="button" value="소모임 찾기" onClick="self.location='/MMONG/group/';"> <br>

<!-- 소모임 추가 버튼 -->
<sec:authorize access="!isAuthenticated()">      
	<button type="button" id="createNone">소모임 만들기</button>
</sec:authorize>
<sec:authorize access="isAuthenticated()">      
	<button type="button" onclick="window.open('/MMONG/group/createGroup.do', '소모임 만들기', 'top=100px, left=100px, height=220px, width=500px')">소모임 만들기</button>
</sec:authorize>






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