<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
	
	var placeSplit;
	var place;
	for(var j=1; j<10; j++) {
		placeSplit = $("#splitIndex"+j+"").next().val();
		place = placeSplit.split("_");
		$("#splitIndex"+j+"").next().after(""+place[2]+"");
	}
}

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
	/* color: blue; */
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

#form{
	 text-align: center;
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




<c:choose>
	<c:when test='${fn:length(requestScope.groupDateList)!=0 }'>

<div class="col-md-12">

	      <h4>전체 일정</h4>
	          <hr>
<table class="table table-hover">
	<thead>
		<tr>
			<td>일정이름</td>
			<td>장소</td>
			<td>시간</td>
			<td>상세보기</td>
		<tr>
	</thead>
	<%int i=1; %>
	<c:forEach items="${requestScope.groupDateList }" var="groupDate">
	<tbody>
		<tr>
			<td><li>${groupDate.title }</li></td>
			<td><input type="hidden" id="splitIndex<%=i%>" value="<%=i%>"><input type="hidden" value="${groupDate.place }" id="placeSplit"></td>
			<td><fmt:formatDate value="${groupDate.groupDate }" pattern="yyyy-MM-dd HH:mm" /></td>
			<td><input type="button" value="상세보기" class="btn btn-default btn-sm" onclick="window.open('/MMONG/group/groupDate/groupDateView.do?groupDateNo=${groupDate.no}','일정 상세보기','top=100px, left=400px, height=500px, width=500px')">
			</td>
		</tr>
	</tbody>
	<%i++; %>
	</c:forEach>
</table>

<button id="inputBtn" class="btn btn-default btn-sm" onclick="location.href='/MMONG/group/groupDate/groupDate_form.do'"style="float:leftt;margin-right: 15px">일정 등록</button>

<%-- ################### 페이징 ################ --%>

	<%-- 첫 페이지로 이동 --%>
	<p align="center">
		<a href="/MMONG/group/groupDate/allGroupDateList.do?page=1">첫 페이지</a>

		<%-- 이전 페이지 그룹 처리 --%>
		<c:choose>
			<c:when test="${requestScope.pageBean.previousPageGroup }">
				<%-- 이전 페이지 그룹이 있다면 isPreviousPageGroup() 호출 --%>
				<a
					href="/MMONG/group/groupDate/allGroupDateList.do?page=${requestScope.pageBean.beginPage - 1 }">◀</a>
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
					<a href="/MMONG/group/groupDate/allGroupDateList.do?page=${page}">${page }&nbsp;&nbsp;</a>
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
					href="/MMONG/group/groupDate/allGroupDateList.do?page=${requestScope.pageBean.endPage + 1 }">▶</a>
				<%-- getEndPage()에서 리턴된 값 넣기 --%>
			</c:when>
			<c:otherwise>
			▶
		</c:otherwise>
		</c:choose>

		<!-- 마지막 페이지로 이동 -->
		<a href="/MMONG/group/groupDate/allGroupDateList.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>
	</p>

<%-- 검색 창 --%>
<div id="form">
<form action="/MMONG/group/groupDate/allGroupDateListByKey.do">
		* 날짜 : 검색일 이후의 날짜로 검색 됩니다.<br>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<select name="option" style="height:24.4px; margin-top:3px">
			<option value="title">일정이름</option>
			<option value="place">장소</option>
			<option value="dateTime">날짜</option>
		</select>
			<input type="text" name="key" placeholder="날짜:yyyy-mm-dd 입력" style="margin-bottom:1px;margin-left:3px"> 
			<input class="btn btn-default btn-sm" type="submit" value="검색" style="margin-left:3px">
</form>
</div>
</div>
</c:when>
<c:otherwise>
	<br> <div style="	text-align:center;">조회된 일정이 없습니다.<br>
	<button id="inputBtn" class="btn btn-default btn-sm" onclick="location.href='/MMONG/group/groupDate/groupDate_form.do'">일정 등록</button>
	</div>
</c:otherwise>
</c:choose>


		</c:when>
	<c:otherwise>
	<p style="text-align:center">
			모임 참여자만 볼 수 있습니다. 모임 참여를 해주세요~
			</p>
	</c:otherwise>
</c:choose>
	</section>
	</div>