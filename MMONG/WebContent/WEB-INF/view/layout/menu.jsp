<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


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
		<li><a href="/MMONG/message.do">쪽지 관리</a></li>          
	</sec:authorize>
	
	<%-- 관리자 메뉴 : 관리자회원 메뉴 /admin으로 시작 --%>
	<sec:authorize access="hasRole('ROLE_0')">
		<li><a href="/MMONG/admin/mypage.do">관리자 정보조회</a></li>          
	</sec:authorize>
</ul>
<hr>
<%-- =======================menu 영역 끝=================== --%>





<%-- =======================대menu 영역 =================== --%>
<ul>
	<sec:authorize access="hasRole('ROLE_0')">
		<li> <a href="/MMONG/admin/member_manage.do">회원관리</a></li>
	</sec:authorize>
	<li><a href="/MMONG/map/basic_map.do">기본 맵</a></li>
	<li><a href="/MMONG/group/mygroup.do">소모임</a></li>
	<li><a href="/MMONG/admin/customerCenter.do">고객센터</a></li>
	<li><a href="/MMONG/health/list.do">건강관리</a></li>
</ul> 
<hr>  
<%-- ======================대menu 영역 끝=================== --%>  


<script type="text/javascript">
   function logout(){
      document.getElementById("logoutForm").submit();
   }
</script>
<form id="logoutForm" action="/MMONG/logout.do" method="post" style="display:none">
<sec:csrfInput/>
</form> 


