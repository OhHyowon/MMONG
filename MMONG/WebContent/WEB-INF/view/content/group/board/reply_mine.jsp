<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style type="text/css">
a:link {
	/*방문하지 않은 링크 설정.*/
	text-decoration: none; /*밑줄 안나오도록 처리.*/
	/* color: gray; */
}

a:visited {
	/*방문한 링크 설정*/
	text-decoration: none;
	/* color: gray; */
}

a:hover {
	/*마우스 포인터가 올라간 시점의 설정.*/
	text-decoration: underline;
	color: black;
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
label{
	color: gray;
}
</style>

<script type="text/javascript"
		src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}

$(document).ready(function(){
	$("#allCheckBtn").on("click", function() {
		$("input[class='check']").prop("checked", this.checked);
	}); // end of CheckBtn
	
	$("input[class='check']").on("click", function() {
		if ($("input[class='check']").not(':checked').length > 0) {
			$("#allCheckBtn").prop("checked", false);
		}
	});
	
	$("#deleteBtn").on("click", function() {
		var cnt = $("input[class='check']").filter(":checked").length;
		if(!confirm("선택된 " + cnt + "개 댓글을 삭제 하시겠습니까?")){
			return ;
		}else{
			
		var replyNoList = [];
		$("input[class='check']:checked").each(function() {
			replyNoList.push($(this).val());
		});
		
		jQuery.ajaxSettings.traditional = true;
		$.ajax({
			url : "/MMONG/group/reply/deleteMyReplyList.do",
			type : "post",
			data : {
				"replyNoList" : replyNoList,
				"${_csrf.parameterName}" : "${_csrf.token}"
			},
			success : function(txt) {
				if (txt == '1') {
					alert("삭제되었습니다.");
					opener.parent.location.reload();
					location.href = "/MMONG/group/reply/myReplyList.do"
				} else {
					alert("삭제실패");
				}
			}
		});
		}
	});
		
});
	
</script>
<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>내가 쓴 댓글 목록
		</h3>
		
		
		
<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
<ul>
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정 목록</a></li> <!-- 소모임 상세페이지 첫 화면 -->
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
	<li><a href="/MMONG/groupMember/searchGroupMember.do">참여 멤버 목록</a></li>
</ul>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>
<hr>
	<a href="/MMONG/group/board/board_form.do">게시글작성</a> | 
	<a href="/MMONG/group/board/myBoardList.do">내가 쓴 글 보기</a> |
	<a href="/MMONG/group/reply/myReplyList.do">내가 쓴 댓글 보기</a> |

<c:choose>
	<c:when test="${fn:length(requestScope.myReplyList)!=0 }">


<div class="col-md-12">
	      <h4>자유게시판</h4>
<input type="button"  id="deleteBtn" value="삭제" class="btn btn-default btn-sm">
	          <hr>
<table class="table">
	<thead>
		<tr>
			<td><input type="checkbox" id="allCheckBtn" name="allCheck"></td>
			<td>내용
			</td>
		</tr>
	</thead>
	
<c:forEach items="${requestScope.myReplyList }" var="reply" varStatus="idx">
	<tbody>
		<tr>
			<td><input type="checkbox" class="check" value="${reply.no }"></td>
			<td>
				<label><fmt:formatDate value="${reply.replyDate }" pattern="yyyy-MM-dd HH:mm" /></label><br>
				<a id="notcolor" href="/MMONG/group/board/board_view.do?boardNo=${requestScope.boardNoList[idx.index] }"><strong>${reply.content }</strong></a><br>
				<label><a href="/MMONG/group/board/board_view.do?boardNo=${requestScope.boardNoList[idx.index] }">원문제목:${requestScope.boardTitle[idx.index]}</a></label><br>
			</td>
		<tr>
	</tbody>
</c:forEach>
</table>


	<%-- ################### 페이징 ################ --%>

	<%-- 첫 페이지로 이동 --%>
	<p align="center">
		<a href="/MMONG/group/reply/myReplyList.do?page=1">첫 페이지</a>

		<%-- 이전 페이지 그룹 처리 --%>
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<%-- 이전 페이지 그룹이 있다면 isPreviousPageGroup() 호출 --%>
				<a
					href="/MMONG/group/reply/myReplyList.do?page=${requestScope.pageBean.beginPage - 1 }">◀</a>
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
					<a href="/MMONG/group/reply/myReplyList.do?page=${page}">${page }&nbsp;&nbsp;</a>
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
					href="/MMONG/group/reply/myReplyList.do?page=${requestScope.pageBean.endPage + 1 }">▶</a>
				<%-- getEndPage()에서 리턴된 값 넣기 --%>
			</c:when>
			<c:otherwise>
			▶
		</c:otherwise>
		</c:choose>

		<!-- 마지막 페이지로 이동 -->
		<a
			href="/MMONG/group/reply/myReplyList.do?page=${requestScope.pageBean.totalPage}">마지막
			페이지</a>
	</p>
	</div>
	</c:when>
	<c:otherwise>
		<p style="text-align:center">내가 쓴 댓글이 없습니다.</p>
	</c:otherwise>
	
	

	</c:choose>
</section>
</div>