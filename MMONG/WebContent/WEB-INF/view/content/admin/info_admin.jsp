<%@ page contentType="text/html;charset=UTF-8"%>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//권한변경 확인 팝업
	 $("#adminAuthorityBtn").on("click",function(){
		if(confirm("접근을 정지 시키겠습니까?")){
			alert("접근이 정지되었습니다.")
		}else{
			return false;
		}
	 });
});
</script>
<h3>검색한 관리자 정보조회</h3>
관리자 ID : ${requestScope.administrator.adminId }<br>
권한 : ${requestScope.administrator.user.userAuthority}<br>
이름 : ${requestScope.administrator.adminName}<br>
전화번호 : ${requestScope.administrator.adminPhone }<br>
이메일 : ${requestScope.administrator.adminEmail }<br>
enable : ${requestScope.administrator.user.userEnable}<br>

<a href="/MMONG/index.do">메인페이지</a>

<form action="/MMONG/admin/info_admin_update_form.do" method="post">
	<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="관리자 정보 수정하기">
</form>
<br>

<form action="/MMONG/admin/changeEnable.do" method="post">
	<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit"  id="adminAuthorityBtn" value="관리자 enable 변경">	
</form>

