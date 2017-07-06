<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 
</head>
<body>

<h3>index 페이지</h3>

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
         
	<%-- 소모임 - 자유게시판 (임시) --%>
	<sec:authorize access="hasRole('ROLE_1')">
	  <li><a href="/MMONG/group/board/board_form.do?userId=<sec:authentication property='principal.userId'/>">자유게시판 글쓰기</a>
	  <li><a href="/MMONG/group/board/allBoardList.do">자유게시판 목록</a>
	</sec:authorize>
   
   
   
	<li><a href="/MMONG/">고객센터</a></li>
	<%-- 고객센터 - 관리자 등록 (관리자메뉴)  --%>
	<sec:authorize access="hasRole('ROLE_0')">
		<li><a href="/MMONG/member/mypage.do">관리자 등록</a></li>	
	</sec:authorize>
      
      
      <li><a href="/MMONG/message.do?userId=<sec:authentication property="principal.userId"/>">쪽지 관리</a></li>
</ul>   
<%-- ======================대menu 영역 끝=================== --%>   




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