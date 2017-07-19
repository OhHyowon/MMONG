<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
a:link {
	/*방문하지 않은 링크 설정.*/
	text-decoration: none; /*밑줄 안나오도록 처리.*/
	/* color: green; */
}

a:visited {
	/*방문한 링크 설정*/
	text-decoration: none;
	/* color: green; */
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
	width: auto;
	/* text-align: center; */
}

table {
	border-collapse: collapse;
	width: 1000px;
}

td {
	padding: 10px;
	text-align: center;
}

#form{
	 text-align: center;
}



</style>
<script type="text/javascript"
		src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
	
		$(document).ready(function() {
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
				if(!confirm("선택된 " + cnt + "개 게시물을 삭제 하시겠습니까?")){
					return;
				}else{
				var boardNoList = [];
				$("input[class='check']:checked").each(function() {
					alert($(this).val());
					boardNoList.push($(this).val());
				});

				jQuery.ajaxSettings.traditional = true;
				$.ajax({
					url : "/MMONG/group/board/deleteMyBoardList.do",
					type : "post",
					data : {
						"boardNoList" : boardNoList,
						"${_csrf.parameterName}" : "${_csrf.token}"
					},
					success : function(txt) {
						if (txt == '1') {
							alert("삭제되었습니다.");
							location.href = "/MMONG/group/board/myBoardList.do"
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

<%-- =============소모임 상세페이지 소메뉴 : 밑에 두메뉴안에도 이것 포함시키기! ================ --%>
	<div class="btn-group btn-group-justified" style="margin-top:50px; margin-bottom:30px;"">
	  <div class="btn-group">
	    <a href="/MMONG/group/groupDate/allGroupDateList.do"><button type="button" class="btn btn-theme">모임 일정 목록</button></a>
	  </div>
	  <div class="btn-group">
	    <a href="/MMONG/group/board/allBoardList.do"><button type="button" class="btn btn-theme">자유게시판</button></a>
	  </div>
	  <div class="btn-group">
	    <a href="/MMONG/group/mygroup.do"><button type="button" class="btn btn-theme">나의 소모임</button></a>
	  </div>
	</div>			
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>

<hr>
	<input type="button"class="btn btn-default btn-sm" value="글쓰기" onclick="location.href='/MMONG/group/board/board_form.do'">
	<input type="button"class="btn btn-default btn-sm" value="내가 쓴 글" onclick="location.href='/MMONG/group/board/myBoardList.do'">
	<input type="button"class="btn btn-default btn-sm" value="내가 쓴 댓글" onclick="location.href='/MMONG/group/reply/myReplyList.do'">


<c:choose>
	<c:when test="${fn:length(requestScope.myBoardList)!=0 }">

<div class="col-md-12">
	      <h4>자유게시판</h4>
	      	<input type="button" id="deleteBtn" value="삭제하기"class="btn btn-default btn-sm">
	          <hr>
<table class="table">
	<thead>
			<tr>
				<td><input type="checkbox" id="allCheckBtn" name="allCheck"></td>
				<td>글번호</td>
				<td>제목</td>
				<td>작성일시</td>
				<td>조회수</td>
			</tr>
		</thead>


		<c:forEach items="${requestScope.myBoardList }" var="board"
			varStatus="idx">
			<c:choose>
				<c:when test="${board.replyCount!=0 }">
					<tbody>
						<tr>
							<td><input type="checkbox" class="check"
								value='${board.no }'></td>
							<td><a
								href="/MMONG/group/board/board_view.do?boardNo=${board.no }">${board.title }[${board.replyCount}]</a></td>
							<td>${board.title }</td>
							<td><fmt:formatDate value="${board.boardDate }"
									pattern="yyyy-MM-dd  HH:mm" /></td>
							<td>${board.hit }</td>
						</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td><input type="checkbox" class="check" value='${board.no }'></td>
						<td><a
							href="/MMONG/group/board/board_view.do?boardNo=${board.no }">${board.title }</a></td>
						<td>${board.title }</td>
						<td><fmt:formatDate value="${board.boardDate }"
								pattern="yyyy-MM-dd  HH:mm" /></td>
						<td>${board.hit }</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</tbody>
	</table>







	<%-- ################### 페이징 ################ --%>

	<%-- 첫 페이지로 이동 --%>
	<p align="center">
		<a href="/MMONG/group/board/myBoardList.do?page=1&groupNo=${sessionScope.groupNo }">첫 페이지</a>

		<%-- 이전 페이지 그룹 처리 --%>
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<%-- 이전 페이지 그룹이 있다면 isPreviousPageGroup() 호출 --%>
				<a
					href="/MMONG/group/board/myBoardList.do?page=${requestScope.pageBean.beginPage - 1 }&groupNo=${sessionScope.groupNo }">◀</a>
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
					<a href="/MMONG/group/board/myBoardList.do?page=${page}&groupNo=${sessionScope.groupNo }">${page }&nbsp;&nbsp;</a>
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
					href="/MMONG/group/board/myBoardList.do?page=${requestScope.pageBean.endPage + 1 }&groupNo=${sessionScope.groupNo }">▶</a>
				<%-- getEndPage()에서 리턴된 값 넣기 --%>
			</c:when>
			<c:otherwise>
			▶
		</c:otherwise>
		</c:choose>

		<!-- 마지막 페이지로 이동 -->
		<a
			href="/MMONG/group/board/myBoardList.do?page=${requestScope.pageBean.totalPage}&groupNo=${sessionScope.groupNo }">마지막
			페이지</a>
	</p>
	
	<%-- 검색창 --%>
<div id="form">
	<form action="/MMONG/group/board/myBoardList.do">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<select name="option"  style="height:24.4px; margin-top:3px">
			<option value="title">제목</option>
			<option value="content">내용</option>
		</select>
			<input type="text" name="key" style="margin-bottom:1px;margin-left:3px">
			<input class="btn btn-default btn-sm" type="submit" value="검색"  style="margin-left:3px">
	</form>
	</div>
	
	</div>
	</c:when>
	<c:otherwise>
		<p style="text-align:center">
		내가 쓴 게시물이 없습니다.
		</p>
	</c:otherwise>
	</c:choose>
</section>
</div>