<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 등록</title>
<style type="text/css">
.error{
	font-size:8px;
	color: red;
}
th, td{
	padding-right: 5px;
}
</style>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
																				
var sizeChk = true; //아이디 길이 체크값
var idDuplicationChk = false; //아이디 중복검사 체크값
var pwdChk = false; //비밀번호 값 검사 체크값
var phoneDuplicationChk = false; //핸드폰번호 중복검사 체크값 

$(document).ready(function(){
	
	///아이디 길이값 검사
	$("#adminId").focus(function(){
		$("#idMsg").empty();
		$("#idMsg").append("8~12글자의 영/소문자/숫자 사용.");
		$("#idMsg").show();
		sizeChk=false;
	});
	//아이디 중복 검사
	$("#idChk").on("click",function(){
		$.ajax({
			"url":"/MMONG/admin/checkAdminId.do",
			"data":{"adminId":$("#adminId").val()},		
			"dataType":"text",
			"beforeSend":function(){
				if(sizeChk==false){
					$("#idMsg").empty(),
					$("#idMsg").append("8~12글자의 영/소문자/숫자 사용.");
					$("#idMsg").show();
					$("#adminId").focus();
					return false;
				}
			},
			"success":function(response){
				sizeChk=true;
				if(response==1){
					$("#idMsg").empty();
					$("#idMsg").append("'"+$("#adminId").val()+"'은(는) 이미 사용중인 아이디 입니다.");
					$("#idMsg").show();
				}else{
					$("#idMsg").empty();
					$("#idMsg").append("사용가능한 아이디 입니다.");
					$("#idMsg").show();
					idDuplicationChk=true;
				}
			}
		});
	});
	//길이 값, 중복 검사
	$("#adminId").blur(function(){
		if($("#adminId").val().length>7 && $("#adminId").val().length<13){
			sizeChk = true;
		}	
		if(idDuplicationChk==false){
			$("#idMsg").empty();
			$("#idMsg").append("아이디 중복확인을 해 주세요.");
			$("#idMsg").show();
		}
	});	
	
	////////////////////비밀번호 값 검사 
	$("#adminPwd").focus(function(){
		$("#pwdMsg").empty();
		$("#pwdMsg").append("8-12자의 영문대소문자, 숫자, 특수문자만 가능.");
		$("#pwdMsg").show();
	});
	$("#adminPwd").blur(function(){
		if($("#adminPwd").val().length>7 && $("#adminPwd").val().length<13){
			$("#pwdMsg").hide();
			pwdChk = true;
		}
	});	
	//비밀번호확인 검사 
	$("#adminPwdCheck").change(function(){
		if($("#adminPwd").val() != $("#adminPwdCheck").val()){
			$("#pwdChkMsg").empty();
			$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요."); //비밀번호 폼을 바꿨을경우도..   <- ????
			$("#pwdChkMsg").show();		
		}else{
			$("#pwdChkMsg").hide();
		}
	});
	
	////////////////////핸드폰번호 인증
	$("#adminPhoneChk").on("click", function(){
		$.ajax({
			"url" : "/MMONG/admin/checkAdminPhone.do",
			"data" : {"adminPhone":$("#adminPhone").val()},
			"dataType" : "text",
			"success":function(response) {
				if(response==1) {
					$("#phoneMsg").empty();
					$("#phoneMsg").append("이미 가입된 핸드폰번호입니다.");
					$("#phoneMsg").show();
				} else {
					$("#phoneMsg").empty();
					$("#phoneMsg").append("사용 가능합니다.");
					$("#phoneMsg").show();
					phoneDuplicationChk = true;
				}
			}
		});	
	});
	$("#adminPhone").blur(function(){
		if($("#memberPhone").val()==""){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
			$("#phoneMsg").show();
		}else if(phoneDuplicationChk==false){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
			$("#phoneMsg").show();
		}
	});	
	//핸드폰번호 숫자만 받게
	 $("#adminPhone").keyup(function(event){
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
             var inputVal = $(this).val();
             $(this).val(inputVal.replace(/[^0-9]/gi,''));
         }
     });

	////////////////////이름 비었는지 체크 
	 $("#adminName").blur(function(){
		 if($("#adminName").val()==""){
			$("#nameMsg").empty();
			$("#nameMsg").append("이름을 입력하세요.");
			$("#nameMsg").show();
		 }else{
			 $("#nameMsg").hide();
		 }
	 });	
	
	////////////////////이메일 비었는지 체크                            // email 칸 2개중 1개만 입력될 경우 경고표시 안나옴
	 $("#adminEmail1").blur(function(){
		 if($("#adminEmail1").val()==""){
			$("#emailMsg").empty();
			$("#emailMsg").append("이메일을 입력하세요.");
			$("#emailMsg").show();
		 }else{
			 $("#emailMsg").hide();
		 }
	 });
	 $("#adminEmail2").blur(function(){
		 if($("#adminEmail2").val()==""){
			$("#emailMsg").empty();
			$("#emailMsg").append("이메일을 입력하세요.");
			$("#emailMsg").show();
		 }else{
			 $("#emailMsg").hide();
		 }
	 });
});//ready 함수의 끝




