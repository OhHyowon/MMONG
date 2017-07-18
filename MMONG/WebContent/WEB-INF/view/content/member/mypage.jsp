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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
<section class="wrapper site-min-height">
		<h3><i class="fa fa-angle-right"></i> 회원 마이페이지</h3>
<div id="view-detail">
<table>
	<tr>
			 <th>ID :</th>
			 <td><sec:authentication property="principal.memberId"/></td>
	</tr>
	<tr>
			<th>이름 :</th> 
			<td>${requestScope.member.memberName }</td>
	</tr>
	<tr>
			<th>전화번호 : </th> 
			<td>${requestScope.member.memberPhone }</td>
	</tr>
	<tr>
			<th>이메일 : </th> 
			<td>${requestScope.member.memberEmail}</td>
	</tr>
	<tr>
			<th>주소 : </th> 
			<td>${requestScope.member.memberAddress}</td>
	</tr>
	<tr>
			<th>사진 : </th> 
			<td>${requestScope.member.memberPicture}</td>
	</tr>
</table>
</div>
<div id="view-menu">
	<form action="/MMONG/member/info_member_update_form.do" method="post">
		<input type="hidden" name="memberId" value="${requestScope.member.memberId }">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="submit" class="btn btn-default btn-sm" value="회원정보 수정">
	</form>&nbsp;
	<form action="/MMONG/member/memberWithdrawal.do" method="post">
		<input type="hidden" name="memberId" value="${requestScope.member.memberId }">
		<input class="btn btn-default btn-sm" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input class="btn btn-default btn-sm" type="submit" value="회원탈퇴">
</form>
</div>

<br>


<ul>
	<li><a href="/MMONG/message/message.do">쪽지 관리</a></li>
</ul>
</section>
</div>
