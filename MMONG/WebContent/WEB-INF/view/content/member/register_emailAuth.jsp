<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Dashboard">
<meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

<title>MMONG - 이메일 인증</title>
<script src="/MMONG/resource/assets/js/jquery.js"></script>

  <!-- Bootstrap core CSS -->
<link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">

<!--external css-->
<link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        

<!-- Custom styles for this template -->
 <link href="/MMONG/resource/assets/css/style.css?var=3" rel="stylesheet">
 <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">

<script src="/MMONG/resource/assets/js/chart-master/Chart.js"></script>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript"></script>

</head>

<script>
function check(){
	var form = document.authForm;
	var authNo = ${authNo};
	var addedFormDiv = opener.document.getElementById("emailSuccessMsg"); //성공메시지 추가시킬 div 노드 가져오기
	
	if(!form.authNo.value){
		alert("인증번호를 입력하세요.");
		return false;
	}
	if(form.authNo.value!=authNo){
		alert("틀린 인증번호입니다. 인증번호를 다시 입력해주세요.");
		form.authNo.value="";
		return false;
	}
	if(form.authNo.value==authNo){
		alert("인증완료");
		var addedDiv = document.createElement("div"); //생성할 폼 생성
		addedDiv.innerHTML = "인증완료"; //생성할 폼에 내용 설정
		addedFormDiv.appendChild(addedDiv); //추가시킬 div노드에 생성한 폼 삽입
		window.close();
	}
}
</script>

		    

<body>

<div style="padding:20px;">
회원가입을 위해 이메일로 받은 인증번호 7자리를 입력하세요.<br><br>
	<form method="post" name="authForm">
		<input type="text" name="authNo" class="form-control" size="20" placeholder="인증번호 입력"> <br>
		<center><input type="button" class="btn btn-theme" onClick="check(); return false;" value="인증"></center>
		<sec:csrfInput/>
	</form>
</div>

</body>
</html>