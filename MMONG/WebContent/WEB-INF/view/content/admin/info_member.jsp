<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style type="text/css">
#view-menu{
	text-align: center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//권한변경 확인 팝업
	 $("#memberAuthorityBtn").on("click",function(){
		if(confirm("권한을 변경하시겠습니까?")){
		}else{
			return false;
		}
	 });
});
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			회원정보 조회
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
		
		
		
		
		
		
 
<div style="height:auto; min-width: 350px; text-align:center;">
		<div>
			<h5>회원정보</h5>
		</div>
		<p><img src="/MMONG/up_image/profilePicture.PNG" class="img-circle" width="100"></p> 
		<p><b>ID :${requestScope.member.user.userId}</b></p>
				<p><b>이름</b> : ${requestScope.member.memberName }</p>
				<p><b>전화번호</b> : ${requestScope.member.memberPhone }</p>
				<p><b>이메일</b> : ${requestScope.member.memberEmail}</p>
				<%-- <p><b>주소</b> : ${requestScope.member.memberAddress}</p> --%>
				<p><b>권한</b> : ${requestScope.member.user.userAuthority}</p>
</div>

<div id="view-menu">
	<form action="/MMONG/admin/changeMemberAuthority.do" method="post">
										<input type="hidden" name="memberId" value="${requestScope.member.user.userId}">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<input class="btn btn-default btn-sm" type="submit" id="memberAuthorityBtn" value="활동 정지/재개 변경">
							   </form>
</div>
</section>
</div>