<%@page import="com.mmong.vo.Group"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#leaveBtn").on("click", function() {
			var leader = $("#leader").val();
			var loginId = $("#loginId").val();

			if (leader == loginId) {
				alert("모임장은 모임을 탈퇴 할 수 없습니다!!!");
			} else {
				if (!confirm("정말 모임을 탈퇴 하시겠습니까?")) {
					return;
				} else {
					$.ajax({
						url : "/MMONG/groupMember/leaveGroup.do",
						type : "post",
						data : {
							"${_csrf.parameterName}" : "${_csrf.token}"
						},
						dataType : "json",
						success : function(txt) {
							if (txt == '1') {
								alert("탈퇴 하였습니다.");
								location.href = "/MMONG/group/mygroup.do"
							} else {
								alert("탈퇴 불가");
							}
						}
					}); // ajax 끝
				}
			}
		});
	});
</script>


	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>소모임 참여 멤버
		</h3>
<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
<ul>
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정
			목록</a></li>
	<!-- 소모임 상세페이지 첫 화면 -->
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
	<li><a href="/MMONG/groupMember/searchGroupMember.do">참여 멤버 목록</a></li>
</ul>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>




<!-- 참여자 목록 -->
<p>
	<b>참여 멤버</b>
</p>
<sec:authorize access="!isAuthenticated()">
		로그인 해주세요. 
	</sec:authorize>
<sec:authorize access="isAuthenticated()">
	<c:choose>
		<c:when test="${groupMemberList == null}">
				참여 멤버 목록 조회는 모임 멤버만 가능합니다. 
			</c:when>
		<c:otherwise>
			<c:forEach var="groupMember" items="${groupMemberList }">
				- 이름 : ${groupMember.memberId }<br>
			</c:forEach>
			<input type="button" id="leaveBtn" value="모임탈퇴">
		</c:otherwise>
	</c:choose>

</sec:authorize>

<sec:authentication property="principal.memberId" var="loginId" />

<c:if test="${requestScope.leader eq loginId}">
	<input type="button" value="모임장 변경하기"
		onclick="window.open('/MMONG/groupMember/searchGroupMember2.do', '모임장 변경하기', 'top=100px, left=100px, height=220px, width=500px')">
</c:if>

<input type="hidden" id="leader" value="${requestScope.leader }">
<input type="hidden" id="loginId" value="${loginId }">


<script type="text/javascript">
	function logout() {
		document.getElementById("logoutForm").submit();
	}
</script>
<form id="logoutForm" action="/MMONG/logout.do" method="post"
	style="display: none">
	<sec:csrfInput />
</form>
</section>
