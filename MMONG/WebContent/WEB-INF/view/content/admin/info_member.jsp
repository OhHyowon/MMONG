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
 


회원 ID : ${requestScope.member.user.userId}<br>
회원 이름 : ${requestScope.member.memberName}<br>
닉네임 : ${requestScope.member.nickName}<br>
권한 : ${requestScope.member.user.userAuthority}<br>
전화번호 :${requestScope.member.memberPhone}<br>
이메일 : ${requestScope.member.memberEmail}<br>
주소 :${requestScope.member.memberAddress}<br>
사진 : ${requestScope.member.memberPicture}<br>


<a href="/MMONG/index.do">메인페이지</a>

<form action="/MMONG/admin/changeMemberAuthority.do" method="post">
	<input type="hidden" name="memberId" value="${requestScope.member.user.userId}">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" id="memberAuthorityBtn" value="활동 정지/재개 변경">
</form>
<br>
</section>