//가입 버튼 누르기 전 값 유효성 검사하기 위한 함수들
function formChk() {
	var result = true;
	if($("#adminId").val()==""){
		$("#idMsg").empty();
		$("#idMsg").append("아이디를 입력하세요.");
		$("#idMsg").show();
		$("#adminId").focus();
		result = false;
	}else if(sizeChk==false){
		$("#idMsg").empty();
		$("#idMsg").append("8-12글자의 영/소문자/숫자 사용.");
		$("#idMsg").show();
		$("#adminId").focus();
		sizeChk = true;
		result = false;
	}else if(idDuplicationChk==false){	
		$("#idMsg").empty();
		$("#idMsg").append("'"+$("#adminId").val()+"'은(는) 이미 사용중인 아이디입니다.");
		$("#idMsg").show();
		result = false;
	}else if(pwdChk==false){
		$("#pwdMsg").empty();
		$("#pwdMsg").append("8-12자의 영문대소문자, 숫자, 특수문자만 가능.");
		$("#pwdMsg").show();
		$("#adminPwd").focus();
		pwdChk = true;
		result = false;
	}else if($("#adminPwd").val() != $("#adminPwdCheck").val()){
		$("#pwdMsg").empty();
		$("#pwdChkMsg").empty();
		$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요.");
		$("#pwdChkMsg").show();
		$("#adminPwd").focus();
		result = false;
	}else if($("#adminName").val()==""){
		$("#nameMsg").empty();
		$("#nameMsg").append("이름을 입력하세요.");
		$("#nameMsg").show();
		$("#nameMsg").focus();
		result = false;
	}else if($("#adminPhone").val()==""){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
		$("#phoneMsg").show();
		$("#adminPhone").focus();
		result = false;
	}else if(phoneDuplicationChk==false){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
		$("#phoneMsg").show();
		result = false;
	}else if($("#adminEmail1").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#adminEmail1").focus();
		result = false;
	}else if($("#adminEmail2").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#adminEmail2").focus();
		result = false;
	}
	return result;
}//formChk함수 끝


function formSubmit(){
    if(formChk()){ // formChk 값이 true일경우만 submit
    	$("#adminEmail").val($("#adminEmail1").val() + "@" + $("#adminEmail2").val()); //이메일 @ 전후로 합쳐서 hidden태그에 넣기
    	$("#insert").submit();
    }
}



</script>
</head>
<body>
<h2>관리자 등록</h2>				<%-- value="${param. } 는 EL의 내장객체를 이용한 것 --%>
<form name="insertForm" id="insert" action="/MMONG/admin/register_success.do" method="post">
	<table>	
		<tr>
			<th>ID</th>
			<td><input type="text" id="adminId" name="adminId"  value="${param.adminId }"> 
					<input type="button" id="idChk" value="중복확인"/></td> 
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="administrator.user.userId" delimiter="<br>"/>
				<div id="idMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<td><input type="password" id="adminPwd" name="user.userPwd" ></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="administrator.user.userPwd" delimiter="<br>"/>
				<div id="pwdMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" id="adminPwdCheck"></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
			<div id="pwdChkMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<th>이름</th>
			<td><input type="text" id="adminName" name="adminName" value="${param.adminName}"></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
			<div id="nameMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<th>핸드폰 번호</th>
			<td><input type="text" id="adminPhone" name="adminPhone" value="${param.adminPhone}">
					<input type="button" id="adminPhoneChk" value="인증"/></td>
							<!-- <select name="tel1">
										<option>선택</option>
										<option>010</option>
										<option>011</option>
										<option>016</option>
										<option>019</option>
								</select>
								 - <input type="text" name="tel2" size="1" maxlength="4"> - <input type="text" name="tel3" size="1" maxlength="4">  -->
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="administrator.adminPhone" delimiter="<br>"/>
				<div id="phoneMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>	
			<th>이메일</th>
			<td><input type="text" id="adminEmail1" name="adminEmail1" value="${param.adminEmail1 }"> @ 
				<input type="text" id="adminEmail2" name="adminEmail2" value="${param.adminEmail2 }">
				<input type="hidden" id="adminEmail" name="adminEmail" value="${param.adminEmail }"> </td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
			<div id="emailMsg" style="display:none"></div>
			</td>
		</tr>
		<tr>
			<td>
			<%-- 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
				<input type="button" value="등록" onClick="formSubmit(); return false;" />
			</td>
		</tr>
	</table>
	<sec:csrfInput/> <!-- 시큐리티 토큰을 위해, 340번 라인 대체 -->
</form>
</body>
</html>
