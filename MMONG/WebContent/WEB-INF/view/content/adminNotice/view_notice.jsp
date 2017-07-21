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
			공지사항 상세조회 
		</h3>
<div id="view-detail">

</div>

		    <table style="border-top: 1px solid gray; border-bottom: 1px dashed; width: 943px; margin-botton: 1px">
				<tr>
					<td style="padding: 10px;">글 번호: ${requestScope.adminNotice.no }&nbsp;&nbsp;</td>
					<td style="text-align: center;">${requestScope.adminNotice.title}</td>
					<td style="text-align: right;">작성일: <fmt:formatDate value="${requestScope.adminNotice.adminDate }" pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>


			<table style="border-bottom: 1px solid gray; width: 943px">
				<tr>
					<td>관리자(${requestScope.adminNotice.administrator.adminId})</td>
				</tr>
				<tr>
					<td style="padding: 10px;">
							<textarea cols="80" rows="10" id="content" name="content" readonly >${requestScope.adminNotice.content}</textarea>
					</td>
				</tr>
			</table>


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