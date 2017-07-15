<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<link href="resource/assets/css/bootstrap.css" rel="stylesheet">
<link href="resource/assets/css/style.css" rel="stylesheet">




<script type="text/javascript"
	src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script src="resource/assets/js/bootstrap.min.js"></script>
<script
	src="resource/assets/js/bootstarp-inputmask/bootstrap-inputmask.min.js"></script>
<style>
.error {
	font-size: 8px;
	color: red;
}
</style>

<h3>로그인 페이지</h3>


<div id="login-page">
	<div class="container">

		<form class="form-login" action="/MMONG/login.do" method="post">
			<h2 class="form-login-heading">sign in now</h2>
			<div class="login-wrap">
				<sec:csrfInput />
				<input type="text" id="userId" name="userId"
					value="${param.userId }" class="form-control" placeholder="User ID"
					autofocus> <br> <input type="password" id="userPwd"
					name="userPwd" value="${param.userPwd }" class="form-control"
					placeholder="Password">
					
					<label class="checkbox"> <!-- 비밀번호 찾기  -->
		                <span class="pull-right">
		                    <a data-toggle="modal" href="login.html#myModal"> Forgot Password?</a>
		                </span>
		            </label>					
					
				<button type="submit" class="btn btn-theme btn-block">SIGN
					IN</button>
					<hr>
				<sec:csrfInput />
			</div>
			<div class="registration" align>
				Don't have an account yet?<br/> 
				<a class="" href="/MMONG/member/register_form.do" > <!-- 회원가입 링크  --> 
				Create an account
				</a>
			</div>
		</form>
	</div>
</div>

<script src="resource/assets/js/jquery.js"></script>
<script src="resource/assets/js/bootstrap.min.js"></script>

<!--BACKSTRETCH-->
<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
<script type="text/javascript" src="resource/assets/js/jquery.backstretch.min.js"></script>
<script>
     $.backstretch("http://www.pbh2.com/wordpress/wp-content/uploads/2013/03/cute-puppy-gifs-playing.gif", {speed: 500});
</script>

<c:if test="${not empty param.errorMessage}">
	<div class="error">${param.errorMessage }</div>
</c:if>
