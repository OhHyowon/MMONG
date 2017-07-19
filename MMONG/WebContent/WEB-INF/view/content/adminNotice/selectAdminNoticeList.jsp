<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<style type="text/css">
table {
    border-collapse: collapse;
    width: 1000px;
}
th, td {
    padding: 4px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

tr:hover {background-color: #f9efd4}

#search{
	text-align:center;
}
#list-menu{
	text-align: left;
}
.paging{
	text-align: center;
	color: black;
    padding: 8px 16px;
    text-decoration: none;
}
.paging a.active{
	 border-radius: 10px;
     border: 1px solid #adaba6;
}
.paging a:hover:not(.active) { 
	background-color: #efd575;
    color: white;
   
}
</style>






<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 공지사항 목록
		</h3>
		<hr>
<table class="table">
		<thead>
				<tr>
						<th>글 번호</th>
						<th>공지사항 제목</th>
						<th>작성일</th>
						<th>작성자</th>
				</tr>
		</thead>
		<tbody>
			<c:forEach items="${requestScope.adminNoticeList }" var="list">
				<tr>
						<td>${list.no }</td>
						<td><a href="/MMONG/adminNotice/viewAdminNotice.do?adminNoticeNo=${list.no }">${list.title}</a></td>			
						<td><fmt:formatDate value="${list.adminDate }" pattern="yyyy-MM-dd"/></td>
						<td>${list.adminId }</td>
				</tr>
			</c:forEach>
		</tbody>
</table>

<div id="list-menu">
			<sec:authorize access="hasRole('ROLE_0')">
				<input class="btn btn-default btn-sm" type="button" value="글쓰기" onclick="location.href='/MMONG/adminNotice/insertAdminNotice_form.do' ">
			</sec:authorize>
</div>		



<div class="paging">
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="/MMONG/adminNotice/selectAdminNoticeList.do?page=1">첫 페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup }">
					<!-- 이전 페이지 그룹이 있다면 : isPreviousPageGroup() -->
					<a href="/MMONG/adminNotice/selectAdminNoticeList.do?page=${requestScope.pageBean.beginPage - 1} ">◀</a>
		</c:when>
		<c:otherwise>
					◀
		</c:otherwise>
	</c:choose>
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작 page ~ 끝 page
	 -->
	 <!-- 만약에 page가 현재페이지이면 링크처리를 하지 않고, page가 현재페이지가 아니라면 링크처리. -->
	
	<c:forEach begin="${requestScope.pageBean.beginPage }" end="${requestScope.pageBean.endPage }" var="page" >
			<c:choose>
					<c:when test="${requestScope.pageBean.page != page }">
							<!-- 현재페이지가 아니라면 -->
								<a href="/MMONG/adminNotice/selectAdminNoticeList.do?page=${page}">${page }&nbsp;&nbsp;</a>
					</c:when>
					<c:otherwise>
								[${page }] &nbsp;&nbsp;
					</c:otherwise>
			</c:choose>
	</c:forEach>
	
	<!-- 
		다음페이지 그룹으로 이동
		만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
	 -->
	
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup }">
					<!-- 다음 페이지 그룹이 있다면 : isNextPageGroup() -->
					<a href="/MMONG/adminNotice/MMONG/adminNotice/selectAdminNoticeList?page=${requestScope.pageBean.endPage + 1 }">▶</a>
		</c:when>
		<c:otherwise>
					▶
		</c:otherwise>
	</c:choose>
	
	<!-- 마지막 페이지로 이동 -->
	<a href="/MMONG/adminNotice/selectAdminNoticeList.do?page=${requestScope.pageBean.totalPage}">마지막 페이지</a>
</div>
<div id="search">
		<form action="/MMONG/adminNotice/selectAdminNoticeList.do" method="post">
			<select name="option" style="height:24.4px; margin-top:3px">
							<option value="title">제목</option>
							<!-- <option>제목+내용</option> -->
							<option value="content">내용</option>
			</select> &nbsp;

			<input id="keyword" type="text" name="keyword">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input class="btn btn-default btn-sm" type="submit" value="검색">
		</form>
</div>

</section>
</div>

