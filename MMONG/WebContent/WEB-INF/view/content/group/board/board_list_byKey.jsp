<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}

$(document).ready(function(){
	
	//팝업창 크기 조절
	var width=480, height=480;
	var left = (screen.availWidth - width)/2;
	var top = (screen.availHeight - height)/2;
	var specs = "width=" + width;
	specs += ",height=" + height;
	specs += ",left=" + left;
	specs += ",top=" + top;
	
	$(".messageGoTxt").on("click", function(){
		var id = $("#id").val()
		var nickname = $("#nickname").val();

		window.open("/MMONG/message/idNnickFromBoard.do?id="+id+"&nickname="+nickname, "쪽지보내기", specs);
	});
});
	
</script>
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

#form{
	text-align:center;
}
</style>

<div id="total_div">
	<section class="wrapper site-min-height">

	

	
<c:choose>
	<c:when test="${requestScope.check == 1}"> <!-- check가 1이면 볼 권한 있음 -->


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
	<c:when test='${fn:length(requestScope.boardList)!=0 }'>

<div class="col-md-12">
	      <h4>자유게시판</h4>
	          <hr>
<table class="table">
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
							<div class="messageGoTxt">쪽지보내기
								<input type="hidden" value="${board.memberId }" id="id">
								<input type="hidden" value="${requestScope.nickNameList[idx.index] }" id="nickname">
							</div>
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
						<div class="messageGoTxt">쪽지보내기
							<input type="hidden" value="${board.memberId }" id="id">
							<input type="hidden" value="${requestScope.nickNameList[idx.index] }" id="nickname">
						</div>
					</td>
					<td><fmt:formatDate value="${board.boardDate }" pattern="yyyy-MM-dd HH:mm" /></td>
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
		<a href="/MMONG/group/board/allBoardListByKey.do?page=1&groupNo=${requestScope.groupNo}&key=${requestScope.key}&option=${requestScope.option}">첫 페이지</a>

		<%-- 이전 페이지 그룹 처리 --%>
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<%-- 이전 페이지 그룹이 있다면 isPreviousPageGroup() 호출 --%>
				<a
					href="/MMONG/group/board/allBoardListByKey.do?page=${requestScope.pageBean.beginPage - 1 }&groupNo=${sessionScope.groupNo}&key=${requestScope.key}&option=${requestScope.option}">◀</a>
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
					<a href="/MMONG/group/board/allBoardListByKey.do?page=${page}&groupNo=${sessionScope.groupNo}&key=${requestScope.key}&option=${requestScope.option}">${page }&nbsp;&nbsp;</a>
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
					href="/MMONG/group/board/allBoardListByKey.do?page=${requestScope.pageBean.endPage + 1 }&groupNo=${sessionScope.groupNo}&key=${requestScope.key}&option=${requestScope.option}">▶</a>
				<%-- getEndPage()에서 리턴된 값 넣기 --%>
			</c:when>
			<c:otherwise>
			▶
		</c:otherwise>
		</c:choose>

		<!-- 마지막 페이지로 이동 -->
		<a
			href="/MMONG/group/board/allBoardListByKey.do?page=${requestScope.pageBean.totalPage}&groupNo=${sessionScope.groupNo}&key=${requestScope.key}&option=${requestScope.option}">마지막
			페이지</a>
	</p>
<c:set var="optionValue" value="${requestScope.option }"/>

<%
	String optionValue=(String)request.getAttribute("option");
%>


 <%-- 검색 창 --%>
 <div id="form">
 	<form action="/MMONG/group/board/allBoardListByKey.do">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<select name="option" style="height:24.4px; margin-top:3px">
			<option value="title" <%if(optionValue.equals("title")){%>selected<%} %>>제목</option>
			<option value="content" <%if(optionValue.equals("content")){%>selected<%} %>>내용</option>
			<option value="writer" <%if(optionValue.equals("writer")){%>selected<%} %>>작성자ID</option>
		</select>
			<input type="text" name="key" value="${requestScope.key }"  style="margin-bottom:1px;margin-left:3px">
			<input class="btn btn-default btn-sm" type="submit" value="검색"  style="margin-left:3px">
	</form>
	</div>
	</div>
	
	</c:when>
		<c:otherwise>
		<p style="text-align:center">
			'${requestScope.key }' (으)로 조회된 게시물이 없습니다. 
		</p>
		</c:otherwise>
	</c:choose>

		</c:when>
		<c:otherwise>
		<p style="text-align:center">
			모임 참여자만 볼 수 있습니다. 모임 참여를 해주세요~</p>
		</c:otherwise>
</c:choose>
	</section>
</div>