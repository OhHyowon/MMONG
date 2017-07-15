<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
a:link {
	/*방문하지 않은 링크 설정.*/
	text-decoration: none; /*밑줄 안나오도록 처리.*/
/* 	color: green; */
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
	border: 1px solid gray;
	width:auto;
	text-align:center;
}

table {
	border-collapse: collapse;
	width: 1000px;
}

td {
	padding: 10px;
	text-align:center;
}

.messageGo {
    position: relative;
}

.messageGo .messageGoTxt {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;

    /* Position the tooltip */
    position: absolute;
    z-index: 1;
}

.messageGo:hover .messageGoTxt {
    visibility: visible;
}
</style>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.messageGoTxt').on("click",function(){
		alert("올ㅋ 되는뎅ㅋ 여기서 세연이한테 쪽지 주소 받고, 아이디, 닉네임 넘겨 주면 됩니다!");
	});
});

</script>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>자유게시판
		</h3>
	

	
<c:choose>
	<c:when test="${requestScope.check == 1}"> <!-- check가 1이면 볼 권한 있음 -->




<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
<ul>
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정 목록</a></li> <!-- 소모임 상세페이지 첫 화면 -->
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
	<li><a href="/MMONG/groupMember/searchGroupMember.do">참여 멤버 목록</a></li>
</ul>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>
<hr>

<ul>
	<li><a href="/MMONG/group/board/board_form.do">게시글작성</a></li>
	<li><a href="/MMONG/group/board/myBoardList.do">내가 쓴 글 보기</a>
	<li><a href="/MMONG/group/reply/myReplyList.do">내가 쓴 댓글 보기</a>
</ul>

<c:choose>
	<c:when test='${fn:length(requestScope.boardList)!=0 }'>

	<h3>게시판 전체 목록</h3>
	<table>
		<thead>
			<tr>
				<td>글번호</td>
				<td>제목</td>
				<td>작성자(닉네임)</td>
				<td>작성일시</td>
				<td>조회수</td>
			</tr>
		</thead>

	<c:forEach items="${requestScope.boardList }" var="board" varStatus="idx">
		<c:choose>
			<c:when test="${board.replyCount!=0 }">
				<tbody>
					<tr>
						<td>${board.no }</td>
						<td><a href="/MMONG/group/board/board_view.do?boardNo=${board.no }">${board.title }[${board.replyCount}]</a></td>
						<td class="messageGo">${board.memberId }(${requestScope.nickNameList[idx.index] })
							<div class="messageGoTxt" >쪽지보내기</div>
						</td>
						<td><fmt:formatDate value="${board.boardDate }" pattern="yyyy-MM-dd HH:mm" />
						</td>
						<td>${board.hit }</td>
					</tr>
			</c:when>
			<c:otherwise>
				<tr>
					<td>${board.no }</td>
					<td><a href="/MMONG/group/board/board_view.do?boardNo=${board.no }">${board.title }</a></td>
					<td class="messageGo">${board.memberId }(${requestScope.nickNameList[idx.index] })
						<div class="messageGoTxt">쪽지보내기</div>
					</td>
					<td><fmt:formatDate value="${board.boardDate }" pattern="yyyy-MM-dd HH:mm" /></td>
					<td>${board.hit }</td>
				</tr>
			</c:otherwise>
			
		</c:choose>
	</c:forEach>
	</tbody>
	</table>




 <%-- 검색 창 --%>
	<form action="/MMONG/group/board/allBoardListByKey.do">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<select name="option">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자ID</option>
			<input type="text" name="key">
			<input type="submit" value="검색">
		</select>
	</form>


	<%-- ################### 페이징 ################ --%>

	<%-- 첫 페이지로 이동 --%>
	<p align="center">
		<a href="/MMONG/group/board/allBoardList.do?page=1&groupNo=${requestScope.groupNo}">첫 페이지</a>

		<%-- 이전 페이지 그룹 처리 --%>
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<%-- 이전 페이지 그룹이 있다면 isPreviousPageGroup() 호출 --%>
				<a
					href="/MMONG/group/board/allBoardList.do?page=${requestScope.pageBean.beginPage - 1 }&groupNo=${sessionScope.groupNo}">◀</a>
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
					<a href="/MMONG/group/board/allBoardList.do?page=${page}&groupNo=${sessionScope.groupNo}">${page }&nbsp;&nbsp;</a>
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
					href="/MMONG/group/board/allBoardList.do?page=${requestScope.pageBean.endPage + 1 }&groupNo=${sessionScope.groupNo}">▶</a>
				<%-- getEndPage()에서 리턴된 값 넣기 --%>
			</c:when>
			<c:otherwise>
			▶
		</c:otherwise>
		</c:choose>

		<!-- 마지막 페이지로 이동 -->
		<a
			href="/MMONG/group/board/allBoardList.do?page=${requestScope.pageBean.totalPage}&groupNo=${sessionScope.groupNo}">마지막
			페이지</a>
	</p>
	</c:when>
		<c:otherwise>
			등록된 게시물이 없습니다. 
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	
		</c:when>
		<c:otherwise>
			모임 참여자만 볼 수 있습니다. 모임 참여 해주세요 ^_^
		</c:otherwise>
</c:choose>
	</section>
