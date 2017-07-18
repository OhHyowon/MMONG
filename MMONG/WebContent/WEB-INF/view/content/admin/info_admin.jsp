<%@ page contentType="text/html;charset=UTF-8"%>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//권한변경 확인 팝업
	 $("#adminAuthorityBtn").on("click",function(){
		if(confirm("권한을 변경하시겠습니까?")){
		}else{
			return false;
		}
	 });
});

</script>

<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>검색한 관리자 정보조회
		</h3>
 
 
 
 
 
 
관리자 ID : ${requestScope.administrator.adminId }<br>
권한 : ${requestScope.administrator.user.userAuthority}<br>
이름 : ${requestScope.administrator.adminName}<br>
전화번호 : ${requestScope.administrator.adminPhone }<br>
이메일 : ${requestScope.administrator.adminEmail }<br>

<a href="/MMONG/index.do">메인페이지</a>





<br>

<form action="/MMONG/admin/changeAdminAuthority.do" method="post">
	<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit"  id="adminAuthorityBtn" value="활동 정지/재개 변경">
</form>
</section>
