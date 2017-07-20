<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 관리자 등록 성공
		</h3>
		
<sec:authorize access="hasRole('ROLE_0')">
	<div class="btn-group btn-group-justified" style="margin-top:50px; margin-bottom:30px;">
		<div class="btn-group">
				<button class="btn btn-theme" type="button" onclick="location.href='/MMONG/admin/register_form.do' ">관리자 등록</button>&nbsp;
		</div>
		<div class="btn-group">	
				<button class="btn btn-theme" type="button" onclick="location.href='/MMONG/admin/search_admin_form.do' ">관리자 찾기</button>&nbsp;
		</div>
		<div class="btn-group">	
				<button class="btn btn-theme" type="button" onclick="location.href='/MMONG/admin/search_member_form.do' ">회원 찾기</button>&nbsp;
		</div>
	</div>
</sec:authorize>		
		
		
		
		
 '${requestScope.administrator.adminId }'님을 관리자로 등록하였습니다<br>

</section>
</div>