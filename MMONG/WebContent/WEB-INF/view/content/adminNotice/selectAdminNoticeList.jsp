<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>








	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 공지사항 목록
		</h3>
<table border="1">
		<thead>
				<tr>
						<td>공지사항 번호</td>
						<td>공지사항 제목</td>
						<td>작성일</td>
						<td>작성자</td>
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






<form action="/MMONG/adminNotice/selectAdminNoticeList.do" method="post">
	<select name="option">
					<option value="title">제목</option>
					<!-- <option>제목+내용</option> -->
					<option value="content">내용</option>
	</select>
	<input type="text" name="keyword">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="submit" value="검색">
</form>
	
<input type="button" value="메인페이지" onclick="location.href='/MMONG/index.do' ">

<sec:authorize access="hasRole('ROLE_0')">
	<input type="button" value="글쓰기" onclick="location.href='/MMONG/adminNotice/insertAdminNotice_form.do' ">
</sec:authorize>
	
	
	<%---==============---이상 정상 작동 : 아래의 페이징은 미완료.............============--%>
	
<p>

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


</p>
</section>
