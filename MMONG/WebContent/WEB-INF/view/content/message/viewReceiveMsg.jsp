<%@ page contentType="text/html;charset=UTF-8"%>

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

$(document).ready(function(){
	$("#ok").on("click", function(){
		opener.parent.location.reload();
		self.close();		
	});
});

</script>

<style type="text/css">
table{
	font-size:18px;
}

body{
	font-size: 16px;
}

.viewName{
	background-color: #F2F2F2;
}
</style>
<body>
		<div class="viewName" align="center"><br>
		<h2>받은 쪽지 상세 보기</h2><br></div>
<br><br>
<div align="center">
		<table>
			<tr><td style="width: 150px;padding:10px 0px 10px 30px;">보낸이</td><td>${requestScope.message.sendId }(${requestScope.message.member.nickName })</td></tr>
			<tr><td style="width: 150px;padding:10px 0px 10px 30px;">받은 시간</td><td>${requestScope.message.messageDate }</td></tr>
			<tr><td style="width: 150px;padding:10px 0px 10px 30px;">제목</td><td>${requestScope.message.title }</td></tr>
			<tr><td style="width: 150px;padding:10px 0px 10px 30px;">내용</td><td>${requestScope.message.content }</td></tr>
		</table>
	<br><br>
		<input type="button" class="btn btn-default" value="답장" onclick="location.href='/MMONG/message/selectMsgIdNick.do?no=${requestScope.message.no}'">
		<input type="button" class="btn btn-default" value="확인" id="ok">
</div>