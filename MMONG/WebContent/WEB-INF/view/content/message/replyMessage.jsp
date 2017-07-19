<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- Bootstrap core CSS -->
    <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
    <!--external css-->
    <link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
    <!-- Custom styles for this template -->
    <link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
    <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">

<style type="text/css">

span, td, th{
	padding: 5px; 
}
span.error{
	font-size:small; /* 1em : 기본 크기의 1배수 크기 */
	color: red;
}

body{
	font-size: 16px;
}

.viewName{
	background-color: #F2F2F2;
}

</style>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#cancel").on("click", function(){
		opener.parent.location.reload();
		self.close();		
	});
});

</script>

<body>
		<div class="viewName" align="center"><br><h2>답장 보내기</h3><br></div>
<br>
<div align="center">

<form action="/MMONG/message/reply.do?receiveId=${requestScope.message.sendId }&no=${requestScope.no }" method="post">
 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 	
	<table>
	<tr>
		<th>받는이</th>
		<td>
			${requestScope.message.sendId }(${requestScope.message.member.nickName })
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td style="padding:20px 0px 0px 4px;">
			<input type="text" name="title" style="width:330px;" value="${param.title }">
			<br><span class="error"><form:errors path="mess.title"/></span></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows='7' cols='39' name="content">${param.content }</textarea>
				<br><span class="error"><form:errors path="mess.content"/></span></td>
	</tr>
</table>
<br>
	<input type="submit" class="btn btn-default" value="전송">
	<input type="button" class="btn btn-default" value="취소" id="cancel">
</form>
</div>
</body>