<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

	<!-- Bootstrap core CSS -->
    <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
    <!--external css-->
    <link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
    <!-- Custom styles for this template -->
    <link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
    <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
</script>

<style type="text/css">
table{
	font-size:18px;
}
</style>
	<div id="total_div">
		<section class="wrapper site-min-height">
		<br><br>
		<ul>
			<li><a href="/MMONG/message/selectReceiveMsg.do">받은 쪽지함</a></li>
			<li><a href="/MMONG/message/selectSendMsg.do">보낸 쪽지함</a></li>
		</ul>
		<h2>　보낸 쪽지 상세 보기</h2>
	<hr>
	<br>
<table>
	<tr><td style="width: 200px;padding:10px 0px 10px 45px;">보낸이</td><td>${requestScope.message.receiveId }(${requestScope.message.member.nickName })</td></tr>
	<tr><td style="width: 200px;padding:10px 0px 10px 45px;">받은 시간</td><td>${requestScope.message.messageDate }</td></tr>
	<tr><td style="width: 200px;padding:10px 0px 10px 45px;">제목</td><td>${requestScope.message.title }</td></tr>
	<tr><td style="width: 200px;padding:10px 0px 10px 45px;">내용</td><td>${requestScope.message.content }</td></tr>
</table>
<br><br>
	<div style="padding-left:170px">
		<input type="button" class="btn btn-default" value="확인" onclick="javascript:history.back(-1)">
	</div>
</section>
</div>
