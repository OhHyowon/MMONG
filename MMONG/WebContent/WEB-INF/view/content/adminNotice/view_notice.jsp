<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
#view-detail{
  top:0;right:0;bottom:0;left:0;
  display:flex;
  align-items:center;
  justify-content:center;
 
  display:-webkit-flex;
  -webkit-align-item;center;
  -webkit-justify-content:center;
}
#view-menu{
	text-align: center;
}
form{
	display:inline;
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
			<i class="fa fa-angle-right"></i> 공지사항 상세조회 
		</h3>
<div id="view-detail">
	<table>
				<tr>
					 <th>글 번호: </th>
	                <td>${requestScope.adminNotice.no }</td>
				</tr>
				<tr>
					<th>작성일: </th>
	                <td><fmt:formatDate value="${requestScope.adminNotice.adminDate }" pattern="yyyy-MM-dd"/></td>
				</tr>
	        	<tr>
	                <th>작성자: </th>
	                <td>${requestScope.adminNotice.administrator.adminId}</td>
	            </tr>
	            <tr>
	                <th>제목: </th>
	                <td>${requestScope.adminNotice.title}</td>
	            </tr>
	            <tr>
	                <th>내용: </th>
	                <td>${requestScope.adminNotice.content}</td>
	            </tr>
	         </tbody>
	         <tbody>
</table>
</div>
<br>
<div id="view-menu">
	<sec:authorize access="hasRole('ROLE_0')">
	            <form action="/MMONG/adminNotice/updateAdminNotice_form.do" method="post">
					<input type="hidden" name="adminNoticeNo" value="${requestScope.adminNotice.no }"/>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input class="btn btn-default btn-sm" type="submit" value="수정">
				</form>&nbsp;
				<form action="/MMONG/adminNotice/deleteAdminNotice.do" method="post">
						<input type="hidden" name="adminNoticeNo" value="${requestScope.adminNotice.no }"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input class="btn btn-default btn-sm" type="submit" value="삭제">
				</form>&nbsp;
	</sec:authorize>
		<input class="btn btn-default btn-sm" type="button" value="목록" onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do' ">
</div>
</section>
</div>