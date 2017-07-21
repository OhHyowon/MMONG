<%@ page contentType="text/html;charset=UTF-8"%>
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
	display: inline;
}

</style>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}//맨 아래 footer 보정

$(document).ready(function(){
	$("#withdrawalBtn").on("click", function(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			return true;
		}else{
			alert("탈퇴가 취소되었습니다.");
			return false;
		}
	});
});//ready 함수 끝
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>관리자 마이페이지</h3>
<div id="view-detail">


<div style="height:auto; min-width: 350px; text-align:center;">
		<div>
			<h5>관리자정보</h5>
		</div>
		<p><img src="/MMONG/up_image/profileAdmin.PNG" class="img-circle" width="100"></p> 
		<p><b>ID</b> : <sec:authentication property="principal.adminId"/></p>
		
				<p><b>이름</b> : ${requestScope.administrator.adminName}</p>
				<p><b>전화번호</b> : ${requestScope.administrator.adminPhone }</p>
				<p><b>이메일</b> : ${requestScope.administrator.adminEmail }</p>
		
	</div>
</div>
<div id="view-menu">
	<form action="/MMONG/admin/info_admin_update_form.do" method="post">
				<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input class="btn btn-default btn-sm" type="submit" value="관리자 정보수정">
	</form>&nbsp;
	<form action="/MMONG/admin/adminWithdrawal.do" method="post">
				<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"/>">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input id="withdrawalBtn" class="btn btn-default btn-sm" type="submit" value="관리자 탈퇴">
	</form>
</div>
</section>
</div>
