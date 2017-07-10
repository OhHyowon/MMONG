<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//로그인 안했을 때 소모임 생성 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	//소모임 하나 클릭했을 때 소모임 상세페이지로 이동 
	$(".myGroup").on("click", function(){
		$(this).parent().submit();
	});
});
</script>

<h3>소모임 페이지</h3>

<!-- 나의 소모임 뿌리기 -->
<p><b>나의 소모임</b></p>
<sec:authorize access="!isAuthenticated()">      
	로그인 해주세욥 <br>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
	<c:forEach var="myGroup" items="${myGroup }">
		<form id="groupInfo" action="/MMONG/group/groupDetail.do">
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
<input type="button" value="소모임 찾기" onClick="self.location='/MMONG/group/searchGroup.do';"> <br>

<!-- 소모임 추가 버튼 -->
<sec:authorize access="!isAuthenticated()"> 
	<button type="button" id="createNone">소모임 만들기</button>
</sec:authorize>
  <sec:authorize access="hasRole('ROLE_1')">  
	<button type="button" onclick="window.open('/MMONG/group/createGroup.do', '소모임 만들기', 'top=100px, left=100px, height=220px, width=500px')">소모임 만들기</button>
</sec:authorize>



