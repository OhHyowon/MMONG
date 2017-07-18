<%@ page contentType="text/html;charset=UTF-8"%>



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

</script>
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>회원정보 조회
		</h3>
 
 
<table>
 <tr>
	<th>ID : </th>
	<td>${requestScope.member.user.userId}</td>
 <tr>
 <tr>
	<th>이름 : </th>
	<td>${requestScope.member.memberName}</td>
 <tr>
 <tr>
 	<th>닉네임 : </th>
 	<td>${requestScope.member.nickName}</td>
 </tr>
 <tr>
	<th>권한 : </th>
	<td>${requestScope.member.user.userAuthority}</td>
 </tr>
 <tr>
	<th>전화번호 : </th>
	<td>${requestScope.member.memberPhone}</td>
 </tr>
 <tr>
	<th>이메일 : </th>
	<td>${requestScope.member.memberEmail}</td>
 </tr>
 <tr>
 	<th>주소 :</th>
 	<td>${requestScope.member.memberAddress}</td>
 </tr>
 <tr>
 	<th>사진 :</th>
 	<td>${requestScope.member.memberPicture}</td>
 </tr>
 <tr>
	<td colspan="2"><form action="/MMONG/admin/changeMemberAuthority.do" method="post">
										<input type="hidden" name="memberId" value="${requestScope.member.user.userId}">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<input class="btn btn-default btn-sm" type="submit" id="memberAuthorityBtn" value="활동 정지/재개 변경">
							   </form>
	</td>
<tr>
</table>
</section>