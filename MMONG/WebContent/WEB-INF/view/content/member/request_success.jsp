<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
#content{
  top:0;right:0;bottom:0;left:0;
  display:flex;
  align-items:center;
  justify-content:center;
 
  display:-webkit-flex;
  -webkit-align-item;center;
  -webkit-justify-content:center;
}
</style>
<script>
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 가입완료
		</h3>


<div id="content">
	<h3>${requestScope.member.memberId }님, 가입을 축하합니다!</h3>

</div>
<div id="content">	
		로그인 해주세요.
</div>

</section>
</div>
