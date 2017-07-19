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
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>검색한 관리자 정보조회
		</h3>
 
 
<table>
<tr>
	<th>관리자 ID : </th>
	<td>${requestScope.administrator.adminId }</td>
<tr>
 <tr>
	<th>권한 : </th>
	<td>${requestScope.administrator.user.userAuthority}</td>
<tr>
 <tr>
	<th>이름 : </th>
	<td>${requestScope.administrator.adminName}</td>
<tr>
 <tr>
	<th>전화번호 : </th>
	<td>${requestScope.administrator.adminPhone }</td>
<tr>
 <tr>
	<th>이메일 : </th>
	<td>${requestScope.administrator.adminEmail }</td>
<tr>
<tr>
	<td colspan="2"><form action="/MMONG/admin/changeAdminAuthority.do" method="post">
			<input type="hidden" name="adminId" value="${requestScope.administrator.adminId }">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input class="btn btn-default btn-sm" type="submit"  id="adminAuthorityBtn" value="활동 정지/재개 변경">
			</form>
	</td>
<tr>
</table>

</section>
</div>