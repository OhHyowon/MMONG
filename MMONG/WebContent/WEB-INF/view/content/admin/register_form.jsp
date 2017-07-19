<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
.error{
	font-size:8px;
	color: red;
}
th, td{
	padding-right: 5px;
}
#register_form{
	width:80%; height:30%; margin:0 auto; 
}
</style>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}

																	
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
			$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요.");
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
	
	////////////////////이메일 비었는지 체크                        
	 $("#adminEmail").blur(function(){
		 if($("#adminEmail").val()==""){
			$("#emailMsg").empty();
			$("#emailMsg").append("이메일을 입력하세요.");
			$("#emailMsg").show();
		 }else{
			 $("#emailMsg").hide();
		 }
	 });
	
 	 
	 ///이메일 중복 확인
	 $("#emailAuth").on("click",function(){
		$.ajax({
			"url":"/MMONG/admin/checkAdminEmail.do",
			"data":{"adminEmail":$("#adminEmail").val()},
			"dataType":"text",
			"beforeSend":function(){
				if($("#adminEmail").val()==""){
					$("#emailMsg").empty();
					$("#emailMsg").append("이메일을 입력하세요");
					$("#emailMsg").show();
					return false;
				}
			},
			"success":function(response){
				if(response==1){
					$("#emailMsg").empty();
					$("#emailMsg").append("이미 가입된 이메일 입니다.");
					$("#emailMsg").show();
				}else{
					$("#emailMsg").hide();
					emailAuthOpen();
				}
			}
		});
	 });
	 
	  
	 
});//ready 함수의 끝

 
function emailAuthOpen(){ //이메일 인증컨트롤러 부르는 함수
	if($("#adminEmail").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		return;
	}else{
		var adminEmail = $("#adminEmail").val();
		window.open("/MMONG/sendMail/auth.do?memberEmail="+$("#adminEmail").val(), '소모임 만들기', 'top=100px, left=100px, height=220px, width=500px');
	}
}




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
	}else if($("#adminPhone").val().length<10 || $("#adminPhone").val().length>11){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("10~11자리 번호를 입력해주세요.");
		$("#phoneMsg").show();
		$("#adminPhone").focus();
		result = false;
	}else if(phoneDuplicationChk==false){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
		$("#phoneMsg").show();
		result = false;
	}else if($("#adminEmail").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#adminEmail").focus();
		result = false;
	}else if($("#emailSuccessMsg").text()!="인증완료"){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일 인증을 해주세요.");
		$("#emailMsg").show();
		result = false;
	}else{
		result = true;
	}
	return result;
}//formChk함수 끝


function formSubmit(){
    if(formChk()){ // formChk 값이 true일경우만 submit
    	$("#insert").submit();
    }
}



</script>
<div id="total_div">		
	<section class="wrapper site-min-height">
		<h3><i class="fa fa-angle-right"></i>관리자 등록</h3>
<div id="register_form">										
									<%-- value="${param. } 는 EL의 내장객체를 이용한 것 --%>
<form name="insertForm" id="insert" action="/MMONG/admin/register_success.do" method="post">
	<table>	
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="administrator.user.userId" delimiter="<br>"/>
				<div id="idMsg" style="display:none"></div>
			</td>
		</tr>
		<tr>
			<th>ID</th>
			<td><input class="form-control" placeholder="ID" type="text" id="adminId" name="adminId"  value="${param.adminId }"><br></td> 
			<td><input class="btn btn-default btn-sm" type="button" id="idChk" value="중복확인"/></td> 
		</tr>
		
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="administrator.user.userPwd" delimiter="<br>"/>
				<div id="pwdMsg" style="display:none"></div>
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input class="form-control" placeholder="패스워드" type="password" id="adminPwd" name="user.userPwd" ><br></td>
		</tr>
		
		<tr>
			<td></td>
			<td class="error">
			<div id="pwdChkMsg" style="display:none"></div>
			</td>
		</tr>
		<tr>
			<th>비밀번호 확인</th>
			<td><input class="form-control" placeholder="패스워드 확인" type="password" id="adminPwdCheck"><br></td>
		</tr>
		
		<tr>
			<td></td>
			<td class="error">
			<div id="nameMsg" style="display:none"></div>
			</td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input class="form-control" placeholder="이름" type="text" id="adminName" name="adminName" value="${param.adminName}"><br></td>
		</tr>
		
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="administrator.adminPhone" delimiter="<br>"/>
				<div id="phoneMsg" style="display:none"></div>
			</td>
		</tr>
		<tr>
			<th>휴대전화 번호</th>
			<td><input class="form-control" placeholder="휴대전화 번호" type="text" id="adminPhone" name="adminPhone" value="${param.adminPhone}"><br></td>
			<td><input class="btn btn-default btn-sm" type="button" id="adminPhoneChk" value="인증"/></td>
		</tr>
		
		<tr>
			<td></td>
			<td class="error">
			<div id="emailMsg" style="display:none"></div>
			<div id="emailSuccessMsg"></div>
			</td>
		</tr>
		<tr>	
			<th>이메일</th>
			<td><form>
				<input class="form-control" placeholder="Email" type="text" id="adminEmail" name="adminEmail" value="${param.adminEmail}"><br></td>
				<td><input class="btn btn-default btn-sm" type="button" id="emailAuth" value="이메일 인증"/> 
				</form></td>
		</tr>
		<tr>
			<td>
			<%-- 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
				<input class="btn btn-default btn-sm" type="button" value="등록" onClick="formSubmit(); return false;" />
			</td>
		</tr>
	</table>
	<sec:csrfInput/> <!-- 시큐리티 토큰을 위해, 340번 라인 대체 -->
</form>
</div>
</section>
</div>