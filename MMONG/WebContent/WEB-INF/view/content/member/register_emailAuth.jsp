<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
</head>
<body>
<h5>인증번호 7자리를 입력하세요.</h5>
	<form method="post" name="authForm" onSubmit="return check();">
		인증번호 입력 : <input type="text" name="authNo"> <br>
						<input type="submit" class="btn btn-info" value="인증">
						<sec:csrfInput/>
	</form>
</body>
</html>