<%@page import="java.util.List"%>
<%@page import="com.mmong.vo.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.mmong.vo.Group"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//로그인 안했을 때 소모임 가입 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	//소모임 가입 처리
	$("#create").on("click", function(){
		if(confirm("소모임에 가입하시겠습니까?")){
			alert("완료");
			$.ajax({
				"url" : "/MMONG/groupMember/insertGroupMember.do",
				"data" : {"no":0, "groupNo":$("#groupNo").val(), "memberId":$("#memberId").val(), "${_csrf.parameterName}":"${_csrf.token}"},
				"dataType" : "text",
				"success":function(response) {
					if(response=="가입완료"){
						alert("가입이 완료되었습니다.");
					}
				}
			});//ajax 끝
		}
	});
	
	//주인장이 소모임 수정 버튼 클릭시
	$("#editGroupBtn").on("click", function(){
		alert("수정해야함~~");
	});
	
	//소모임 하나 클릭했을 때 소모임 상세페이지로 이동 
	$(".myGroup").on("click", function(){
		$(this).parent().submit();
	});
});
</script>

<h3>소모임 페이지 - 소모임 상세 페이지 </h3>

<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
<ul>
	
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정 목록</a></li> <!-- 소모임 상세페이지 첫 화면 -->
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
	<li><a href="/MMONG/groupMember/searchGroupMember.do">참여 멤버 목록</a></li>
</ul>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>


<!-- 그룹 상세페이지가 열릴 때마다 해당 소모임NO를 세션에 담음 -->
<%
	int groupNo = ((Group)request.getAttribute("group")).getNo();
	session.setAttribute("groupNo", groupNo);	
%>
<!-- 그룹 가입 시 그룹멤버 객체 만들어주기위해 넘겨줄 값 : 이건 예전에 만든거라 세션처리 못함 - 이주현 -->
<input type="hidden" id="groupNo" value="${requestScope.group.no}">
<sec:authorize access="hasRole('ROLE_1')">
	<input type="hidden" id="memberId" value="<sec:authentication property="principal.memberId"/>">
</sec:authorize>


<!-- 소모임 정보 -->
<p><b>모임 정보</b></p>
모임 이름 : ${requestScope.group.name } <br>
모임 장 : ${requestScope.group.leader } <br>

<!-- 가입하기 버튼 -->
<sec:authorize access="!isAuthenticated()"> <!-- 로그인 안했을시  -->       
   <button type="button" id="createNone">가입하기</button>
</sec:authorize>
<sec:authorize access="isAuthenticated()"> <!-- 로그인 했을시 -->
   <%
   List authList = (List)SecurityContextHolder.getContext().getAuthentication().getAuthorities(); //로그인한 사용자 권한정보 리스트
   String au = String.valueOf(authList.get(0));
   if(au.equals("ROLE_1")){//관리자인 경우 아무것도 안뜸 
      Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
      if(((Group)request.getAttribute("group")).getLeader().equals(member.getMemberId())){ //주인장은 가입하기 버튼 대신 소모임 정보수정 버튼 필요
         out.println("<button type='button' id='editGroupBtn'>소모임 수정하기</button>");
      }else{
         out.println("<button type='button' id='create'>가입하기</button>");
      }
   }
   %>
</sec:authorize>



<br>


<!-- 모임 일정 목록 -->
<p><b>모임 일정</b></p>
